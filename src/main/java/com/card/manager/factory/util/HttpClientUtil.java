package com.card.manager.factory.util;

import java.io.InputStream;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 说明：httpClientUtil 连接池
 * 
 * @author 赵增丰
 * @version 1.0 2014-12-15 下午4:11:07
 */
public class HttpClientUtil {
	private final static Logger logger = LoggerFactory.getLogger(HttpClientUtil.class);
	private static PoolingHttpClientConnectionManager connManager = null;
	private static CloseableHttpClient httpclient = null;
	public final static int connectTimeout = 5000;
	private static CloseableHttpClient httpsclient = null;

	static {
		try {
			connManager = new PoolingHttpClientConnectionManager();

			connManager.setMaxTotal(1000);// 设置整个连接池最大连接数 根据自己的场景决定
			connManager.setDefaultMaxPerRoute(connManager.getMaxTotal());
			httpclient = HttpClients.custom().setConnectionManager(connManager).build();
			httpsclient = wrapClient(new DefaultHttpClient());
		} catch (Exception e) {
			logger.error("NoSuchAlgorithmException", e);
		}
	}

	private static CloseableHttpClient wrapClient(HttpClient base) {
		try {
			SSLContext ctx = SSLContext.getInstance("TLS");
			X509TrustManager tm = new X509TrustManager() {
				public java.security.cert.X509Certificate[] getAcceptedIssuers() {
					return null;
				}

				@Override
				public void checkServerTrusted(X509Certificate[] arg0, String arg1) throws CertificateException {
					// TODO Auto-generated method stub

				}

				@Override
				public void checkClientTrusted(X509Certificate[] chain, String authType) throws CertificateException {
					// TODO Auto-generated method stub

				}

			};
			ctx.init(null, new TrustManager[] { tm }, null);
			SSLSocketFactory ssf = new SSLSocketFactory(ctx, SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
			SchemeRegistry registry = new SchemeRegistry();
			registry.register(new Scheme("https", 443, ssf));
			ThreadSafeClientConnManager mgr = new ThreadSafeClientConnManager(registry);
			return new DefaultHttpClient(mgr, base.getParams());
		} catch (Exception ex) {
			ex.printStackTrace();
			return null;
		}
	}

	public static void closeConnections() {
		if (logger.isInfoEnabled()) {
			logger.info("release start connect count:=" + connManager.getTotalStats().getAvailable());
		}
		// Close expired connections
		connManager.closeExpiredConnections();
		// Optionally, close connections
		// that have been idle longer than readTimeout*2 MILLISECONDS
		connManager.closeIdleConnections(connectTimeout * 2, TimeUnit.MILLISECONDS);

		if (logger.isInfoEnabled()) {
			logger.info("release end connect count:=" + connManager.getTotalStats().getAvailable());
		}

	}

	public static byte[] getByteArr(String url) {
		byte[] result = null;
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectTimeout).build();

		HttpGet httpGet = null;
		HttpEntity entity = null;
		CloseableHttpResponse response = null;

		try {
			// 创建get请求
			httpGet = new HttpGet(url);

			httpGet.setConfig(requestConfig);

			logger.info("executing request uri：" + httpGet.getURI());

			response = httpsclient.execute(httpGet);

			// 如果连接状态异常，则直接关闭
			if (response.getStatusLine().getStatusCode() != 200) {
				logger.info("httpclient 访问异常 ");
				httpGet.abort();
				return null;
			}
			entity = response.getEntity();
			if (entity != null) {
				result = EntityUtils.toByteArray(entity);
			}

		} catch (Exception e) {
			httpGet.abort();
			logger.error("http get error ", e);
			return null;
			// 关闭连接,释放资源
		} finally {
			try {
				if (entity != null) {
					EntityUtils.consume(entity);// 关闭
				}
				if (response != null) {
					response.close();
				}
				if (httpGet != null) {
					// 关闭连接,释放资源
					httpGet.releaseConnection();
				}

			} catch (Exception e) {
				logger.error("http get error " + e.getMessage());
			}

		}
		return result;
	}

	/**
	 * 默认超时为5S 发送 post请求
	 * 
	 * @param params
	 * @return
	 */
	public static String post(Map<String, String> params) {
		String resultStr = "";
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectTimeout).build();
		Map<String, String> urlMap = URLUtils.getConfMap();
		String url = urlMap.get("kjbcUrl");

		// 创建httppost
		HttpPost httpPost = new HttpPost(url);
		// 创建参数队列
		List<NameValuePair> formParams = new ArrayList<NameValuePair>();
		// 绑定到请求 Entry
		for (Map.Entry<String, String> entry : params.entrySet()) {
			formParams.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}

		UrlEncodedFormEntity uefEntity;
		HttpEntity entity = null;
		CloseableHttpResponse response = null;
		try {
			uefEntity = new UrlEncodedFormEntity(formParams, "UTF-8");
			logger.info("executing request params" + formParams.toString());
			httpPost.setEntity(uefEntity);
			httpPost.setConfig(requestConfig);
			logger.info("executing request uri：" + httpPost.getURI());
			response = httpclient.execute(httpPost);

			// 如果连接状态异常，则直接关闭
			if (response.getStatusLine().getStatusCode() != 200) {
				logger.info("httpclient 访问异常 ");
				httpPost.abort();
				return null;
			}
			entity = response.getEntity();
			if (entity != null) {
				resultStr = EntityUtils.toString(entity, "UTF-8");
				logger.info(" httpClient response string " + resultStr);
			}

		} catch (Exception e) {
			httpPost.abort();
			logger.error("http post error " + e.getMessage());
			return null;
			// 关闭连接,释放资源
		} finally {
			try {
				if (entity != null) {
					EntityUtils.consume(entity);// 关闭
				}
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					// 关闭连接,释放资源
					httpPost.releaseConnection();
				}

			} catch (Exception e) {
				logger.error("http post error " + e.getMessage());
			}

		}
		return resultStr;
	}

	/**
	 * 默认超时为5S 发送 post请求 GTS
	 * 
	 * @param params
	 * @return
	 */
	public static String postGTSOrder(String params) {
		String resultStr = "";
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectTimeout).build();
		Map<String, String> urlMap = URLUtils.getConfMap();
		String url = urlMap.get("gtsGTSUrl");
		// 创建httppost
		HttpPost httpPost = new HttpPost(url);

		HttpEntity entity = null;
		CloseableHttpResponse response = null;
		try {
			StringEntity uefEntity = new StringEntity(params);
			// uefEntity = new UrlEncodedFormEntity(params, "UTF-8");
			httpPost.setEntity(uefEntity);
			httpPost.setConfig(requestConfig);
			logger.info("executing request " + httpPost.getURI());
			response = httpclient.execute(httpPost);

			// 如果连接状态异常，则直接关闭
			if (response.getStatusLine().getStatusCode() != 200) {
				logger.info("httpclient 访问异常 ");
				httpPost.abort();
				return null;
			}
			entity = response.getEntity();
			if (entity != null) {
				resultStr = EntityUtils.toString(entity, "UTF-8");
				logger.info(" httpClient response string " + resultStr);
			}

		} catch (Exception e) {
			httpPost.abort();
			logger.error("http post error " + e.getMessage());
			return null;
			// 关闭连接,释放资源
		} finally {
			// 关闭连接,释放资源
			httpPost.releaseConnection();

			try {
				if (entity != null) {
					EntityUtils.consume(entity);// 关闭
				}
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					// 关闭连接,释放资源
					httpPost.releaseConnection();
				}

			} catch (Exception e) {
				logger.error("http post error " + e.getMessage());
			}

		}

		return resultStr;
	}

	public static String post23(String url, Map<String, String> params) {
		String resultStr = "";
		RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectTimeout).build();
		Map<String, String> urlMap = URLUtils.getConfMap();
		// String url = urlMap.get("kjbcUrl");
		// 创建httppost
		HttpPost httpPost = new HttpPost(url);
		// 创建参数队列
		List<NameValuePair> formParams = new ArrayList<NameValuePair>();
		// 绑定到请求 Entry
		for (Map.Entry<String, String> entry : params.entrySet()) {
			formParams.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
		}

		UrlEncodedFormEntity uefEntity;
		HttpEntity entity = null;
		CloseableHttpResponse response = null;
		try {
			uefEntity = new UrlEncodedFormEntity(formParams, "UTF-8");
			logger.info("executing request params" + formParams.toString());
			httpPost.setEntity(uefEntity);
			httpPost.setConfig(requestConfig);
			logger.info("executing request uri：" + httpPost.getURI());
			response = httpclient.execute(httpPost);
			// 如果连接状态异常，则直接关闭
			if (response.getStatusLine().getStatusCode() != 200) {
				logger.info("httpclient 访问异常 ");
				httpPost.abort();
				return null;
			}
			entity = response.getEntity();
			if (entity != null) {
				resultStr = EntityUtils.toString(entity, "UTF-8");
				logger.info(" httpClient response string " + resultStr);
			}

		} catch (Exception e) {
			httpPost.abort();
			logger.error("http post error " + e.getMessage());
			return null;
			// 关闭连接,释放资源
		} finally {
			try {
				if (entity != null) {
					EntityUtils.consume(entity);// 关闭
				}
				if (response != null) {
					response.close();
				}
				if (httpPost != null) {
					// 关闭连接,释放资源
					httpPost.releaseConnection();
				}

			} catch (Exception e) {
				logger.error("http post error " + e.getMessage());
			}

		}
		return resultStr;
	}

}

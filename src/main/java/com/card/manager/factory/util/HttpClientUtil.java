package com.card.manager.factory.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
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

	static {
		try {
			connManager = new PoolingHttpClientConnectionManager();

			connManager.setMaxTotal(1000);// 设置整个连接池最大连接数 根据自己的场景决定
			connManager.setDefaultMaxPerRoute(connManager.getMaxTotal());
			httpclient = HttpClients.custom().setConnectionManager(connManager).build();
		} catch (Exception e) {
			logger.error("NoSuchAlgorithmException", e);
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

	
	/**
	 * 默认超时为5S 发送 post请求
	 * @param params
	 * @return
	 */
	public static String post(Map<String, String> params) {
		String resultStr = "";
		RequestConfig requestConfig = RequestConfig.custom()
				.setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout)
				.setConnectionRequestTimeout(connectTimeout).build();
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
	     HttpEntity entity =  null;
	     CloseableHttpResponse response = null;
		try {
			uefEntity = new UrlEncodedFormEntity(formParams, "UTF-8");
			logger.info("executing request params" + formParams.toString());
			httpPost.setEntity(uefEntity);
			httpPost.setConfig(requestConfig);
			logger.info("executing request uri：" + httpPost.getURI());
			response = httpclient.execute(httpPost);
			
			//如果连接状态异常，则直接关闭
            if (response.getStatusLine ().getStatusCode () != 200) {  
            	 logger.info("httpclient 访问异常 " );
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
			try{
        		if (entity != null) {
                    EntityUtils.consume(entity);// 关闭
                }
        		if(response != null){
        			response.close();
        		}
        		if(httpPost != null){
        			// 关闭连接,释放资源
                    httpPost.releaseConnection();
        		}
           	 
        	}catch(Exception e){
        		logger.error("http post error " + e.getMessage());
        	}


		}
		return resultStr;
	}
	
	
	/**
	 * 默认超时为5S 发送 post请求  GTS
	 * @param params
	 * @return
	 */
	public static String postGTSOrder(String params) {
		String resultStr = "";
		RequestConfig requestConfig = RequestConfig.custom()
				.setSocketTimeout(connectTimeout)
				.setConnectTimeout(connectTimeout)
				.setConnectionRequestTimeout(connectTimeout).build();
		Map<String, String> urlMap = URLUtils.getConfMap();
		String url = urlMap.get("gtsGTSUrl");
		// 创建httppost
		HttpPost httpPost = new HttpPost(url);
		
		HttpEntity entity = null;
		CloseableHttpResponse response = null;
		try {
			StringEntity uefEntity = new StringEntity(params);
			//uefEntity = new UrlEncodedFormEntity(params, "UTF-8");
			httpPost.setEntity(uefEntity);
			httpPost.setConfig(requestConfig);
			logger.info("executing request " + httpPost.getURI());
			response = httpclient.execute(httpPost);
			
			//如果连接状态异常，则直接关闭
            if (response.getStatusLine ().getStatusCode () != 200) {  
            	 logger.info("httpclient 访问异常 " );
            	httpPost.abort();
                return null;  
            }  
            entity = response.getEntity();
            if (entity != null) {
                resultStr = EntityUtils.toString(entity, "UTF-8");
                logger.info(" httpClient response string " + resultStr);
            }
			
			
		}catch(Exception e){
			httpPost.abort();
            logger.error("http post error " + e.getMessage());
            return null;
         // 关闭连接,释放资源
		} finally {
			// 关闭连接,释放资源
			httpPost.releaseConnection();
			
			try{
        		if (entity != null) {
                    EntityUtils.consume(entity);// 关闭
                }
        		if(response != null){
        			response.close();
        		}
        		if(httpPost != null){
        			// 关闭连接,释放资源
                    httpPost.releaseConnection();
        		}
           	 
        	}catch(Exception e){
        		logger.error("http post error " + e.getMessage());
        	}
			
		}
		
		
		return resultStr;
	}
	
	
	
	public static String post23(String url, Map<String, String> params) {
        String resultStr = "";
        RequestConfig requestConfig = RequestConfig.custom().setSocketTimeout(connectTimeout).setConnectTimeout(connectTimeout).setConnectionRequestTimeout(connectTimeout).build();
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
        HttpEntity entity =  null;
        CloseableHttpResponse response = null;
        try {
            uefEntity = new UrlEncodedFormEntity(formParams, "UTF-8");
            logger.info("executing request params" + formParams.toString());
            httpPost.setEntity(uefEntity);
            httpPost.setConfig(requestConfig);
            logger.info("executing request uri：" + httpPost.getURI());
            response = httpclient.execute(httpPost);
            //如果连接状态异常，则直接关闭
            if (response.getStatusLine ().getStatusCode () != 200) {  
            	 logger.info("httpclient 访问异常 " );
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
        	try{
        		if (entity != null) {
                    EntityUtils.consume(entity);// 关闭
                }
        		if(response != null){
        			response.close();
        		}
        		if(httpPost != null){
        			// 关闭连接,释放资源
                    httpPost.releaseConnection();
        		}
           	 
        	}catch(Exception e){
        		logger.error("http post error " + e.getMessage());
        	}

        }
        return resultStr;
    }
	
}

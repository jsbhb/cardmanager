/**  
 * Project Name:cardmanager  
 * File Name:HttpCommon.java  
 * Package Name:com.card.manager.factory.common  
 * Date:Oct 30, 20172:57:20 PM  
 *  
 */
package com.card.manager.factory.common;

import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.RestTemplate;

import com.card.manager.factory.base.Pagination;

/**
 * ClassName: HttpCommon <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Oct 30, 2017 2:57:20 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class RestCommonHelper {

	private HttpHeaders httpHeaders;
	private Pagination pagination;
	private RestTemplate restTemplate;

	public RestCommonHelper() {
		httpHeaders = new HttpHeaders();
		restTemplate = new RestTemplate();
	}

	public RestCommonHelper(Pagination pagination) {
		this.pagination = pagination;
		httpHeaders = new HttpHeaders();
		restTemplate = new RestTemplate();
	}

	/**
	 * 
	 * request:普通请求. <br/>
	 * 
	 * @author hebin
	 * @param url
	 * @param token
	 * @param needToken
	 * @param entity
	 * @param method
	 * @return
	 * @since JDK 1.7
	 */
	public ResponseEntity<String> requestWithParams(String url, String token, boolean needToken, Object entity,
			HttpMethod method, Map<String, Object> params) {
		if (needToken) {
			httpHeaders.add("authentication", ServerCenterContants.TOKEN_PREFIX + token);
		}

		return restTemplate.exchange(url, method, new HttpEntity<Object>(entity, httpHeaders), String.class, params);

	}

	/**
	 * 
	 * request:普通请求. <br/>
	 * 
	 * @author hebin
	 * @param url
	 * @param token
	 * @param needToken
	 * @param entity
	 * @param method
	 * @return
	 * @since JDK 1.7
	 */
	public ResponseEntity<String> request(String url, String token, boolean needToken, Object entity,
			HttpMethod method) {
		if (needToken) {
			httpHeaders.add("authentication", ServerCenterContants.TOKEN_PREFIX + token);
		}

		return restTemplate.exchange(url, method, new HttpEntity<Object>(entity, httpHeaders), String.class);

	}

	/**
	 * 
	 * requestForPage:分页请求. <br/>
	 * 
	 * @author hebin
	 * @param url
	 * @param params
	 * @param token
	 * @param method
	 * @return
	 * @since JDK 1.7
	 */
	public ResponseEntity<String> requestForPage(String url, Map<String, Object> params, String token,
			HttpMethod method) {
		httpHeaders.setContentType(MediaType.APPLICATION_JSON);
		httpHeaders.add("authentication", ServerCenterContants.TOKEN_PREFIX + token);

		return restTemplate.exchange(url, method, new HttpEntity<Object>(pagination, httpHeaders), String.class,
				params);

	}

}

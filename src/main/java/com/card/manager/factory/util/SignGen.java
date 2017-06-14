package com.card.manager.factory.util;

import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;
import java.util.Map;
import java.util.SimpleTimeZone;
import java.util.TreeMap;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang3.StringUtils;


/**
 * 签名生成示例
 * @author ryan.hcy
 *
 */
public class SignGen {
	
	public static final String NEW_LINE = "\n";
	private static final String DEFAULT_ENCODING = "UTF-8";
    private static final String ALGORITHM = "HmacSHA1";
    private static final Object LOCK = new Object();
    private static Mac macInstance;
	
	public static void main(String[] args){
		try {
			//永久KeyId示例
			genSign("testuser", "9g1Ur7xoqOOhOmDJ4PfX1YsGAa5n27wU", "GET", null, null, null, null);
			
			//临时KeyId示例
/*			
			genSign("DSS.0i0a5NBu0NAqXtU1gYfE", "Ya8EnbFWkE1GkxTRqdwnGCdTVO5EWYORyhicDwYF", "GET", null, null, null, 
					"tqX7ydnwZyqoPykuxTnaGmVbQ9MacwCR0bAaZJFVs6It8G0iUDBZCIgPzqjzNMo9z29lkpubjk6bqhnm8KMUtdciVX7lQ7DIL1A83aQoGQSG75J6jmC2opzjE1dfLhFX");*/
 
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	

	/**
	 * 生成签名
	 * @param keyId        必选参数
	 * @param keySecret    必选参数
	 * @param method       必选参数， HTTP方法，POST/GET/PUT。
	 * @param contentType  可选参数，HTTP header Content-Type。
	 * @param contentMd5     可选参数，HTTP content的MD5值。
	 * @param date         可选参数，不传递则默认使用当前时间，需与DSS服务器时间误差不超过15分钟。
	 * @param token        keyId为临时授权凭证时，为必选参数；永久keyId时无此参数。
	 * @return String      返回Auth的值
	 * @throws Exception   keyId、keySecret、method参数未传入时，将抛出参数异常。
	 */
	public static String genSign(String keyId, String keySecret, String method, 
			String contentType, String contentMd5, Date date, String token) throws Exception{
		if(StringUtils.isEmpty(keyId) || StringUtils.isEmpty(keySecret) || StringUtils.isEmpty(method)){
			throw new Exception("Parameter error");
		}
		System.out.println("--------------------------------------------------------------------------");
		System.out.println("- keyId=" + keyId + " keySecret=" + keySecret);
		String sign = buildSignString(method.toUpperCase(), contentType, contentMd5, date, token);
		System.out.println("--------------------------------------------------------------------------");
		System.out.println("-                           【签名内容】                                                             -");
		System.out.println("--------------------------------------------------------------------------");
		System.out.print(sign);
		System.out.println("--------------------------------------------------------------------------");
		System.out.println("-                           【签名结果】                                                             -");
		System.out.println("--------------------------------------------------------------------------");
		String secSign = computeSignature(keySecret, sign);
		String result = "DSS " + keyId + ":" + secSign;
		System.out.println(result);
		System.out.println("--------------------------------------------------------------------------");
		return result;
	}
	
	/**
	 * 拼装明文的待签名内容
	 * @param method
	 * @param contentType
	 * @param contentMd5
	 * @param date
	 * @param token
	 * @return
	 * @throws ParseException
	 */
	private static String buildSignString(String method, String contentType, 
			String contentMd5, Date date, String token) throws ParseException {
    	/*
		Signature = base64(hmac-sha1(KeySecret,
		            VERB + "\n” 
		            + Content-MD5 + "\n" 
		            + Content-Type + "\n" 
		            + Date + "\n" 
		            + DSSHeaders))
    	 */
    	
        StringBuilder sign = new StringBuilder();
        sign.append(method + NEW_LINE);
        
        TreeMap<String, String> headersToSign = new TreeMap<String, String>();
        headersToSign.put("content-type", (contentType == null) ? "" : contentType);
        headersToSign.put("content-md5", (contentMd5 == null) ? "" : contentMd5);
//        headersToSign.put("x-dss-order-type", (orderType == null) ? "" : orderType);
        if(date == null){
        	date = new Date();
        }
        String time = parseGMT(date);
        headersToSign.put("date", time);
        if(!StringUtils.isEmpty(token)){
        	headersToSign.put("x-dss-token", token);
        }
        for(Map.Entry<String, String> entry : headersToSign.entrySet()) {
            String key = entry.getKey();
            Object value = entry.getValue();
            if (key.startsWith("x-dss-")) {
            	sign.append(key).append(":").append(value);
            } else {
            	sign.append(value);
            }
            sign.append(NEW_LINE);
        }
        return sign.toString();
    }

	/**
	 * 将时间转换为GMT格式字符串
	 * @param date
	 * @return GMT时间
	 * @throws ParseException
	 */
    public static String parseGMT(Date date) throws ParseException {
        SimpleDateFormat gmtFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss z", Locale.US);
        gmtFormat.setTimeZone(new SimpleTimeZone(0, "GMT"));
        return gmtFormat.format(date);
    }

    /**
     * 使用密钥进行数据签名
     * @param keySecret
     * @param data
     * @return 签名
     */
    private static String computeSignature(String keySecret, String data) {
        try {
            byte[] signData = sign(keySecret.getBytes(DEFAULT_ENCODING), data.getBytes(DEFAULT_ENCODING));
            return toBase64String(signData);
        }
        catch(UnsupportedEncodingException ex) {
            throw new RuntimeException("Unsupported algorithm: " + DEFAULT_ENCODING, ex);
        }
    }
    
    /**
     * Base64编码
     * @param binaryData
     * @return
     */
    private static String toBase64String(byte[] binaryData) {
        return new String(Base64.encodeBase64(binaryData));
    }

    /**
     * HmacSHA1加密
     * @param key
     * @param data
     * @return
     */
    private static byte[] sign(byte[] key, byte[] data) {
        try {
            if (macInstance == null) {
                synchronized (LOCK) {
                    if (macInstance == null) {
                        macInstance = Mac.getInstance(ALGORITHM);
                    }
                }
            }
            Mac mac = null;
            try {
                mac = (Mac)macInstance.clone();
            } catch (CloneNotSupportedException e) {
                mac = Mac.getInstance(ALGORITHM);
            }
            mac.init(new SecretKeySpec(key, ALGORITHM));
            return mac.doFinal(data);
        }
        catch(NoSuchAlgorithmException ex) {
            throw new RuntimeException("Unsupported algorithm: " + ALGORITHM, ex);
        }
        catch(InvalidKeyException ex) {
            throw new RuntimeException("Invalid key: " + key, ex);
        }
    }

}

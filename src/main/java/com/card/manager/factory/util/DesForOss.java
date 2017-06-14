package com.card.manager.factory.util;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.crypto.spec.IvParameterSpec;

public class DesForOss {

	private static byte[] encryptByDES(byte[] bytP, byte[] bytKey) throws Exception {
		DESKeySpec desKS = new DESKeySpec(bytKey);
		SecretKeyFactory skf = SecretKeyFactory.getInstance("DES");
		IvParameterSpec zeroIv = new IvParameterSpec(bytKey);
		SecretKey sk = skf.generateSecret(desKS);
		Cipher cip = Cipher.getInstance("DES/CBC/PKCS5Padding");
		cip.init(Cipher.ENCRYPT_MODE, sk, zeroIv);
		return cip.doFinal(bytP);
	}

	public static String encry(String skey, String content) throws Exception {
		skey = "YnNnLjIwMTY=";
		byte[] keyBytes = new sun.misc.BASE64Decoder().decodeBuffer(skey);
		byte[] encryptBytes = encryptByDES(content.getBytes("utf8"), keyBytes);
		return com.sun.org.apache.xerces.internal.impl.dv.util.Base64.encode(encryptBytes);

	}

}

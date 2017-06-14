package com.card.manager.factory.util;

import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class StringUtil {

	static int index = 0;
	static final int MAX = 99999;
	static SimpleDateFormat fm = new SimpleDateFormat("yyMMddHHmmss");

	/**
	 * 将字符串"元"转换成"分"
	 */
	public static String Dollar2Cent(String s) {
		s = trim(s);
		int i = s.indexOf(".");
		if (i == -1)
			return s + "00";
		String intStr = s.substring(0, i);
		if (intStr.length() <= 0)
			intStr = "0";
		String decStr = s.substring(i + 1, s.length());
		if (decStr.length() <= 0)
			decStr = "00";
		if (decStr.length() == 1)
			decStr += "0";
		if (decStr.length() > 2)
			decStr = decStr.substring(0, 2);
		int iInt = Integer.parseInt(intStr);
		if (iInt <= 0)
			return decStr;
		else
			return intStr + decStr;
	}

	/**
	 * 将字符串"分"转换成"元"（长格式），如：100分被转换为1.00元。
	 */
	public static String Cent2Dollar(String s) {
		long l = 0;
		try {
			if (s.charAt(0) == '+') {
				s = s.substring(1);
			}
			l = Long.parseLong(s);
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
		boolean negative = false;
		if (l < 0) {
			negative = true;
			l = Math.abs(l);
		}
		s = Long.toString(l);
		if (s.length() == 1)
			return (negative ? ("-0.0" + s) : ("0.0" + s));
		if (s.length() == 2)
			return (negative ? ("-0." + s) : ("0." + s));
		else
			return (negative ? ("-" + s.substring(0, s.length() - 2) + "." + s
					.substring(s.length() - 2)) : (s.substring(0,
					s.length() - 2) + "." + s.substring(s.length() - 2)));
	}

	/**
	 * 将字符串"分"转换成"元"（短格式），如：100分被转换为1元。
	 */
	public static String Cent2DollarShort(String s) {
		String ss = Cent2Dollar(s);
		ss = "" + Double.parseDouble(ss);
		if (ss.endsWith(".0"))
			return ss.substring(0, ss.length() - 2);
		if (ss.endsWith(".00"))
			return ss.substring(0, ss.length() - 3);
		else
			return ss;
	}

	/*
	 * 去掉字符串首尾的 <空格字符>（包括TAB），如果s为null则返回空字符串""。
	 */
	public static String trim(String s) {
		if (s == null)
			return "";
		else
			return s.trim();
	}

	/**
	 * 判断是否为空
	 * 
	 * @param src
	 * @return
	 */
	public static boolean isEmpty(String src) {
		return src == null ? true : "".equals(src.trim());
	}

	/**
	 * 判断是否均为空
	 * 
	 * @param src
	 * @return
	 */
	public static boolean isEmptyAnd(String... srcs) {
		for (String src : srcs) {
			if (!isEmpty(src)) {
				return false;
			}
		}
		return true;
	}

	/**
	 * 判断是否有一个为空
	 * 
	 * @param src
	 * @return
	 */
	public static boolean isEmptyOr(String... srcs) {
		for (String src : srcs) {
			if (isEmpty(src)) {
				return true;
			}
		}
		return false;
	}

	public static char ByteToHexChar(byte c) {
		if (c >= 0 && c <= 9)
			return (char) (c + '0');
		else if (c >= 10 && c <= 15)
			return (char) (c + 'a' - 10);
		else
			return (char) 0;
	}

	/**
	 * 获取网页的meta标签数据
	 * 
	 * @param sb
	 * @return
	 */
	public static String getMeta(StringBuffer sb) {
		try {
			while (true) {
				// find ">"
				int ei = sb.indexOf(">");
				if (ei == -1)
					return null;
				String str = sb.substring(0, ei + 1);
				sb.delete(0, ei + 1);
				// find "<"
				int si = str.indexOf("<");
				if (si == -1)
					continue;
				// 获得字符串"<...>"
				str = str.substring(si);
				// 删除 字符串"<...>"中的回车换行\r\n \r \n都换成" "
				str = str.replace('\r', ' ');
				str = str.replace('\n', ' ');
				StringBuffer sbf = new StringBuffer(str);
				// 删除 "<" 和后面单词直接的空格 meta"from "< Meta Name=...>" find first " "
				while (sbf.charAt(1) == ' ') {
					sbf.delete(1, 2);
				}
				// 查找第一个单词后的空格，并取出第一个单词
				ei = sbf.indexOf(" ");
				if (ei < 0)
					ei = sbf.indexOf(">");
				if (ei == -1)
					continue;
				String tag = sbf.substring(1, ei);
				if (tag.equalsIgnoreCase("meta")) {
					int index = sbf.indexOf(" CONTENT");
					if (index == -1)
						continue;
					sbf.delete(0, index);
					index = sbf.indexOf("=");
					sbf.delete(0, index);
					index = sbf.indexOf("\"");
					sbf.delete(0, index + 1);
					index = sbf.lastIndexOf("\"");
					sbf.delete(index, sbf.length());

					return sbf.toString();
				}
			}
		} catch (Exception e) {
			return null;
		}
	}

	/**
	 * @param src
	 * @param len
	 * @param fillWith
	 * @return 把src串用fillwith左补足到len长
	 * 
	 */
	public static String leftFillStr(String src, int len, byte fillWith) {
		try {
			byte[] srcbyte;
			if (src != null) {
				srcbyte = src.getBytes("GBK");
			} else {
				srcbyte = new byte[0];
			}

			if (srcbyte.length >= len) {
				return src;
			}
			byte[] tmp = new byte[len];
			int fulllen = len - srcbyte.length;
			for (int i = 0; i < fulllen; i++) {
				tmp[i] = fillWith;
			}
			System.arraycopy(srcbyte, 0, tmp, fulllen, srcbyte.length);
			return new String(tmp, "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}

	/**
	 * @param src
	 * @param len
	 * @param fillWith
	 * @return 把src串用fillwith左补足到len长 如果用空格补的话，"" 等同于 " "
	 */
	public static String leftFillStr(String src, int len, String fillWith) {
		if ("".equals(fillWith))
			fillWith = " ";
		byte fill = fillWith.getBytes()[0];
		return leftFillStr(src, len, fill);
	}

	/**
	 * 右填充
	 * 
	 * @param src
	 * @param len
	 * @param fillWith
	 * @return
	 */
	public static String rightFillStr(String src, int len, String fillWith) {
		if (src == null)
			src = "";
		if (fillWith == null || "".equals(fillWith))
			fillWith = " ";
		byte[] fill = fillWith.getBytes();
		try {
			byte[] srcbyte = null;
			if (src != null) {
				srcbyte = src.getBytes("GBK");
			}
			if (srcbyte.length >= len) {
				return src;
			}
			byte[] tmp = new byte[len];
			int i = srcbyte.length;
			for (; i < len; i++) {
				tmp[i] = fill[0];
			}
			System.arraycopy(srcbyte, 0, tmp, 0, srcbyte.length);
			return new String(tmp, "GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return "";
		}
	}

	public static boolean checkNum(String str) {
		Pattern p = Pattern.compile("\\d+");
		Matcher m = p.matcher(str);
		return m.matches();
	}

	/**
	 * 十六进制字符串转换成十六进制BYTE数组
	 * 
	 * @param hex
	 *            String 十六进制字符串，注意：字母须大写
	 * @return String 转换后的字符串
	 */
	public static byte[] hex2bin(String hex) {
		String digital = "0123456789ABCDEF";
		char[] hex2char = hex.toCharArray();
		byte[] bytes = new byte[hex.length() / 2];
		int temp;
		for (int i = 0; i < bytes.length; i++) {
			temp = digital.indexOf(hex2char[2 * i]) * 16;
			temp += digital.indexOf(hex2char[2 * i + 1]);
			bytes[i] = (byte) (temp & 0xff);
		}
		return bytes;
	}

	/**
	 * 产生自定义位数的随机数
	 * 
	 * @param len
	 * @return
	 */
	public static String getRandomNum(int len) {
		int count = 0;

		char str[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' };

		StringBuffer randomNum = new StringBuffer("");

		Random random = new Random();

		while (count < len) {

			int i = Math.abs(random.nextInt(10));

			if (i >= 0 && i < str.length) {
				randomNum.append(str[i]);
				count++;
			}
		}

		return randomNum.toString();
	}
	
	/**
	 * 转换为十六进制
	 * 
	 * @param str
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String str2Hex(String str) {
		byte[] b = null;
		StringBuffer sb = null;
		try {
			b = str.getBytes("GBK");

			sb = new StringBuffer();
			for (int i = 0; i < b.length; i++) {
				String hex = Integer.toHexString(b[i] & 0xFF);
				if (hex.length() == 1) {
					hex = '0' + hex;
				}
				sb.append(hex);
			}
		} catch (UnsupportedEncodingException e) {
		}
		return sb.toString().toUpperCase();
	}

	/**
	 * 16进制转换为byte数组
	 * 
	 * @param hexStr
	 * @return
	 */
	public static byte[] hex2byte(String hexStr) {
		byte[] bts = new byte[hexStr.length() / 2];
		for (int i = 0, j = 0; j < bts.length; j++) {
			bts[j] = (byte) Integer.parseInt(hexStr.substring(i, i + 2), 16);
			i += 2;
		}
		return bts;
	}

	/**
	 * 16进制转换为字符串
	 * 
	 * @param hexStr
	 * @return
	 */
	public static String hex2Str(String hexStr) throws UnsupportedEncodingException {
		byte[] bt = hex2byte(hexStr);
		return new String(bt, "GBK");
	}
	
	/**
	 * 去除换行符
	 * @param str
	 * @return
	 */
	public static String replaceBlank(String str) {
        String dest = "";
        if (str!=null) {
            Pattern p = Pattern.compile("^\\t|\\r|\\n");
            Matcher m = p.matcher(str);
            dest = m.replaceAll("");
        }
        return dest;
    }
	/**
	 * 去除数字 后面00，数据库存放数字 5位小数点，直接去掉2位
	 * @param str
	 * @return
	 */
	public static String splitZero(String str) {
        if(str != null && str.length()>2){
        	str  = str.substring(0, str.length()-2);
        }
        return str;
    }
	
	public static void main(String[] args) {
		System.out.println(StringUtil.splitZero("986.00000"));
	}
}

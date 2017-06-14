package com.card.manager.factory.log;

import java.util.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;

public class Test {
	public static void main(String[] args) throws ParseException {
			long time = 1473645233665L;
			SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
			Date date = new Date(time);
			System.out.println(sdf.format(date));
			
			
	}
}

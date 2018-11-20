package com.card.manager.factory.exception;

public class WxCodeException extends Exception{

	/**  
	 * serialVersionUID:TODO(用一句话描述这个变量表示什么).  
	 * @since JDK 1.7  
	 */
	private static final long serialVersionUID = 1L;
	
	private String code;
	
	public WxCodeException(String code,String errorMsg){
		super(errorMsg);
		this.code = code;
	}
	
	public WxCodeException(String errorMsg){
		super(errorMsg);
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

}

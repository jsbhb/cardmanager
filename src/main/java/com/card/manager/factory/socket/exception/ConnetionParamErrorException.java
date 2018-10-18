package com.card.manager.factory.socket.exception;

public class ConnetionParamErrorException extends Exception {

	private static final long serialVersionUID = 1L;
	
	public ConnetionParamErrorException(){
		super();
	}
	public ConnetionParamErrorException(String message){
		super(message);
	}
	public ConnetionParamErrorException(String message, Throwable cause){
		super(message, cause);
	}
	public ConnetionParamErrorException(Throwable cause){
		super(cause);
	}
}

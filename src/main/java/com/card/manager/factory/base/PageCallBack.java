package com.card.manager.factory.base;

/**
 * 
 * @author 贺斌
 * @datetime  2016年7月27日
 * @func 页面回传
 */
public class PageCallBack {
	private boolean isSuccess;
	private String errTrace;
	private Object obj;
	private Pagination pagination;
	private Object object;

	public Object getObject() {
		return object;
	}

	public void setObject(Object object) {
		this.object = object;
	}

	public PageCallBack() {
	}

	public PageCallBack(boolean res, Object obj) {
		this.isSuccess = res;
		this.obj = obj;
	}

	public boolean isSuccess() {
		return isSuccess;
	}

	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
	}

	public String getErrTrace() {
		return errTrace;
	}

	public void setErrTrace(String errTrace) {
		this.errTrace = errTrace;
	}

	public void setObj(Object obj) {
		this.obj = obj;
	}

	public Object getObj() {
		return obj;
	}

	public Pagination getPagination() {
		return pagination;
	}

	public void setPagination(Pagination pagination) {
		this.pagination = pagination;
	}


}

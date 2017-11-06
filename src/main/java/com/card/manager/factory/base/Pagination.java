package com.card.manager.factory.base;

import net.sf.json.JSONObject;

/**
 * 
 * ClassName: Pagination <br/>  
 * Function: 分页组件. <br/>   
 * date: Oct 29, 2017 8:00:08 PM <br/>  
 *  
 * @author hebin  
 * @version   
 * @since JDK 1.7
 */
public class Pagination {
	private int numPerPage;
	private Long totalRows;
	private int totalPages;
	private int currentPage;
	private int startIndex;
	private int lastIndex;

	/**  
	 * Creates a new instance of Pagination.  
	 *  
	 * @param pJson  
	 */  
	public Pagination(){
		
	}
	
	public Pagination(JSONObject pJson) {
		this.numPerPage = pJson.getInt("numPerPage");
		this.totalRows = pJson.getLong("totalRows");
		this.totalPages = pJson.getInt("totalPages");
		this.currentPage = pJson.getInt("currentPage");
		this.startIndex = pJson.getInt("startIndex");
		this.lastIndex = pJson.getInt("lastIndex");
	}

	public int getNumPerPage() {
		return numPerPage;
	}

	public void setNumPerPage(int numPerPage) {
		this.numPerPage = numPerPage;
	}

	public Long getTotalRows() {
		return totalRows;
	}

	public void setTotalRows(Long totalRows) {
		this.totalRows = totalRows;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(int startIndex) {
		this.startIndex = startIndex;
	}

	public int getLastIndex() {
		return lastIndex;
	}

	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

}

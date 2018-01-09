/**  
 * Project Name:cardmanager  
 * File Name:SpecsPojo.java  
 * Package Name:com.card.manager.factory.goods.pojo  
 * Date:Dec 4, 20174:26:46 PM  
 *  
 */
package com.card.manager.factory.goods.pojo;

/**
 * ClassName: SpecsPojo <br/>
 * Function: 前端规格信息. <br/>
 * date: Dec 4, 2017 4:26:46 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class SpecsPojo {

	private String templateName;
	private String specsName;
	private String specsValue;
	private int templateId;
	private int specsId;

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getSpecsName() {
		return specsName;
	}

	public void setSpecsName(String specsName) {
		this.specsName = specsName;
	}

	public String getSpecsValue() {
		return specsValue;
	}

	public void setSpecsValue(String specsValue) {
		this.specsValue = specsValue;
	}

	public int getTemplateId() {
		return templateId;
	}

	public void setTemplateId(int templateId) {
		this.templateId = templateId;
	}

	public int getSpecsId() {
		return specsId;
	}

	public void setSpecsId(int specsId) {
		this.specsId = specsId;
	}

}

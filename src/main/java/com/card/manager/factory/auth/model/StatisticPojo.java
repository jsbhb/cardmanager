/**  
 * Project Name:cardmanager  
 * File Name:StatisticPojo.java  
 * Package Name:com.card.manager.factory.auth.model  
 * Date:Apr 27, 20183:54:05 PM  
 *  
 */
package com.card.manager.factory.auth.model;

import java.util.List;

/**
 * ClassName: StatisticPojo <br/>
 * Function: TODO ADD FUNCTION. <br/>
 * date: Apr 27, 2018 3:54:05 PM <br/>
 * 
 * @author hebin
 * @version
 * @since JDK 1.7
 */
public class StatisticPojo {

	private List<DiagramPojo> diagramData;
	private List<DiagramPojo> chartData;

	public StatisticPojo(List<DiagramPojo> diagramData, List<DiagramPojo> chartData) {
		this.diagramData = diagramData;
		this.chartData = chartData;
	}

	public StatisticPojo() {
	}

	public List<DiagramPojo> getDiagramData() {
		return diagramData;
	}

	public void setDiagramData(List<DiagramPojo> diagramData) {
		this.diagramData = diagramData;
	}

	public List<DiagramPojo> getChartData() {
		return chartData;
	}

	public void setChartData(List<DiagramPojo> chartData) {
		this.chartData = chartData;
	}

}

function setCharts(em,option){
    //创建图表
    var myChart = echarts.init(document.getElementById(em));
    myChart.setOption(option);
}
function setCharts(em,option){
    //创建图表
    require.config({
        paths: {
            echarts: '../plugins/build/dist'
        }
    });
    require(
        [
            'echarts',
            'echarts/chart/pie',//饼图
            'echarts/chart/line',//折线图
            'echarts/chart/bar',//柱状图
            'echarts/chart/funnel'//d
        ],
        function (ec) {
            var myChart = ec.init(document.getElementById(em));
            myChart.setOption(option);
        }
    );
}
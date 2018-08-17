function setImgScroll(ele,data){
    var htm =  '<img src="'+ data.host +'/img/icon_prev.png" class="prevBtn"><ul>';
    $.each(data.imgList,function(index,val){
        if(data.activeIndex == index){
            htm += '<li class="active" data-id="'+ index +'"><img src="'+ val +'"></li>'
        }else{
            htm += '<li data-id="'+ index +'"><img src="'+ val +'"></li>'
        }
    });
    htm += '</ul><img src="'+ data.host +'/img/icon_next.png" class="nextBtn">';
    $('.' + ele).html(htm);
    if(data.imgWidth != 0 && data.imgWidth != undefined){
        $('.' + ele).css('width',data.imgWidth + 300 + 'px');
        $('.' + ele).css('height',data.imgHeight + 'px');
        $('.' + ele).find('ul li img').css('width',data.imgWidth + 'px');
        $('.' + ele).find('ul li img').css('height',data.imgHeight + 'px');
    }
    $('.' + ele).on('click','.prevBtn',function(){
        var dataId = $('.'+ ele +' li.active').attr('data-id');
        if(dataId == 0){
            dataId = (data.imgList.length - 1);
        }else{
            dataId --;
        }
        $('.' + ele).find('li[data-id="'+dataId+'"]').fadeIn(500).addClass('active').siblings('.active').hide().removeClass('active');
    });
    $('.' + ele).on('click','.nextBtn',function(){
        var dataId = $('.'+ ele +' li.active').attr('data-id');
        if(dataId == (data.imgList.length - 1)){
            dataId = 0;
        }else{
            dataId ++;
        }
        $('.' + ele).find('li[data-id="'+dataId+'"]').fadeIn(500).addClass('active').siblings('.active').hide().removeClass('active');
    });
}
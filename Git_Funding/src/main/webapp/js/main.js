/* ---------------------- SEARCH -----------------------*/
$('.search_more').click(function(){
    if(!$(this).hasClass('rotate')){
        $(this).addClass('rotate');
        $('.search_list').css({display:'block'});    
    }else{
        $(this).removeClass('rotate');
        $('.search_list').css({display:'none'});    
    }
})
$('.search_list button').click(function(){
    $('.search_more').removeClass('rotate');
    $('.search_list').css({display:'none'});
})
$('#search_cate .category .next').click(function(){
    $(this).siblings('.prev').css({display:'block'});
    $(this).css({display:"none"});
    $('#search_cate .cate_list').addClass('scroll')
})
$('#search_cate .category .prev').click(function(){
    $(this).siblings('.next').css({display:'block'});
    $(this).css({display:"none"});
    $('#search_cate .cate_list').removeClass('scroll');
})

let best_keyword=function(){
    timer=setTimeout(function(){
        $('#search_cate .rolling li:first').animate( {marginTop:'-54px'},500,function(){
            $(this).detach().appendTo('.rolling ol').removeAttr('style');
        });
        best_keyword();
    }, 2000);         
};
let keyword_pause = function(){
    $('#search_cate .rolling ol').mouseover(function(){
      clearTimeout(timer);
    }).mouseout(function(){
        best_keyword();
    });  
};
best_keyword();
keyword_pause();

/* ---------------------- BANNER & LANK -----------------------*/
$('#banner .main_slide').slick();

$('.rank .rank_tab li').click(function(e){
    e.preventDefault()
    $(this).addClass('active');
    $(this).siblings('li').removeClass('active');
})

/* ---------------- OPEN & DEADLINE & LATEST -----------------*/
$('#main .multiple_slide').slick({
    infinite: true,
    slidesToShow: 5,
    slidesToScroll: 1,
    arrows:true,
    speed: 500,
    pauseOnHover:false
});

let date=new Date();
let year = date.getFullYear();
let month = ('0' + (date.getMonth() + 1)).slice(-2);
let day = ('0' + date.getDate()).slice(-2);
let today = year + '/' + month  + '/' + day;
$('#main #deadline .clock').countdown(today+' 24:00:00',function(e){
    $(this).text(e.strftime('%H:%M:%S'));
})

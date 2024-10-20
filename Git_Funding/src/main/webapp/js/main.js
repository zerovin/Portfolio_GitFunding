window.onload=function () {
	/* --------------- LOGIN -----------------*/
	if($('#login').length > 0){
		let login_input=$('#login form .login_box input');
		login_input.change(function(){
			if($(this).val()!==""){
				$(this).siblings('label').addClass('active');
			}else{
				$(this).siblings('label').removeClass('active');
			}
		})
	}
	
	/* ---------------------- MAIN -----------------------*/
	if($('#main').length > 0){
		/* ----------------- SEARCH ------------------*/
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
		
		/* ------------- BANNER & LANK --------------*/
		$('#banner .main_slide').slick({
			autoplay:true,
			speed:500
		});
		
		$('.rank .rank_tab li').click(function(e){
		    e.preventDefault()
		    $(this).addClass('active');
		    $(this).siblings('li').removeClass('active');
		})
		
		/* ------- OPEN & DEADLINE & LATEST ------------*/
		/*
		$('#main .multiple_slide').slick({
		    infinite: true,
		    slidesToShow: 5,
		    slidesToScroll: 1,
		    arrows:true,
		    speed: 500,
		    pauseOnHover:false
		});
		*/
		
		//open_slide
	    let sliderWrapper = document.querySelector("#open .multiple_slide_wrapper"),
	        sliderUl = sliderWrapper.querySelector(".multiple_slide");
	    let currentIdx = 0,
	        //slideCount=sliderUl.children.length,
	        slideWidth = 220,
	        slideMargin = 20,
	        prevBtn = document.querySelector("#open .arrows .prev"),
	        nextBtn = document.querySelector("#open .arrows .next");
	    if(slideCount<=5){
	        prevBtn.style.display='none';
	        nextBtn.style.display='none';
	    }
	    function moveSlide(idx) {
	        sliderUl.style.left = -idx * (slideWidth + slideMargin) + "px";
	        currentIdx = idx;
	    }
	    //버튼으로 이동하기
	    nextBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (currentIdx == slideCount - 5) {
	            moveSlide(0);
	        } else {
	            moveSlide(currentIdx + 1);
	        }
	    });
	    prevBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (currentIdx == 0) {
	            moveSlide(slideCount - 5);
	        } else {
	            moveSlide(currentIdx - 1);
	        }
	    });
	
	    //deadline_slide
	    let d_sliderWrapper = document.querySelector("#deadline .multiple_slide_wrapper"),
	        d_sliderUl = d_sliderWrapper.querySelector(".multiple_slide");
	    let d_currentIdx = 0,
	        //d_slideCount=d_sliderUl.children.length,
	        d_slideWidth = 220,
	        d_slideMargin = 20,
	        d_prevBtn = document.querySelector("#deadline .arrows .prev"),
	        d_nextBtn = document.querySelector("#deadline .arrows .next");
	    if(d_slideCount<=5){
	        d_prevBtn.style.display='none';
	        d_nextBtn.style.display='none';
	    }
	    function d_moveSlide(idx) {
	        d_sliderUl.style.left = -idx * (d_slideWidth + d_slideMargin) + "px";
	        d_currentIdx = idx;
	    }
	    //버튼으로 이동하기
	    d_nextBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (d_currentIdx == d_slideCount - 5) {
	            d_moveSlide(0);
	        } else {
	            d_moveSlide(d_currentIdx + 1);
	        }
	    });
	    d_prevBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (d_currentIdx == 0) {
	            d_moveSlide(d_slideCount - 5);
	        } else {
	            d_moveSlide(d_currentIdx - 1);
	        }
	    });
		
		let date=new Date();
		let year = date.getFullYear();
		let month = ('0' + (date.getMonth() + 1)).slice(-2);
		let day = ('0' + date.getDate()).slice(-2);
		let today = year + '/' + month  + '/' + day;
		$('#main #deadline .clock').countdown(today+' 24:00:00',function(e){
		    $(this).text(e.strftime('%H:%M:%S'));
		})
	
		 //latest_slide
	    let l_sliderWrapper = document.querySelector("#latest .multiple_slide_wrapper"),
	        l_sliderUl = document.querySelector("#latest .multiple_slide");
	    let l_currentIdx = 0,
	        //l_slideCount=l_sliderUl.children.length,
	        l_slideWidth = 220,
	        l_slideMargin = 20,
	        l_prevBtn = document.querySelector("#latest .arrows .prev"),
	        l_nextBtn = document.querySelector("#latest .arrows .next");
	    if(l_slideCount<=5){
	        l_prevBtn.style.display='none';
	        l_nextBtn.style.display='none';
	    }
	    function l_moveSlide(idx) {
	        l_sliderUl.style.left = -idx * (l_slideWidth + l_slideMargin) + "px";
	        l_currentIdx = idx;
	    }
	    //버튼으로 이동하기
	    l_nextBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (l_currentIdx == l_slideCount - 5) {
	            l_moveSlide(0);
	        } else {
	            l_moveSlide(l_currentIdx + 1);
	        }
	    });
	    l_prevBtn.addEventListener("click", function (e) {
	        e.preventDefault();
	        if (l_currentIdx == 0) {
	            l_moveSlide(l_slideCount - 5);
	        } else {
	            l_moveSlide(l_currentIdx - 1);
	        }
	    });
	    
	    console.log(slideCount);
	    console.log(d_slideCount);
	    console.log(l_slideCount);
	}
	
	/* ----------------- CATEGORY ------------------*/
	if($('.category').length > 0){
		$('.category .next').click(function(){
		    $(this).siblings('.prev').css({display:'block'});
		    $(this).css({display:"none"});
		    $('.cate_list').addClass('scroll')
		})
		$('.category .prev').click(function(){
		    $(this).siblings('.next').css({display:'block'});
		    $(this).css({display:"none"});
		    $('.cate_list').removeClass('scroll');
		})
	}
	
	
	/* ---------------- FUNDING DETAIL -----------------*/
	if($('#funding_detail').length>0){
	    let detail_tab=$('.detail_tab'),
	        tabOST=detail_tab.offset().top
	    $(window).scroll(function(){
	        let scrollAmt=$(window).scrollTop();
	        if(scrollAmt > tabOST){
	            detail_tab.css({
	                position:'sticky',
	                top:0
	            })
	        }else{
	            detail_tab.css({position:'static'})
	        }
	    })
	
	    $('.share').click(function(){
			let temp=document.createElement("textarea");
			document.body.appendChild(temp);
			let current_url=window.document.location.href;
			temp.value = current_url;
			temp.select();
			document.execCommand("copy");
			document.body.removeChild(temp);
			alert("현재 URL이 복사되었습니다.");
		})
	
	    let reward_wrap=$('.reward_wrap'),
	        rewardOST=detail_tab.offset().top
	    $(window).scroll(function(){
	        let scrollAmt=$(window).scrollTop();
	        if(scrollAmt > rewardOST){
	            reward_wrap.css({
	                position:'sticky',
	                top:'100px'
	            })
	        }else{
	            reward_wrap.css({position:'static'})
	        }
	    })
	
	    let readmore=$('.readmore');
	    readmore.click(function(){
	        if(!readmore.hasClass('active')){
	            $(this).siblings('.imgs').css({
	                height:'auto',
	                overflow:'auto'
	            })
	            $(this).html('상세내용 접기 <i class="fa-solid fa-chevron-up"></i>')
	            $(this).css({
	                boxShadow:'none'
	            })
	            readmore.addClass('active');
	        }else{
	            $(this).siblings('.imgs').css({
	                height:'2000px',
	                overflow:'hidden'
	            })
	            $(this).html('상세내용 더보기 <i class="fa-solid fa-chevron-down"></i>')
	            $(this).css({
	                boxShadow:'0 -30px 20px#fff'
	            })
	            readmore.removeClass('active')
	        }
	    })
	}
}





<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="../css/funding_list.css">
</head>
<body>
  <div class="container" id="funding_list">
	<div class="list_wrap">
            <ul class="list">
                <li v-for="vo in goods_list">
                    <a href="" class="f_list">
                        <img :src="vo.img" alt="">
                        <p class="percent"></p>
                        <p class="title">{{vo.title}}</p>
                        <p class="p_admin">{{vo.brand}}</p>
                        <div class="progress">
                            <div class="top">
                            	<p style="text-decoration-line: line-through;color: #899c8f;">{{vo.price}}</p>
                            </div>
                            <div class="top">
                            	<p>{{vo.realprice}}</p><p class="current"><span class="num">[{{vo.discount}}]</span></p>
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
    </div>
  </div>
	<script>
		let goods=Vue.createApp({
			data(){
				return{
					goods_list:[],
					curpage:1
				}
			},
			mounted(){
				this.dataRecv()
			},
			methods:{
				dataRecv(){
					axios.get("../goods/list_vue.do",{
						params:{
							page:this.curpage
						}
					}).then(response=>{
						console.log(response)
						this.goods_list=response.data.list
						console.log(this.list)
					})
				}
			}
		}).mount('.list_wrap')
	</script>
</body>
</html>
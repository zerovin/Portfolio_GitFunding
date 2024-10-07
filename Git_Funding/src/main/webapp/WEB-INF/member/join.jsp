<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<head>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="../css/join.css">
</head>
<body>
	<div id="join">
        <div class="tt_box">
            <h2>회원가입</h2>
        </div>
        <section class="join_wrap">
            <p><span>*</span> 필수입력사항</p>
            <form method="POST" action="../member/join_ok.do" id="join_form" @submit="submitForm()">
                <div class="center">
                    <div class="hasMsg">
                        <div class="input_wrap">
                            <label for="id">아이디<span>*</span></label>
                            <input type="text" id="userId" name="userId" v-model="userId" ref="userId" placeholder="아이디를 입력해주세요" required @keyup="idCheck()">
                        </div>
                        <p class="check_msg">{{idCheckMsg}}</p>
                    </div>
                    <div class="hasMsg">
	                    <div class="input_wrap">
	                        <label for="pw">비밀번호<span>*</span></label>
	                        <input type="password" id="userPwd" name="userPwd" ref="userPwd" v-model="userPwd" @keyup="pwValidate()" placeholder="공백없이 숫자, 영어를 혼합하여 8-20자리로 입력하세요." required>
	                    </div>
	                    <p class="check_msg">{{pwValidateMsg}}</p>
                    </div>
                    <div class="hasMsg">
	                    <div class="input_wrap">
	                        <label for="pw_check">비밀번호확인<span>*</span></label>
	                        <input type="password" id="pw_check" v-model="pw_check" ref="pw_check" @keyup="pwCheck()" placeholder="비밀번호를 한번 더 입력해주세요" required>
	                    </div>
	                    <p class="check_msg">{{pwCheckMsg}}</p>
                    </div>
                    <div class="input_wrap">
                        <label for="name">이름<span>*</span></label>
                        <input type="text" id="userName" name="userName" ref="userName" v-model="userName" placeholder="이름을 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <p class="label">성별</p>
                        <div class="radios">
                            <div class="radio_btn">
                                <label for="man">남자</label>
                                <input type="radio" id="man" name="gender" v-model="gender" value="남자">
                            </div>
                            <div class="radio_btn">
                                <label for="woman">여자</label>
                                <input type="radio" id="woman" name="gender" v-model="gender" value="여자">
                            </div>
                        </div>
                    </div>
                    <div class="input_wrap">
                        <label for="phone">휴대폰<span>*</span></label>
                        <input type="text" id="phone" name="phone" v-model="phone" placeholder="숫자만 입력해주세요" required>
                    </div>
                    <div class="input_wrap">
                        <label for="email_id">이메일<span>*</span></label>
                        <div>
                            <input type="text" id="email_id" name="email_id" ref="email_id" v-model="email_id" placeholder="ex&#41; git_funding" required>@
                            <select name="email_domain" v-model="email_domain">
                                <option selected value="naver.com">naver.com</option>
                                <option value="gmail.com">gmail.com</option>
                                <option value="hanmail.net">hanmail.net</option>
                                <option value="kakao.com">kakao.com</option>
                                <option value="daum.net">daum.net</option>
                                <option value="hotmail.com">hotmail.com</option>
                                <option value="yahoo.co.kr">yahoo.co.kr</option>
                            </select>
                        </div>
                    </div>
                    <div class="hasMsg">
                        <div class="input_wrap">
                            <label for="post">우편번호<span>*</span></label>
                            <input type="text" id="post" name="post" v-model="post" placeholder="검색버튼을 눌러주세요" required readonly>
                        </div>
                        <input type="button" class="post_search" value="우편번호 검색" @click="postSearch()">
                    </div>
                    <div class="input_wrap">
                        <label for="addr1">기본주소<span>*</span></label>
                        <input type="text" id="addr1" name="addr1" v-model="addr1" readonly>
                    </div>
                    <div class="input_wrap">
                        <label for="add2">상세주소</label>
                        <input type="text" id="addr2" name="addr2" v-model="addr2">
                    </div>
                    <div class="form_btns">
                        <button class="join_btn">회원가입</button>
                        <button onclick="javascript:history.back()">취소</button>
                    </div>
                </div>
            </form>
        </section>
    </div>
    <script>
    	let joinApp=Vue.createApp({
    		data(){
    			return{
    				userId:'',
    				idCheckMsg:'',
    				userPwd:'',
    				pwValidateMsg:'',
    				pwCheckMsg:'',
    				pw_check:'',
    				userName:'',
    				gender:'',
    				phone:'',
    				email_id:'',
    				email_domain:'',
    				post:'',
    				addr1:'',
    				addr2:''
    			}
    		},
    		methods:{
    			idCheck(){
    				axios.get('../member/idcheck_vue.do',{
    					params:{
    						userId:this.userId
    					}
    				}).then(response=>{
   	    				let kor=/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/
    					if(this.userId===''){
       						this.idCheckMsg=''
    					}else if(kor.exec(this.userId)!==null){
    	    				this.idCheckMsg='영문, 숫자만 입력가능합니다.'
       					}else{
	    					if(response.data===0){
	    						this.idCheckMsg='사용 가능한 아이디입니다.'
	    					}else{
	    						this.idCheckMsg='이미 사용중인 아이디입니다.'
	    						this.userId=""
	    						this.$refs.userId.focus()
	    					}       						
       					}
    				}).catch(error=>{
    					console.log(error.response)
    				})
    			},
    			postSearch(){
    				let _this=this
    				new daum.Postcode({
    					oncomplete:function(data){
    						_this.post=data.zonecode
    						_this.addr1=data.address
    					}
    				}).open()
    			},
    			pwValidate(){
    				let pw=String(this.userPwd)
    				let num=pw.search(/[0-9]/g)
    				let eng=pw.search(/[a-z]/g)
    				if(pw===''){
    					this.pwValidateMsg=""
    					return
    				}
    				if(pw.length<8 || pw.length>20){
    					this.pwValidateMsg="비밀번호는 8-20자리로 입력하세요."
    					return
    				}else if(pw.search(/\s/)!=-1){ // \s => 공백, 공백이 있다면
   						this.pwValidateMsg="비밀번호는 공백없이 입력하세요"
       					return
       				}else if(num<0 || eng<0){
       					this.pwValidateMsg="비밀번호는 영문, 숫자를 혼합해서 입력하세요."
       					return
       				}else{
       					this.pwValidateMsg=""
       					return
       				}
    			},
    			pwCheck(){
    				if(this.userPwd!=this.pw_check){
    					this.pwCheckMsg="비밀번호가 일치하지 않습니다"
    				}else{
    					this.pwCheckMsg=""
    				}
    			},
    			phoneValidate(){
    				$event.target.value = $event.target.value.replace(/[^0-9]/g, '')
    			},
    			submitForm(e){
    				if(this.userId && this.userName && this.userPwd && this.pw_check && this.gender && this.email_id 
    						&& this.post && this.addr1 && this.addr2 && this.idCheckMsg=='사용 가능한 아이디입니다.' && this.pwValidateMsg==""){
	   					alert("정상 수행")
	   					return true
	   				}
	   				if(this.userId==='' || this.idCheckMsg!='사용 가능한 아이디입니다.'){
	   					this.$refs.userId.focus()
	   				}else if(this.userName===''){
	   					this.$refs.userName.focus()
	   				}else if(this.userPwd===''){
	   					this.$refs.userPwd.focus()
	   				}else if(this.pw_check===''){
	   					this.$refs.pw_check.focus()
	   				}else if(this.userPwd!==this.pw_check){
	   					this.userPwd=''
	   					this.pw_check=''
	   				}else if(this.phone===''){
	   					this.$refs.phone.focus()
	   				}else if(this.email_id===''){
	   					this.$refs.email_id.focus()
	   				}
	   				e.preventDefault() 
    			}
    		}
    	}).mount('#join')
    </script>
</body>
</html>
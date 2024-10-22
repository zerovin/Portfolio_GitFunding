<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <div class="top">
     <p class="cate">{{funding_vo.type}}</p>
     <button class="share"><i class="fa-solid fa-share-nodes"></i>공유</button>
 </div>
 <div class="content">
     <p class="title">{{funding_vo.title}}</p>
     <p class="desc">{{funding_vo.description}}</p>
     <p class="p_admin">{{funding_vo.p_admin}}</p>
     <div class="num_icon">
         <div class="nums">
             <div>
                 <p class="big"><span class="num">{{funding_vo.fm_percent}}</span> % 달성</p>
                 <p class="small">{{funding_vo.dday}}일 남음</p>
             </div>
             <div>
                 <p class="big"><span class="num">{{funding_vo.fm_totalprice}}</span> 원 달성</p>
                 <p class="small">{{funding_vo.fm_headcount}}명 참여</p>
             </div>
             <p><span class="num">{{funding_vo.period}}</span> 진행</p>
         </div>
         <div class="icons">
             <button @click="wishUpdate(funding_vo.fno)" v-if="isWish===false"><i class="fa-regular fa-heart"></i>{{funding_vo.fm_wish}}</button>
             <button @click="wishDelete(funding_vo.fno)" v-else><i class="fa-solid fa-heart"></i>{{funding_vo.fm_wish}}</button>
             <button class="backingBtn" @click="backingWrite()"><i class="fa-regular fa-handshake"></i>{{funding_vo.fm_backing}}</button>
         </div>
     </div>
 </div>
 <div class="reward_wrap">
     <h2>리워드 선택</h2>
     <ul class="reward_list">
     	<li v-if="type==1" class="open_reward">오픈 예정입니다 ☺️</li>
         <li v-for="reward in reward_list" v-else>
             <button @click="rewardClick(fno, reward.rno)">
                 <div class="price_account">
                     <p class="price">{{reward.fm_price}}원</p>
                     <span class="account">현재 {{reward.amount}}개 남음!</span>
                 </div>
                 <p class="re_title">{{reward.name}}</p>
                 <pre>{{reward.description}}</pre>
                 <dl>
                     <dt>배송비</dt>
                     <dd>{{reward.fm_del}}</dd>
                 </dl>
                 <dl>
                     <dt>발송 시작일</dt>
                     <dd>{{reward.del_start}}</dd>
                 </dl>
                 <dl>
                     <dt>제한 수량</dt>
                     <dd>{{reward.fm_limit}}개</dd>
                 </dl>
             </button>
         </li>
     </ul>
 </div>
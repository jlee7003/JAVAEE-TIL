<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <script src="http://code.jquery.com/jquery-latest.js"></script>
 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script> 
 <script>
   $(function()
   {
	 $("#logo").mouseover(function()
	 {	
		$(this).animate(
		{
			color:"#bbbbbb"		
		},500);
	 });   
	 $("#logo").mouseout(function()
	 {
		 $(this).animate(
		 {
			color:"black"		
	 	 },500);
	 });
   });
   
 </script>
  <nav>
    <div id=logo> C H A N N Y </div>
    <ul id=start_menu>  <!-- li태그를 클릭하면 해당되는 하위메뉴의 ul태그를 보여라 -->
      <li class=main onclick=view(0,this,180)> SUITS 
        <ul class=menu>    <!-- 하위메뉴의 이름은 class=menu -->
          <li> 싱글수트 </li>
          <li> 스트라이프수트 </li>
          <li> 비즈니스수트 </li>
          <li> 더블수트 </li>
          <li> 체크수트 </li> 
          <li> 드레스슈즈 </li>
          <li> 수트악세사리</li>
        </ul>
      </li> 
      <li class=main onclick=view(1,this,120)> TOP 
        <ul class=menu>
          <li> 긴팔티셔츠 </li>
          <li> 반팔티셔츠 </li>
          <li> 헨리넥 </li>
          <li> 니트 </li>
        </ul>
      </li>
      <li class=main onclick=view(2,this,140)> SHIRTS 
        <ul class=menu>
          <li> 스트라이프셔츠 </li>
          <li> 오픈카라셔츠 </li>
          <li> 솔리드셔츠 </li>
          <li> 체크셔츠 </li>
          <li> Etc </li>
        </ul>
      </li>
      <li class=main onclick=view(3,this,160)> PANTS 
        <ul class=menu>
          <li> 슬랙스 </li>
          <li> 면바지 </li>
          <li> 청바지 </li>
          <li> 반바지 </li>
          <li> 조거팬츠 </li>
          <li> Etc </li>
        </ul>
      </li>
      <li class=main onclick=view(4,this,140)> OUTER
        <ul class=menu>
          <li> 코트 </li>
          <li> 자켓/블레이저 </li>
          <li> 가디건 </li>
          <li> 베스트 </li>
          <li> 점퍼 </li>
        </ul>  
      </li>
      <li class=main onclick=view(5,this,140)> SHOES  
        <ul class=menu>
          <li> 드레스슈즈 </li>
          <li> 스니커즈 </li>
          <li> 벨크만슈즈 </li>
          <li> 부츠/워커 </li>
          <li> Etc </li>
        </ul>
      </li>
      <li class=main onclick=view(6,this,300)> ACCESSORY 
        <ul class=menu>
          <li> 타이/행거치프 </li>
          <li> 머플러/스카프 </li>
          <li> 목걸이/팔찌 </li>
          <li> 벨트/서스펜더 </li>
          <li> 아이웨어 </li>
          <li> 모자 </li>
          <li> 가방 </li>
          <li> 타이핀/부토니에 </li>
          <li> 양말 </li>
          <li> 시계 </li>
          <li> 벨크만악세사리 </li>
          <li> 방향제 </li>
          <li> Etc</li>
        </ul>
      </li>
      <li> &nbsp; </li>
      <li> BEST </li>
      <li> NEW </li>
    </ul>
    
    <ul>
      <li> 돋보기 </li>
    </ul>
    
    <ul>
      <li> LOGIN </li>
      <li> MY ACCOUNT </li>
      <li> CART </li>
      <li> Q&A / REVIEW </li>
    </ul>
  </nav>
 
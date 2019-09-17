<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@page import="java.time.LocalDate" %>    
<%@ include file="../top.jsp" %> 
<%@page import="java.sql.*" %>   
<%  
  String aa="jdbc:mysql://localhost:3307/pension?useSSL=false";
  String bb="root";
  String cc="1234";
  Connection conn = DriverManager.getConnection(aa,bb,cc);
  Statement stmt=conn.createStatement();
 
   request.setCharacterEncoding("utf-8");
   // reserve.jsp에서 보낸 값을 저장하기
   String bang=request.getParameter("bang"); // 방이름
   String y=request.getParameter("y");
   String m=request.getParameter("m");
   if(m.length()==1)
	   m="0"+m; // 1~9일 경우  => 0을 앞에 붙인다..
   String d=request.getParameter("d");
   if(d.length()==1)
	   d="0"+d;
   
   // DB에 저장될 날짜형식 => 2019-07-01
   String date=y+"-"+m+"-"+d;
   //out.print(date);
   
   // 현재 사용자가 선택한 방의 정보를 읽어오기
   // 숙박금액, 기준인원, 최대인원
   String sql="select * from bang where name='"+bang+"'";
   ResultSet rs=stmt.executeQuery(sql);
   rs.next();
%> 
<script>
   var first=<%=rs.getInt("price")%>;  // 숙박요금
   var second=0; // 추가요금
   window.onload=function() // 문서를 읽을때 function(){} 실행
   {   
	   // 숙박은 첫번재 option태그이므로 추가해줄 필요X
	   //document.pkc.sung.selectedIndex=1; // 기준인원:2명
	   document.pkc.sung.value=<%=rs.getInt("min_in")%>;
	   document.getElementById("tot").innerText="<%=rs.getInt("price")%>";
	   document.getElementById("chong").innerText="<%=rs.getInt("price")%>";
	   document.pkc.suk_price.value=<%=rs.getInt("price")%>; // 문서를 읽을때
   }
   function cal() // 숙박과 인원을 계산하여 합계금액 전달
   {
	   var s=document.pkc.suk.value;// 숙박일수
	   var s_price=s*<%=rs.getInt("price")%>; // 숙박일수에 따른 금액 a
	   //alert(s_price);
	   var n1=parseInt(document.pkc.sung.value); // 성인인원
	   var n2=eval(document.pkc.child.value);  // 아동인원
	   var inwon=n1+n2; // 총인원
	   if(inwon><%=rs.getInt("max_in")%>) // 최대값을 넘을경우 기준인원으로 수정
	   {
		   document.pkc.sung.value=<%=rs.getInt("min_in")%>;
		   document.pkc.child.selectedIndex=0;
		   inwon=<%=rs.getInt("min_in")%>;
	   }

	   //alert(inwon);
	   var chuga=inwon-<%=rs.getInt("min_in")%>; // 총인원-기준인원
	   if(chuga > 0)// 총인원에 대한 금액 b
	     var in_price=chuga*10000; // 3명이상일때 
	   else
		 var in_price=0;  // 1~2명일 경우
	   //alert(in_price);
	   // tot인 곳에 a+b금액을 전달 
	   first=s_price+in_price; // 계산되어진 숙박요금을 변수에 저장
	   document.pkc.suk_price.value=first; // type=hidden
	   document.getElementById("chong").innerText=comma(first+second);
	   var tot_price=comma(s_price+in_price);
	   document.getElementById("tot").innerText=tot_price;

   }
   function comma(price)
   {  
	   price=price+"";
	   price=price.replace(/\B(?=(\d{3})+(?!\d))/g,",");
	   return price;
   }
   function chuga_cal() // 추가금액 계산 함수
   {
	   
	   if(document.pkc.spa.checked) // 체크가 되었다면
		   var p1=parseInt(document.pkc.spa.value);
	   else
		   var p1=0;
	   
	   if(document.pkc.charo.checked)
	       var p2=parseInt(document.pkc.charo.value);
	   else
		   var p2=0;
	   
	   if(document.pkc.bbq.checked)
	       var p3=parseInt(document.pkc.bbq.value);
	   else
		   var p3=0;
	   
	   second=p1+p2+p3; // 추가요금을 변수에 저장
	   document.pkc.chu_price.value=second;
	   document.getElementById("chong").innerText=comma(first+second);
	   document.getElementById("chu").innerText=comma(p1+p2+p3);
   }
 </script>
<div id=section>
 <form name=pkc method=post action=input_ok.jsp> <!-- form태그내의 입력양식 -->
  <input type=hidden name=suk_price>
  <input type=hidden name=chu_price> <!-- value가 없다 => 자바스크립트에서 전달 -->
  <input type=hidden name=bang value="<%=bang%>">
  <input type=hidden name=y value=<%=y%>>
  <input type=hidden name=m value=<%=m%>>
  <input type=hidden name=d value=<%=d%>>
   <table width=600 align=center>
     <tr>
       <td> 예약 방 </td>
       <td> <%=bang%> </td>
     </tr>
     <tr>
       <td> 예약자 </td>
       <td> <input type=text name=name> </td>
     </tr>
     <tr>
       <td> 전화번호 </td>
       <td> <input type=text name=phone> </td>
     </tr>
     <tr>
       <td> 입실일 </td>
       <td> <%=date%></td>
     </tr>
     <tr>
       <td colspan=2>
         <!-- inwon.jsp있던거 복사 시작 --> 

   기준2/최대6  <!-- bang테이블에 있는 필드값으로 변경 -->
  
  <select name=suk onchange=cal()>
    <option value=1> 1박 </option>
    <option value=2> 2박 </option>
    <option value=3> 3박 </option>
    <option value=4> 4박 </option>
  </select>
  
  성인 
  <select name=sung onchange=cal()>
    <option value=1> 1명 </option> <!-- selectedIndex 0 -->
    <option value=2> 2명 </option> <!-- selectedIndex 1 -->
    <option value=3> 3명 </option> <!-- selectedIndex 2 -->
    <option value=4> 4명 </option> <!-- selectedIndex 3 -->
    <option value=5> 5명 </option> <!-- selectedIndex 4 -->
    <option value=6> 6명 </option> <!-- selectedIndex 5 -->
  </select>
 아동
  <select name=child onchange=cal()>
    <option value=0> 0명 </option>
    <option value=1> 1명 </option>
    <option value=2> 2명 </option>
    <option value=3> 3명 </option>
    <option value=4> 4명 </option>
    <option value=5> 5명 </option>
    <option value=6> 6명 </option>
  </select>
 숙박금액 : <span id=tot></span>원  <p>
 <input type=checkbox name=spa onclick=chuga_cal() value=50000> 스파추가 50,000원  <p>
 <input type=checkbox name=charo onclick=chuga_cal() value=30000> 숯불세트 30,000원  <p>
 <input type=checkbox name=bbq onclick=chuga_cal() value=40000> 바베큐세트 40,000원  
 <p style="margin-left:400px"> 추가금액 : <span id=chu>0</span>원 </p>
 <p style="margin-left:400px"> 총합계금액 : <span id=chong></span>원 </p>

         <!-- inwon.jsp있던거 복사 끝 --> 
       </td> 
     </tr>
     <tr>
       <td colspan=2 align=center> <input type=submit value=예약> </td>
     </tr>
   </table>
  </form>   
</div> 
<%@ include file="../bottom.jsp" %> 




















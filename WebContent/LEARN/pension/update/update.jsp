<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>    
<%
  // DB 연결및 쿼리를 사용할수 있는환경
  // Connection , Statement 
  String aa="jdbc:mysql://localhost:3307/pension?useSSL=false";
  String bb="root";
  String cc="1234";
  Connection conn = DriverManager.getConnection(aa,bb,cc);
  Statement stmt=conn.createStatement(); 
  
  // 정보수정할 사용자의 레코드를 읽어올 쿼리 작성
  request.setCharacterEncoding("utf-8");
  
  String sql="select * from member where userid='"+session.getAttribute("userid")+"'";
  
  ResultSet rs=stmt.executeQuery(sql);
  rs.next();//출력할려면
 %>
 <%@ include file="../main/top.jsp" %>
  <style>
#section{
width:1200px;
height:600px;
margin:auto;
background:#F4F4F4;

}
table
{

padding-top: 30px;
border: 0px solid gray;
}
td{

width:150px;
border-spacing: 10px;
border: 1px solid gray;
border: 1px solid #d4e2e1;
box-shadow: 3px 3px 3px 1px #bbb;
}
tr{
height:80px;
border: 0px solid gray;
}
#td{

width:500px;
border-spacing: 10px;
border: 0px solid gray;
}
input{
width:200px;

}


</style>
<script>
function check(form)
{
	 if(form.userid.value=="")
	 {
      document.all.idid.innerHTML="<b style='color:#828282'>아이디를 입력해주세요</b>";
       form.userid.focus();
       return false;
	 }
	 else if(form.userid.length<=7)
		 {
		 document.all.idid.innerHTML="<b style='color:#828282'>아이디를 8자 이상으로 만들어주세요</b>";
	       form.userid.focus();
	       return false;
		 }
		 else if(form.name.value=="")
			  {
			 document.all.namein.innerHTML="<b style='color:#828282>이름을 입력해주세요</b>";
			     form.name.focus();
			     return false;
			  }
		      else if(form.pwd1.value=="")
		    	   {
		    	  document.all.pwd1in.innerHTML="<b style='color:#828282'>비밀번호를 입력해주세요</b>";
		    	      form.pwd1.focus();
		    	      return false;
		    	   }
		           else if(form.pwd1.value != form.pwd2.value)
		        	    {
		        	   document.all.pwd2in.innerHTML="<b style='color:#828282'>비밀번호가 같지 않습니다.</b>";
		        	       form.pwd1.value="";
		        	       form.pwd2.value="";
		        	       form.pwd1.focus();
		        	       return false;
		        	    }
		                else if(form.email.value=="")
		                	 {
		                	document.all.emailin.innerHTML="<b style='color:#828282'>이메일을 입력해주세요</b>";
		                	    form.email.focus();
		                	    return false;
		                	 }
		                     else
		                    	return true;
}

</script>
<div id=section> 
<form method=post action=update_ok.jsp onsubmit="return check(this)"> 
<table align=center border=0 cellspacing=5 cellpadding=5>
<tr>
<td>아이디</td>
<td id=td><input type=text disabled name=userid value="<%=rs.getString("userid") %>">&nbsp;<span id=idid></span></td>
</tr>
<tr>
<td>이름</td>
<td id=td><input type=text disabled name=name value="<%=rs.getString("name") %>"><span id=namein></span></td>
</tr>
<tr>
<td>비밀번호 변경</td>
<td id=td><input type=password name=pwd><span id=pwd2in></span></td>
</tr>
<tr>
<td>이메일</td>
<td id=td><input type=text name=email value="<%=rs.getString("email") %>"><span id=emailin></span></td>
</tr>
<tr>
<td colspan=2 align=center>
   <input type=submit value=정보수정>
</td>
</tr>

</table>
</form>
</div>

<%@ include file="../main/bottom.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	String aa = "jdbc:mysql://localhost:3307/amudo?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);
	Statement stmt = conn.createStatement();

	
	int start;
	int Page=0;
	
	String last=request.getParameter("");
	if(request.getParameter("page")==null)
	{
		start=0;
		Page=1;
	}
	else{
		Page=Integer.parseInt(request.getParameter("page"));
		start=(Page-1)*10;
	}
	String sql="select * from board";
	
	ResultSet rs=stmt.executeQuery(sql);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function move_p()
{
var y= document.all.ppage.value;

location = "list.jsp?page="+y;
}
</script>
</head>
<body>
<table border=2 align=center width=600 cellspacing=0>
<caption ><h2>계시판</h2> </caption>
<tr>
<td>name</td>
<td>title</td>
<td>read num</td>
<td>writeday</td>
</tr>

<% 
while(rs.next())
{
	
}

%>
<tr>
<td><%=rs.getString("name") %></td>
<td><a href="rnumadd.jsp?id=<%=rs.getInt("id")%>"> <%=rs.getString("title") %> <</a></td>
<td></td>
<td></td>
</tr>
</table>

</body>
</html>
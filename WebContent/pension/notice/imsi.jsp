<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%@ page import="java.util.Date" %>   
  <%@ page import="java.text.SimpleDateFormat" %> 
 <%
    Date today= new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String writeday= sdf.format(today);
    
    out.print(writeday);
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>
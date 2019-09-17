<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@page import="java.time.LocalDate"%>
<%@ include file="../main/top2.jsp"%>
<%@ page import="java.sql.*"%>


<%
	String aa = "jdbc:mysql://localhost:3307/pension?useSSL=false";
	String bb = "root";
	String cc = "1234";
	Connection conn = DriverManager.getConnection(aa, bb, cc);// db와의 접속이 만들어짐
	Statement stmt = conn.createStatement(); //stmt 라는 변수에는 서버의 정보 모두가 담겨있다.
	Statement stmt1 = conn.createStatement(); //stmt 라는 변수에는 서버의 정보 모두가 담겨있다.
	request.setCharacterEncoding("UTF-8"); //자바에서의 인코딩
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<style>
#section {
	width: 100%;
	height: 850px;
	margin: auto;
}

table {
	margin-top: 25px;
	border-radius: 5px;
}

a {
	color: red;
}

caption {
	font-size: 20px;
}
</style>
<script>
	function move_cal() {//다른년도와 다른월의 달력을 보여주기
		//년도, 월을 가지고 문서를 호출
		var y = document.all.year.value;
		var m = document.all.month.value;
		location = "reserve.jsp?yy=" + y + "&mm=" + m;
	}

	//객실에 관련된 테이블
	//정신 차리자

	//bang : 테이블명
	/*
	id
	name
	sogae
	content
	img
	price
	min_in 최소인원
	max_in 최대인원
	writeday //timestamp???-> 지가 알아서 넣어줌 레코드의 값이 바뀔때마다
	 */
</script>
<body>
	<div id=section align=center>
		<%
			// cal4.jsp
			// LocalDate.now(); // 현재시간 기준
			int y, m; // 년,월저장할 변수
			if (request.getParameter("yy") == null) // 값이 없다면 , yy???
			{
				LocalDate xday = LocalDate.now(); // 현재시간
				y = xday.getYear(); // 현재시간의 년도
				m = xday.getMonthValue(); // 현재시간의 월
			} else // request값이 있어서 받은값은 정수로 변환
			{
				y = Integer.parseInt(request.getParameter("yy"));
				m = Integer.parseInt(request.getParameter("mm"));
			}
			LocalDate today = LocalDate.of(y, m, 1); // 괄호내에있는 년월일
			int yoil = today.getDayOfWeek().getValue(); // 1일의 요일
			if (yoil == 7)
				yoil = 0; // 일요일경우 이전소스가 대부분 일요일이 0이라서 

			double chong = today.lengthOfMonth(); // 월의 총일수

			int ju = (int) Math.ceil((chong + yoil) / 7); // 현재월의 주의 수 
			// 올림(X.xxxx) =>  X정수보다 1큰 정수로
			int max_day = (int) chong;

			//double a=100; // double과 int로 바꾸어서 출력을 확인해보세요
			//int b=6;
			//out.print(a/b);
		%>
		<table width=80% height=500 border=1 cellspacing=0>
			<caption>
				<%
					if (m != 1) {
				%>
				<a href="reserve.jsp?yy=<%=y%>&mm=<%=m - 1%>"> 이전달 </a>
				<%
					//링크에서 변수 선언
					} else {
				%>
				<a href="reserve.jsp?yy=<%=y - 1%>&mm=<%=12%>"> 이전달 </a>
				<%
					}
				%>
				<select onchange=move_cal() name=year>
					<!-- 			년 -->
					<%
						// 				현재 해당 년도와 월 표시
						// -----------------------------------------------------------------
						String sel1 = "";
						for (int i = y + 3; i >= y - 3; i--) // 2019라면 2022~2016
						{
							if (i == y)
								sel1 = "selected";
							else
								sel1 = "";
					%>
					<option value=<%=i%> <%=sel1%>>
						<%=i%>
					</option>
					<%
						}
					%>

				</select> <select onchange=move_cal() name=month>
					<!-- 			 월 -->
					<%
						String sel2 = "";
						for (int i = 1; i <= 12; i++) {
							if (i == m)
								sel2 = "selected";
							else
								sel2 = "";
					%>
					<option value=<%=i%> <%=sel2%>><%=i%></option>
					<%
						}
					%>
				</select>
				<!------------------------------------------------------------------------------------- -->
				<%
					if (m != 12) {
				%>
				<a href="reserve.jsp?yy=<%=y%>&mm=<%=m + 1%>"> 다음달 </a>
				<%
					} else {
				%>
				<a href="reserve.jsp?yy=<%=y + 1%>&mm=<%=1%>"> 다음달 </a>
				<%
					}
				%>
			</caption>
			<tr align=center height=50px>
				<td>일</td>
				<td>월</td>
				<td>화</td>
				<td>수</td>
				<td>목</td>
				<td>금</td>
				<td>토</td>
			</tr>
			<%
				int day = 1;
				for (int i = 1; i <= 5; i++) // i의 값이 행의 값과 일치
				{
			%>
			<tr align=center>
				<!-- 주 -->
				<%
				//오늘 날짜와 달력상의 날짜를 비교
				//y:년도, m:월 ,day:일
				//
				
					for (int j = 0; j < 7; j++) { //일~ 토 출력 부분
							if ((yoil > j && i == 1) || max_day < day) // 빈칸을 출력할 경우가 맞다면
							{ // 앞쪽빈칸        // 뒤쪽빈간(총일수 뒷부분)
				%>
				<td>&nbsp;</td>
				<!-- 빈칸을 출력하는 부분 -->
				<%
					} else // 날짜를 출력할 경우라면
							{

								String sql;
								ResultSet rs, rs1;
								String nowday;//1일 부터 31일 까지의 년월일
				%>
				<td valign=top align=left>
					<!-- 달력 날짜---------------------------- --> <span> <%=day%></span> <!-- 날짜 출력부분 -->
					<%
 	// bang 테이블에 있는 방의 갯수 만큼 실행하기
 				// bang 테이블을 rs에 가지고 오기
 				LocalDate now_day=LocalDate.now(); //현재 년월일
 				LocalDate cal_day=LocalDate.of(y,m,day); //현재 년월일
 				int chk=now_day.compareTo(cal_day);
 				if(chk <= 0)//현제 날짜부터 이후는 보이게(true)
 				{
 				sql = "select * from bang order by price asc";
 				rs = stmt.executeQuery(sql); //while 문 도는 동안 사용하기에  rs객체의 이름을 달리해주어야함
 				while (rs.next()) //stmt는 사용후에 클로즈 됨으로 다시 사용하려면 객체를 새로 만들어야 함
 				{
 					nowday = y + "-" + m + "-" + day;
 					sql = "select * from reserve where in_date <= '" + nowday + "' and out_date > '" + nowday
 							+ "' and bang='" + rs.getString("name") + "'";
 					rs1 = stmt1.executeQuery(sql);
 					if (rs1.next()) {
 %>
					<p align=center><%=rs.getString("name")%>(불)
					</p> <%
					
					}
 					else 
 					{
 %>

					<p align=center>
						<a
							href="javascript:input_move('<%=rs.getString("name")%>',<%=y%>,<%=m%>,<%=day%>)"><%=rs.getString("name")%>(가)</a>
					</p> <%
 	}
 				}
							}//if문의 끝
 %> <%
 	day = day + 1;///???
 			}

 		}
 %>
				
			</tr>
			<%
				}
			%>

		</table>
	</div>
</body>
<script>
	function input_move(n, y, m, d) //주소창에서는 익스플로러가 자동번역 처리를 안해주므로 get방식을 이용했을때에 jsp로 인코딩 해주어야함
	{
		n = encodeURIComponent(n);
		location = "input.jsp?bang=" + n + "&y=" + y + "&m=" + m + "&d=" + d;
	}
</script>
</html>
<%@ include file="../main/bottom.jsp"%>
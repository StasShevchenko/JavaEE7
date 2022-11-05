<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.net.InetAddress" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.ArrayList" %>
<%-- Печаталка: %><%= "welcome to jsp" + name + " " + password %><% --%>
<html>
<head>
    <title>Страница пользователя</title>
</head>
<body>
<%
     class Visit {
        public String ip;
        public String visitTime;

        public Visit(String ip, String visitTime) {
            this.ip = ip;
            this.visitTime = visitTime;
        }
    }



    response.setContentType("text/html; charset = UTF-8");
    request.setCharacterEncoding("UTF-8");
    String name = request.getParameter("login");
    String password = request.getParameter("password");
    if (name.equals("") || password.equals("")) {
%>
<p>Введите имя и пароль!</p>
<%
} else {
    String DB_URL = "jdbc:postgresql://127.0.0.01:5432/javaee7";
    String USER = "postgres";
    String PASS = "MyNameIsEminem";
    try {
        Class.forName("org.postgresql.Driver");
        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SELECT id, name FROM users WHERE password = '" + password + "' and name = '" + name + "'");

        if (rs.next()) {
            Integer userId = Integer.parseInt(rs.getString("id"));
%>
<h2>Здравствуйте, <%=rs.getString("name")%>
</h2>
<%
    String timeStamp = new SimpleDateFormat("yyyy.MM.dd.HH.mm.ss").format(new java.util.Date());
    statement.executeUpdate("INSERT INTO visits(userId, ip, visitTime) VALUES (" + rs.getString("id") + ", '" + InetAddress.getLocalHost().getHostAddress() + "', '" + timeStamp + "')");
    ResultSet visitResult = statement.executeQuery("SELECT ip, visitTime FROM visits WHERE userid = " + userId + "");
    ArrayList<Visit> visits = new ArrayList<>();
    while (visitResult.next()) {
        visits.add(new Visit(visitResult.getString("ip"), visitResult.getString("visitTime")));
    }
%>
<p>Вы посетили сайт <%=visits.size()%> раз!</p>
<%
    for (Visit visit :
            visits) {
%>
Посещение <%=visit.visitTime%> ip=<%=visit.ip%> <br><br>
<%
        }
    }
} catch (SQLException e) {
%>
<%=e %><%
        }
    }
%>
</body>

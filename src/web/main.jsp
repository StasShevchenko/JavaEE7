<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Авторизация</title>
</head>
<body>
<h1><u>Вход</u></h1>
<%
    response.setContentType("text/html; charset = UTF-8");
    request.setCharacterEncoding("UTF-8");
%>
<form action="auth.jsp" method="POST">
Логин: <input name = "login"> <br><br>
Пароль <input type="password" name = "password"><br><br>
<input type="submit" value="Войти!" />
</form>
</body>
</html>

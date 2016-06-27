<%@ page import="java.io.*,java.util.*" %>
<html>
<body>
<%
String basePath = request.getContextPath();
String redirectURL = basePath+"/logins";
response.sendRedirect(redirectURL);
%>
</body>
</html>

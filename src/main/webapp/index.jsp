<%@ page import="java.io.*,java.util.*" %>
<html>
<body>
<%
String basePath = request.getContextPath();
String redirectURL = basePath+"/login";
response.sendRedirect(redirectURL);
%>
</body>
</html>

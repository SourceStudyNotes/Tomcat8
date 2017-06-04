<%@ page 	contentType="text/html; charset=GBK" %>
<%@ page 	import="com.vogoal.util.JspFileUpload" %>

<html>
<head>
<title>get method</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>
<body>
<%
	JspFileUpload jfu = new JspFileUpload();
	jfu.setRequest(request);
	jfu.setUploadPath("C:\\");
	jfu.process();
	String username = jfu.getParameter("username");
	String[] usernameArr = jfu.getParameters("username");
	String[] fileArr = jfu.getUpdFileNames();
	out.println("parameter:" + username);
	out.println("parameter size:" + usernameArr.length);
	out.println("fileArr size:" + fileArr.length);
	if (fileArr.length > 0)
		out.println("fileArr 0:" + fileArr[0]);
%>
</body>
</html>

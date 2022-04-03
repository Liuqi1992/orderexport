<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>app 后台</title>
    <%@include file="../head.jsp"%>
    <%@include file="../jquery.jsp"%>
    <%
        request.setAttribute("nav", "draw");
        request.setAttribute("tab", "set");
        String host = "";
        host = request.getHeader("Host");
        if (host.indexOf(':') > 0) {
            host = host.substring(0, host.indexOf(':'));
        }
    %>
</head>
<body style="background: #f6f1eb none repeat scroll 0 0;">
<%@include file="top.jsp"%>
<div class="nr">
    <%@include file="navigation.jsp"%>
    <div class="pagemain">
        <input id="strMenuId" type="hidden" value="0"/>
        <input id="strSubMenuId" type="hidden" value="1"/>
        hello
    </div>
</div>
 <%--<%@include file="mbottom.jsp"%>--%>
</body>
</html>
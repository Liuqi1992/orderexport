<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/customStyle.css" rel="stylesheet">

<title>app 后台</title>
    <%@include file="../../head.jsp"%>
    <%@include file="../../jquery.jsp"%>
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
<%@include file="../top.jsp"%>
<div class="nr">
    <%@include file="../navigation.jsp"%>
    <div class="pagemain po">
        <input id="strMenuId" type="hidden" value="2"/>
        <input id="strSubMenuId" type="hidden" value="23"/>

        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/institution/list.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">机构名称</label>
                                  <input type="hidden" value="${name}" id="name_param">
                &nbsp;&nbsp;&nbsp;<select class="select_style" name="name" id="institution_all">
                                    <option value=""></option>
                                  </select>

                &nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="17">机构名称</th>
                <th class="center left-con" width="15%">法人姓名</th>
                <th class="center left-con" width="15%">联系人</th>
                <th class="center left-con" width="20%">联系方式</th>
                <th class="center left-con" width="15%">邮箱</th>
                <th class="center left-con" width="10">操作</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0}">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="center left-con">${item.name}</td>
                    <td class="center left-con">${item.legalpName}</td>
                    <td class="center left-con">${item.linkMan}</td>
                    <td class="center left-con">${item.linkStyle}</td>
                    <td class="center left-con">${item.email}</td>
                    <td class="center left-con">
                       <span class=""><a href="javascript:void(0)" onclick="itemDetails('${item.id}');">详情</a></span>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="name" value="${name}">
    <div id="page" align="center" class="pagestyle"></div>
   </div>
</div>

<%--分页 start--%>
<%--<div align="center" class="page_num_style">
    第${pageNo}页&nbsp;&nbsp;
        <c:choose>
            <c:when test="${pageNo > 1}">
                <a href="${pageContext.request.contextPath}/institution/list.do?pageNo=${pageNo - 1}&name=${name}">上一页</a>&nbsp;&nbsp;
            </c:when>
            <c:otherwise>
                <a href="#">上一页</a>&nbsp;&nbsp;
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${pageNo < totalPage}">
                <a href="${pageContext.request.contextPath}/institution/list.do?pageNo=${pageNo + 1}&name=${name}">下一页</a>&nbsp;&nbsp;
            </c:when>
            <c:otherwise>
                <a href="#">下一页</a>&nbsp;&nbsp;
            </c:otherwise>
        </c:choose>
    共${totalPage}页
</div>--%>
<%--分页 end--%>

<div id="institution_details" style="display: none">
    <table id="detail_info_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="2">
            <col width="30%">
            <col width="70%">
        </colgroup>
        <tbody>
            <tr>
                <td align="left">机构名称</td>
                <td></td>
            </tr>
            <tr>
               <td align="left">机构地址</td>
               <td></td>
            </tr>
            <tr>
                <td align="left">法人姓名</td>
                <td></td>
            </tr>
            <tr>
                <td align="left">法人身份证</td>
                <td></td>
            </tr>
            <tr>
                <td align="left">营业执照</td>
                <td><img alt="" style="width: 50px;height: 50px" />&nbsp;&nbsp;<a></a></td>
            </tr>
            <tr>
                <td align="left">医疗机构执业许可证</td>
                <td><img alt="" style="width: 50px;height: 50px" />&nbsp;&nbsp;<a></a></td>
            </tr>
            <tr>
                <td align="left">医疗机构外观照</td>
                <td><img alt="" style="width: 50px;height: 50px" />&nbsp;&nbsp;<a></a></td>
            </tr>
            <tr>
                <td align="left">在职医生执照</td>
                <td><img alt="" style="width: 50px;height: 50px" />&nbsp;&nbsp;<a></a></td>
            </tr>
            <tr>
                <td align="left">在职护士执照</td>
                <td><img alt="" style="width: 50px;height: 50px" />&nbsp;&nbsp;<a></a></td>
            </tr>
            <tr>
                <td align="left">申请联系人</td>
                <td></td>
            </tr>
            <tr>
                <td align="left">联系方式</td>
                <td></td>
            </tr>
            <tr>
                <td align="left">邮箱</td>
                <td></td>
            </tr>
        </tbody>
    </table>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/institution/institution.js"></script>
</body>
</html>

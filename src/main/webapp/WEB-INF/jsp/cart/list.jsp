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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/cart/cart.js"></script>
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
        <input id="strMenuId" type="hidden" value="7"/>
        <input id="strSubMenuId" type="hidden" value="71"/>

        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/cart/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">用户名</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style_new" name="user_username" value="${user_username}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">用户姓名</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style_new" name="user_name" value="${user_name}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">套餐名称</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style_new" name="package_name" value="${package_name}" />

                &nbsp;&nbsp;&nbsp;
                <label class="label_Style">创建时间:</label>&nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <input class="input_text_style_new" name="createTimeStart" placeholder="开始日期" id="createtime_range_start" value="${createTimeStart}">
                </div>&nbsp;——&nbsp;
                <div class="layui-inline">
                    <input class="input_text_style_new" name="createTimeEnd" placeholder="结束日期" id="createtime_range_end" value="${createTimeEnd}">
                </div>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="14%">用户名</th>
                <th class="center left-con" width="12%">用户姓名</th>
                <th class="center left-con" width="18%">套餐名称</th>
                <th class="center left-con" width="8%">数量（个）</th>
                <th class="center left-con" width="15%">创建时间</th>
                <th class="center left-con" width="15%">修改时间</th>
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
                    <td class="center left-con">${item.userModel.userName}</td>
                    <td class="center left-con">${item.userModel.name}</td>
                    <td class="center left-con">${item.packageModel.name}</td>
                    <td class="center left-con">${item.num}</td>
                    <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td class="center left-con"><fmt:formatDate value="${item.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <%--<td class="center left-con">${item.price}</td>--%>
                    <td class="center left-con">
                       <%--<span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;--%>
                       <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}');">编辑</a></span>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="query_flag" value="${query_flag}">
    <input type="hidden" id="user_username" value="${user_username}">
    <input type="hidden" id="user_name" value="${user_name}">
    <input type="hidden" id="package_name" value="${package_name}">
    <input type="hidden" id="createTimeStart" value="${createTimeStart}">
    <input type="hidden" id="createTimeEnd" value="${createTimeEnd}">
    <div id="page" align="center" class="pagestyle"></div>
   </div>
</div>

<%--分页 start--%>
<%--<div align="center" class="page_num_style">
    第${pageNo}页&nbsp;&nbsp;
    <c:choose>
        <c:when test="${query_flag == true}">
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/cart/query.do?pageNo=${pageNo - 1}&user_username=${user_username}&user_name=${user_name}&package_name=${package_name}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/cart/query.do?pageNo=${pageNo + 1}&user_username=${user_username}&user_name=${user_name}&package_name=${package_name}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/cart/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/cart/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:otherwise>
    </c:choose>
    共${totalPage}页
</div>--%>
<%--分页 end--%>

 <%--<%@include file="mbottom.jsp"%>--%>

<%--编辑购物车内容 start--%>
<div id="edit_cart" style="display: none">
    <br/><form id="edit_cart_form" action="" class="layui-form">
    <%--套餐名称--%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">用户编号</label>
            <div class="layui-input-block">
                <input type="hidden" id="edit_id" name="id">
                <input type="text" id="userId_edit" name="userId" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
    </div>
    <%--使用人群---%>
    <div class="layui-form-item">
        <label class="layui-form-label">套餐编号</label>
        <div class="layui-input-block">
            <input type="text" id="packageId_edit" name="packageId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--价格---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">套餐数量</label>
            <div class="layui-input-inline">
                <input type="text" id="num_edit" name="num" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;个</span>
        </div>
    </div>
</form>
</div>
<%--编辑检验细项 end--%>
</body>
</html>
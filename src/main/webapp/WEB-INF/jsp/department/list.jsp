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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/department/department.js"></script>
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
        <input id="strSubMenuId" type="hidden" value="22"/>
        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/department/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">科室名称</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="departmentName" value="${departmentName}" />


                &nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
                &nbsp;&nbsp;&nbsp;<button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addDepartemnt()">增加</button>
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="10%">科室编号</th>
                <th class="center left-con" width="20%">科室名称</th>
                <th class="center left-con" width="10%">科室人数</th>
                <th class="center left-con" width="18%">创建时间</th>
                <th class="center left-con" width="18%">修改时间</th>
                <th class="center left-con" width="16%">操作</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0}">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="center left-con">${item.departmentNum}</td>
                    <td class="center left-con">${item.departmentName}</td>
                    <td class="center left-con">${item.departmentNumber}</td>
                    <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td class="center left-con"><fmt:formatDate value="${item.modiftTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td class="center left-con">
                       <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}');">编辑</a></span>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="query_flag" value="${query_flag}">
    <input type="hidden" id="departmentName" value="${departmentName}">
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
                    <a href="${pageContext.request.contextPath}/department/query.do?pageNo=${pageNo - 1}&departmentName=${departmentName}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/department/query.do?pageNo=${pageNo + 1}&departmentName=${departmentName}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/department/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/department/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
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
<%--增加科室 start--%>
<div id="add_department" style="display: none">
    <br/><form id="add_department_form" action="" class="layui-form">
    <%--科室编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label">科室编号</label>
        <div class="layui-input-block">
            <input type="text" name="departmentNum" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室名称---%>
    <div class="layui-form-item">
        <label class="layui-form-label">科室名称</label>
        <div class="layui-input-block">
            <input type="text" name="departmentName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室人数---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">科室人数</label>
            <div class="layui-input-inline">
                <input type="text" name="departmentNumber" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;人</span>
        </div>
    </div>
    </form>
</div>
<%--增加科室 end--%>

<%--编辑检验细项 start--%>
<div id="edit_department" style="display: none">
    <br/><form id="edit_department_form" action="" class="layui-form">
    <%--科室编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label">科室编号</label>
        <div class="layui-input-block">
            <input type="hidden" id="edit_id" name="id">
            <input type="text" id="edit_departmentNum" name="departmentNum" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室名称---%>
    <div class="layui-form-item">
        <label class="layui-form-label">科室名称</label>
        <div class="layui-input-block">
            <input type="text" id="edit_departmentName" name="departmentName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室人数---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">科室人数</label>
            <div class="layui-input-inline">
                <input type="text" id="edit_departmentNumber" name="departmentNumber" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;人</span>
        </div>
    </div>
</form>
</div>
<%--编辑检验细项 end--%>
</body>
</html>
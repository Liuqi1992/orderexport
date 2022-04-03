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
    <script language="javascript" src="${pageContext.request.contextPath}/LODOP/LodopFuncs.js"></script>
    <%
        request.setAttribute("nav", "draw");
        request.setAttribute("tab", "set");
        String host = "";
        host = request.getHeader("Host");
        if (host.indexOf(':') > 0) {
            host = host.substring(0, host.indexOf(':'));
        }
    %>
    <object  id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
        <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
    </object>
</head>
<body style="background: #f6f1eb none repeat scroll 0 0;">
<%@include file="../top.jsp"%>
<div class="nr">
    <%@include file="../navigation.jsp"%>
    <div class="pagemain po">
        <input id="strMenuId" type="hidden" value="8"/>
        <input id="strSubMenuId" type="hidden" value="83"/>
        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/doctorBillStat/query.do" METHOD="post">

                &nbsp;&nbsp;&nbsp;<label class="label_Style">医生姓名</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="doctorName" value="${doctorName}" />

                &nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <label>年份</label>&nbsp;&nbsp;&nbsp;
                    <div class="layui-input-inline">
                        <input type="hidden" id="year_input" value="${year}">
                        <select name="year" id="year_id" class="select_style">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                &nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <label>月份</label>&nbsp;&nbsp;&nbsp;
                    <div class="layui-input-inline">
                        <select name="month" id="month_query" class="select_style">
                            <option value=""></option>
                            <option value="1" <c:if test="${month == 1}">selected</c:if>>一月</option>
                            <option value="2" <c:if test="${month == 2}">selected</c:if>>二月</option>
                            <option value="3" <c:if test="${month == 3}">selected</c:if>>三月</option>
                            <option value="4" <c:if test="${month == 4}">selected</c:if>>四月</option>
                            <option value="5" <c:if test="${month == 5}">selected</c:if>>五月</option>
                            <option value="6" <c:if test="${month == 6}">selected</c:if>>六月</option>
                            <option value="7" <c:if test="${month == 7}">selected</c:if>>七月</option>
                            <option value="8" <c:if test="${month == 8}">selected</c:if>>八月</option>
                            <option value="9" <c:if test="${month == 9}">selected</c:if>>九月</option>
                            <option value="10" <c:if test="${month == 10}">selected</c:if>>十月</option>
                            <option value="11" <c:if test="${month == 11}">selected</c:if>>十一月</option>
                            <option value="12" <c:if test="${month == 12}">selected</c:if>>十二月</option>
                        </select>
                    </div>
                </div>
                &nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input type="button" class="layui-btn layui-btn-small" value="打印" onclick="f_print()">
            </form>
        </div>
        <%--查询 end--%>
        <br>
        <h3 align="center">
            <c:choose>
                <c:when test="${doctorName != null and doctorName != ''}">${doctorName}</c:when>
                <c:otherwise>各医生</c:otherwise>
            </c:choose>
            <c:if test="${year != null and year != ''}">${year}年</c:if><c:if test="${month != null and month != ''}">-${month}月</c:if>开单统计
        </h3>
        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="10%">医生编号</th>
                <th class="center left-con" width="20%">医生姓名</th>
                <th class="center left-con" width="20%">开单量（个）</th>
                <th class="center left-con" width="20%">开单总额（元）</th>
                <th class="center left-con" width="22%">创建时间</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0}">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="center left-con">${item.doctorId}</td>
                    <td class="center left-con">${item.doctorName}</td>
                    <td class="center left-con">${item.billNum}</td>
                    <td class="center left-con"><fmt:formatNumber type="number" value="${item.billAmount / 100}" pattern="#0.00" maxFractionDigits="2"/> </td>
                    <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <input type="hidden" id="pageNo" value="${pageNo}">
        <input type="hidden" id="totalPage" value="${totalPage}">
        <input type="hidden" id="query_flag" value="${query_flag}">
        <input type="hidden" id="doctorName" value="${doctorName}">
        <input type="hidden" id="year" value="${year}">
        <input type="hidden" id="month" value="${month}">
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
                    <a href="${pageContext.request.contextPath}/doctorBillStat/query.do?pageNo=${pageNo - 1}&doctorName=${doctorName}&year=${year}&month=${month}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/doctorBillStat/query.do?pageNo=${pageNo + 1}&doctorName=${doctorName}&year=${year}&month=${month}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/doctorBillStat/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/doctorBillStat/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
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

<div id="table_stat" style="display: none">
    <h3 align="center">
        <c:choose>
            <c:when test="${doctorName != null and doctorName != ''}">${doctorName}</c:when>
            <c:otherwise>各医生</c:otherwise>
        </c:choose>
        <c:if test="${year != null and year != ''}">${year}年</c:if><c:if test="${month != null and month != ''}">-${month}月</c:if>开单统计
    </h3>
    <table class="sui-table table-bordered" style="margin-top:20px;width: 700px">
        <thead>
        <tr>
            <th class="center left-con" width="8%">编号</th>
            <th class="center left-con" width="17%">医生编号</th>
            <th class="center left-con" width="20%">医生姓名</th>
            <th class="center left-con" width="20%">开单量（个）</th>
            <th class="center left-con" width="20%">开单总额（元）</th>
            <th class="center left-con" width="15%">创建时间</th>
        </tr>
        </thead>
        <tbody id="all_task1">
        <c:if test="${fn:length(list_all)==0}">
            <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
        </c:if>
        <c:set var="totalBillAmount" value="${0}" />
        <c:forEach items="${list_all}" var="item">
            <tr>
                <td class="center left-con">${item.id}</td>
                <td class="center left-con">${item.doctorId}</td>
                <td class="center left-con">${item.doctorName}</td>
                <td class="center left-con">${item.billNum}</td>
                <td class="center left-con"><fmt:formatNumber type="number" value="${item.billAmount / 100}" pattern="#0.00" maxFractionDigits="2"/> </td>
                <c:set var="totalBillAmount" value="${item.billAmount + totalBillAmount}" />
                <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd"/></td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <br>
    <p align="right">总计：<fmt:formatNumber type="number" value="${totalBillAmount / 100}" pattern="#0.00" maxFractionDigits="2" />（元） </p>
</div>

<script type="text/javascript" src="${pageContext.request.contextPath}/js/saleStat/doctorBillStat.js"></script>
</body>
</html>

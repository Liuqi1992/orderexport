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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/trade/trade.js"></script>
    <%--<%
        request.setAttribute("nav", "draw");
        request.setAttribute("tab", "set");
        String host = "";
        host = request.getHeader("Host");
        if (host.indexOf(':') > 0) {
            host = host.substring(0, host.indexOf(':'));
        }
    %>--%>
</head>
<body style="background: #f6f1eb none repeat scroll 0 0;">
<%@include file="../top.jsp"%>
<div class="nr">
    <%@include file="../navigation.jsp"%>
    <div class="pagemain po">
        <input id="strMenuId" type="hidden" value="7"/>
        <input id="strSubMenuId" type="hidden" value="72"/>

        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/trade/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;<label class="label_Style">用户名</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="userName" value="${userName_}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">申请人</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="applyName" value="${applyName}"/>

                &nbsp;&nbsp;&nbsp;<label class="label_Style">订单编号</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="tradeNum" value="${tradeNum}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">订单状态</label>
                &nbsp;&nbsp;&nbsp;<select class="select_style" name="status">
                                    <option value=""></option>
                                    <option value="-2" <c:if test="${status == -2}">selected</c:if>>未确认（预约医生）</option>
                                    <option value="-1" <c:if test="${status == -1}">selected</c:if>>已确认（预约医生）</option>
                                    <option value="0" <c:if test="${status == '0'}">selected</c:if>>已下单</option>
                                    <option value="1" <c:if test="${status == 1}">selected</c:if>>已付款</option>
                                    <option value="2" <c:if test="${status == 2}">selected</c:if>>已开医嘱</option>
                                    <option value="3" <c:if test="${status == 3}">selected</c:if>>已采集</option>
                                    <option value="4" <c:if test="${status == 4}">selected</c:if>>检验中</option>
                                    <option value="5" <c:if test="${status == 5}">selected</c:if>>已报告</option>
                                    <option value="6" <c:if test="${status == 6}">selected</c:if>>已解读</option>
                                  </select>

                <br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <label class="label_Style">创建时间</label>&nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <input class="input_text_style" name="createTimeStart" placeholder="开始日期" id="createtime_range_start" value="${createTimeStart}">
                </div>&nbsp;——&nbsp;

                <div class="layui-inline">
                    <input class="input_text_style" name="createTimeEnd" placeholder="结束日期" id="createtime_range_end" value="${createTimeEnd}">
                </div>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="12%">用户名</th>
                <th class="center left-con" width="8%">申请人</th>
                <th class="center left-con" width="12%">订单编号</th>
                <th class="center left-con" width="14%">订单状态</th>
                <th class="center left-con" width="6%">价格</th>
                <th class="center left-con" width="15%">下单时间</th>
                <th class="center left-con" width="15%">付款时间</th>
                <th class="center left-con" width="10%">操作</th>
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
                    <td class="center left-con">${item.applicantModel.applyName}</td>
                    <td class="center left-con">${item.tradeNum}</td>
                    <td class="center left-con">
                        <c:if test="${item.status == -2}">未确认（预约医生）</c:if>
                        <c:if test="${item.status == -1}">已确认（预约医生）</c:if>
                        <c:if test="${item.status == 0}">已下单</c:if>
                        <c:if test="${item.status == 1}">已付款</c:if>
                        <c:if test="${item.status == 2}">已开医嘱</c:if>
                        <c:if test="${item.status == 3}">已采集</c:if>
                        <c:if test="${item.status == 4}">检验中</c:if>
                        <c:if test="${item.status == 5}">已报告</c:if>
                        <c:if test="${item.status == 6}">已解读</c:if>
                    </td>
                    <td class="center left-con"><fmt:formatNumber type="number" value="${item.price / 100}" pattern="#0.00" maxFractionDigits="2"/></td>
                    <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <td class="center left-con"><fmt:formatDate value="${item.payTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                    <%--<td class="center left-con">${item.price}</td>--%>
                    <td class="center left-con">
                       <%--<span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;--%>
                       <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}');">编辑</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemDetail('${item.id}');">详情</a></span>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="query_flag" value="${query_flag}">
    <input type="hidden" id="userName" value="${userName_}">
    <input type="hidden" id="applyName" value="${applyName}">
    <input type="hidden" id="tradeNum" value="${tradeNum}">
    <input type="hidden" id="status" value="${status}">
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
                    <a href="${pageContext.request.contextPath}/trade/query.do?pageNo=${pageNo - 1}&userName=${userName_}&applyName=${applyName}&tradeNum=${tradeNum}&status=${status}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/trade/query.do?pageNo=${pageNo + 1}&userName=${userName_}&applyName=${applyName}&tradeNum=${tradeNum}&status=${status}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/trade/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/trade/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
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

<%--编辑订单 start--%>
<div id="edit_trade" style="display: none">
    <br/><form id="edit_trade_form" action="" class="layui-form">
    <%--订单用户编号---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">订单用户编号</label>
        <div class="layui-input-block">
            <input type="hidden" id="edit_id" name="id">
            <input type="text" id="userId_edit" name="userId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--联系人编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">联系人编号</label>
        <div class="layui-input-block">
            <input type="text" id="applicantId_edit" name="applicantId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--订单编号--%>
    <%--<div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label">订单编号</label>
            <div class="layui-input-block">
                <input type="text" id="atradeNum_edit" name="tradeNum" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
    </div>--%>
    <%--订单状态--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">订单状态</label>
        <div class="layui-input-inline" style="width: 260px">
            <select id="status_edit" name="status" lay-verify="">
                <option value=""></option>
                <option value="-2">未确认（预约医生）</option>
                <option value="-1">已确认（预约医生）</option>
                <option value="0">已下单</option>
                <option value="1">已付款</option>
                <option value="2">已开医嘱</option>
                <option value="3">已采集</option>
                <option value="4">检验中</option>
                <option value="5">已报告</option>
                <option value="6">已解读</option>
            </select>
        </div>
    </div>
    <%--订单价格到分---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">订单价格到分</label>
            <div class="layui-input-inline">
                <input type="text" id="price_edit" name="price_" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;元</span>
        </div>
    </div>
    <%--数量---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">套餐数量</label>
            <div class="layui-input-inline">
                <input type="text" id="num_edit" name="num" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;个</span>
        </div>
    </div>
    <%--订单名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">订单名称</label>
        <div class="layui-input-block">
            <input type="text" id="name_edit" name="name" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--解读医生编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读医生编号</label>
        <div class="layui-input-block">
            <input type="text" id="doctorId_edit" name="doctorId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--解读医生姓名--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读医生姓名</label>
        <div class="layui-input-block">
            <input type="text" id="doctorName_edit" name="doctorName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--采集机构编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">采集机构编号</label>
        <div class="layui-input-block">
            <input type="text" id="hospitalId_edit" name="hospitalId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--采集机构名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">采集机构名称</label>
        <div class="layui-input-block">
            <input type="text" id="hospitalName_edit" name="hospitalName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--付款方式--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">付款方式</label>
        <div class="layui-input-block">
            <input type="text" id="payType_edit" name="payType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--医嘱医生编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">医嘱医生编号</label>
        <div class="layui-input-block">
            <input type="text" id="yzDoctorId_edit" name="yzDoctorId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--医嘱医生姓名--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">医嘱医生姓名</label>
        <div class="layui-input-block">
            <input type="text" id="yzDoctorName_edit" name="yzDoctorName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">科室编号</label>
        <div class="layui-input-block">
            <input type="text" id="yzDepartmentNum_edit" name="yzDepartmentNum" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--科室名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">科室名称</label>
        <div class="layui-input-block">
            <input type="text" id="yzDepartmentName_edit" name="yzDepartmentName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--创建类型--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">创建类型</label>
        <div class="layui-input-inline" style="width: 260px">
            <select id="createType_eidt" name="createType" lay-verify="">
                <option value=""></option>
                <option value="0">客户创建</option>
                <option value="1">解读医生创建</option>
            </select>
        </div>
    </div>
    <%--关联编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">关联编号</label>
        <div class="layui-input-block">
            <input type="text" id="relationId_edit" name="relationId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--是否需要解读医生--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">是否需要解读医生</label>
        <div class="layui-input-inline" style="width: 260px">
            <select id="needRead_eidt" name="needRead" lay-verify="">
                <option value=""></option>
                <option value="0">不需要</option>
                <option value="1">需要</option>
            </select>
        </div>
    </div>
    <%--医生留言--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">医生留言</label>
        <div class="layui-input-block">
            <textarea id="doctorMsg_edit" name="doctorMsg" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
</form>
</div>
<%--编辑订单 end--%>

<%--显示订单详情 start--%>
<div id="detail_trade" style="display: none">
    <table id="detail_trade_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="4">
            <col width="20%">
            <col width="30%">
            <col width="20%">
            <col width="30%">
            <%--<col width="27%">
            <col width="23%">--%>
        </colgroup>
        <tbody>
        <tr>
            <td align="left">订单用户编号</td>
            <td align="left"></td>
            <td align="left">用户名</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">联系人编号</td>
            <td align="left"></td>
            <td align="left">申请人</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">订单编号</td>
            <td align="left"></td>
            <td align="left">订单状态</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">价格</td>
            <td align="left"></td>
            <td align="left">数量</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">订单名称</td>
            <td align="left"></td>
            <td align="left">解读医生姓名</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">采集机构名称</td>
            <td align="left"></td>
            <td align="left">付款方式</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">预约时间</td>
            <td align="left"></td>
            <td align="left">付款时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">医嘱医生编号</td>
            <td align="left"></td>
            <td align="left">医嘱医生姓名</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">科室编号</td>
            <td align="left"></td>
            <td align="left">科室名称</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">医嘱时间</td>
            <td align="left"></td>
            <td align="left">创建类型</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">关联编号</td>
            <td align="left"></td>
            <td align="left">是否需要解读医生</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">下单时间</td>
            <td align="left"></td>
            <td align="left">修改时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">医生留言</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
    </table>
</div>
<%--显示订单详情 end--%>
</body>
</html>
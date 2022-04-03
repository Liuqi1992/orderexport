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
        <input id="strMenuId" type="hidden" value="7"/>
        <input id="strSubMenuId" type="hidden" value="73"/>

        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/order/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">用户名</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="userName" id="userName_query" value="${userName_}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">订单编号</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="tradeNum" id="tradeNum_query" value="${tradeNum}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">套餐名称</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="packageName" id="packageName_query" value="${packageName}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">订单状态</label>
                &nbsp;&nbsp;&nbsp;<select class="select_style" name="status" id="status_query">
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

                &nbsp;&nbsp;&nbsp;<label class="label_Style">条码号</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="barcode" id="barcode_query" value="${barcode}" />

                <br/><br/>
                &nbsp;&nbsp;&nbsp;<label class="label_Style">采集点</label>
                &nbsp;&nbsp;&nbsp;<select class="select_style" name="hospitalName" id="hospitalName_query" title="${hospitalName}">
                                    <option value=""></option>
                                  </select>
                <%--<input type="text" class="input_text_style" name="hospitalName" value="${hospitalName}" id="hospitalName_query" />--%>
                &nbsp;&nbsp;&nbsp;<label class="label_Style">采集时间</label>&nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <input class="input_text_style" name="takeTimeStart" placeholder="开始日期" id="taketime_range_start" value="${takeTimeStart}">
                </div>&nbsp;——&nbsp;

                <div class="layui-inline">
                    <input class="input_text_style" name="takeTimeEnd" placeholder="结束日期" id="taketime_range_end" value="${takeTimeEnd}">
                </div>
               <%-- <label class="label_Style">创建时间</label>&nbsp;&nbsp;&nbsp;
                <div class="layui-inline">
                    <input class="input_text_style" name="createTimeStart" placeholder="开始日期" id="createtime_range_start">
                </div>&nbsp;——&nbsp;

                <div class="layui-inline">
                    <input class="input_text_style" name="createTimeEnd" placeholder="结束日期" id="createtime_range_end">
                </div>--%>

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">

                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel()">导出Excel</button>
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="12%">用户名</th>
                <th class="center left-con" width="10%">订单编号</th>
                <th class="center left-con" width="14%">套餐名称</th>
                <th class="center left-con" width="6%">价格</th>
                <th class="center left-con" width="12%">条码号</th>
                <th class="center left-con" width="13%">状态</th>
                <th class="center left-con" width="15%">创建时间</th>
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
                    <td class="center left-con">${item.tradeModel.tradeNum}</td>
                    <td class="line_limit" align="middle" style="height: 34px">${item.packageName}&nbsp;</td>
                    <%--<td class="center left-con">${item.packageNum}</td>--%>
                    <td class="center left-con"><fmt:formatNumber type="number" value="${item.price / 100}" pattern="#0.00" maxFractionDigits="2"/> </td>
                    <td class="center left-con">${item.barcode}</td>
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
                    <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
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
    <input type="hidden" id="tradeNum" value="${tradeNum}">
    <input type="hidden" id="packageName" value="${packageName}">
    <input type="hidden" id="status" value="${status}">
    <input type="hidden" id="barcode" value="${barcode}">
    <input type="hidden" id="hospitalName" value="${hospitalName}">
    <input type="hidden" id="takeTimeStart" value="${takeTimeStart}">
    <input type="hidden" id="takeTimeEnd" value="${takeTimeEnd}">
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
                    <a href="${pageContext.request.contextPath}/order/query.do?pageNo=${pageNo - 1}&userName=${userName_}&tradeNum=${tradeNum}&packageName=${packageName}&status=${status}&barcode=${barcode}&hospitalName=${hospitalName}&takeTimeStart=${takeTimeStart}&takeTimeEnd=${takeTimeEnd}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/order/query.do?pageNo=${pageNo + 1}&userName=${userName_}&tradeNum=${tradeNum}&packageName=${packageName}&status=${status}&barcode=${barcode}&hospitalName=${hospitalName}&takeTimeStart=${takeTimeStart}&takeTimeEnd=${takeTimeEnd}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/order/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/order/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
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

<%--编辑订单子项 start--%>
<div id="edit_order" style="display: none">
    <br/><form id="edit_order_form" action="" class="layui-form">
    <%--订单用户编号---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">用户编号</label>
        <div class="layui-input-block">
            <input type="hidden" id="edit_id" name="id">
            <input type="text" id="userId_edit" name="userId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--订单编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">订单编号</label>
        <div class="layui-input-block">
            <input type="text" id="tradeId_edit" name="tradeId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--套餐编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">套餐编号</label>
        <div class="layui-input-block">
            <input type="text" id="packageId_edit" name="packageId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--套餐名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">套餐名称</label>
        <div class="layui-input-block">
            <input type="text" id="packageName_edit" name="packageName" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--套餐数量---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">套餐数量</label>
            <div class="layui-input-inline">
                <input type="text" id="packageNum_edit" name="packageNum" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;个</span>
        </div>
    </div>
    <%--套餐价格到分---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 120px">套餐价格到分</label>
            <div class="layui-input-inline">
                <input type="text" id="price_edit" name="price_" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;元</span>
        </div>
    </div>
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
    <%--采集时间--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">采集时间</label>
        <div class="layui-input-block">
            <input type="text" id="takeTime_edit" name="takeTimeS" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--采集护士编号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">采集护士编号</label>
        <div class="layui-input-block">
            <input type="text" id="takeDoctorId_edit" name="takeDoctorId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--报告时间--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">报告时间</label>
        <div class="layui-input-block">
            <input type="text" id="reportTime_edit" name="reportTime" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--报告时间描述--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">报告时间描述</label>
        <div class="layui-input-block">
            <input type="text" id="reportTimeDesc_edit" name="reportTimeDesc" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--条码号--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">条码号</label>
        <div class="layui-input-block">
            <input type="text" id="barcode_edit" name="barcode" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--报告URL--%>
    <%--<div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">报告URL</label>
        <div class="layui-input-block">
            <input type="text" id="reportUrl_edit" name="reportUrl" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>--%>
    <%--报告接受时间--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">报告接受时间</label>
        <div class="layui-input-block">
            <input type="text" id="reportAcceptTime_edit" name="reportAcceptTime" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--解读报告时间--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读报告时间</label>
        <div class="layui-input-block">
            <input type="text" id="unscrambleTime_edit" name="unscrambleTimeS" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--解读音频文件路径--%>
    <%--<div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读音频文件路径</label>
        <div class="layui-input-block">
            <input type="text" id="unscrambleAudioUrl_edit" name="unscrambleAudioUrl" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>--%>
    <%--解读音频文件时长--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读音频文件时长</label>
        <div class="layui-input-block">
            <input type="text" id="unscrambleAudioTime_edit" name="unscrambleAudioTime" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--解读报告内容--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">解读报告内容</label>
        <div class="layui-input-block">
            <textarea id="unscrambleContent_edit" name="unscrambleContent" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    <%--备注--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 120px">备注</label>
        <div class="layui-input-block">
            <textarea id="remark_edit" name="remark" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
</form>
</div>
<%--编辑订单子项 end--%>

<%--显示订单详情 start--%>
<div id="detail_order" style="display: none">
    <table id="detail_order_table" class="layui-table" lay-even lay-skin="nob" style='word-break:break-all'>
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
            <td align="left">用户编号</td>
            <td align="left"></td>
            <td align="left">用户名</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">订单号</td>
            <td align="left"></td>
            <td align="left">订单编号</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">套餐编号</td>
            <td align="left"></td>
            <td align="left">套餐名称</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">套餐数量</td>
            <td align="left"></td>
            <td align="left">套餐价格到分</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">状态</td>
            <td align="left"></td>
            <td align="left">采集时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">采集护士编号</td>
            <td align="left"></td>
            <td align="left">采集护士姓名</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">报告时间</td>
            <td align="left"></td>
            <td align="left">报告时间表述</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">条形码</td>
            <td align="left"></td>
            <td align="left">采集点</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">报告接受时间</td>
            <td align="left"></td>
            <td align="left">解读报告时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">解读音频文件路径</td>
            <td align="left"></td>
            <td align="left">解读音频文件时长</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">创建时间</td>
            <td align="left"></td>
            <td align="left">修改时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">解读报告内容</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">备注</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
    </table>
</div>
<%--显示订单详情 end--%>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/order/order.js"></script>
</body>
</html>

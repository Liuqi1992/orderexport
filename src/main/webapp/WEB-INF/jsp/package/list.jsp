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
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/package/package.js"></script>
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
        <input id="strMenuId" type="hidden" value="1"/>
        <input id="strSubMenuId" type="hidden" value="2"/>

        <%--查询 start--%>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/package/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">套餐名称</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="name" value="${name}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">状态</label>&nbsp;&nbsp;&nbsp;
                <select class="select_style" name="status" >
                    <option value=""></option>
                    <option value="0" <c:if test="${status == '0'}">selected</c:if>>未发布</option>
                    <option value="1" <c:if test="${status == 1}">selected</c:if>>已发布</option>
                    <option value="2" <c:if test="${status == 2}">selected</c:if>>已下线</option>
                </select>

                &nbsp;&nbsp;&nbsp;<label class="label_Style">物价编码</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="wjCode" value="${wjCode}"/>

                &nbsp;&nbsp;&nbsp;<label class="label_Style">价格</label>&nbsp;&nbsp;&nbsp;
                <input type="text" class="input_text_style" placeholder="最低价格" name="min_price" value="${min_price}" />&nbsp;——&nbsp;
                <input type="text" class="input_text_style" placeholder="最高价格" name="max_price" value="${max_price}" />

                <br/><br/>
                &nbsp;&nbsp;&nbsp;<label class="label_Style">销售次数</label>&nbsp;&nbsp;&nbsp;
                <input type="text" class="input_text_style" placeholder="最少次数" name="min_saleNum" value="${min_saleNum}" />&nbsp;——&nbsp;
                <input type="text" class="input_text_style" placeholder="最多次数" name="max_saleNum" value="${max_saleNum}"/>

                &nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
                &nbsp;&nbsp;&nbsp;<button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addPackage()">增加</button>
                <button type="button" class="layui-btn layui-btn-radius layui-btn-small" id="threeDepartmentImport">三方导入</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                <div class="layui-input-inline">
                    <input type="file" class="input_text_style" style="width: 120px" id="selectedExcelFile" name="excelFile">
                </div>
                &nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-small" onclick="importExcel()">Excel导入</button>
                &nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel()">导出Excel</button>
            </form>
        </div>
        <%--查询 end--%>

        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="18%">套餐名称</th>
                <th class="center left-con" width="10%">图片</th>
                <th class="center left-con" width="32%">使用人群</th>
                <th class="center left-con" width="10%">价格（元）</th>
                <th class="center left-con" width="10%">注意事项</th>
                <th class="center left-con" width="30%">操作</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0}">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="line_limit" valign="middle" style="height: 34px">${item.name}&nbsp;</td>
                    <td class="center left-con"><img src="<%@include file="../../ImgUrl/acquireUrl.jsp"%>${item.picUrl}" style="height: 30px; width: 50px"/></td>
                    <td class="line_limit" valign="middle" style="height: 34px">${item.useCrowd}&nbsp;</td>
                    <td class="center left-con"><c:if test="${item.price != null}"><fmt:formatNumber type="number" value="${item.price / 100}" pattern="#0.00" maxFractionDigits="2"/></c:if></td>
                    <td class="line_limit" valign="middle" style="height: 34px">${item.needAttention}&nbsp;</td>
                    <td class="center left-con">
                       <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;
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
    <input type="hidden" id="name" value="${name}">
    <input type="hidden" id="status" value="${status}">
    <input type="hidden" id="wjCode" value="${wjCode}">
    <input type="hidden" id="min_price" value="${min_price}">
    <input type="hidden" id="max_price" value="${max_price}">
    <input type="hidden" id="min_saleNum" value="${min_saleNum}">
    <input type="hidden" id="max_saleNum" value="${max_saleNum}">
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
                    <a href="${pageContext.request.contextPath}/package/query.do?pageNo=${pageNo - 1}&name=${name}&status=${status}&wjCode=${wjCode}&min_price=${min_price}&max_price=${max_price}&min_saleNum=${min_saleNum}&max_saleNum=${max_saleNum}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/package/query.do?pageNo=${pageNo + 1}&name=${name}&status=${status}&wjCode=${wjCode}&min_price=${min_price}&max_price=${max_price}&min_saleNum=${min_saleNum}&max_saleNum=${max_saleNum}">下一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">下一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:choose>
                <c:when test="${pageNo > 1}">
                    <a href="${pageContext.request.contextPath}/package/listPage.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                </c:when>
                <c:otherwise>
                    <a href="#">上一页</a>&nbsp;&nbsp;
                </c:otherwise>
            </c:choose>
            <c:choose>
                <c:when test="${pageNo < totalPage}">
                    <a href="${pageContext.request.contextPath}/package/listPage.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
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
<%--增加套餐 start--%>
<div id="add_package" style="display: none;">
    <br/><form id="add_package_form" action="" class="layui-form">
    <%--套餐名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐名称</label>
        <div class="layui-input-block">
            <input type="text" id="name_add" name="name" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--套餐类别--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐类别</label>
        <div class="layui-input-inline" style="width: 260px;">
            <select name="packageType" lay-verify="">
                <option value=""></option>
                <option value="0">新项目</option>
                <option value="1">常见</option>
                <option value="2">慢病</option>
                <option value="3">特检</option>
                <option value="4">妇幼</option>
            </select>
        </div>
    </div>
    <%--使用人群---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">使用人群</label>
        <div class="layui-input-block">
            <input type="text" name="useCrowd" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--价格---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">价格</label>
            <div class="layui-input-inline">
                <input type="text" name="price_str" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;元</span>
        </div>
    </div>
    <%--报告时间---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">报告时间</label>
            <div class="layui-input-inline">
                <input type="text" name="reportTime" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;小时</span>
        </div>
    </div>
    <%--报告时间说明---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">报告时间说明</label>
        <div class="layui-input-block">
            <input type="text" name="reportTimeDesc" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--物价编号---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">物价编号</label>
        <div class="layui-input-block">
            <input type="text" name="wjCode" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--使用数量---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">使用数量</label>
            <div class="layui-input-inline">
                <input type="text" name="saleNum" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;次</span>
        </div>
    </div>
    <%--套餐图片--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐图片</label>
        <div class="layui-input-block">
            <input type="file" id="picUrl_add" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="picUrl_add_" name="picUrl" />
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPic()">
        </div>
    </div>
    <%--套餐详情图片--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐详情图片</label>
        <div class="layui-input-block">
            <input type="file" id="detailImg_add" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="detailImg_add_" name="detailImg" />
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadDetailImg()">
        </div>
    </div>
    <%--套餐状态--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐状态</label>
        <div class="layui-input-inline" style="width: 260px">
            <select name="status" lay-verify="">
                <option value=""></option>
                <option value="0">未发布</option>
                <option value="1">已发布</option>
                <option value="2">已下线</option>
            </select>
        </div>
    </div>
    <%--样本类型--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">样本类型</label>
        <div class="layui-input-block">
            <input type="text" name="sampleType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--检验分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">检验分类</label>
        <div class="layui-input-block">
            <input type="text" name="testType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--疾病分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">疾病分类</label>
        <div class="layui-input-block">
            <input type="text" name="diseaseType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--采集分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">采集分类</label>
        <div class="layui-input-block">
            <input type="text" name="takeType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--检验目的ID--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">检验目的ID</label>
        <div class="layui-input-block">
            <input type="text" name="testObjectId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--树兰检验目的Id--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">树兰检验目的Id</label>
        <div class="layui-input-block">
            <input type="text" name="shulanObjectId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--是否是血液流程--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">是否是血液流程</label>
        <div class="layui-input-inline" style="width: 260px">
            <select name="isBlood" lay-verify="">
                <option value=""></option>
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
        </div>
    </div>

    <%--储存条件--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">储存条件</label>
        <div class="layui-input-block">
            <input type="text" name="storageCondit" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--注意事项--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">注意事项</label>
        <div class="layui-input-block">
            <textarea name="needAttention" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    <%--检验项目说明--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">项目说明</label>
        <div class="layui-input-block">
            <textarea name="projectDesc" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    <%--相关问题及免责条款--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">相关问题及免责条款</label>
        <div class="layui-input-block">
            <textarea name="clause" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
</form>
</div>
<%--增加套餐 end--%>

<%--套餐关联信息 start--%>
<div id="package_detail_add" style="display: none">
    <br/><form id="package_detail_add_form" action="" class="layui-form">
    <%--his项目名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label">his项目名称</label>
        <div class="layui-input-block" style="width: 260px">
            <select name="status" lay-verify="">
                <option value=""></option>
            </select>
        </div>
    </div>
    <%--his价格到分--%>
    <div class="layui-form-item">
        <label class="layui-form-label">his价格到分</label>
        <div class="layui-input-block">
            <input type="text" name="hisPrice" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    </form>
</div>
<%--套餐关联信息 end--%>

<%--编辑套餐 start--%>
<script type="text/html" id="edit_package">
    <br/><form id="edit_package_form" action="" class="layui-form">
    <%--套餐名称--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐名称</label>
        <div class="layui-input-block">
            <input type="hidden" id="edit_id" name="id">
            <input type="text" id="edit_name" name="name" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--套餐类别--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐类别</label>
        <div class="layui-input-inline" style="width: 260px;">
            <input type="hidden" name="packageKindId" id="edit_packageKindId">
            <select name="packageType" id="edit_packageType" lay-verify="">
                <option value=""></option>
                <option value="0">新项目</option>
                <option value="1">常见</option>
                <option value="2">慢病</option>
                <option value="3">特检</option>
                <option value="4">妇幼</option>
            </select>
        </div>
    </div>
    <%--使用人群---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">使用人群</label>
        <div class="layui-input-block">
            <input type="text" id="edit_useCrowd" name="useCrowd" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--价格---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">价格</label>
            <div class="layui-input-inline">
                <input type="text" id="edit_price" name="price_str" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;元</span>
        </div>
    </div>
    <%--报告时间--%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">报告时间</label>
            <div class="layui-input-inline">
                <input type="text" id="edit_reportTime" name="reportTime" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;小时</span>
        </div>
    </div>
    <%--报告时间说明--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">报告时间说明</label>
        <div class="layui-input-block">
            <input type="text" id="edit_reportTimeDesc" name="reportTimeDesc" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--物价编号---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">物价编号</label>
        <div class="layui-input-block">
            <input type="text" id="edit_wjCode" name="wjCode" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--使用数量---%>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label class="layui-form-label" style="width: 100px">使用数量</label>
            <div class="layui-input-inline">
                <input type="text" id="edit_saleNum" name="saleNum" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-inline">
            <span>&nbsp;&nbsp;次</span>
        </div>
    </div>
    <%--套餐图片--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐图片</label>
        <div class="layui-input-block">
            <input type="file" id="picUrl_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="picUrl_edit_" name="picUrl" />
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPicEdit()">
        </div>
    </div>
    <%--套餐详情图片--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐详情图片</label>
        <div class="layui-input-block">
            <input type="file" id="detailImg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="detailImg_edit_" name="detailImg" />
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadDetailImgEdit()">
        </div>
    </div>

    <%--套餐状态--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">套餐状态</label>
        <div class="layui-input-inline" style="width: 260px">
            <select id="edit_status" name="status" lay-verify="">
                <option value=""></option>
                <option value="0">未发布</option>
                <option value="1">已发布</option>
                <option value="2">已下线</option>
            </select>
        </div>
    </div>

    <%--样本类型--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">样本类型</label>
        <div class="layui-input-block">
            <input type="text" id="edit_sampleType" name="sampleType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--检验分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">检验分类</label>
        <div class="layui-input-block">
            <input type="text" id="edit_testType" name="testType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--疾病分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">疾病分类</label>
        <div class="layui-input-block">
            <input type="text" id="edit_diseaseType" name="diseaseType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--采集分类---%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">采集分类</label>
        <div class="layui-input-block">
            <input type="text" id="edit_takeType" name="takeType" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--检验目的ID--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">检验目的ID</label>
        <div class="layui-input-block">
            <input type="text" id="edit_testObjectId" name="testObjectId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--树兰检验目的Id--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">树兰检验目的Id</label>
        <div class="layui-input-block">
            <input type="text" id="edit_shulanObjectId" name="shulanObjectId" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--是否是血液流程--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">是否是血液流程</label>
        <div class="layui-input-inline" style="width: 260px">
            <select id="edit_isBlood" name="isBlood" lay-verify="">
                <option value=""></option>
                <option value="0">否</option>
                <option value="1">是</option>
            </select>
        </div>
    </div>

    <%--储存条件--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">储存条件</label>
        <div class="layui-input-block">
            <input type="text" id="edit_storageCondit" name="storageCondit" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--注意事项--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">注意事项</label>
        <div class="layui-input-block">
            <textarea id="edit_needAttention" name="needAttention" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    <%--检验项目说明--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">项目说明</label>
        <div class="layui-input-block">
            <textarea id="edit_projectDesc" name="projectDesc" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    <%--相关问题及免责条款--%>
    <div class="layui-form-item">
        <label class="layui-form-label" style="width: 100px">相关问题及免责条款</label>
        <div class="layui-input-block">
            <textarea id="edit_clause" name="clause" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
    </form>
</script>
<%--编辑套餐 end--%>
<%--知识库编辑start--%>
<script type="text/html" id="edit_packageKnowledge">
    <br><form class="layui-form" id="edit_package_knowledge_from">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">套餐名称</label>
            <div class="layui-input-block">
                <input type="hidden" id="edit_knowledge_id" name="id">
                <input type="hidden" id="edit_knowledge_package_id" name="packageId">
                <input type="text" id="packageNameOfKnowledge" class="layui-input" style="width: 260px" readonly="readonly">
            </div>
        </div>
        <%--疾病类型--%>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">疾病类型</label>
            <div class="layui-input-inline" style="width: 260px">
                <select id="edit_knowledge_disease_type" name="diseaseType" lay-verify="">
                    <option value=""></option>
                    <option value="0">心血管疾病</option>
                    <option value="1">肝炎</option>
                    <option value="2">肿瘤疾病</option>
                    <option value="3">肝胆胰疾病</option>
                    <option value="4">肾功能</option>
                    <option value="5">血液病</option>
                    <option value="6">出凝血检测</option>
                    <option value="7">内分泌疾病</option>
                    <option value="8">自身抗体</option>
                    <option value="9">感染性疾病</option>
                    <option value="10">骨疾病</option>
                    <option value="11">电解质与微量元素</option>
                    <option value="12">过敏原</option>
                    <option value="13">染色体</option>
                    <option value="14">药物浓度监测</option>
                    <option value="15">体液检验</option>
                    <option value="16">常规检验</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">项目介绍</label>
            <div class="layui-input-block">
                <textarea id="edit_knowledge_introduction" name="introduction" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">检验目的</label>
            <div class="layui-input-block">
                <textarea id="edit_knowledge_objective" name="objective" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
            </div>
        </div>

        <%--<div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">检验时间</label>
            <div class="layui-input-block">
                <textarea id="edit_knowledge_text_time" name="textTime" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
            </div>
        </div>--%>
        <%--<div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">注意事项</label>
            <div class="layui-input-block">
                <textarea id="edit_knowledge_need_attention" name="needAttention" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
            </div>
        </div>--%>
    </form>
</script>
<%--知识库编辑end--%>

<%--采集手册编辑start--%>
<script type="text/html" id="edit_collect_manual">
    <br><form class="layui-form" id="edit_package_collect_manual_from">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">套餐名称</label>
            <div class="layui-input-block">
                <input type="hidden" id="edit_collect_manual_id" name="id">
                <input type="hidden" id="edit_collect_manual_package_id" name="packageId">
                <input type="text" id="packageNameOfCollectManual" class="layui-input" style="width: 260px" readonly="readonly">
            </div>
        </div>
        <%--采集手册类型--%>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">采集手册类型</label>
            <div class="layui-input-inline" style="width: 260px">
                <select id="edit_type" name="type" lay-verify="">
                    <option value=""></option>
                    <option value="0">生化</option>
                    <option value="1">免疫</option>
                    <option value="2">微生物</option>
                    <option value="3">病理</option>
                    <option value="4">内分泌</option>
                    <option value="5">临检</option>
                    <option value="6">细菌</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">检验方法</label>
            <div class="layui-input-block">
                <input type="text" id="edit_collect_manual_text_method" name="textMethod" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">采集管</label>
            <div class="layui-input-block">
                <input type="text" id="edit_collect_manual_collect_tube" name="collectTube" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">采集图片</label>
            <div class="layui-input-block">
                <input type="file" id="collectImg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
                <input type="hidden" id="collectImg_edit_" name="collectImg" />
                <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadCollectImgEdit()">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">存储条件</label>
            <div class="layui-input-block">
                <input type="text" id="edit_collect_manual_storage_condit" name="storageCondit" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">样本量</label>
            <div class="layui-input-block">
                <input type="text" id="edit_collect_manual_collect_require" name="collectRequire" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">注意事项</label>
            <div class="layui-input-block">
                <input type="text" id="edit_collect_manual_need_attention" name="needAttention" required lay-verify="required" class="layui-input" style="width: 260px">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">备注说明</label>
            <div class="layui-input-block">
                <textarea id="edit_collect_manual_remark" name="remark" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
            </div>
        </div>
    </form>
</script>
<%--采集手册编辑end--%>

<%--套餐详情 start--%>
<script type="text/html" id="detail_package">
    <table id="detail_package_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="4">
            <col width="20%">
            <col width="30%">
            <col width="5%">
            <col width="45%">
            <%--<col width="27%">
            <col width="23%">--%>
        </colgroup>
        <tbody>
        <tr>
            <td align="left">套餐名称</td>
            <td align="left"></td>
            <td rowspan="4">套餐主图</td>
            <td rowspan="4"><img id="package_picture" alt="套餐主图" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>"
                                 style="width: 220px;height: 140px" /></td>
        </tr>
        <tr>
            <td align="left">价格</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">套餐状态</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">报告时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">报告时间说明</td>
            <td align="left"></td>
            <td align="left" rowspan="4">套餐详情图</td>
            <td rowspan="4"><img alt="套餐详情图" id="packageDetailImg" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>"
                                style="width: 220px;height: 140px" />
            </td>
        </tr>
        <tr>
            <td align="left">已使用数量</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">物价编码</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">套餐类型</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">检验分类</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">检验目的ID</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">树兰检验目的ID</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">是否是血液流程</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">储存条件</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">样本类型</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">使用人群</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">疾病分类</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td align="left">采集分类</td>
            <td align="left" colspan="3"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">注意事项</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">检验项目说明</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">相关问题及免责条款</td>
            <td colspan="3" style="height: 50px" valign="top"></td>
        </tr>
        </tbody>
    </table>
</script>
<%--套餐详情 end--%>
<%--知识库详情start--%>
<script type="text/html" id="knowledge_details">
    <table id="detail_knowledge_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="2">
            <col width="20%">
            <col width="80%">
        </colgroup>
        <tbody>
            <tr>
                <td align="left">套餐名称</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">疾病类型</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td valign="top" align="left" style="height: 50px">项目介绍</td>
                <td style="height: 50px" valign="top"></td>
            </tr>
            <tr>
                <td valign="top" align="left" style="height: 50px">检验目的</td>
                <td style="height: 50px" valign="top"></td>
            </tr>
            <%--<tr>
                <td valign="top" align="left" style="height: 50px">何时检测</td>
                <td style="height: 50px" valign="top"></td>
            </tr>--%>
            <%--<tr>
                <td valign="top" align="left" style="height: 50px">注意事项</td>
                <td style="height: 50px" valign="top"></td>
            </tr>--%>
        </tbody>
    </table>
</script>
<%--知识库详情end--%>

<%--采集手册详情start--%>
<%----%>
<script type="text/html" id="collect_manual_details">
    <table id="detail_collect_manual_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="2">
            <col width="20%">
            <col width="80%">
        </colgroup>
        <tbody>
        <tr>
            <td align="left">套餐名称</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">采集手册类型</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">检验方法</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">采集管</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">采集图片</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">存储条件</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">样本量</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">注意事项</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 50px">备注说明</td>
            <td style="height: 50px" valign="top"></td>
        </tr>
        </tbody>
    </table>
</script>
<%--采集手册详情end--%>
</body>
</html>
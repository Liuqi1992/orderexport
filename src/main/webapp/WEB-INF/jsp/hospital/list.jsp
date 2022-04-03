<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>app 后台</title>
    <%@include file="../../head.jsp"%>
    <%@include file="../../jquery.jsp"%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/hospital/hospital.js"></script>
    <link href="${pageContext.request.contextPath}/css/customStyle.css" rel="stylesheet">
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
        <input id="strSubMenuId" type="hidden" value="21"/>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/hospital/query.do" method="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">医院名称:</label>
                &nbsp;&nbsp;&nbsp;<input id="jskajskajska" class="input_text_style" name="name" value="${name}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">电话:</label>
                &nbsp;&nbsp;&nbsp;<input class="input_text_style" name="telphone" value="${telphone}" />

                &nbsp;&nbsp;&nbsp;
                <input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询" />

                &nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addHospital()">新增</button>
                &nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-radius layui-btn-small" id="threeDepartmentImport">三方导入</button>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel()">导出Excel</button>
            </form>
        </div>
        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="15%">医院名称</th>
                <th class="center left-con" width="12%">主图</th>
                <th class="center left-con" width="30%">地址</th>
                <th class="center left-con" width="15%">电话</th>
                <th class="center left-con" width="20%">操作</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0 }">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="center left-con">${item.name}</td>
                    <td class="center left-con"><img src="<%@include file="../../constants.jsp"%>${item.picUrl}" style="width: 50px;height:30px"/></td>
                    <td class="line_limit" align="middle" style="height: 34px;">${item.address}</td>
                    <td class="center left-con">${item.telphone}</td>
                    <td class="center left-con">
                       <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}');">编辑</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemDetail('${item.id}')">详情</a> </span>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>

    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="query_flag" value="${query_flag}">
    <input type="hidden" id="type" value="${type}">
    <input type="hidden" id="name" value="${name}">
    <input type="hidden" id="telphone" value="${telphone}">
    <div id="page" align="center" class="pagestyle"></div>
    <%--<div align="center" style="font-size: small;position: fixed;left: 400px;top: 600px;right: 200px">
        第${pageNo}页&nbsp;&nbsp;
        <c:choose>
            <c:when test="${query_flag == true}">
                <c:choose>
                    <c:when test="${pageNo > 1}">
                        <a href="${pageContext.request.contextPath}/hospital/query.do?pageNo=${pageNo - 1}&name=${name}&telphone=${telphone}">上一页</a>&nbsp;&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="#">上一页</a>&nbsp;&nbsp;
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${pageNo < totalPage}">
                        <a href="${pageContext.request.contextPath}/hospital/query.do?pageNo=${pageNo + 1}&name=${name}&telphone${telphone}">下一页</a>&nbsp;&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="#">上一页</a>&nbsp;&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:otherwise>
                <c:choose>
                    <c:when test="${pageNo > 1}">
                        <a href="${pageContext.request.contextPath}/hospital/list.do?pageNo=${pageNo - 1}&type=${type}">上一页</a>&nbsp;&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="#">上一页</a>&nbsp;&nbsp;
                    </c:otherwise>
                </c:choose>
                <c:choose>
                    <c:when test="${pageNo < totalPage}">
                        <a href="${pageContext.request.contextPath}/hospital/list.do?pageNo=${pageNo + 1}&type=${type}">下一页</a>&nbsp;&nbsp;
                    </c:when>
                    <c:otherwise>
                        <a href="#">上一页</a>&nbsp;&nbsp;
                    </c:otherwise>
                </c:choose>
            </c:otherwise>
        </c:choose>
        共${totalPage}页
    </div>
   </div>
</div>--%>
 <%--<%@include file="mbottom.jsp"%>--%>
    <%--增加医院--%>
    <div id="add_hospital_page" style="display: none">
        <br/><form id="add_hospital_form" action="" class="layui-form">
            <%--医院名--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院名称</label>
                <div class="layui-input-block">
                    <input type="text" name="name" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--医院图片--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院图片</label>
                <div class="layui-input-block">
                    <input type="file" id="picUrl_add" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
                    <input type="hidden" id="picUrl_add_" name="picUrl"/>
                    <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPic()">
                </div>
            </div>

            <%--医院大图--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院大图</label>
                <div class="layui-input-block">
                    <input type="file" id="bigImg_add" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
                    <input type="hidden" id="bigImg_add_" name="bigImg"/>
                    <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadBigImg()">
                </div>
            </div>

            <%--医院电话--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院电话</label>
                <div class="layui-input-block">
                    <input type="text" name="telphone" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--医院经度--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">医院经度</label>
                    <div class="layui-input-block">
                        <input type="text" name="longitude" required lay-verify="required" class="layui-input" style="width: 200px">
                    </div>
                </div>
                <div class="layui-inline">
                    <input type="button" class="layui-btn layui-btn-radius layui-btn-small" value="获取" onclick="getLongitudeAndLatitude()">
                </div>
            </div>

            <%--医院纬度--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">医院纬度</label>
                    <div class="layui-input-block">
                        <input type="text" name="latitude" required lay-verify="required" class="layui-input" style="width: 200px">
                    </div>
                </div>
                <div class="layui-inline">
                    <input type="button" class="layui-btn layui-btn-radius layui-btn-small" value="获取" onclick="getLongitudeAndLatitude()">
                </div>
            </div>

            <%--支付宝付款账户--%>
            <div class="layui-form-item">
                <label class="layui-form-label">支付宝账户</label>
                <div class="layui-input-block">
                    <input type="text" name="alipayPayAccount" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--微信付款账户--%>
            <div class="layui-form-item">
                <label class="layui-form-label">微信账户</label>
                <div class="layui-input-block">
                    <input type="text" name="weixinPayAccount" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>
            <%--客户号--%>
            <div class="layui-form-item">
                <label class="layui-form-label">客户号</label>
                <div class="layui-input-block">
                    <input type="text" name="clientNum" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>
            <%--机构号--%>
            <div class="layui-form-item">
                <label class="layui-form-label">机构号</label>
                <div class="layui-input-block">
                    <input type="text" name="institutionNum" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>


            <%--检验项目说明--%>
            <%--<div class="layui-form-item">
                <label class="layui-form-label">检验说明</label>
                <div class="layui-input-block">
                    <textarea name="projectDesc" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>--%>
            <%--省市区县--%>
            <div class="layui-form-item">
                <label class="layui-form-label">省市区（县）</label>
                <div class="layui-input-inline" style="width: 100px">
                    <input type="hidden" id="h_add_province" name="province">
                    <select id="add_province" lay-filter="add_province">
                        <option value=""></option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 100px;">
                    <input type="hidden" id="h_add_city" name="city">
                    <select id="add_city" lay-filter="add_city">
                        <option value=""></option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 100px">
                    <input type="hidden" id="h_add_area" name="area">
                    <select id="add_area">
                        <option value=""></option>
                    </select>
                </div>
            </div>
            <%--详细地址--%>
            <div class="layui-form-item">
                <label class="layui-form-label">详细地址</label>
                <div class="layui-input-block">
                    <input type="text" name="address" required lay-verify="required" class="layui-input" style="width: 320px">
                </div>
            </div>

            <%--特色优势--%>
            <div class="layui-form-item">
                <label class="layui-form-label">特色优势</label>
                <div class="layui-input-block">
                    <textarea name="specialist" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>

            <%--交通路线--%>
            <div class="layui-form-item">
                <label class="layui-form-label">交通路线</label>
                <div class="layui-input-block">
                    <textarea name="route" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>
            <%--详情介绍--%>
            <div class="layui-form-item">
                <label class="layui-form-label">详情介绍</label>
                <div class="layui-input-block">
                    <textarea name="details" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>
        </form>
    </div>

    <%--编辑医院信息--%>
    <div id="hospital_info_edit" style="display: none">
        <br/><form id="edit_hospital_form" action="" class="layui-form">
            <%--医院名--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院名称</label>
                <div class="layui-input-block">
                    <input type="hidden" id="id_form" name="id" />
                    <input type="text" id="edit_name" name="name" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--医院图片--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院图片</label>
                <div class="layui-input-block">
                    <input type="file" id="edit_picUrl" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
                    <input type="hidden" id="edit_picUrl_" name="picUrl" />
                    <input type="button" class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPicEdit()">
                </div>
            </div>

            <%--医院大图--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院大图</label>
                <div class="layui-input-block">
                    <input type="file" id="bigImg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
                    <input type="hidden" id="bigImg_edit_" name="bigImg"/>
                    <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadBigImgEdit()">
                </div>
            </div>

            <%--医院电话--%>
            <div class="layui-form-item">
                <label class="layui-form-label">医院电话</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_telphone" name="telphone" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--医院经度--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">医院经度</label>
                    <div class="layui-input-block">
                        <input type="text" id="edit_longitude" name="longitude" required lay-verify="required" class="layui-input" style="width: 200px">
                    </div>
                </div>
                <div class="layui-inline">
                    <input type="button" class="layui-btn layui-btn-radius layui-btn-small" value="获取" onclick="getLongitudeAndLatitude()">
                </div>
            </div>

            <%--医院纬度--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">医院纬度</label>
                    <div class="layui-input-block">
                        <input type="text" id="edit_latitude" name="latitude" required lay-verify="required" class="layui-input" style="width: 200px">
                    </div>
                </div>
                <div class="layui-inline">
                    <input type="button" class="layui-btn layui-btn-radius layui-btn-small" value="获取" onclick="getLongitudeAndLatitude()">
                </div>
            </div>

            <%--支付宝付款账户--%>
            <div class="layui-form-item">
                <label class="layui-form-label">支付宝账户</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_alipayPayAccount" name="alipayPayAccount" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--微信付款账户--%>
            <div class="layui-form-item">
                <label class="layui-form-label">微信账户</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_weixinPayAccount" name="weixinPayAccount" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--客户号--%>
            <div class="layui-form-item">
                <label class="layui-form-label">客户号</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_clientNum" name="clientNum" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>
            <%--机构号--%>
            <div class="layui-form-item">
                <label class="layui-form-label">机构号</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_institutionNum" name="institutionNum" required lay-verify="required" class="layui-input" style="width: 260px">
                </div>
            </div>

            <%--检验项目说明--%>
            <%--<div class="layui-form-item">
                <label class="layui-form-label">检验说明</label>
                <div class="layui-input-block">
                    <textarea id="edit_projectDesc" name="projectDesc" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>--%>
            <%--省市区县--%>
            <div class="layui-form-item">
                <label class="layui-form-label">省市区（县）</label>
                <div class="layui-input-inline" style="width: 100px">
                    <input type="hidden" id="h_edit_province" name="province">
                    <select id="edit_province" lay-filter="edit_province">
                        <option value=""></option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 100px;">
                    <input type="hidden" id="h_edit_city" name="city">
                    <select id="edit_city" lay-filter="edit_city">
                        <option value=""></option>
                    </select>
                </div>
                <div class="layui-input-inline" style="width: 100px">
                    <input type="hidden" id="h_edit_area" name="area">
                    <select id="edit_area">
                        <option value=""></option>
                    </select>
                </div>
            </div>
            <%--详细地址--%>
            <div class="layui-form-item">
                <label class="layui-form-label">详细地址</label>
                <div class="layui-input-block">
                    <input type="text" id="edit_address" name="address" required lay-verify="required" class="layui-input" style="width: 320px">
                </div>
            </div>

            <%--特色优势--%>
            <div class="layui-form-item">
                <label class="layui-form-label">特色优势</label>
                <div class="layui-input-block">
                    <textarea id="edit_specialist" name="specialist" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>

            <%--交通路线--%>
            <div class="layui-form-item">
                <label class="layui-form-label">交通路线</label>
                <div class="layui-input-block">
                    <textarea id="edit_route" name="route" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>

            <%--详情介绍--%>
            <div class="layui-form-item">
                <label class="layui-form-label">详情介绍</label>
                <div class="layui-input-block">
                    <textarea id="edit_details" name="details" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
                </div>
            </div>
        </form>
    </div>

    <%--显示医院详细信息--%>
    <div id="detail_info" style="display: none">
        <table id="detail_info_table" class="layui-table" lay-even lay-skin="nob">
            <colgroup align="left" span="3">
                <col width="20%">
                <col width="35%">
                <col width="45%">
                <%--<col width="27%">
                <col width="23%">--%>
            </colgroup>
            <tbody>
            <tr>
                <td align="left">医院名称</td>
                <td align="left"></td>
                <td rowspan="4"><img id="hospital_picture" alt="医院主图" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>"
                                     style="width: 260px;height: 160px"></td>
            </tr>
            <tr>
                <td align="left">电话</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">经度</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">纬度</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">地址</td>
                <td colspan="2" align="left"></td>
            </tr>
            <tr>
                <td align="left">客户号</td>
                <td colspan="2" align="left"></td>
            </tr>
            <tr>
                <td align="left">机构号</td>
                <td colspan="2" align="left"></td>
            </tr>
            <%--<tr>
                <td valign="top" align="left" style="height: 80px">检验项目说明</td>
                <td colspan="2" style="height: 80px" valign="top"></td>
            </tr>--%>
            <tr>
                <td valign="top" align="left" style="height: 80px">特色优势</td>
                <td colspan="2" style="height: 80px" valign="top"></td>
            </tr>
            <tr>
                <td valign="top" align="left" style="height: 80px">交通路线</td>
                <td colspan="2" style="height: 80px" valign="top"></td>
            </tr>
            <tr>
                <td valign="top" align="left" style="height: 100px">详情介绍</td>
                <td colspan="2" style="height: 100px" valign="top"></td>
            </tr>
            <tr>
                <td>医院大图</td>
                <td colspan="2"><img id="hospital_bigImg" alt="医院大图" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>"
                                     style="width: 460px;height: 160px"></td>
            </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
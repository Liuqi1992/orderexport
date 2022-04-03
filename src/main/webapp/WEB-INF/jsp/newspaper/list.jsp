<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/KindEdit/themes/default/default.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/KindEdit/plugins/code/prettify.css" />
<script charset="utf-8" src="${pageContext.request.contextPath}/KindEdit/kindeditor-all-min.js"></script>
<script charset="utf-8" src="${pageContext.request.contextPath}/KindEdit/lang/zh-CN.js"></script>
<script charset="utf-8" src="${pageContext.request.contextPath}/KindEdit/plugins/code/prettify.js"></script>
<link href="${pageContext.request.contextPath}/css/customStyle.css" rel="stylesheet">
<title>app 后台</title>
    <%@include file="../../head.jsp"%>
    <%@include file="../../jquery.jsp"%>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/newspaper/newspapaer.js"></script>
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
        <input id="strMenuId" type="hidden" value="3"/>
        <input id="strSubMenuId" type="hidden" value="31"/>
        <div>
            <br/>
            <form action="${pageContext.request.contextPath}/newspaper/query.do" METHOD="post">
                &nbsp;&nbsp;&nbsp;<label class="label_Style">标题</label>
                &nbsp;&nbsp;&nbsp;<input type="text" class="input_text_style" name="title" value="${title}" />

                &nbsp;&nbsp;&nbsp;<label class="label_Style">类型</label>&nbsp;&nbsp;&nbsp;
                <select class="select_style" name="type" >
                    <option value=""></option>
                    <option value="0" <c:if test="${type == '0'}">selected</c:if>>客户端首页广告</option>
                    <option value="1" <c:if test="${type == 1}">selected</c:if>>医生端广告</option>
                    <option value="2" <c:if test="${type == 2}">selected</c:if>>护士</option>
                </select>

                &nbsp;&nbsp;&nbsp;<label class="label_Style">状态</label>&nbsp;&nbsp;&nbsp;
                <select class="select_style" name="status" >
                    <option value=""></option>
                    <option value="0" <c:if test="${status == '0'}">selected</c:if>>暂存草稿</option>
                    <option value="1" <c:if test="${status == 1}">selected</c:if>>已发布</option>
                    <option value="2" <c:if test="${status == 2}">selected</c:if>>取消发布</option>
                </select>

                &nbsp;&nbsp;&nbsp;<input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询">
                &nbsp;&nbsp;&nbsp;<button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addNewspaper()">增加</button>

            </form>
        </div>
        <table class="sui-table table-bordered" style="margin-top:20px;">
            <thead>
            <tr>
                <th class="center left-con" width="8%">编号</th>
                <th class="center left-con" width="18%">标题</th>
                <th class="center left-con" width="32%">主图</th>
                <th class="center left-con" width="10%">类型</th>
                <th class="center left-con" width="10%">状态</th>
                <th class="center left-con" width="30%">操作</th>
            </tr>
            </thead>
            <tbody id="all_task0">
            <c:if test="${fn:length(list)==0 }">
                <tr ><td colspan="6" class="center left-con" >亲，暂时没有活动哦！</td></tr>
            </c:if>
            <c:forEach items="${list}" var="item">
                <tr>
                    <td class="center left-con">${item.id}</td>
                    <td class="center left-con">${item.title}</td>
                    <td class="center left-con"><img src="<%@include file="../../constants.jsp"%>${item.imgUrl}" height="50px" width="50px"/></td>
                    <td class="center left-con">
                        <c:if test="${item.type==0}">
                            <span class="sui-label label-success">客户端</span>
                        </c:if>
                        <c:if test="${item.type==1}">
                            <span class="sui-label label-">开单医生端</span>
                        </c:if>
                        <c:if test="${item.type==2}">
                            <span class="sui-label label-">护士端</span>
                        </c:if>
                        <c:if test="${item.type==3}">
                            <span class="sui-label label-info">解读医生端</span>
                        </c:if>
                    </td>
                    <td class="center left-con">
                        <c:if test="${item.status==0}">
                            <span class="sui-label label-">暂存草稿</span>
                        </c:if>
                        <c:if test="${item.status==1}">
                            <span class="sui-label label-success">已发布</span>
                        </c:if>
                        <c:if test="${item.status==2}">
                            <span class="sui-label label-">取消发布</span>
                        </c:if>
                    </td>
                    <td class="center left-con">
                       <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}');">删除</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}');">编辑</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemContent('${item.id}');">内容</a></span>&nbsp;&nbsp;
                       <span class=""><a href="javascript:void(0)" onclick="ItemDetail('${item.id}');">详情</a></span>&nbsp;&nbsp;
                    </td>
                </tr>
            </c:forEach>
            </tbody>
    </table>
    <input type="hidden" id="pageNo" value="${pageNo}">
    <input type="hidden" id="totalPage" value="${totalPage}">
    <input type="hidden" id="query_flag" value="${query_flag}">
    <input type="hidden" id="type" value="${type}">
    <input type="hidden" id="title" value="${title}">
    <input type="hidden" id="status" value="${status}">
    <div id="page" align="center" class="pagestyle"></div>
        <%--<div align="center" class="page_num_style">
            第${pageNo}页&nbsp;&nbsp;
            <c:choose>
                <c:when test="${query_flag == true}">
                    <c:choose>
                        <c:when test="${pageNo > 1}">
                            <a href="${pageContext.request.contextPath}/newspaper/query.do?pageNo=${pageNo - 1}&title=${title}&type=${type}&status=${status}">上一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">上一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/newspaper/query.do?pageNo=${pageNo + 1}&title=${title}&type=${type}&status=${status}">下一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">下一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:when>
                <c:otherwise>
                    <c:choose>
                        <c:when test="${pageNo > 1}">
                            <a href="${pageContext.request.contextPath}/newspaper/list.do?pageNo=${pageNo - 1}&type=${type}">上一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">上一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                    <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/newspaper/list.do?pageNo=${pageNo + 1}&type=${type}">下一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">下一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>
            共${totalPage}页
        </div>--%>
   </div>
</div>
 <%--<%@include file="mbottom.jsp"%>--%>
<%--添加新闻--%>
<div id="add_newspaper" style="display: none">
    <br/><form id="add_newspaper_form" action="" class="layui-form">
    <%--广告标题--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>
    <%--广告主图--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告主图</label>
        <div class="layui-input-block">
            <input type="file" id="imgUrl_add" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="imgUrl_add_" name="imgUrl"/>
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPic()">
        </div>
    </div>

    <%--广告内容链接--%>
    <%--<div class="layui-form-item">
        <label class="layui-form-label">内容链接</label>
        <div class="layui-input-block">
            <input type="text" name="contentUrl" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>--%>

    <%--广告类型--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告类型</label>
        <div class="layui-input-block" style="width: 260px">
            <select name="type" lay-verify="">
                <option value=""></option>
                <option value="0">客户端首页广告</option>
                <option value="1">开单医生端广告</option>
                <option value="2">护士</option>
                <option value="3">解读医生端广告</option>
            </select>
        </div>
    </div>

    <%--广告状态--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告状态</label>
        <div class="layui-input-block" style="width: 260px">
            <select name="status" lay-verify="">
                <option value=""></option>
                <option value="0">暂存草稿</option>
                <option value="1">已发布</option>
                <option value="2">取消发布</option>
            </select>
        </div>
    </div>

    <%--广告描述--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告描述</label>
        <div class="layui-input-block">
            <textarea name="descInfo" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
</form>
</div>

<%--编辑新闻--%>
<div id="edit_newspaper" style="display: none">
    <br/><form id="edit_newspaper_form" action="" class="layui-form">
    <%--广告标题--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告标题</label>
        <div class="layui-input-block">
            <input type="hidden" name="id" id="id_edit" >
            <input type="text" id="title_edit" name="title" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>

    <%--广告主图--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告主图</label>
        <div class="layui-input-block">
            <input type="file" id="imgUrl_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>">
            <input type="hidden" id="imgUrl_edit_" name="imgUrl" />
            <input type="button"  class="layui-btn layui-btn-radius layui-btn-small" value="上传" onclick="uploadPicEdit()">
        </div>
    </div>

    <%--广告内容链接--%>
    <%--<div class="layui-form-item">
        <label class="layui-form-label">内容链接</label>
        <div class="layui-input-block">
            <input type="text" id="contentUrl_edit" name="contentUrl" required lay-verify="required" class="layui-input" style="width: 260px">
        </div>
    </div>--%>

    <%--广告类型--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告类型</label>
        <div class="layui-input-block" style="width: 260px">
            <select name="type" id="type_edit" lay-verify="">
                <option value=""></option>
                <option value="0">客户端首页广告</option>
                <option value="1">开单医生端广告</option>
                <option value="2">护士</option>
                <option value="3">解读医生端广告</option>
            </select>
        </div>
    </div>

    <%--广告状态--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告状态</label>
        <div class="layui-input-block" style="width: 260px">
            <select name="status" id="status_edit" lay-verify="">
                <option value=""></option>
                <option value="0">暂存草稿</option>
                <option value="1">已发布</option>
                <option value="2">取消发布</option>
            </select>
        </div>
    </div>

    <%--广告描述--%>
    <div class="layui-form-item">
        <label class="layui-form-label">广告描述</label>
        <div class="layui-input-block">
            <textarea name="descInfo" id="descInfo_edit" required lay-verify="required" class="layui-textarea" style="width: 320px"></textarea>
        </div>
    </div>
</form>
</div>

<%--显示详情--%>
<div id="detail_newspaper" style="display: none">
    <table id="detail_newspaper_table" class="layui-table" lay-even lay-skin="nob" style='word-break:break-all'>
        <colgroup align="left" span="3">
            <col width="20%">
            <col width="35%">
            <col width="45%">
            <%--<col width="27%">
            <col width="23%">--%>
        </colgroup>
        <tbody>
        <tr>
            <td align="left">广告标题</td>
            <td align="left"></td>
            <td rowspan="5"><img id="newspaper_picture" alt="照片" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>"
                                 style="width: 260px;height: 180px"></td>
        </tr>
        <tr>
            <td align="left">广告类型</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">广告状态</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">创建人</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">创建时间</td>
            <td align="left"></td>
        </tr>
        <tr>
            <td align="left">内容链接</td>
            <td colspan="2"></td>
        </tr>
        <tr>
            <td valign="top" align="left" style="height: 240px">广告描述</td>
            <td colspan="2" valign="top" style="height: 240px"></td>
        </tr>
        </tbody>
    </table>
</div>

<%--编辑广告内容--%>
<div id="newspaper_edit_content" style="display: none;z-index: 99">
    <form id="newspaper_page" action="<%--${pageContext.request.contextPath}/newspaper/content.do--%>" class="layui-form" method="post">
        <div class="layui-form-item">
            <div class="layui-input-inline">
                <textarea id="editor_id" name="content" style="width:700px;height:300px;">
                </textarea>
            </div>
        </div>
    </form>
</div>
</body>
</html>
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
  <script src="${pageContext.request.contextPath}/js/user/user.js"></script>
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
          <input id="strMenuId" type="hidden" value="6" />
          <input id="strSubMenuId" type="hidden" value="61" />
          <div>
              <br/><form action="${pageContext.request.contextPath}/user/query.do" method="post">
              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">用户名:</label>&nbsp;&nbsp;&nbsp;
              <input name="userName" type="text" class="input_text_style" value="${userName_}" />

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">姓名:</label>&nbsp;&nbsp;&nbsp;
              <input name="name" type="text" class="input_text_style" value="${name}" />

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">状态:</label>&nbsp;&nbsp;&nbsp;
              <select id="query_status" name="status" lay-verify="" class="select_style" >
                  <option value=""></option>
                  <option value="0" <c:if test="${status == '0'}">selected</c:if>>初始化</option>
                  <option value="1" <c:if test="${status == 1}">selected</c:if>>可用</option>
                  <option value="2" <c:if test="${status == 2}">selected</c:if>>待审核</option>
                  <option value="3" <c:if test="${status == 3}">selected</c:if>>停用</option>
              </select>

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">创建日期:</label>&nbsp;&nbsp;&nbsp;
              <div class="layui-inline">
                  <input class="input_text_style" name="createTimeStart" placeholder="开始日期" id="createtime_range_start" value="${createTimeStart}">
              </div>&nbsp;——&nbsp;
              <div class="layui-inline">
                  <input class="input_text_style" name="createTimeEnd" placeholder="结束日期" id="createtime_range_end" value="${createTimeEnd}">
              </div>

              <br/><br/>&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
              <input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询"/>
              &nbsp;&nbsp;&nbsp;
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addUser()">新增</button>
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
          <table class="sui-table table-bordered" style="margin-top:20px;">
              <thead>
                <tr>
                    <th class="center left-con" width="8%">编号</th>
                    <th class="center left-con" width="12%">用户名</th>
                    <th class="center left-con" width="10%">姓名</th>
                    <th class="center left-con" width="20%">身份证号</th>
                    <th class="center left-con" width="8%">性别</th>
                    <th class="center left-con" width="12%">状态</th>
                    <th class="center left-con" width="16%">创建日期</th>
                    <th class="center left-con" width="16%">操作</th>
                </tr>
              </thead>
              <tbody id="all_task0">
                <c:if test="${fn:length(list) == 0}">
                    <tr ><td colspan="6" class="center left-con" >暂无医生</td></tr>
                </c:if>
                <c:forEach items="${list}" var="item">
                    <tr>
                        <td class="center left-con">${item.id}</td>
                        <td class="center left-con">${item.userName}</td>
                        <td class="center left-con">${item.name}</td>
                        <td class="center left-con">${item.sfzNum}</td>
                        <td class="center left-con">${item.sex}</td>
                        <td class="center left-con">
                            <c:if test="${item.status == '1'}">可用</c:if>
                            <c:if test="${item.status == '2'}">不可用</c:if>
                        </td>
                        <td class="center left-con"><fmt:formatDate value="${item.createTime}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate></td>
                        <td class="center left-con">
                            <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}')">删除</a></span>&nbsp;&nbsp;
                            <span class=""><a href="javascript:void(0)" onclick="ItemEdit('${item.id}')">编辑</a></span>&nbsp;&nbsp;
                            <span class=""><a href="javascript:void(0)" onclick="ItemDetail('${item.id}')">详情</a></span>
                        </td>
                    </tr>
                </c:forEach>
              </tbody>
          </table>
          <%--<br/><br/>
          <c:choose>
              <c:when test="${query_flag == true}">
                  <div align="center" style="font-size: small;position: fixed;left: 400px;top: 600px;right: 200px">
                      第${pageNo}页&nbsp;&nbsp;
                      <c:choose>
                          <c:when test="${pageNo > 1}">
                            <a href="${pageContext.request.contextPath}/user/query.do?pageNo=${pageNo - 1}&userName=${userName_}&name=${name}&status=${status}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">
                            上一页</a>&nbsp;&nbsp;
                          </c:when>
                            <c:otherwise>
                             <a href="#">上一页</a>&nbsp;&nbsp;
                            </c:otherwise>
                      </c:choose>
                      <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/user/query.do?pageNo=${pageNo + 1}&userName=${userName_}&name=${name}&status=${status}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">
                            下一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">下一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                      </c:choose>
                      共${totalPage}页&nbsp;&nbsp;
                  </div>
              </c:when>
              <c:otherwise>
                  <div align="center" style="font-size: small;position: fixed;left: 400px;top: 600px;right: 200px">
                      第${pageNo}页&nbsp;&nbsp;
                      <c:choose>
                        <c:when  test="${pageNo > 1}">
                            <a href="${pageContext.request.contextPath}/user/list.do?pageNo=${pageNo - 1}">上一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">上一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                      </c:choose>
                      <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/user/list.do?pageNo=${pageNo + 1}">下一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">下一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                      </c:choose>
                      共${totalPage}页&nbsp;&nbsp;
                  </div>
              </c:otherwise>
          </c:choose>--%>
          <input type="hidden" id="pageNo" value="${pageNo}">
          <input type="hidden" id="totalPage" value="${totalPage}">
          <input type="hidden" id="query_flag" value="${query_flag}">
          <input type="hidden" id="userName_" value="${userName_}">
          <input type="hidden" id="name" value="${name}">
          <input type="hidden" id="status" value="${status}">
          <input type="hidden" id="createTimeStart" value="${createTimeStart}">
          <input type="hidden" id="createTimeEnd" value="${createTimeEnd}">
          <div id="page" align="center" class="pagestyle"></div>
      </div>
  </div>

  <%--编辑用户信息--%>
  <div id="edit_user" style="display: none">
      <br/><form id="edit_user_form" class="layui-form" action="">
      <div class="layui-form-item">
          <label class="layui-form-label">用户名</label>
          <div class="layui-input-block">
              <input type="hidden" id="edit_id" name="id">
              <input type="text" id="edit_userName" name="userName" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">密码</label>
          <div class="layui-input-inline">
              <input type="text" id="edit_passWord" name="passWord" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">姓名</label>
          <div class="layui-input-block">
              <input type="text" id="edit_name" name="name" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">身份证号</label>
          <div class="layui-input-block">
              <input type="text" id="edit_sfzNum" name="sfzNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">生日</label>
          <div class="layui-input-block">
              <input type="text" id="edit_birthday" name="birthStr" class="layui-input" style="width: 260px" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})"/>
          </div>
      </div>


      <div class="layui-form-item">
          <label class="layui-form-label">性别</label>
          <div class="layui-input-block" style="width: 260px">
              <input type="radio" name="sex" value="男" title="男">
              <input type="radio" name="sex" value="女" title="女">
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">地址</label>
          <div class="layui-input-block">
              <input type="text" id="edit_address" name="address" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">状态</label>
          <div class="layui-input-block" style="width: 260px">
              <select id="edit_status" name="status" lay-verify="">
                  <option value=""></option>
                  <option value="1">可用</option>
                  <option value="2">不可用</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">头像</label>
          <div class="layui-input-block">
              <input type="file" id="touimg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="touimg_edit_" name="touImg" />
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadTouImgEdit()">上传</button>
          </div>
      </div>
      </form>
  </div>

  <%--显示医生的详细信息--%>
  <div id="detail_info" style="display: none">
      <table id="user_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="4">
            <col width="20%">
            <col width="45%">
            <col width="35%">
        </colgroup>
        <tbody>
            <tr>
                <td align="left">用户名</td>
                <td align="left"></td>
                <td rowspan="4"><img id="user_touImg" alt="照片" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>" style="width: 136px;height: 148px"></td>
            </tr>
            <tr>
                <td align="left">姓名</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">性别</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">状态</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">身份证号</td>
                <td id="sfzNumber" colspan="2"></td>
            </tr>
            <tr>
                <td align="left">生日</td>
                <td id="modifyTime" colspan="2"></td>
            </tr>
            <tr>
                <td align="left">创建日期</td>
                <td id="birthday" colspan="2"></td>
            </tr>
            <tr>
                <td align="left">修改日期</td>
                <td id="createTime" colspan="2"></td>
            </tr>
            <tr>
                <td valign="top" align="left">地址</td>
                <td id="address" valign="top" colspan="2" style="height: 50px"></td>
            </tr>
            </tbody>
      </table>
  </div>

  <%--新增用户--%>
  <div id="add_user" style="display: none;">
    <br/><form id="add_user_form" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="userName" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
        </div>

       <div class="layui-form-item">
            <label class="layui-form-label">密码</label>
            <div class="layui-input-inline">
                <input type="text" name="passWord" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

       <div class="layui-form-item">
            <label class="layui-form-label">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="name" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

       <div class="layui-form-item">
            <label class="layui-form-label">身份证号</label>
            <div class="layui-input-block">
                <input type="text" name="sfzNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

      <div class="layui-form-item">
          <label class="layui-form-label">生日</label>
          <div class="layui-input-block">
              <input type="text" name="birthStr" class="layui-input" style="width: 260px" onclick="layui.laydate({elem: this, istime: true, format: 'YYYY-MM-DD'})"/>
          </div>
      </div>


      <div class="layui-form-item">
            <label class="layui-form-label">性别</label>
            <div class="layui-input-block" style="width: 260px">
                <input type="radio" name="sex" value="男" title="男">
                <input type="radio" name="sex" value="女" title="女">
            </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">地址</label>
          <div class="layui-input-block">
              <input type="text" name="address" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">状态</label>
          <div class="layui-input-block" style="width: 260px">
              <select name="status" lay-verify="">
                  <option value=""></option>
                  <option value="0">初始化</option>
                  <option value="1">可用</option>
                  <option value="2">待审核</option>
                  <option value="3">停用</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label">头像</label>
          <div class="layui-input-block">
              <input type="file" id="touimg_id" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="touimg_id_" name="touImg" />
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadTouImg()">上传</button>
          </div>
      </div>
    </form>
  </div>
</body>
</html>

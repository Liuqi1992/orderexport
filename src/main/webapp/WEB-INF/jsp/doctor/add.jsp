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
  <script src="${pageContext.request.contextPath}/js/doctor/doctor.js"></script>
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
      <div class="pagemain">
          <%--<input id="strMenuId" type="hidden" value="3" />
          <input id="strSubMenuId" type="hidden" value="31" />--%>
      </div>
  </div>

  <div id="infoEdit" style="display: none">
      <br/><form id="doctorInfo" class="layui-form" method="post" action="">
      <%--用户名--%>
      <div class="layui-form-item">
          <label class="layui-form-label">用户名</label>
          <div class="layui-input-block">
              <input type="hidden" id="id" name="id">
              <input type="hidden" id="password" name="passWord">
              <input type="hidden" id="hospitalId" name="hospitalId">
              <input type="hidden" id="sfzNum" name="sfzNum">
              <input type="hidden" id="touImg" name="touImg">
              <input type="hidden" id="zzImg" name="zzImg">
              <input type="hidden" id="status" name="status">
              <input type="hidden" id="auditReason" name="auditReason">
              <input type="hidden" id="verificationCode" name="verificationCode">
              <input type="hidden" id="isOpenAutoreceipt" name="isOpenAutoreceipt">
              <input type="hidden" id="receiptInterval" name="receiptInterval">
              <input type="hidden" id="codeSendTime" name="codeSendTime">
              <input type="hidden" id="createTime" name="createTime">
              <input type="text"  id="userName" name="userName"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
              </div>
          </div>
      <%--医院名称--%>
      <div class="layui-form-item">
          <label class="layui-form-label">医院名称</label>
          <div class="layui-input-block">
              <input type="text" id="hospitalName" name="hospitalName"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
          </div>
      </div>
      <%--医生姓名--%>
      <div class="layui-form-item">
          <label class="layui-form-label">医生姓名</label>
          <div class="layui-input-block">
              <input type="text" id="doctorName" name="doctorName"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
          </div>
      </div>
      <%--性别--%>
      <div class="layui-form-item">
          <label class="layui-form-label">性别</label>
          <div class="layui-input-block">
              <input type="radio" name="sex" value="男" title="男">
              <input type="radio" name="sex" value="女" title="女">
          </div>
      </div>
      <%--年龄--%>
      <div class="layui-form-item">
          <label class="layui-form-label">年龄</label>
          <div class="layui-input-block">
              <input type="text" id="age" name="age"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
          </div>
      </div>
      <%--职称--%>
      <div class="layui-form-item">
          <label class="layui-form-label">职称</label>
          <div class="layui-input-block">
              <input type="text" id="title" name="title"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
          </div>
      </div>
      <%--解读报告次数--%>
      <div class="layui-form-item">
          <label class="layui-form-label">解读报告次数</label>
          <div class="layui-input-block">
              <input type="text" id="readReportNum" name="readReportNum"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
          </div>
      </div>
      <%--诊断次数--%>
      <div class="layui-form-item">
          <label class="layui-form-label">诊断次数</label>
          <div class="layui-input-block">
              <input type="text" id="diagnosisNum" name="diagnosisNum"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 220px">
              </div>
          </div>
      <%--医生类型--%>
      <div class="layui-form-item">
          <label class="layui-form-label">医生类型</label>
          <div class="layui-input-block">
              <select id="doctor_type" name="type" lay-verify="required">
                  <option value=""></option>
                  <option value="1">医生</option>
                  <option value="2">护士</option>
              </select>
          </div>
      </div>
      <%--医生介绍--%>
      <div class="layui-form-item">
          <label class="layui-form-label">医生介绍</label>
          <div class="layui-input-block">
              <textarea id="introduce" name="introduce" class="layui-textarea"  style="width: 320px"></textarea>
          </div>
      </div>
      </form>
  </div>
</body>
</html>

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
          <input id="strMenuId" type="hidden" value="5" />
          <input id="strSubMenuId" type="hidden" value="511" />
          <div>
              <br/><form action="${pageContext.request.contextPath}/doctor/query.do" method="post">
              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">用户名:</label>&nbsp;&nbsp;&nbsp;
              <input id="query_userName" name="userName" type="text" class="input_text_style" value="${userName_}" />

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">采集点:</label>&nbsp;&nbsp;&nbsp;
              <select id="query_hospital_id" name="hospitalId" lay-verify="" class="select_style" />
              <option value=""></option>
              </select>

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">姓名:</label>&nbsp;&nbsp;&nbsp;
              <input id="query_doctor_name" name="doctorName" type="text" class="input_text_style" value="${doctorName}" />

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">职称:</label>&nbsp;&nbsp;&nbsp;
              <select id="query_title" name="title" lay-verify="" class="select_style" />
              <option value=""></option>
              <option value="住院医师（初级）" <c:if test="${title == '住院医师（初级）'}">selected</c:if>>住院医师（初级）</option>
              <option value="主治医师（中级）" <c:if test="${title == '主治医师（中级）'}">selected</c:if>>主治医师（中级）</option>
              <option value="副主任医师（副高）" <c:if test="${title == '副主任医师（副高）'}">selected</c:if>>副主任医师（副高）</option>
              <option value="主任医师（正高）" <c:if test="${title == '主任医师（正高）'}">selected</c:if>>主任医师（正高）</option>
              </select>

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">状态:</label>&nbsp;&nbsp;&nbsp;
              <select id="query_status" name="status" lay-verify="" class="select_style" >
                  <option value=""></option>
                  <option value="0" <c:if test="${status == '0'}">selected</c:if>>初始化</option>
                  <option value="1" <c:if test="${status == 1}">selected</c:if>>可用</option>
                  <option value="2" <c:if test="${status == 2}">selected</c:if>>待审核</option>
                  <option value="3" <c:if test="${status == 3}">selected</c:if>>停用</option>
              </select>

              <br/><br/>&nbsp;&nbsp;&nbsp;
              <label class="label_Style">岗位:</label>&nbsp;&nbsp;&nbsp;
              <select id="query_type" name="type" lay-verify="" class="select_style" >
                  <option value=""></option>
                  <option value="1" <c:if test="${type == 1}">selected</c:if>>开单医生</option>
                  <option value="2" <c:if test="${type == 2}">selected</c:if>>护士</option>
                  <option value="2" <c:if test="${type == 3}">selected</c:if>>解读医生</option>
              </select>

              &nbsp;&nbsp;&nbsp;
              <label class="label_Style">创建时间:</label>&nbsp;&nbsp;&nbsp;
              <div class="layui-inline">
                  <input class="input_text_style" name="createTimeStart" placeholder="开始日期" id="createtime_range_start" value="${createTimeStart}">
              </div>&nbsp;——&nbsp;
              <div class="layui-inline">
                  <input class="input_text_style" name="createTimeEnd" placeholder="结束日期" id="createtime_range_end" value="${createTimeEnd}">
              </div>

              &nbsp;&nbsp;&nbsp;
              <input type="submit" class="layui-btn layui-btn-radius layui-btn-small" value="查询"/>
              &nbsp;&nbsp;&nbsp;
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="addDoctor()">新增</button>
              &nbsp;
              <div class="layui-input-inline">
                  <input type="file" class="input_text_style" style="width: 100px" id="selectedExcelFile" name="excelFile">
              </div>
              &nbsp;&nbsp;&nbsp;
              <button type="button" class="layui-btn layui-btn-small" onclick="importExcel()">Excel导入</button>
              &nbsp;
              <button type="button" class="layui-btn layui-btn-small" onclick="exportExcel()">导出Excel</button>
            </form>
          </div>
          <table class="sui-table table-bordered" style="margin-top:20px;">
              <thead>
                <tr>
                    <th class="center left-con" width="8%">编号</th>
                    <th class="center left-con" width="14%">用户名</th>
                    <th class="center left-con" width="14%">采集点</th>
                    <th class="center left-con" width="10%">姓名</th>
                    <%--<th class="center left-con" width="10%">职称</th>--%>
                    <th class="center left-con" width="10%">解读次数</th>
                    <th class="center left-con" width="10%">服务次数</th>
                    <th class="center left-con" width="8%">状态</th>
                    <th class="center left-con" width="8%">岗位</th>
                    <th class="center left-con" width="18%">操作</th>
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
                        <td class="center left-con">${item.hospitalName}</td>
                        <td class="center left-con">${item.doctorName}</td>
                        <%--<td class="center left-con">${item.title}</td>--%>
                        <td class="center left-con">${item.readReportNum}</td>
                        <td class="center left-con">${item.diagnosisNum}</td>
                        <td class="center left-con">
                            <c:if test="${item.status == 0}">初始化</c:if>
                            <c:if test="${item.status == 1}">可用</c:if>
                            <c:if test="${item.status == 2}">待审核</c:if>
                            <c:if test="${item.status == 3}">停用</c:if>
                        </td>
                        <td class="center left-con">
                            <c:if test="${item.type == '1'}">开单医生</c:if>
                            <c:if test="${item.type == '2'}">护士</c:if>
                            <c:if test="${item.type == '3'}">解读医生</c:if>
                        </td>
                        <td class="center left-con">
                            <span class=""><a href="javascript:void(0)" onclick="ItemDele('${item.id}')">删除</a></span>&nbsp;&nbsp;
                            <c:if test="${item.status == 2 and item.type == '3'}"><span class=""><a href="javascript:void(0)"
                                onclick="ItemAudite('${item.id}')">解读审核</a></span>&nbsp;&nbsp;</c:if>
                            <c:if test="${item.status == 2 and item.type == '2'}"><span class=""><a href="javascript:void(0)"
                                onclick="ItemAudite('${item.id}')">护士审核</a></span>&nbsp;&nbsp;</c:if>
                            <c:if test="${item.isAudit == 1}"><span class=""><a href="javascript:void(0)"
                                onclick="ItemBillAudite('${item.id}')">开单审核</a></span>&nbsp;&nbsp;</c:if>
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
                            <a href="${pageContext.request.contextPath}/doctor/query.do?pageNo=${pageNo - 1}&userName=${userName_}&hospitalId=${hospital_id}&doctorName=${doctorName}&title=${title}&status=${status}&type=${type}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">
                            上一页</a>&nbsp;&nbsp;
                          </c:when>
                            <c:otherwise>
                             <a href="#">上一页</a>&nbsp;&nbsp;
                            </c:otherwise>
                      </c:choose>
                      <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/doctor/query.do?pageNo=${pageNo + 1}&userName=${userName_}&hospitalId=${hospital_id}&doctorName=${doctorName}&title=${title}&status=${status}&type=${type}&createTimeStart=${createTimeStart}&createTimeEnd=${createTimeEnd}">
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
                            <a href="${pageContext.request.contextPath}/doctor/list.do?pageNo=${pageNo - 1}&type=${type}">上一页</a>&nbsp;&nbsp;
                        </c:when>
                        <c:otherwise>
                            <a href="#">上一页</a>&nbsp;&nbsp;
                        </c:otherwise>
                      </c:choose>
                      <c:choose>
                        <c:when test="${pageNo < totalPage}">
                            <a href="${pageContext.request.contextPath}/doctor/list.do?pageNo=${pageNo + 1}&type=${type}">下一页</a>&nbsp;&nbsp;
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
          <input type="hidden" id="type" value="${type}">
          <input type="hidden" id="userName_" value="${userName_}">
          <input type="hidden" id="hospitalId" value="${hospital_id}">
          <input type="hidden" id="doctorName_" value="${doctorName}">
          <input type="hidden" id="title_" value="${title}">
          <input type="hidden" id="status" value="${status}">
          <input type="hidden" id="createTimeStart" value="${createTimeStart}">
          <input type="hidden" id="createTimeEnd" value="${createTimeEnd}">
          <div id="page" align="center" class="pagestyle"></div>
      </div>
  </div>

  <%--编辑医生信息--%>
  <div id="infoEdit" style="display: none">
      <br/><form id="doctorInfo" class="layui-form" method="post" action="">
      <%--用户名--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">用户名</label>
          <div class="layui-input-block">
              <input type="hidden" id="id" name="id">
              <input type="text"  id="userName" name="userName"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 260px">
          </div>
      </div>
      <%--医院名称--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">采集点</label>
          <div class="layui-input-inline" style="width: 260px">
              <input type="hidden" id="hospitalName" name="hospitalName"/>
              <select id="hospital_Id" name="hospitalId" lay-verify="">
                  <option value=""></option>
              </select>
          </div>
      </div>
       <%--科室--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">科室</label>
          <div class="layui-input-inline" style="width: 260px">
              <input type="hidden" id="departmentName_edit" name="departmentName"/>
              <select id="department_num_edit" name="departmentNum" lay-verify="">
                  <option value=""></option>
              </select>
          </div>
      </div>
      <%--医生姓名--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">医生姓名</label>
          <div class="layui-input-block">
              <input type="text" id="doctorName" name="doctorName"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 260px">
          </div>
      </div>
      <%--性别--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">性别</label>
          <div class="layui-input-block">
              <input type="radio" name="sex" value="男" title="男">
              <input type="radio" name="sex" value="女" title="女">
          </div>
      </div>
      <%--年龄--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">年龄</label>
          <div class="layui-input-block">
              <input type="text" id="age" name="age"  required lay-verify="required" autocomplete="off"
              class="layui-input" style="width: 260px">
          </div>
      </div>
      <%--身份证号--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">身份证号</label>
          <div class="layui-input-block">
              <input type="text" id="sfzNum_edit" name="sfzNum"  required lay-verify="required" autocomplete="off"
                     class="layui-input" style="width: 260px">
          </div>
      </div>
      <%--职称--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称</label>
          <div class="layui-input-inline" style="width: 260px">
              <select id="title" name="title" lay-verify="">
                  <option value=""></option>
                  <option value="住院医师（初级）">住院医师（初级）</option>
                  <option value="主治医师（中级）">主治医师（中级）</option>
                  <option value="副主任医师（副高）">副主任医师（副高）</option>
                  <option value="主任医师（正高）">主任医师（正高）</option>
              </select>
          </div>
      </div>
      <%--医生头像--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">头像</label>
          <div class="layui-input-block">
              <input type="file" id="touimg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="touimg_edit_" name="touImg" />
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadTouImgEdit()">上传</button>
          </div>
      </div>
        <%--从业执照号--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">执业证书编号</label>
          <div class="layui-input-block">
              <input type="text" id="zzNum_edit" name="zzNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>
      <%--从业执照图片--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">执业证书图片</label>
          <div class="layui-input-block">
              <input type="file" id="zzImg_edit" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="zzImg_edit_" name="zzImg"/>
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadZZImgEdit()">上传</button>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称证书编号</label>
          <div class="layui-input-block">
              <input type="text" id="zcNum_edit" name="zcNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称证书图片</label>
          <div class="layui-input-block">
              <input type="file" id="zcImg_edit_id" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="zcImg_edit_id_" name="zcImg"/>
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadZCImgEdit()">上传</button>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">学历</label>
          <div class="layui-input-inline" style="width: 260px">
              <select id="education_edit" name="education" lay-verify="">
                  <option value=""></option>
                  <option value="中专">中专</option>
                  <option value="大专">大专</option>
                  <option value="本科">本科</option>
                  <option value="硕士研究生">硕士研究生</option>
                  <option value="博士研究生">博士研究生</option>
                  <option value="院士">院士</option>
              </select>
          </div>
      </div>
      <%--解读报告次数--%>
      <div class="layui-form-item">
          <div class="layui-inline">
              <label class="layui-form-label" style="width: 100px">解读次数</label>
              <div class="layui-input-inline">
                  <input type="text" id="readReportNum" name="readReportNum"  required lay-verify="required" autocomplete="off"
                  class="layui-input" style="width: 260px">
              </div>
          </div>
          <div class="layui-inline">
              <span>&nbsp;&nbsp;次</span>
          </div>
      </div>
      <%--诊断次数--%>
      <div class="layui-form-item">
          <div class="layui-inline">
              <label class="layui-form-label" style="width: 100px">诊断次数</label>
              <div class="layui-input-inline">
                  <input type="text" id="diagnosisNum" name="diagnosisNum"  required lay-verify="required" autocomplete="off"
                  class="layui-input" style="width: 260px">
              </div>
          </div>
          <div class="layui-inline">
              <span>&nbsp;&nbsp;次</span>
          </div>
      </div>
      <%--医生类型--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">岗位</label>
          <div class="layui-input-inline" style="width: 260px">
              <select id="doctor_type" name="type" lay-verify="required">
                  <option value=""></option>
                  <option value="1">开单医生</option>
                  <option value="2">护士</option>
                  <option value="3">解读医生</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职位</label>
          <div class="layui-input-block">
              <input type="text" id="position_edit" name="position" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>
      <%--医生介绍--%>
      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">医生介绍</label>
          <div class="layui-input-block">
              <textarea id="introduce" name="introduce" class="layui-textarea"  style="width: 320px"></textarea>
          </div>
      </div>
      </form>
  </div>

  <%--审核医生--%>
  <div id="doctorAudite" style="display: none">
      <br/><form id="Audite" class="layui-form" method="post" action="">
        <div class="layui-form-item">
            <label class="layui-form-label">审核</label>
            <div class="layui-input-block" style="width: 260px">
                <select id="doctorStatus" name="status" lay-verify="" >
                    <option value=""></option>
                    <option value="1">通过</option>
                    <option value="3">不通过</option>
                </select>
            </div>
            <%--原因--%>
            <br/><div class="layui-form-item">
                <label class="layui-form-label">原因</label>
                <div class="layui-input-block">
                    <input type="hidden" id="id2" name="id">
                    <textarea id="auditReason2" name="auditReason" class="layui-textarea"  style="width: 300px;height: 120px"></textarea>
                </div>
            </div>
        </div>
      </form>
  </div>
  <%--审核解读医生--%>
  <div id="doctorBillAudite" style="display: none">
      <br/><form id="BillAudite" class="layui-form" method="post" action="">
      <div class="layui-form-item">
          <label class="layui-form-label">审核</label>
          <div class="layui-input-block" style="width: 260px">
              <select id="isPass" name="isPass" lay-verify="" >
                  <option value=""></option>
                  <option value="1">通过</option>
                  <option value="0">不通过</option>
              </select>
          </div>
          <%--原因--%>
          <br/><div class="layui-form-item">
          <label class="layui-form-label">原因</label>
          <div class="layui-input-block">
              <input type="hidden" id="id3" name="id">
              <textarea id="billAuditReason" name="billAuditReason" class="layui-textarea"  style="width: 300px;height: 120px"></textarea>
          </div>
      </div>
      </div>
  </form>
  </div>

  <%--显示医生的详细信息--%>
  <div id="detail_info" style="display: none">
      <table id="doctor_table" class="layui-table" lay-even lay-skin="nob">
        <colgroup align="left" span="4">
            <col width="15%">
            <col width="25%">
            <col width="10%">
            <col width="15%">
            <col width="35%">
        </colgroup>
        <tbody>
            <tr>
                <td align="left">姓名</td>
                <td align="left"></td>
                <td align="left">性别</td>
                <td align="left"></td>
                <td rowspan="5"><img id="doctor_picture" alt="头像" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>" style="width: 168px;height: 184px"></td>
            </tr>
            <tr>
                <td align="left">医院名称</td>
                <td align="left"></td>
                <td align="left">年龄</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">职称</td>
                <td align="left"></td>
                <td align="left">岗位</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">学历</td>
                <td align="left"></td>
                <td align="left">科室</td>
                <td align="left"></td>
            </tr>
            <tr>
                <td align="left">身份证号</td>
                <td id="sfzNumber" colspan="3"></td>
            </tr>
            <tr>
                <td align="left">执业证书编号</td>
                <td colspan="2"></td>
                <td align="left">职称证书编号</td>
                <td></td>
            </tr>
            <tr>
                <td align="left">创建时间</td>
                <td colspan="2"></td>
                <td align="left">修改时间</td>
                <td></td>
            </tr>
            <tr>
                <td>执业证书</td>
                <td colspan="2" style="height: 200px"><img id="doctor_zzImg" alt="执业证书" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>" style="width: 168px;height: 184px"></td>
                <td>职称证书</td>
                <td style="height: 200px"><img id="doctor_zcImg" alt="职称证书" title="<%@include file="../../ImgUrl/acquireUrl.jsp"%>" style="width: 168px;height: 184px"></td>
            </tr>
            <tr>
                <td valign="top" align="center" style="height: 80px">医生简介</td>
                <td id="doctorIntroduce" colspan="4" style="height: 80px" valign="top"></td>
            </tr>
        </tbody>
      </table>
  </div>

  <%--新增医生--%>
  <div id="add_doctor" style="display: none;">
    <br/><form id="add_doctor_form" class="layui-form" action="">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">用户名</label>
            <div class="layui-input-block">
                <input type="text" name="userName" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
        </div>

       <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">密码</label>
            <div class="layui-input-inline">
                <input type="password" name="passWord" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

       <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">采集点</label>
            <div class="layui-input-inline" style="width: 260px">
                <input type="hidden" id="hospital_name" name="hospitalName"/>
                <select id="hospital_name_select" name="hospitalId" lay-verify="">
                    <option value=""></option>
                </select>
            </div>
       </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">科室</label>
          <div class="layui-input-inline" style="width: 260px">
              <input type="hidden" id="departmentName_add" name="departmentName"/>
              <select id="department_num_add" name="departmentNum" lay-verify="">
                  <option value=""></option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">姓名</label>
            <div class="layui-input-block">
                <input type="text" name="doctorName" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

       <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">身份证号</label>
            <div class="layui-input-block">
                <input type="text" name="sfzNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
            </div>
       </div>

       <div class="layui-form-item">
            <label class="layui-form-label" style="width: 100px">性别</label>
            <div class="layui-input-block" style="width: 260px">
                <input type="radio" name="sex" value="男" title="男">
                <input type="radio" name="sex" value="女" title="女">
            </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">年龄</label>
          <div class="layui-input-block">
              <input type="text" name="age" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称</label>
          <div class="layui-input-inline" style="width: 260px">
              <select name="title" lay-verify="">
                  <option value=""></option>
                  <option value="住院医师（初级）">住院医师（初级）</option>
                  <option value="主治医师（中级）">主治医师（中级）</option>
                  <option value="副主任医师（副高）">副主任医师（副高）</option>
                  <option value="主任医师（正高）">主任医师（正高）</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">头像</label>
          <div class="layui-input-block">
              <input type="file" id="touimg_id" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="touimg_id_" name="touImg" />
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadTouImg()">上传</button>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">执业证书编号</label>
          <div class="layui-input-block">
              <input type="text" name="zzNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">执业证书图片</label>
          <div class="layui-input-block">
              <input type="file" id="zzImg_id" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="zzImg_id_" name="zzImg"/>
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadZZImg()">上传</button>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称证书编号</label>
          <div class="layui-input-block">
              <input type="text" name="zcNum" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职称证书图片</label>
          <div class="layui-input-block">
              <input type="file" id="zcImg_id" style="width: 210px" title="<%@include file="../../ImgUrl/uploadUrl.jsp"%>"/>
              <input type="hidden" id="zcImg_id_" name="zcImg"/>
              <button type="button" class="layui-btn layui-btn-radius layui-btn-small" onclick="uploadZCImg()">上传</button>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">学历</label>
          <div class="layui-input-inline" style="width: 260px">
              <select name="education" lay-verify="">
                  <option value=""></option>
                  <option value="中专">中专</option>
                  <option value="大专">大专</option>
                  <option value="本科">本科</option>
                  <option value="硕士研究生">硕士研究生</option>
                  <option value="博士研究生">博士研究生</option>
                  <option value="院士">院士</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">状态</label>
          <div class="layui-input-inline" style="width: 260px">
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
          <label class="layui-form-label" style="width: 100px">岗位</label>
          <div class="layui-input-inline" style="width: 260px">
              <select name="type" lay-verify="">
                  <option value=""></option>
                  <option value="1">开单医生</option>
                  <option value="2">护士</option>
                  <option value="3">解读医生</option>
              </select>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">职位</label>
          <div class="layui-input-block">
              <input type="text" name="position" required lay-verify="required" class="layui-input" style="width: 260px"/>
          </div>
      </div>

      <div class="layui-form-item">
          <label class="layui-form-label" style="width: 100px">介绍</label>
          <div class="layui-input-block">
              <textarea name="introduce" class="layui-textarea" style="width: 320px"></textarea>
          </div>
      </div>
    </form>
  </div>
</body>
</html>

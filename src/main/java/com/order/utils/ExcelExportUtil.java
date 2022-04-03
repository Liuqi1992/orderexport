//package com.order.utils;
//
//import jxl.Workbook;
//import jxl.format.Alignment;
//import jxl.write.*;
//
//import javax.servlet.http.HttpServletResponse;
//import java.io.OutputStream;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.List;
//
///**
// * Created by LiuQi on 2017/8/30.
// */
//public class ExcelExportUtil {
//
//    public static void orderRecoredExport(HttpServletResponse response, List<OrderModelWithBLOBs> orderList) {
//        //标题行
//        String title[] = {"我方条码号", "病人姓名", "病人唯一号", "门诊住院号", "性别", "年龄",
//                "年龄单位", "在院方式", "申请科室（采集机构）", "病床号", "临床诊断", "检验目的ID",
//                "检验目的名称", "标本类型", "开单医生", "开单时间", "采样人", "采样时间",
//                "客户号（采集点号）", "客户条码"};
//        StringBuilder tempPath = new StringBuilder();
//        SimpleDateFormat fileNameFormat = new SimpleDateFormat("yyyyMMddkkmmss_S");
//        tempPath.append(fileNameFormat.format(new Date()));
//        tempPath.append(".").append("xls");
//        String filename = tempPath.toString();
//        try {
//            response.setContentType("application/vnd.ms-excel;charset=utf-8");
////			response.setHeader("Content-Disposition", "attachment;filename=" + new String((filename).getBytes(), "iso-8859-1"));
//            response.setHeader("Content-Disposition", "attachment;filename="+ new String((filename).getBytes(), "utf-8"));
//            OutputStream os = response.getOutputStream();
//            WritableWorkbook book = Workbook.createWorkbook(os);
//            WritableSheet sheet = book.createSheet("订单信息", 0);
//            WritableFont font = new WritableFont(WritableFont.createFont("宋体"), 11);
//            WritableCellFormat format = new WritableCellFormat(font);
//            format.setAlignment(Alignment.RIGHT);
//            WritableCellFormat format1 = new WritableCellFormat(font);
//            format1.setAlignment(Alignment.LEFT);
//
//            //写入标题
//            for (int i=0; i<title.length; i++) {
//                sheet.addCell(new Label(i, 0, title[i], format1));
//            }
//            for (int i=0; i<orderList.size(); i++) {
//                //根据用户的身份证号计算年龄
//                Integer age = null;
//                if (orderList.get(i).getApplicantModel() != null && orderList.get(i).getApplicantModel().getSfzNum() != null) {
//                    String sfzN = orderList.get(i).getApplicantModel().getSfzNum();
//                    IdcardInfoExtractor idcardInfo=new IdcardInfoExtractor(sfzN);
//                    age = idcardInfo.getAge();
//                }
//                int j=0;
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getBarcode(), format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getApplicantModel() != null ? orderList.get(i).getApplicantModel().getApplyName() : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getApplicantModel() != null ? (orderList.get(i).getApplicantModel().getId() != null ? Long.toString(orderList.get(i).getApplicantModel().getId()) : "") : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeId() != null ? Long.toString(orderList.get(i).getTradeId()) : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getApplicantModel() != null ? orderList.get(i).getApplicantModel().getSex() : "", format));
////                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getApplicantModel() != null ? (orderList.get(i).getApplicantModel().getAge() != null ? Integer.toString(orderList.get(i).getApplicantModel().getAge()) : "") : "", format));
//                sheet.addCell(new Label(j++, i + 1, age != null ? (age != 0 ? age.toString() : "") : "", format));
//                sheet.addCell(new Label(j++, i + 1, "岁", format));
//                sheet.addCell(new Label(j++, i + 1, "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeModel()  != null ? orderList.get(i).getTradeModel().getYzDepartmentName() : "", format));
//                sheet.addCell(new Label(j++, i + 1, "", format));
//                sheet.addCell(new Label(j++, i + 1, "体检", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getPackageModel() != null ? orderList.get(i).getPackageModel().getHisId() : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getPackageModel() != null ? orderList.get(i).getPackageModel().getHisName() : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getPackageModel() != null ? orderList.get(i).getPackageModel().getSampleType(): "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeModel() != null ? orderList.get(i).getTradeModel().getYzDoctorName() : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeModel() != null ? StringUtil.getFormatDate(orderList.get(i).getTradeModel().getYzTime(), "yyyy/M/d H:m") : "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getDoctorModel() != null ? orderList.get(i).getDoctorModel().getDoctorName() : "", format));
//                sheet.addCell(new Label(j++, i + 1, StringUtil.getFormatDate(orderList.get(i).getTakeTime(), "yyyy/M/d H:m"), format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeModel() != null ? (orderList.get(i).getTradeModel().getHospitalId() != null ? Long.toString(orderList.get(i).getTradeModel().getHospitalId()) : ""): "", format));
//                sheet.addCell(new Label(j++, i + 1, orderList.get(i).getTradeModel() != null ? orderList.get(i).getTradeModel().getTradeNum() : "", format));
//            }
//            //写入数据
//            book.write();
//            //关闭文件
//            book.close();
//            os.flush();
//            os.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }
//}

//package com.order.utils.excel.impl;
//
//import com.order.utils.StringUtil;
//import com.order.utils.excel.ReadExcel;
//import org.apache.poi.hssf.usermodel.HSSFCell;
//import org.apache.poi.hssf.usermodel.HSSFWorkbook;
//import org.apache.poi.ss.usermodel.Cell;
//import org.apache.poi.ss.usermodel.Row;
//import org.apache.poi.ss.usermodel.Sheet;
//import org.apache.poi.ss.usermodel.Workbook;
//import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import org.springframework.web.multipart.MultipartFile;
//
//import java.io.IOException;
//import java.io.InputStream;
//import java.util.ArrayList;
//import java.util.List;
//
///**
// * Created by LiuQi on 2017/8/19.
// */
//public class ReadPackageDetailsExcel implements ReadExcel{
//
//    //总行数
//    private int totalRows;
//    //总列数
//    private int totalCells;
//    //错误信息接收器
//    private String errorMsg;
//
//    public int getTotalRows() {return totalRows;}
//
//    public int getTotalCells() {return totalCells;}
//
//    public String getErrorMsg() {return errorMsg;}
//
//    public List<PackageDetailsModel> getExcelInfo(MultipartFile excelFile) {
//        String filename = excelFile.getOriginalFilename();
//        List<PackageDetailsModel> packageDetailsList = null;
//        try {
//            if (!validateExcel(filename)) {
//                return null;
//            }
//            boolean isExcel2003 = true;// 根据文件名判断文件是2003版本还是2007版本
//            if (isExcel2007(filename)) {
//                isExcel2003 = false;
//            }
//
//            packageDetailsList = createExcel(excelFile.getInputStream(), isExcel2003);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return packageDetailsList;
//    }
//
//    private List<PackageDetailsModel> createExcel(InputStream inputStream, boolean isExcel2003) {
//        List<PackageDetailsModel> packageDetailsList = null;
//        Workbook wb = null;
//        try {
//            if (isExcel2003) {
//                wb = new HSSFWorkbook(inputStream);
//            }
//            else {
//                wb = new XSSFWorkbook(inputStream);
//            }
//            packageDetailsList = readExcelValue(wb);
//        } catch (Exception e) {
//            e.getStackTrace();
//        }
//        return packageDetailsList;
//    }
//
//    private List<PackageDetailsModel> readExcelValue(Workbook wb) {
//        //得到第一个shell
//        Sheet sheet = wb.getSheetAt(0);
//        //得到Excel的行数
//        this.totalRows = sheet.getPhysicalNumberOfRows();
//        //得到Excel的列数(前提是有行数)
//        if(totalRows > 1 && sheet.getRow(0) != null) {
//            this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
//        }
//        List<PackageDetailsModel> packageDetailsList = new ArrayList<PackageDetailsModel>();
//        for(int r = 1; r < totalRows; r++) {
//            Row row = sheet.getRow(r);
//            if (row == null) {
//                continue;
//            }
//            PackageDetailsModel packageDetailsModel = new PackageDetailsModel();
//            //循环Excel列
//            for (int c = 0; c < totalCells; c++) {
//                Cell cell = row.getCell(c);
//                if (null != cell) {
//                    if (c == 0) {
//                        String hisId = null;
//                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            hisId = String.valueOf(cell.getNumericCellValue());
//                            hisId = hisId.substring(0, hisId.length() - 2 > 0 ? hisId.length() - 2 : 1);
//                        } else {
//                            hisId = cell.getStringCellValue();
//                        }
//                        packageDetailsModel.setHisId(hisId);
//                    }
//                    if (c == 1) {
//                        String hisName = null;
//                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            hisName = String.valueOf(cell.getNumericCellValue());
//                            hisName = hisName.substring(0, hisName.length() - 2 > 0 ? hisName.length() - 2 : 1);
//                        } else {
//                            hisName = cell.getStringCellValue();
//                        }
//                        packageDetailsModel.setName(hisName);
//                    }
//                    if (c == 2) {
//                        Long hisPrice = null;
//                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            String hisPrice_str = String.valueOf(cell.getNumericCellValue());
//                            hisPrice_str = hisPrice_str.substring(0, hisPrice_str.length() - 2 > 0 ? hisPrice_str.length() - 2 : 1);
//                            hisPrice = StringUtil.priceProcess(hisPrice_str);
//                        } else {
//                            String hisPrice_str = cell.getStringCellValue();
//                            if (!hisPrice_str.isEmpty() && hisPrice_str != null) {
//                                hisPrice = StringUtil.priceProcess(hisPrice_str);
//                            }
//                        }
//                        packageDetailsModel.setHisPrice(hisPrice);
//                    }
//                    if (c == 3) {
//                        Long packageId  = null;
//                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            String packageId_str = String.valueOf(cell.getNumericCellValue());
//                            packageId_str = packageId_str.substring(0, packageId_str.length() - 2 > 0 ? packageId_str.length() - 2 : 1);
//                            packageId = Long.parseLong(packageId_str);
//                        } else {
//                            String packageId_str = cell.getStringCellValue();
//                            if (!packageId_str.isEmpty() && packageId_str != null) {
//                                packageId = Long.parseLong(packageId_str);
//                            }
//                        }
//                        packageDetailsModel.setPackageId(packageId);
//                    }
//                    if (c == 4) {
//                        String name = null;
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            name = String.valueOf(cell.getNumericCellValue());
//                            name = name.substring(0, name.length() - 2 > 0 ? name.length() - 2 : 1);
//                        } else {
//                            name = cell.getStringCellValue();
//                        }
//                        packageDetailsModel.setName(name);
//                    }
//                    if (c == 5) {
//                        Long price = null;
//                        //如果是纯数字,比如你写的是25,cell.getNumericCellValue()获得是25.0,通过截取字符串去掉.0获得25
//                        if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
//                            String price_str = String.valueOf(cell.getNumericCellValue());
//                            price_str = price_str.substring(0, price_str.length() - 2 > 0 ? price_str.length() - 2 : 1);
//                            price = StringUtil.priceProcess(price_str);
//                        } else {
//                            String price_str = cell.getStringCellValue();
//                            if (!price_str.isEmpty() && price_str == null ) {
//                                price = StringUtil.priceProcess(price_str);
//                            }
//                        }
//                        packageDetailsModel.setPrice(price);
//                    }
//                }
//            }
//            packageDetailsList.add(packageDetailsModel);
//        }
//        return packageDetailsList;
//    }
//
//    private boolean validateExcel(String filename) {
//        if (filename == null || !(isExcel2003(filename) || isExcel2007(filename))) {
//            errorMsg = "文件名不是excel格式";
//            return false;
//        }
//        return true;
//    }
//
//    public static boolean isExcel2003(String filePath)  {
//        return filePath.matches("^.+\\.(?i)(xls)$");
//    }
//
//    public static boolean isExcel2007(String filePath)  {
//        return filePath.matches("^.+\\.(?i)(xlsx)$");
//    }
//}

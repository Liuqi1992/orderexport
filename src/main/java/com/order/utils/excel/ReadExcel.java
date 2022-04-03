package com.order.utils.excel;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by LiuQi on 2017/8/19.
 */
public interface ReadExcel {

    List getExcelInfo(MultipartFile excelFile);
}

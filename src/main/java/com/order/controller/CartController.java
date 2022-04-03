package com.order.controller;

import com.order.model.CartModel;
import com.order.service.CartService;
import com.order.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by LiuQi on 2017/8/15.
 */
@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;

    private static final int PAGE_SIZE = 10;

    /**
     * 列出所有购物车数据
     * @param map
     * @param pageNo
     * @return
     */
    @RequestMapping("/list")
    public String cartList(ModelMap map, String pageNo) {
        Map<String, Object> mapInfo = new HashMap<String, Object>();
        mapInfo.put("pageNo", pageNo);
        Map<String, Object> result_map = getData(mapInfo);
        map.put("pageNo", result_map.get("pageNo"));
        map.put("totalPage", result_map.get("totalPage"));
        map.put("list", result_map.get("list"));
        return "cart/list";
    }

    /**
     * 通过参数查询
     * @param map
     * @param user_username
     * @param user_name
     * @param package_name
     * @param pageNo
     * @param createTimeStart
     * @param createTimeEnd
     * @return
     */
    @RequestMapping(value = "/query")
    public String queryCart(ModelMap map, String user_username, String user_name, String package_name,
                                      String pageNo, String createTimeStart, String createTimeEnd) {
        Map<String, Object> mapInfo = new HashMap<String, Object>();
        mapInfo.put("pageNo", pageNo);
        mapInfo.put("user_username", user_username.trim());
        mapInfo.put("user_name", user_name.trim());
        mapInfo.put("package_name", package_name.trim());
        Date create_time_start = StringUtil.getDate(createTimeStart, "yyyy-MM-dd");
        Date create_time_end = StringUtil.getDate(createTimeEnd, "yyyy-MM-dd");
        mapInfo.put("create_time_start", create_time_start);
        mapInfo.put("create_time_end", create_time_end);
        Map<String, Object> result_map =  getData(mapInfo);
        map.put("user_username", user_username.trim());
        map.put("user_name", user_name.trim());
        map.put("package_name", package_name.trim());
        map.put("createTimeStart", createTimeStart.trim());
        map.put("createTimeEnd", createTimeEnd.trim());
        map.put("pageNo", result_map.get("pageNo"));
        map.put("totalPage", result_map.get("totalPage"));
        map.put("list", result_map.get("list"));
        map.put("query_flag", true);
        return "cart/list";
    }

    /**
     * 通过ID查找购物车
     * @param id
     * @return*/
    @RequestMapping(value = "/acquire", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> selectById(String id) {
        //对接收到的字符串参数进行基本的处理与判断
        id = id.trim();
        Pattern p = Pattern.compile("^[0-9]+$");
        Matcher matcher = p.matcher(id);
        Map<String, Object> map = new HashMap<String, Object>();
        if (matcher.matches()) {
            map.put("cart", cartService.selectById(Long.parseLong(id)));
        } else {
            CartModel cartModel = new CartModel();
            cartModel.setPackageId(-100L);
            map.put("cart", cartModel);
        }
        return map;
    }

    /**
     * 更新购物车内容
     * @param cartModel
     * @return*/
    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> updateById(CartModel cartModel) {
        int result = cartService.updateById(cartModel);
        Map<String, String> map = new HashMap<String, String>();
        if (result > 0) {
            map.put("msg", "success");
        }else {
            map.put("msg", "error");
        }
        return map;
    }

    /**
     * 通过ID删除某条记录
     * @param id
     * @return*/
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> deleteById(String id) {
        //对接收到的字符串参数进行基本的处理与判断
        id = id.trim();
        Pattern p = Pattern.compile("^[0-9]+$");
        Matcher matcher = p.matcher(id);
        int result;
        Map<String, String> map = new HashMap<String, String>();
        if(matcher.matches()) {
            result = cartService.deleteById(Long.parseLong(id));
            if(result > 0) {
                //返回1表示删除成功
                map.put("msg", "1");
            } else {
                //返回2表示删除失败
                map.put("msg", "2");
            }
        } else {
            //返回3表示参数有误
            map.put("msg", "3");
        }
        return map;
    }

    private Map<String, Object> getData(Map<String, Object> mapInfo) {
        int page_no;
        boolean isEmpty = false;
        Map<String, Object> map = new HashMap<String, Object>();
        if (mapInfo.get("pageNo") == null || mapInfo.get("pageNo") == "") {
            page_no = 1;
        }
        else {
            page_no = Integer.parseInt(((String)mapInfo.get("pageNo")).trim());
            if (page_no < 1) {
                page_no = 1;
            }
        }
        List<CartModel> cart_list = cartService.selectList(mapInfo);
        int total_page = (cart_list.size() + PAGE_SIZE - 1) / PAGE_SIZE;
        if (total_page < 1) {
            total_page = 1;
            isEmpty = true;
        }
        if(page_no > total_page) {
            page_no = total_page;
        }
        map.put("pageNo", page_no);
        map.put("totalPage", total_page);
        if(!isEmpty) {
            mapInfo.put("start_num", (page_no - 1) * PAGE_SIZE);
            mapInfo.put("pageSize", PAGE_SIZE);
            List<CartModel> PackageDetails = cartService.selectList(mapInfo);
            map.put("list", PackageDetails);
        }else {
            map.put("list",new ArrayList<CartModel>());
        }
        return map;
    }

    /**
     * 导出Excel功能
     * @param request
     * @param response
     * @return
     */
    /*@RequestMapping(value = "/exportexcel", method = RequestMethod.POST)
    public String exportExcel(HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> map = new HashMap<String, Object>();
        List<PackageDetailsModel> packageDetails_list = null;
        //标题行
        String title[] = {"检验项目编号", "his项目编号", "his项目名称", "his价格到分", "套餐编号", "项目名称", "price"};
        StringBuilder tempPath = new StringBuilder();
        SimpleDateFormat fileNameFormat = new SimpleDateFormat("yyyyMMddkkmmss_S");
        tempPath.append(fileNameFormat.format(new Date()));
        tempPath.append(".").append("xls");
        String filename = tempPath.toString();
        try {
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
//			response.setHeader("Content-Disposition", "attachment;filename="+ new String((path1).getBytes(), "iso-8859-1"));
            response.setHeader("Content-Disposition", "attachment;filename="+ new String((filename).getBytes(), "utf-8"));
            OutputStream os = response.getOutputStream();
            WritableWorkbook book = Workbook.createWorkbook(os);
            WritableSheet sheet = book.createSheet("套餐信息", 0);
            //写入标题
            for (int i=0; i<title.length; i++) {
                sheet.addCell(new Label(i, 0, title[i]));
            }
            packageDetails_list = packageDetailsService.selectList(new HashMap<String, Object>());
            for (int i=0; i<packageDetails_list.size(); i++) {
                int j=0;
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getId() != null ? Long.toString(packageDetails_list.get(i).getId()) : ""));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getHisId()));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getHisName()));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getHisPrice() != null ? Long.toString(packageDetails_list.get(i).getHisPrice()) : ""));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getPackageId() != null ? Long.toString(packageDetails_list.get(i).getPackageId()) : ""));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getName()));
                sheet.addCell(new Label(j++, i+1, packageDetails_list.get(i).getPrice() != null ? Long.toString(packageDetails_list.get(i).getPrice()) : ""));
            }
            //写入数据
            book.write();
            //关闭文件
            book.close();
            os.flush();
            os.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }*/

    /**
     * excel数据的导入
     * @param excelFile
     * @return
     */
    /*@RequestMapping(value = "/excelImport", method = RequestMethod.POST)
    @ResponseBody
    public Map<String , String> importExcelFile(MultipartFile excelFile) {
        Map<String, String> map = new HashMap<String, String>();
        String result = packageDetailsService.importExcelFile(excelFile);
        map.put("msg", result);
        return map;
    }*/
}

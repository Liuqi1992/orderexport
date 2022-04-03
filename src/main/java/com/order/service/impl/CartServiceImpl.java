package com.order.service.impl;

import com.order.dao.CartModelMapper;
import com.order.model.CartModel;
import com.order.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by LiuQi on 2017/8/15.
 */
@Service
public class CartServiceImpl implements CartService{

    @Autowired
    private CartModelMapper cartDao;

    public List<CartModel> selectList(Map map) {
        return cartDao.selectList(map);
    }

    public CartModel selectById(long id) {
        return cartDao.selectByPrimaryKey(id);
    }

    public int updateById(CartModel cartModel) {
        return cartDao.updateByPrimaryKeySelective(cartModel);
    }

    public int deleteById(long id) {
        return cartDao.deleteByPrimaryKey(id);
    }

    /*public int addPackageDetails(PackageDetailsModel packageDetailsModel) {
        return packageDetailsDao.insertSelective(packageDetailsModel);
    }*/

    /*public String importExcelFile(MultipartFile excelFile) {
        String result = "";
        //创建处理Excel的类
        ReadExcel readExcel = new ReadPackageDetailsExcel();
        List<PackageDetailsModel> userLists = readExcel.getExcelInfo(excelFile);
        if (userLists != null && !userLists.isEmpty()) {
            //userDao.batchInsert(userLists);
            for (int i=0; i<userLists.size(); i++) {
                packageDetailsDao.insert(userLists.get(i));
            }
            result = "导入成功";
        } else {
            result = "导入失败";
        }
        return result;
    }*/
}

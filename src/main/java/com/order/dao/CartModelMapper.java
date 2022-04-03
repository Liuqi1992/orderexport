package com.order.dao;

import com.order.model.CartModel;

import java.util.List;
import java.util.Map;

public interface CartModelMapper {
    int deleteByPrimaryKey(Long id);

    int insert(CartModel record);

    int insertSelective(CartModel record);

    CartModel selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(CartModel record);

    int updateByPrimaryKey(CartModel record);

    List<CartModel> selectList(Map map);
}
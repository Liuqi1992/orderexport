package com.order.dao;

import com.order.model.ApplicantModel;

import java.util.List;
import java.util.Map;

public interface ApplicantModelMapper {
    int deleteByPrimaryKey(Long id);

    int insert(ApplicantModel record);

    int insertSelective(ApplicantModel record);

    ApplicantModel selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(ApplicantModel record);

    int updateByPrimaryKey(ApplicantModel record);

    List<ApplicantModel> applicantList(Map map);

    void batchUpdate(List list);
}
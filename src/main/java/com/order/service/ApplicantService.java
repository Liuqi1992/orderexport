package com.order.service;

import com.order.model.ApplicantModel;

import java.util.List;
import java.util.Map;

/**
 * Created by LiuQi on 2017/11/17.
 */
public interface ApplicantService {

    List<ApplicantModel> applicantList(Map map);

    void batchUpdate(List list);
}

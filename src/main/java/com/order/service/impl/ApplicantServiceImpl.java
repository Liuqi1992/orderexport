package com.order.service.impl;

import com.order.dao.ApplicantModelMapper;
import com.order.model.ApplicantModel;
import com.order.service.ApplicantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by LiuQi on 2017/11/17.
 */
@Service
public class ApplicantServiceImpl implements ApplicantService {

    @Autowired
    private ApplicantModelMapper applicantModelDao;

    public List<ApplicantModel> applicantList(Map map) {
        return applicantModelDao.applicantList(map);
    }

    public void batchUpdate(List list) {
        applicantModelDao.batchUpdate(list);
    }
}

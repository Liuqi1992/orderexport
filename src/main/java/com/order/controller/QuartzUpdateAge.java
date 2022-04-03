package com.order.controller;

import com.order.model.ApplicantModel;
import com.order.service.ApplicantService;
import com.order.utils.IdcardInfoExtractor;
import com.order.utils.IdcardValidator;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * Created by LiuQi on 2017/11/14.
 */
public class QuartzUpdateAge {

    private ExecutorService singleThreadExecutor = null;

    private IdcardValidator idcardValidator = new IdcardValidator();

    @Autowired
    private ApplicantService applicantService;

    public void work() {
        if (singleThreadExecutor == null) {
            singleThreadExecutor = Executors.newSingleThreadExecutor();
        } else {
            singleThreadExecutor.shutdown();
            singleThreadExecutor = Executors.newSingleThreadExecutor();
        }
        try {
            updateAgeBySfzNum();
        } catch (Exception e) {
            e.getStackTrace();
        }
    }

    private void updateAgeBySfzNum() {
        //通过身份证号码更新联系人年龄
        List<ApplicantModel> list = applicantService.applicantList(new HashMap());
        List<ApplicantModel> needUpdateList = new ArrayList<ApplicantModel>();
        for (ApplicantModel applicantModel : list) {
            String sfzNum = applicantModel.getSfzNum();
            if (sfzNum != null && idcardValidator.isValidatedAllIdcard(sfzNum)) {
                IdcardInfoExtractor idcardInfoExtractor = new IdcardInfoExtractor(sfzNum);
                applicantModel.setAge(idcardInfoExtractor.getAge());
                applicantModel.setModifyTime(new Date());
                needUpdateList.add(applicantModel);
            }
        }
        applicantService.batchUpdate(needUpdateList);
    }
}

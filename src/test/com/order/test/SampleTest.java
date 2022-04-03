package com.order.test;

//import com.tongshuo.dsf.model.preprocess.DsfSampleInfo;
//import com.tongshuo.dsf.service.baseDataManager.DsfTemplateConfigService;
//import com.tongshuo.dsf.service.preprocessManager.DsfProcessService;
//import com.tongshuo.dsf.service.preprocessManager.DsfSampleInfoService;
//import com.tongshuo.dsf.util.ConvertUtil;
//import com.tongshuo.dsf.util.DateUtil;
//import com.tongshuo.dsf.util.SpringContextUtil;
//import com.tongshuo.dsf.webService.client.model.ThirdSampleInfo;


/**
 * Created by Kewell on 2017/9/29.
 */
public class SampleTest {
//    static DsfSampleInfoService dsfSampleInfoService = null;
//    DsfProcessService dsfProcessService = null;
//    DsfTemplateConfigService dsfTemplateConfigService = null;
    public SampleTest(){
//        dsfSampleInfoService = (DsfSampleInfoService) SpringContextUtil.getBean("dsfSampleInfoService");
//        dsfProcessService = (DsfProcessService) SpringContextUtil.getBean("dsfProcessService");
//        dsfTemplateConfigService = (DsfTemplateConfigService) SpringContextUtil.getBean("dsfTemplateConfigService");
    }
    public static void main(String[] args) throws Exception{
        /*
        HttpClient httpClient = new HttpClient();

        httpClient.getHostConfiguration().setHost("http://192.168.105.185:8080/lisservice/services/");

        //GetMethod method = new GetMethod("http://192.168.105.185:8080/lisservice/services/customer/rest/customer/getSampleInfo?" +
      //          "barcode=191399259P&key=$2a$10$fwxrYIuqID0JnoEotQgLL.d7KSg7hOMemnblkGQDm8yk52fDvm5sm&customerId=K0086595001");

        GetMethod method = new GetMethod("http://192.168.105.185:8080/lisservice/services/customer/rest/customer/getClinicalDepart?" +
                "customerId=0086595001&key=$2a$10$fwxrYIuqID0JnoEotQgLL.d7KSg7hOMemnblkGQDm8yk52fDvm5sm");
        method.releaseConnection();
        httpClient.executeMethod(method);
        JSONObject obj = new JSONObject(method.getResponseBodyAsString());
        System.out.println(obj);
        */
        //List<DsfSampleInfo> ds = dsfSampleInfoService.getAll();
        /*List<DsfSampleInfo> dsfSampleInfoList = new ArrayList<DsfSampleInfo>();
        DsfSampleInfo dsfSampleInfo =  new DsfSampleInfo();
        dsfSampleInfo.setAge("12");
        dsfSampleInfo.setBarcode("123456");
        dsfSampleInfo.setBedNo("XX12");
        dsfSampleInfo.setBirthday("2002-12-21");
        dsfSampleInfo.setDigCode("123");
        dsfSampleInfo.setExecutor("执行者");
        dsfSampleInfo.setFee("12");
        dsfSampleInfo.setPatientName("name");*/
        /*
        dsfSampleInfo.setPatientId(dsfSampleInfo.getPatientId());
        dsfSampleInfo.setPatientAddress(dsfSampleInfo.getPatientAddress());
        dsfSampleInfo.setPatientPhone(dsfSampleInfo.getPatientPhone());
        dsfSampleInfo.setSex(dsfSampleInfo.getSex());
        dsfSampleInfo.setSender(dsfSampleInfo.getSender());
        dsfSampleInfo.setTestPurposeId(dsfSampleInfo.getTestPurposeId());
        dsfSampleInfo.setTestPurposeName(dsfSampleInfo.getTestPurposeName());
        dsfSampleInfo.setTestCenter(dsfSampleInfo.getTestCenter());
        */
        /*dsfSampleInfoList.add(dsfSampleInfo);
        String interfaceUrl = "http://localhost:80/TPS_Services/services/";
        String methodUrl = interfaceUrl+"third/rest/third/saveSampleInfoToThird";
        String ds = saveSampleInfoToThird(interfaceUrl, methodUrl, dsfSampleInfoList);
        System.out.println(ds);*/
    }

    /*public static String saveSampleInfoToThird(String interfaceUrl,String methodUrl,List<DsfSampleInfo> dsfSampleInfoList) {
        List<ThirdSampleInfo> thirdSampleInfoList = new ArrayList<ThirdSampleInfo>();
        String messgae = "";
        for(DsfSampleInfo dsfSampleInfo: dsfSampleInfoList){
            ThirdSampleInfo thirdSampleInfo = new ThirdSampleInfo();

            thirdSampleInfo.setAge(dsfSampleInfo.getAge());
            thirdSampleInfo.setAgeType(dsfSampleInfo.getAgeUnit());
            thirdSampleInfo.setBarcode(dsfSampleInfo.getBarcode());
            thirdSampleInfo.setCustomName(dsfSampleInfo.getCustomerName());
            thirdSampleInfo.setCustomBarcode(dsfSampleInfo.getCustomerBarcode());
            thirdSampleInfo.setPreBarCode(dsfSampleInfo.getBarcode());
            thirdSampleInfo.setCustomId(dsfSampleInfo.getCustomerId());
            thirdSampleInfo.setBedNo(dsfSampleInfo.getBedNo());
            thirdSampleInfo.setBirthday(dsfSampleInfo.getBirthday());
            thirdSampleInfo.setCustomId(dsfSampleInfo.getCustomerId());
            thirdSampleInfo.setCycle(ConvertUtil.getIntValue(dsfSampleInfo.getPatientCycle(),0));
            thirdSampleInfo.setDepartmentCode(dsfSampleInfo.getClinicalDepartId());
            thirdSampleInfo.setDepartment(dsfSampleInfo.getClinicalDepartName());
            thirdSampleInfo.setDiagnosis(dsfSampleInfo.getDiagnostic());
            thirdSampleInfo.setDigCode(dsfSampleInfo.getDigCode());
            thirdSampleInfo.setExecutor(dsfSampleInfo.getExecutor());
            String executeTime = ConvertUtil.null2String(dsfSampleInfo.getExecuteTime());
            thirdSampleInfo.setExecuteTime(executeTime.equals("")?null: DateUtil.getLongLongTime(dsfSampleInfo.getExecuteTime()));
            thirdSampleInfo.setFee(dsfSampleInfo.getFee());
            if(null != dsfSampleInfo.getFeeStatus() && "".equals(dsfSampleInfo.getFeeStatus())){
                thirdSampleInfo.setFeeStatus(dsfSampleInfo.getFeeStatus());
            }
            thirdSampleInfo.setKsreceiver(dsfSampleInfo.getServicePerson());
            String serviceTime = ConvertUtil.null2String(dsfSampleInfo.getServiceTime());
            thirdSampleInfo.setKsreceivetime(serviceTime.equals("")?null:DateUtil.getLongLongTime(dsfSampleInfo.getServiceTime()));
            thirdSampleInfo.setNote(dsfSampleInfo.getProperty());
            thirdSampleInfo.setPatientName(dsfSampleInfo.getPatientName());
            thirdSampleInfo.setPatientId(dsfSampleInfo.getPatientId());
            thirdSampleInfo.setPatientAddress(dsfSampleInfo.getPatientAddress());
            thirdSampleInfo.setPatientFileCode(dsfSampleInfo.getPatientCode());
            thirdSampleInfo.setPart(dsfSampleInfo.getCollectPart());
            thirdSampleInfo.setPatientIdNumber(dsfSampleInfo.getPatientIdCard());
            thirdSampleInfo.setPatientPhone(dsfSampleInfo.getPatientPhone());
            thirdSampleInfo.setRequester(dsfSampleInfo.getRequestDoctorName());
            String requestTime = ConvertUtil.null2String(dsfSampleInfo.getRequestTime());
            thirdSampleInfo.setRequestTime(requestTime.equals("")?null:DateUtil.getLongLongTime(dsfSampleInfo.getRequestTime()));
            thirdSampleInfo.setRequestMode(ConvertUtil.getIntValue(dsfSampleInfo.getEmergency()+"",0));
            *//*
            thirdSampleInfo.setStayHospitalMode(dsfSampleInfo.getVisitMode());
            thirdSampleInfo.setSex(dsfSampleInfo.getSex());
            thirdSampleInfo.setSender(dsfSampleInfo.getSender());
            String sendTime = ConvertUtil.null2String(dsfSampleInfo.getSendTime());
            thirdSampleInfo.setSendTime(sendTime.equals("")?null:DateUtil.getLongLongTime(dsfSampleInfo.getSendTime()));
            //不需要传样本类型
            //thirdSampleInfo.setSampleType();
            thirdSampleInfo.setTestPurposeId(dsfSampleInfo.getTestPurposeId());
            thirdSampleInfo.setTestPurposeName(dsfSampleInfo.getTestPurposeName());
            thirdSampleInfo.setTestCenter(dsfSampleInfo.getTestCenter());
            *//*
            thirdSampleInfoList.add(thirdSampleInfo);
        }
        try {
            HttpClient httpClient = new HttpClient();
            httpClient.getHostConfiguration().setHost(interfaceUrl);
            PostMethod method = new PostMethod(methodUrl);
            net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(thirdSampleInfoList);
            System.out.println(jsonArray);
            RequestEntity requestEntity = new StringRequestEntity(jsonArray.toString(),
                    "application/json", "UTF-8");
            method.setRequestEntity(requestEntity);
            method.releaseConnection();
            httpClient.executeMethod(method);
            org.codehaus.jettison.json.JSONObject obj;
            try {
                if (null != method.getResponseBodyAsString() && !"".equals(method.getResponseBodyAsString())) {
                    System.out.println("推送结果为：" + method.getResponseBodyAsString());
                    obj = new org.codehaus.jettison.json.JSONObject(method.getResponseBodyAsString());
                    if ((Integer) obj.get("State") != 1) {
                        return "0";
                    } else {
                        return "1";
                    }
                } else {
                    System.out.println("推送出现错误，error：" + method.getResponseBodyAsString());
                    return "0";
                }
            } catch (Exception e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }*/
}

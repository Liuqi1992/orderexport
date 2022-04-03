package com.order.utils;

import cn.jiguang.common.resp.APIConnectionException;
import cn.jiguang.common.resp.APIRequestException;
import cn.jmessage.api.JMessageClient;
import cn.jmessage.api.common.model.RegisterInfo;

import java.util.List;

/**
 * Created by wang on 2017-07-27.
 */
public class JMessageUtils {
    private static String masterSecret = "45ec5ccd2999902e7d81784c";
    private static String appKey = "624a57bc4a6b9c73a76a5f89";

    /*public static void main(String[] args) {
        JMessageClient client = new JMessageClient(appKey, masterSecret);
        RegisterInfo.Builder builder=RegisterInfo.newBuilder();
        builder.setPassword("tcl123456");
        builder.setUsername("15669008061");
        RegisterInfo[] users={builder.build()};
        String result = null;
        try {
            result=client.registerUsers(users);
            client.updateUserInfo("15669008061", "牛牛", null, null, 0, null, null);
//            UserInfoResult userInfoResult = client.getUserInfo("15669008061");
//            System.out.println("删除成功");
//            client.deleteUser("15669008061");
        } catch (APIConnectionException e) {
            System.out.println("连接错误");
            e.printStackTrace();
        } catch (APIRequestException e) {
            System.out.println("请求错误");
            System.out.println(e.getErrorCode() + "--" + e.getErrorMessage());
        } finally {
            System.out.println(result);
        }
    }*/

    public static String registerUser(String userName, String nickname) {
        JMessageClient client = new JMessageClient(appKey, masterSecret);
        int result = 0;
        for (int i=0; i<5; i++) {
            result = registerUser(client, userName);
            //表示用户已存在
            if (result == 898001 || result == 899001) break;
            //表示注册成功
            if (result == 200) break;
        }
        int updateResult = 0;
        if (result == 200 || result == 898001 || result == 899001) {
            updateResult = updateUserInfo(client, userName, nickname);
        }
        return updateResult == 200 ? "success" : "error";
    }

    //单个注册
    public static int registerUser(JMessageClient client, String userName) {
        int result;
        try {
            RegisterInfo.Builder builder = RegisterInfo.newBuilder();
            builder.setPassword("tcl123456");
            builder.setUsername(userName);
            RegisterInfo[] users = {builder.build()};
            String s = client.registerUsers(users);
            System.out.println(s);
            result = 200;
        } catch (APIConnectionException e) {
            result = -1;
        } catch (APIRequestException e) {
            result = e.getErrorCode();
            System.out.println(e.getErrorMessage());
        }
        return result;
    }

    /**
     * 更新用户昵称
     * @param client
     * @param userName
     * @param nickname
     * @return
     */
    public static int updateUserInfo(JMessageClient client, String userName, String nickname) {
        int result = 0;
        try {
            client.updateUserInfo(userName, nickname, null, null, 0, null, null);
            result = 200;
        } catch (APIConnectionException e) {
            result = -1;
            e.printStackTrace();
        } catch (APIRequestException e) {
            result = e.getErrorCode();
            System.out.println(e.getErrorMessage());
            e.printStackTrace();
        }
        return result;
    }

    /**
     * 删除极光上的用户
     * @param userName
     * @return
     */
    public static String deleteUser(String userName) {
        JMessageClient client = new JMessageClient(appKey, masterSecret);
        String result = null;
        try {
            client.deleteUser(userName);
            result = "success";
        } catch (APIConnectionException e) {
            result = "connec error";
            e.printStackTrace();
        } catch (APIRequestException e) {
            result = e.getErrorMessage();
            e.printStackTrace();
        }
        return result;
    }

    //批量注册
    public static String registerUsers(List<String> userNames) {
        JMessageClient client = new JMessageClient(appKey, masterSecret);
        try {
            if(userNames!=null&&userNames.size()>0){
                RegisterInfo[] users=new RegisterInfo[userNames.size()];
                for(int i=0;i<userNames.size();i++){
                    RegisterInfo.Builder builder=RegisterInfo.newBuilder();
                    builder.setPassword("tcl123456");
                    builder.setUsername(userNames.get(i));
                    users[i]=builder.build();
                }
                String result=client.registerUsers(users);
                System.out.println(result);
                return result;
            }

        } catch (APIConnectionException e) {
            e.printStackTrace();
        } catch (APIRequestException e) {
            e.printStackTrace();
        }
        return "";
    }
    /*
    public static void main(String[] args) {
        registerUsers();
    }*/
}

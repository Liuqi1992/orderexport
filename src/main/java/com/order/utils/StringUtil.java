package com.order.utils;

import java.security.MessageDigest;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by LiuQi on 2017/8/18.
 */
public class StringUtil {
    public static String getFormatDate(Date date) {
        if (date == null) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String datetime = sdf.format(date);
        return datetime;
    }

    /**
     * 自定义时间格式
     * @param date
     * @param format
     * @return
     */
    public static String getFormatDate(Date date, String format) {
        if (date == null) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        String birthday = sdf.format(date);
        return birthday;
    }

    /**
     * 将字符串时间改为Date时间
     * @param time
     * @return
     */
    public static Date getDate(String time, String format) {
        if (time == null || time.trim().isEmpty()) {
            return null;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(format);
        Date date = null;
        try {
            date = sdf.parse(time.trim());
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    /**
     *
     * 将一个字符串进行 MD5 加密<BR/>
     * 方法名：MD5<BR/>
     * 创建人：auger <BR/>
     *
     * @param securityStr
     * @return String<BR/>
     * @exception <BR/>
     * @since 1.0.0
     */
    public static String MD5(String securityStr) {
        char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F' };
        try {
            byte[] btInput = securityStr.getBytes();
            // 获得MD5摘要算法的 MessageDigest 对象
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            // 使用指定的字节更新摘要
            mdInst.update(btInput);
            // 获得密文
            byte[] md = mdInst.digest();
            // 把密文转换成十六进制的字符串形式
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str).toLowerCase();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    //对价格的处理
    public static Long priceProcess(String price_str) {
        if (price_str == null || price_str.trim() == "") {
            return null;
        } else {
            return (long)(Arith.mul(Double.parseDouble(price_str.trim()), 100));
        }
    }

    //价格转换成字符串
    public static String priceToString(Long price) {
        double priced = Arith.div(((double) ((long) price)), 100, 2);
        return new DecimalFormat("0.00").format(priced);
    }
}
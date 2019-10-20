package com.aishang.manager.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class publictool {
    public static String getStringdate() {
        Date date = new Date();
        //转换提日期输出格式
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(date);
    }
}

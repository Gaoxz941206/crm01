package com.myself.Utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class TimeFormat {
    public static String getCurrentAllTime(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return dateFormat.format(new Date());
    }
    public static String getCurrentShortTime(){
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        return dateFormat.format(new Date());
    }
}

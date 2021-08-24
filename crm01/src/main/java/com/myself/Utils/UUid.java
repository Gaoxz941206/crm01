package com.myself.Utils;

import java.util.UUID;

public class UUid {
    public static String getUUID(){
        return UUID.randomUUID().toString().replaceAll("-","");
    }
}

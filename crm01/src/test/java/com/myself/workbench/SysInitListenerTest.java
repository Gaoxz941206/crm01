package com.myself.workbench;

import org.junit.Test;

import java.util.Enumeration;
import java.util.Iterator;
import java.util.ResourceBundle;

/**
 * @Author Gaoxz
 * @CreateTiime 2021-09-22 10:51
 * @apiNote
 */
public class SysInitListenerTest {
    @Test
    public void test001(){
        ResourceBundle bundle = ResourceBundle.getBundle("StageToPossibility");
        Enumeration<String> keys = bundle.getKeys();
        while (keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = bundle.getString(key);
            System.out.println(key+" : "+value);
        }
    }

    @Test
    public void test002(){
        ResourceBundle bundle = ResourceBundle.getBundle("StageToPossibility");
        Iterator<String> strings = bundle.keySet().iterator();
        while (strings.hasNext()){
            String key = strings.next();
            String value = bundle.getString(key);
            System.out.println(key+" : "+value);
        }
    }
}

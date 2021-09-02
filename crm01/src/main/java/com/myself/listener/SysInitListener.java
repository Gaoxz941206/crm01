package com.myself.listener;

import com.myself.dic.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;

public class SysInitListener implements ServletContextListener {

    @Autowired(required = false)
    private DicService service;

    /**
     * 该方法是用来监听context域对象方法
     * @param sce
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        List<String> list = service.selectDicCodeTypes();
        for (String type : list) {
            System.out.println(type);
        }
    }
}

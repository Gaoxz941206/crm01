package com.myself.listener;

import com.myself.dic.entity.DicValue;
import com.myself.dic.service.DicService;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

@Controller
public class SysInitListener implements ServletContextListener {

    /**
     * 该方法是用来监听context域对象方法
     * @param sce
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        /*
            将数据字典存入全局作用域中
         */
        ServletContext context = sce.getServletContext();
        WebApplicationContext application = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        DicService service = (DicService) application.getBean("dicServiceImpl");
        Map<String,List<DicValue>> map = service.selectDicCodeTypes();
        context.setAttribute("map",map);

        /*
            将配置文件中内容存入全局作用于中
         */
        ResourceBundle bundle = ResourceBundle.getBundle("StageToPossibility");
        Map<String,String> possibilityMap = new HashMap<>();
        Enumeration<String> keys = bundle.getKeys();
        while (keys.hasMoreElements()){
            String key = keys.nextElement();
            String value = bundle.getString(key);
            possibilityMap.put(key,value);
        }
        context.setAttribute("pMap",possibilityMap);
    }
}

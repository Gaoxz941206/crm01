package com.myself.listener;

import com.myself.dic.entity.DicValue;
import com.myself.dic.service.DicService;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.List;
import java.util.Map;

@Controller
public class SysInitListener implements ServletContextListener {

    /**
     * 该方法是用来监听context域对象方法
     * @param sce
     */
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServletContext context = sce.getServletContext();
        WebApplicationContext application = WebApplicationContextUtils.getRequiredWebApplicationContext(context);
        DicService service = (DicService) application.getBean("dicServiceImpl");
        Map<String,List<DicValue>> map = service.selectDicCodeTypes();
        context.setAttribute("map",map);
    }
}

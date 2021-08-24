package com.myself.handler;

import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if(session != null && session.getAttribute("user") != null){
            return true;
        }else {
            String uri = request.getRequestURI();
            if (uri.contains(".js") || uri.contains(".css") || uri.contains(".png") || uri.contains(".JPG") || uri.contains(".eot") ||
                    uri.contains(".svg") || uri.contains(".ttf") || uri.contains(".woff") || uri.contains(".gif") ||
                    uri.contains("user/login")){
                return true;
            }else {
                response.sendRedirect("/crm01/login.jsp");
                return false;
            }
        }
    }
}

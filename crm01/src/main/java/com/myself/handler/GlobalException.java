package com.myself.handler;

import com.myself.exception.UserException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice
public class GlobalException {
    @ExceptionHandler(value = UserException.class)
    @ResponseBody
    public Map<String,Object> userLoginException(Exception e){
        Map<String,Object> map = new HashMap<>();
        map.put("isSuccess",false);
        map.put("msg",e.getMessage());
        return map;
    }
}

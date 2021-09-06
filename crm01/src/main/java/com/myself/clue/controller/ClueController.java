package com.myself.clue.controller;

import com.myself.Utils.Page;
import com.myself.clue.entity.Clue;
import com.myself.clue.service.ClueService;
import com.myself.vo.ClueQueryParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/clue")
public class ClueController {

    @Autowired(required = false)
    private ClueService service;

    @RequestMapping(value = "/selectPage",produces = "application/json;charset=utf-8")
    @ResponseBody
    public Page<Clue> selectPage(ClueQueryParam param){
        return service.selectPage(param);
    }

}
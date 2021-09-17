package com.myself.workbench;

import com.myself.workbench.entity.Activity;
import com.myself.workbench.service.ActivityService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml"})
public class ActivityTest {

    @Autowired(required = false)
    ActivityService service;

    @Test
    public void test001(){
        List<Activity> list = service.selectActivityByName("");
        for (Activity act : list) {
            System.out.println(act);
        }
    }
}

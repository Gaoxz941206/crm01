package com.myself.workbench;

import com.myself.Utils.Page;
import com.myself.customer.entity.Customer;
import com.myself.customer.service.CustomerService;
import com.myself.vo.CustomerQueryParam;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:spring.xml"})
public class CustomerTest {

    @Autowired(required = false)
    private CustomerService service;

    @Test
    public void test001(){
        CustomerQueryParam param = new CustomerQueryParam();
        param.setName("");
        param.setOwner("");
        param.setPhone("");
        param.setWebsite("");
        param.setPageNo(2);
        param.setPageSize(5);
        Page<Customer> page = service.pageQuery(param);
        System.out.println("记录总条数："+page.getTotalSize());
        System.out.println("当前页："+page.getPageNo());
        System.out.println("每页显示条数："+page.getTotalSize());
        System.out.println("************************************");
        for (Customer customer : page.getList()) {
            System.out.println(customer);
        }
    }
}

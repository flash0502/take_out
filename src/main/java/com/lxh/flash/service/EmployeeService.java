package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.Employee;


import javax.servlet.http.HttpServletRequest;

public interface EmployeeService extends IService<Employee> {

    //员工登录
    public R<Employee> login(HttpServletRequest request,Employee employee);

    //分页查询员工信息
    public R<Page> page(int page, int pageSize, String name);

}

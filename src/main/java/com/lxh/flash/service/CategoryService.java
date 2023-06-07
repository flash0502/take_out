package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.Category;

import java.util.List;

public interface CategoryService extends IService<Category> {

    //删除分类
    public void remove(Long ids);

    //分类信息分页查询
    public R<Page> page(int page, int pageSize);

    //根据条件查询分类数据
    public R<List<Category>> list(Category category);
}

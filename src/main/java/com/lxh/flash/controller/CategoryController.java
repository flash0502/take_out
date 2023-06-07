package com.lxh.flash.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.Category;
import com.lxh.flash.service.CategoryService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

//分类管理
@RestController
@RequestMapping("category")
@Slf4j
public class CategoryController {
    @Autowired
    private CategoryService categoryService;

    //新增分类
    @PostMapping
    public R<String> save(@RequestBody Category category) {
        categoryService.save(category);
        return R.success("新增分类成功");
    }

    //分类信息分页查询
    @GetMapping("/page")
    public R<Page> page(int page, int pageSize) {
        return categoryService.page(page, pageSize);
    }

    //根据id删除分类
    @DeleteMapping
    public R<String> delete(Long ids) {

        categoryService.remove(ids);
        return R.success("分类信息删除成功");
    }

    //根据id修改分类信息
    @PutMapping
    public R<String> update(@RequestBody Category category) {
        log.info("修改分类信息：{}", category);

        categoryService.updateById(category);
        return R.success("修改分类信息成功");
    }

    //根据条件查询分类数据
    @GetMapping("/list")
    public R<List<Category>> list(Category category) {
        return categoryService.list(category);

    }
}

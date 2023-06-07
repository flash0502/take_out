package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.DishDto;
import com.lxh.flash.entity.Dish;

import java.util.List;

public interface DishService extends IService<Dish> {

    //新增菜品，同时插入菜品对应的口味数据，需要操作两张表：dish，dish_flavor
    public void saveWithFlavor(DishDto dishDto);

    //菜品信息分页查询
    public R<Page> page(int page, int pageSize, String name);

    //根据id查询菜品信息和对应的口味信息
    public DishDto getByIdWithFlavor(Long id);

    //更新菜品信息，同时更新对应的口味信息
    public void updateWithFlavor(DishDto dishDto);

    //删除菜品信息
    public void deleteByIds(List<Long> ids);

    //改变菜品状态
    public void modifyStatus(Integer stu,List<Long> ids);

    //根据条件查询菜品数据(缓存优化)
    public R<List<DishDto>> list(Dish dish);



}

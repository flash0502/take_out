package com.lxh.flash.service;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.DishDto;
import com.lxh.flash.dto.SetmealDto;
import com.lxh.flash.entity.Setmeal;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface SetmealService extends IService<Setmeal> {
    //新增套餐同时需要保存套餐和菜品的关联关系
    public void saveWithDish(SetmealDto setmealDto);

    //套餐信息分页查询
    public R<Page> page(int page, int pageSize, String name);

    //删除套餐，同时需要删除套餐和菜品的关联数据
    public void removeWithDish(List<Long> ids);

    //根据id查询套餐信息
    public SetmealDto getByIdWithDish(Long ids);

    //修改套餐信息
    public void updateWithDish(SetmealDto setmealDto);

    //用户端页面显示套餐
    public R<List<Setmeal>> list(Setmeal setmeal);

    //页面回显套餐数据
    public R<List<DishDto>> echo(Long id);
}

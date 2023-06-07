package com.lxh.flash.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lxh.flash.entity.Dish;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface DishMapper extends BaseMapper<Dish> {

}

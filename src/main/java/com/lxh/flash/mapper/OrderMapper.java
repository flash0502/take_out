package com.lxh.flash.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lxh.flash.entity.Orders;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OrderMapper extends BaseMapper<Orders> {

}
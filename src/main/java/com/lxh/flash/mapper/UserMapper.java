package com.lxh.flash.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.lxh.flash.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
}

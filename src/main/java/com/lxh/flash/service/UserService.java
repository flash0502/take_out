package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.User;
import org.springframework.web.bind.annotation.RequestBody;

import javax.servlet.http.HttpSession;
import java.util.Map;


public interface UserService extends IService<User> {

    //用户端发送验证码
    public R<String> sendMsg(@RequestBody User user, HttpSession session);

    //用户端登录
    public R<User> login(@RequestBody Map map, HttpSession session);
}

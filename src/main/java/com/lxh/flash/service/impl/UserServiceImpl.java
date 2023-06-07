package com.lxh.flash.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.User;
import com.lxh.flash.mapper.UserMapper;
import com.lxh.flash.service.UserService;
import com.lxh.flash.utils.ValidateCodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Autowired
    private UserService userService;

    @Autowired
    private RedisTemplate redisTemplate;

    @Resource
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String from;

    //用户端发送验证码
    @Override
    public R<String> sendMsg(User user, HttpSession session) {
        //获取邮箱地址
        String email = user.getEmail();

        if(!StringUtils.isEmpty(email)){
            //生成随机的4位验证码
            String code = ValidateCodeUtils.generateValidateCode(4).toString();
            log.info("code={}",code);
//            构建一个邮件的对象
            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
//          设置邮件发件者
            simpleMailMessage.setFrom(from);
//            设置邮件接受者
            simpleMailMessage.setTo(email);
//            设置邮件的主题
            simpleMailMessage.setSubject("登录验证码");
//            设置邮件的正文
            String text = "你的登录验证码为" + code + "请勿泄露，有效期为5分钟";
            simpleMailMessage.setText(text);
            //将需要生成的验证码保存到Session
//            session.setAttribute(email,code);

            //将生成的验证码缓存到Redis中，并且设置有效期为5分钟
            redisTemplate.opsForValue().set(email,code,5, TimeUnit.MINUTES);

            try {
                javaMailSender.send(simpleMailMessage);
                return R.success("邮箱验证码发送成功");
            } catch (MailException e) {
                e.printStackTrace();
            }
        }

        return R.error("邮箱验证码发送失败");
    }

    //用户端登录
    @Override
    public R<User> login(Map map, HttpSession session) {

        //获取邮箱地址
        String email = map.get("email").toString();

        //获取验证码
        String code = map.get("code").toString();

        //从Session中获取保存的验证码
        //Object codeInSession = session.getAttribute(email);

        //从Redis中获取缓存的验证码
        Object codeInSession = redisTemplate.opsForValue().get(email);

        //进行验证码的比对(页面提交的验证码和Session中保存的验证码比对)
        if(codeInSession != null && codeInSession.equals(code)){
            //比对成功则说明登录成功

            LambdaQueryWrapper<User> queryWrapper = new LambdaQueryWrapper<>();
            queryWrapper.eq(User::getEmail,email);

            User user = userService.getOne(queryWrapper);
            if(user == null){
                //判断当前邮箱对应的用户是否为新用户，如果是新用户则自动完成注册
                user = new User();
                user.setEmail(email);
                user.setStatus(1);
                userService.save(user);
            }
            session.setAttribute("user",user.getId());

            //如果用户登录成功，删除Redis中缓存的验证码
            redisTemplate.delete(email);

            return R.success(user);
        }
        return R.error("登录失败");
    }
}

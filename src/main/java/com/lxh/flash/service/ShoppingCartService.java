package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.ShoppingCart;

import java.util.List;

public interface ShoppingCartService extends IService<ShoppingCart> {

    //添加商品到购物车
    public R<ShoppingCart> add(ShoppingCart shoppingCart);

    //查看购物车
    public List<ShoppingCart> list();

    //客户端的套餐或者是菜品数量减少设置
    public R<ShoppingCart> sub(ShoppingCart shoppingCart);


    //清空购物车
    public void clean();

}

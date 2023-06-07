package com.lxh.flash.controller;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.lxh.flash.common.BaseContext;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.ShoppingCart;
import com.lxh.flash.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 购物车
 */
@Slf4j
@RestController
@RequestMapping("/shoppingCart")
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加购物车
     * @param shoppingCart
     * @return
     */
    @PostMapping("/add")
    public R<ShoppingCart> add(@RequestBody ShoppingCart shoppingCart){
        log.info("购物车数据:{}",shoppingCart);
        return shoppingCartService.add(shoppingCart);

    }

    /**
     * 查看购物车
     * @return
     */
    @GetMapping("/list")
    public R<List<ShoppingCart>> list(){
        log.info("查看购物车...");
        List<ShoppingCart> list = shoppingCartService.list();
        return R.success(list);
    }

    /**
     * 清空购物车+
     * @return
     */
    @DeleteMapping("/clean")
    public R<String> clean(){

        return R.success("清空购物车成功");
    }


    /**
     *客户端的套餐或者是菜品数量减少设置
     *没必要设置返回值
     * @param shoppingCart
     * @return
     */
    @PostMapping("/sub")
    @Transactional
    public R<ShoppingCart> sub(@RequestBody ShoppingCart shoppingCart){
      return shoppingCartService.sub(shoppingCart);

    }
}
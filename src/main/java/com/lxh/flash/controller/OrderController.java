package com.lxh.flash.controller;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.OrderDto;
import com.lxh.flash.entity.Orders;
import com.lxh.flash.service.OrderDetailService;
import com.lxh.flash.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

/**
 * 订单管理
 */
@Slf4j
@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService ordersService;

    /**
     * 用户下单
     * @param orders
     * @return
     */
    @PostMapping("/submit")
    public R<String> submit(@RequestBody Orders orders){
        log.info("订单数据:{}",orders);
        ordersService.submit(orders);
        return R.success("下单成功");
    }

    /**
     * 订单信息分页查询
     * @param page
     * @param pageSize
     * @return
     */
    @GetMapping("/userPage")
    public R<Page<OrderDto>> page(int page, int pageSize) {
        R<Page<OrderDto>> result = ordersService.page(page, pageSize);
        return R.success(result.getData());
    }

    /**
     * 再来一单
     * @param map
     * @return
     */
    @PostMapping("/again")
    public R<String> again(@RequestBody Map<String,String> map){
        ordersService.again(map);
        return R.success("再次下单成功");
    }

    /**
     * 订单明细分页查询
     * @param page
     * @param pageSize
     * @param number
     * @param beginTime
     * @param endTime
     * @return
     */
    @GetMapping("/page")
    public R<Page> page(int page,int pageSize,Long number,String beginTime,String endTime){
        log.info("page = {},pageSize = {},number = {},beginTime = {},endTime = {}",page,pageSize,number,beginTime,endTime);
        return ordersService.pageDetail(page, pageSize, number, beginTime, endTime);

    }

    /**
     * 修改订单状态
     * @param orders
     * @return
     */
    @PutMapping
    public R<String> modifyStatus(@RequestBody Orders orders){
        log.info("orders:{}",orders);
        Orders order = ordersService.getById(orders.getId());
        order.setStatus(orders.getStatus());
        ordersService.updateById(order);
        return R.success("状态修改成功");
    }
}

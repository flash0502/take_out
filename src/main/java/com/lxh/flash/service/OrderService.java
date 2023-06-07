package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.OrderDto;
import com.lxh.flash.entity.Orders;

import java.util.Map;


public interface OrderService extends IService<Orders> {

    /**
     * 用户下单
     * @param orders
     */
    public void submit(Orders orders);

    /**
     * 用户再来一单
     * @param map
     */
    public void again(Map<String,String> map);

    /**
     * 订单信息查询(用户端)
     * @param page
     * @param pageSize
     */
    public R<Page<OrderDto>> page(int page, int pageSize);

    /**
     * 订单明细（管理端）
     * @param page
     * @param pageSize
     * @param number
     * @param beginTime
     * @param endTime
     * @return
     */
    public R<Page> pageDetail(int page,int pageSize,Long number,String beginTime,String endTime);


}

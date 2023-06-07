package com.lxh.flash.dto;



import com.lxh.flash.entity.OrderDetail;
import com.lxh.flash.entity.Orders;
import lombok.Data;

import java.util.List;

@Data
public class OrderDto extends Orders {

    //记录订单的数量
    private Integer sumNum;

    //记录下单用户的名字
    private String consignee;

    //记录订单中具体的菜品
    private List<OrderDetail> orderDetails;
}

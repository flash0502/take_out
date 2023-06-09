package com.lxh.flash.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.lxh.flash.common.BaseContext;
import com.lxh.flash.common.CustomException;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.DishDto;
import com.lxh.flash.dto.OrderDto;
import com.lxh.flash.dto.SetmealDto;
import com.lxh.flash.entity.*;
import com.lxh.flash.mapper.OrderMapper;
import com.lxh.flash.service.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
@Slf4j
public class OrderServiceImpl extends ServiceImpl<OrderMapper, Orders> implements OrderService {


    @Autowired
    private ShoppingCartService shoppingCartService;

    @Autowired
    private UserService userService;

    @Autowired
    private AddressBookService addressBookService;

    @Autowired
    private OrderService ordersService;
    @Autowired
    private OrderDetailService orderDetailService;

    @Autowired
    private DishService dishService;
    @Autowired
    private SetmealService setmealService;

    /**
     * /**
     * 用户下单
     *
     * @param orders
     */
    @Override
    @Transactional
    public void submit(Orders orders) {
        //获得当前用户id
        Long userId = BaseContext.getCurrentId();

        //查询当前用户的购物车数据
        LambdaQueryWrapper<ShoppingCart> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(ShoppingCart::getUserId, userId);
        List<ShoppingCart> shoppingCarts = shoppingCartService.list(wrapper);

        if (shoppingCarts == null || shoppingCarts.size() == 0) {
            throw new CustomException("购物车为空，不能下单");
        }

        //查询用户数据
        User user = userService.getById(userId);

        //查询地址数据
        Long addressBookId = orders.getAddressBookId();
        AddressBook addressBook = addressBookService.getById(addressBookId);
        if (addressBook == null) {
            throw new CustomException("用户地址信息有误，不能下单");
        }

        long orderId = IdWorker.getId();//订单号

        AtomicInteger amount = new AtomicInteger(0);

        List<OrderDetail> orderDetails = shoppingCarts.stream().map((item) -> {
            OrderDetail orderDetail = new OrderDetail();
            orderDetail.setOrderId(orderId);
            orderDetail.setNumber(item.getNumber());
            orderDetail.setDishFlavor(item.getDishFlavor());
            orderDetail.setDishId(item.getDishId());
            orderDetail.setSetmealId(item.getSetmealId());
            orderDetail.setName(item.getName());
            orderDetail.setImage(item.getImage());
            orderDetail.setAmount(item.getAmount());
            amount.addAndGet(item.getAmount().multiply(new BigDecimal(item.getNumber())).intValue());
            return orderDetail;
        }).collect(Collectors.toList());


        orders.setId(orderId);
        orders.setOrderTime(LocalDateTime.now());
        orders.setCheckoutTime(LocalDateTime.now());
        orders.setStatus(2);
        orders.setAmount(new BigDecimal(amount.get()));//总金额
        orders.setUserId(userId);
        orders.setNumber(String.valueOf(orderId));
        orders.setUserName(user.getName());
        orders.setConsignee(addressBook.getConsignee());
        orders.setPhone(addressBook.getPhone());
        orders.setAddress((addressBook.getProvinceName() == null ? "" : addressBook.getProvinceName())
                + (addressBook.getCityName() == null ? "" : addressBook.getCityName())
                + (addressBook.getDistrictName() == null ? "" : addressBook.getDistrictName())
                + (addressBook.getDetail() == null ? "" : addressBook.getDetail()));
        //向订单表插入数据，一条数据
        this.save(orders);

        //向订单明细表插入数据，多条数据
        orderDetailService.saveBatch(orderDetails);

        //清空购物车数据
        shoppingCartService.remove(wrapper);
    }

    /**
     * 用户再次下单
     *
     * @param map
     */
    @Override
    @Transactional
    public void again(Map<String, String> map) {
        String ids = map.get("id");

        long id = Long.parseLong(ids);

        LambdaQueryWrapper<OrderDetail> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(OrderDetail::getOrderId, id);
        //获取该订单对应的所有的订单明细表
        List<OrderDetail> orderDetailList = orderDetailService.list(queryWrapper);

        //通过用户id把原来的购物车给清空，这里的clean方法是视频中讲过的,建议抽取到service中,那么这里就可以直接调用了
        shoppingCartService.clean();

        //获取用户id
        Long userId = BaseContext.getCurrentId();
        List<ShoppingCart> shoppingCartList = orderDetailList.stream().map((item) -> {
            //把从order表中和order_details表中获取到的数据赋值给这个购物车对象
            ShoppingCart shoppingCart = new ShoppingCart();
            shoppingCart.setUserId(userId);
            shoppingCart.setImage(item.getImage());
            Long dishId = item.getDishId();
            Long setmealId = item.getSetmealId();
            if (dishId != null) {
                //如果是菜品那就添加菜品的查询条件
                shoppingCart.setDishId(dishId);
            } else {
                //添加到购物车的是套餐
                shoppingCart.setSetmealId(setmealId);
            }
            shoppingCart.setName(item.getName());
            shoppingCart.setDishFlavor(item.getDishFlavor());
            shoppingCart.setNumber(item.getNumber());
            shoppingCart.setAmount(item.getAmount());
            shoppingCart.setCreateTime(LocalDateTime.now());
            return shoppingCart;
        }).collect(Collectors.toList());

        //把携带数据的购物车批量插入购物车表  这个批量保存的方法要使用熟练！！！
        shoppingCartService.saveBatch(shoppingCartList);

    }

    //订单信息查询(用户端)
    @Transactional
    @Override
    public R<Page<OrderDto>> page(int page, int pageSize) {
        //获取用户id
        Long currentId = BaseContext.getCurrentId();

        //构造分页构造器
        Page<Orders> pageInfo = new Page(page, pageSize);
        Page<OrderDto> dtoPage = new Page<>();

        //构造条件构造器
        LambdaQueryWrapper<Orders> queryWrapper = new LambdaQueryWrapper<>();

        //添加查询条件，根据用户id进行查询
        queryWrapper.eq(Orders::getUserId, currentId);

        //添加排序条件，根据更新时间进行排序
        queryWrapper.orderByDesc(Orders::getCheckoutTime);

        ordersService.page(pageInfo, queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo, dtoPage, "records");
        List<Orders> orders = pageInfo.getRecords();

        List<OrderDto> list = orders.stream().map((item) -> {
            OrderDto ordersDto = new OrderDto();
            //对象拷贝
            BeanUtils.copyProperties(item, ordersDto);
            //构造条件构造器
            LambdaQueryWrapper<OrderDetail> wrapper = new LambdaQueryWrapper<>();
            //订单id
            Long id = item.getId();
            wrapper.eq(OrderDetail::getOrderId, id);
            //根据id查询订单详细表中的数据数量
            List<OrderDetail> orderDetailList = orderDetailService.list(wrapper);
            ordersDto.setSumNum(orderDetailList.size());
            ordersDto.setOrderDetails(orderDetailList);
            return ordersDto;
        }).collect(Collectors.toList());

        dtoPage.setRecords(list);
        return R.success(dtoPage);
    }

    //订单明细（管理端）
    @Transactional
    @Override
    public R<Page> pageDetail(int page, int pageSize, Long number, String beginTime, String endTime) {
        //构造分页构造器
        Page<Orders> pageInfo = new Page(page,pageSize);

        //构造条件构造器
        LambdaQueryWrapper<Orders> queryWrapper = new LambdaQueryWrapper<>();

        //添加过滤条件
        queryWrapper.like(number!=null,Orders::getNumber,number);
        queryWrapper.gt(!StringUtils.isEmpty(beginTime),Orders::getOrderTime,beginTime);
        queryWrapper.lt(!StringUtils.isEmpty(endTime),Orders::getOrderTime,endTime);

        //添加排序条件
        queryWrapper.orderByDesc(Orders::getOrderTime);

        //执行查询
        ordersService.page(pageInfo,queryWrapper);

        return R.success(pageInfo);
    }
}
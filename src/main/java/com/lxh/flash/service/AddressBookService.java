package com.lxh.flash.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.lxh.flash.common.R;
import com.lxh.flash.entity.AddressBook;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;


public interface AddressBookService extends IService<AddressBook> {

    //设置默认地址
    public R<AddressBook> setDefault(@RequestBody AddressBook addressBook);

    //查询默认地址
    public R<AddressBook> getDefault();

    //查询用户的全部地址
    public R<List<AddressBook>> list(AddressBook addressBook);

    //修改地址
    public R<String> update(@RequestBody AddressBook addressBook);

    //删除地址
    public R<String> delete(@RequestParam Long ids);


}

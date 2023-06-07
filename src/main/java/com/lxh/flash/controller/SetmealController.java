package com.lxh.flash.controller;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.lxh.flash.common.R;
import com.lxh.flash.dto.DishDto;
import com.lxh.flash.dto.SetmealDto;
import com.lxh.flash.entity.Setmeal;
import com.lxh.flash.service.SetmealService;
import io.swagger.annotations.Api;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.web.bind.annotation.*;

import java.util.List;


//套餐管理
@RestController
@RequestMapping("/setmeal")
@Slf4j
@Api(tags = "套餐相关接口")
public class SetmealController {
    @Autowired
    private SetmealService setmealService;

    //新增套餐
    @PostMapping
    public R<String> save(@RequestBody SetmealDto setmealDto) {
        log.info("套餐信息：{}", setmealDto);

        setmealService.saveWithDish(setmealDto);

        return R.success("新增套餐成功");
    }

    //    套餐信息分页查询
    @GetMapping("/page")
    public R<Page> page(int page, int pageSize, String name) {
        return setmealService.page(page,pageSize,name);
    }

    //删除套餐
    @DeleteMapping
    public R<String> delete(@RequestParam List<Long> ids) {
        log.info("ids: {}", ids);

        setmealService.removeWithDish(ids);
        return R.success("套餐数据删除成功");
    }

    //修改或批量修改套餐的停售启售状态
    @PostMapping("status/{stu}")
    public R<String> modify(@PathVariable Integer stu, @RequestParam("ids") List<Long> list) {
        for (Long ids : list) {
            Setmeal setmeal = setmealService.getById(ids);
            setmeal.setStatus(stu);
            setmealService.updateById(setmeal);
        }
        return R.success("套餐状态修改成功");
    }

    //根据id查询对应的套餐信息
    @GetMapping("/{id}")
    public R<SetmealDto> get(@PathVariable Long id) {
        SetmealDto setmealDto = setmealService.getByIdWithDish(id);
        return R.success(setmealDto);
    }


    //修改套餐内容
    @PutMapping
    public R<String> update(@RequestBody SetmealDto setmealDto) {
        log.info(setmealDto.toString());
        setmealService.updateWithDish(setmealDto);
        return R.success("套餐修改成功");
    }


    //用户端页面显示套餐
    @GetMapping("/list")
    @Cacheable(value = "setmealCache", key = "#setmeal.categoryId + '_' + #setmeal.status")
    public R<List<Setmeal>> list(Setmeal setmeal) {
        R<List<Setmeal>> result = setmealService.list(setmeal);
        return R.success(result.getData());
    }

    //页面回显套餐数据
    @GetMapping("/dish/{id}")
    public R<List<DishDto>> echo(@PathVariable Long id) {
        R<List<DishDto>> result = setmealService.echo(id);
        return R.success(result.getData());

    }

}

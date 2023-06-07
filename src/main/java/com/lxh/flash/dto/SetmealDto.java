package com.lxh.flash.dto;


import com.lxh.flash.entity.Setmeal;
import com.lxh.flash.entity.SetmealDish;
import lombok.Data;
import java.util.List;

@Data
public class SetmealDto extends Setmeal {

    private List<SetmealDish> setmealDishes;

    private String categoryName;
}

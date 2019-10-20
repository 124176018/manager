package com.aishang.manager.dao;

import java.util.List;

import com.aishang.manager.po.ProductImage;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ProductImageExtMapper {
    //添加图片
    public void addProductimage(ProductImage productImage);


}

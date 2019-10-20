package com.aishang.manager.dao;

import com.aishang.manager.po.*;

import com.aishang.manager.util.PageBenForProduct;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProductMapper {
    List<Product> findAllProduct(PageBenForProduct pageBenForProduct);

    Integer findAllCount(PageBenForProduct pageBenForCate);

    List<Category> findCateone();

    List<CategorySecond> findCatetwo(Integer cid);

    List<Category> findCate(Integer cid);

    void aps(ProductImageExt productImageExt);

    public CategorySecond findtwocsid(String csname);

    public Integer deleproduct(PageBenForProduct pageBenForProduct);

    public Integer deleproductimage(PageBenForProduct pageBenForProduct);

    public List<ProductImage> selectImageByPid(PageBenForProduct pageBenForProduct);

    public Product findimage(PageBenForProduct pageBenForProduct);

    public List<CategorySecond> findallseconds();

    void changeproduct(ProductImageExt productImageExt);

    public ProductExt getAllProduct(PageBenForProduct pageBenForProduct);


}


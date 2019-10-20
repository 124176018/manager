package com.aishang.manager.service;

import com.aishang.manager.po.*;
import com.aishang.manager.util.PageBenForProduct;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;


public interface IProductService {
    List<Product> findAllProduct(PageBenForProduct pageBenForProduct);

    List<Category> findCateone();

    List<CategorySecond> findCatetwo(Integer cid);

    List<Category> findCate(Integer cid);

    public boolean aps(MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct, MultipartFile filename);

    public void addProductimage(ProductImage productImage);

    public CategorySecond findtwocsid(String csname);

    public Integer deleproduct(PageBenForProduct pageBenForProduct, ProductImageExt productImageExt);

    public List<ProductImage> selectImageByPid(PageBenForProduct pageBenForProduct);

    public int delImage1(PageBenForProduct pageBenForProduct, String path);

    public int delImage(PageBenForProduct pageBenForProduct);

    public List<CategorySecond> findallseconds();

    public void changeproduct(MultipartFile filename, MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct);

    public File newfolder(PageBenForProduct pageBenForProduct);

    public ProductExt getAllProduct(PageBenForProduct pageBenForProduct);


}

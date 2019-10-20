package com.aishang.manager.po;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public class ProductImageExt extends Product {
    private ProductImage productImage;
    private Category category;

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public List<ProductImage> getProductImageList() {
        return productImageList;
    }

    public void setProductImageList(List<ProductImage> productImageList) {
        this.productImageList = productImageList;
    }

    private List<ProductImage> productImageList;


    public ProductImage getProductImage() {
        return productImage;
    }

    public void setProductImage(ProductImage productImage) {
        this.productImage = productImage;
    }


}

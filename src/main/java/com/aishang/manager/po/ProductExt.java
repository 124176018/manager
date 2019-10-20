package com.aishang.manager.po;

public class ProductExt extends Product {
    private CategoryExt categories;

    public CategoryExt getCategories() {
        return categories;
    }

    public void setCategories(CategoryExt categories) {
        this.categories = categories;
    }
}

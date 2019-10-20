package com.aishang.manager.po;

import java.util.List;

public class CategoryExt extends Category {

    private List<CategorySecond> categorysSeconds;

    public List<CategorySecond> getCategorysSeconds() {
        return categorysSeconds;
    }

    public void setCategorysSeconds(List<CategorySecond> categorysSeconds) {
        this.categorysSeconds = categorysSeconds;
    }
}

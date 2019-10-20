package com.aishang.manager.util;

import java.util.List;

public class PageBen<T> {
    private List<T> list;
    private Integer pageNow = 1;
    private Integer pageSize = 10;
    private Integer pageCount;
    private Integer totalCount;


    public Integer getPageNow() {
        return pageNow;
    }

    public void setPageNow(Integer pageNow) {
        this.pageNow = pageNow;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public List<T> getList() {
        return list;
    }

    public void setList(List<T> list) {
        this.list = list;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getPageCount() {
        return pageCount;
    }

    public Integer getTotalCount() {
        return totalCount;
    }

    public void setTotalCount(Integer totalCount) {
        this.totalCount = totalCount;
        /*计算pageCount*/
        if (totalCount % pageSize == 0) {
            pageCount = totalCount / pageSize;
        } else {
            pageCount = totalCount / pageSize + 1;
        }
        /*计算pageNow*/
        if (pageNow > pageCount) {
            pageNow = pageCount;
        }
        if (pageNow <= 0) {
            pageNow = 1;
        }
    }

    public Integer getStartIndex() {

        return (getPageNow() - 1) * pageSize > 0 ? (getPageNow() - 1) * pageSize : 0;
    }


}

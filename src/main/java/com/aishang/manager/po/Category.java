package com.aishang.manager.po;

public class Category {
    private Integer cid;
    private String cname;
    private Integer cstate;

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public String getCname() {
        return cname;
    }

    public void setCnname(String cnname) {
        this.cname = cnname;
    }

    public Integer getCstate() {
        return cstate;
    }

    public void setCstate(Integer cstate) {
        this.cstate = cstate;
    }

    @Override
    public String toString() {
        return "Category{" +
                "cid=" + cid +
                ", cnname='" + cname + '\'' +
                ", cstate=" + cstate +
                '}';
    }
}
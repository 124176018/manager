package com.aishang.manager.po;

public class CategorySecond {
    private Integer csid;
    private String csname;
    private Integer cid;
    private Integer csstate;

    public Integer getCsid() {
        return csid;
    }

    public void setCsid(Integer csid) {
        this.csid = csid;
    }

    public String getCsname() {
        return csname;
    }

    public void setCsname(String csname) {
        this.csname = csname;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getCsstate() {
        return csstate;
    }

    public void setCsstate(Integer csstate) {
        this.csstate = csstate;
    }

    @Override
    public String toString() {
        return "CategorySecond{" +
                "csid=" + csid +
                ", csname='" + csname + '\'' +
                ", cid=" + cid +
                ", csstate=" + csstate +
                '}';
    }
}

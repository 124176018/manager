package com.aishang.manager.util;

public class PageBenForProduct<T> extends PageBen<T> {
    private Integer csid;
    private Integer cid;
    private Integer pid;
    private String pname;
    private String csname;

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

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getPname() {
        return pname;
    }

    public void setPname(String pname) {
        this.pname = pname;
    }

    public Integer getCsid() {
        return csid;
    }

    public void setCsid(Integer csid) {
        this.csid = csid;
    }

    @Override
    public String toString() {
        return "PageBenForProduct{" +
                "csid=" + csid +
                ", cid=" + cid +
                ", pid=" + pid +
                ", pname='" + pname + '\'' +
                ", csname='" + csname + '\'' +
                '}';
    }
}

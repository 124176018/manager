package com.aishang.manager.controller;

import com.aishang.manager.dao.ProductMapper;
import com.aishang.manager.po.*;
import com.aishang.manager.service.IProductService;
import com.aishang.manager.util.PageBenForProduct;
import com.aishang.manager.util.publictool;
import net.sf.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

@RequestMapping("/product")
@Controller
public class ProductController {

    @Resource
    private IProductService iProductService;
    @Resource
    private HttpSession session;
    @Resource
    private ServletContext application;
    @Resource
    private HttpServletRequest request;


    @RequestMapping("getproduct")
    public String getproduct(PageBenForProduct pageBenForProduct, Model model) {
        List<Product> productList = iProductService.findAllProduct(pageBenForProduct);
        pageBenForProduct.setList(productList);
        List<Category> onecate = iProductService.findCateone();
        List<CategorySecond> findallsecondsmap = iProductService.findallseconds();
        model.addAttribute("findallsecondsmap", findallsecondsmap);
        model.addAttribute("allProduct", pageBenForProduct);
        model.addAttribute("onecate", onecate);
        return "product";
    }


    /*返回一级类目的查询结果*/
    @RequestMapping("getaddproduct")
    public String getaddproduct(Model model) {
        List<Category> cateone = iProductService.findCateone();
        model.addAttribute("cateone", cateone);
        return "addProduct";
    }

    /*通过一级类目的ID返回二级类目的结果JSON*/
    @RequestMapping(value = "/doaddproduct", produces = {"text/html;charset=utf-8"})
    @ResponseBody
    public String doaddproduct(Integer cid) {
        List<CategorySecond> catetwo = iProductService.findCatetwo(cid);
        return JSONArray.fromObject(catetwo).toString();
    }

    @RequestMapping("addProductImage")
    public String addProductImage(@RequestParam("files") MultipartFile[] files, PageBenForProduct pageBenForProduct, ProductImageExt productImageExt, MultipartFile filename) {
        /*后端添加商品校验*/
        boolean flag = true;
        if (files.length == 0) {
            flag = false;
        }
        if (productImageExt.getPname() == "" || productImageExt.getPname() == null) {
            flag = false;
        }
        if (pageBenForProduct.getCid() == 0) {
            flag = false;
        }

        if (productImageExt.getPdesc() == "" || productImageExt.getPdesc() == null) {
            flag = false;
        }
        if (productImageExt.getMarket_price() == null) {
            flag = false;
        }
        if (productImageExt.getShop_price() == null) {
            flag = false;
        }
        if (flag == false) {
            return "redirect:/product/getaddproduct";
        }

        iProductService.aps(files, productImageExt, pageBenForProduct, filename);
        return "redirect:/product/getproduct";
    }


    /*调用删除方法对商品进行删除操作*/
    @RequestMapping("deproduct")
    public void deproduct(PageBenForProduct pageBenForProduct, HttpServletResponse response, ProductImageExt productImageExt) throws IOException {
        PrintWriter out = response.getWriter();
        if (pageBenForProduct.getPid() != null) {
            List<ProductImage> productImages = iProductService.selectImageByPid(pageBenForProduct);
            productImageExt.setProductImageList(productImages);
            Integer deleproduct = iProductService.deleproduct(pageBenForProduct, productImageExt);
            if (deleproduct == 1) {
                out.print("yes");

            } else {
                out.print("no");
            }
            out.close();
        }

    }

    /*调用相关方法为修改页面进行信息回显操作*/
    @RequestMapping("uproduct")
    public String uproduct(PageBenForProduct pageBenForProduct, Model model) {
        List<Category> cateone = iProductService.findCateone();
        model.addAttribute("cateone", cateone);
        ProductExt product = iProductService.getAllProduct(pageBenForProduct);
        List<ProductImage> imageList = iProductService.selectImageByPid(pageBenForProduct);
        model.addAttribute("imageList", imageList);
        model.addAttribute("product", product);
        return "updateProduct";
    }

    /*接收用户所填写的修改的信息对商品的相关信息进行修改操作*/
    @RequestMapping("uuproduct")
    public String uuproduct(MultipartFile filename, MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct) {
        String stringdate = publictool.getStringdate();
        productImageExt.setPdate(stringdate);
        iProductService.changeproduct(filename, files, productImageExt, pageBenForProduct);
        return "redirect:/product/getproduct";
    }

    /*修改商品图片移除功能*/
    @RequestMapping("ajaxdelimage")
    public void ajaxdelimage(HttpServletResponse response, PageBenForProduct pageBenForProduct) throws IOException {
        int a = iProductService.delImage(pageBenForProduct);
        List<ProductImage> productImageList = iProductService.selectImageByPid(pageBenForProduct);
        int i = 0;
        for (ProductImage pis : productImageList) {
            i = iProductService.delImage1(pageBenForProduct, pis.getImage());
        }
        response.getWriter().print("yes");
    }
}

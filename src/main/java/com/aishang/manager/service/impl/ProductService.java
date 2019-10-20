package com.aishang.manager.service.impl;

import com.aishang.manager.dao.ProductImageExtMapper;
import com.aishang.manager.dao.ProductMapper;
import com.aishang.manager.po.*;
import com.aishang.manager.service.IProductService;

import com.aishang.manager.util.PageBenForProduct;
import com.aishang.manager.util.publictool;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;


@Service
public class ProductService implements IProductService {
    @Resource
    private ProductMapper productMapper;
    @Resource
    private ProductImageExtMapper productImageExtMapper;
    @Resource
    private ServletContext application;
    @Resource
    private IProductService iProductService;


    @Override
    public List<Product> findAllProduct(PageBenForProduct pageBenForProduct) {
        Integer allCount = productMapper.findAllCount(pageBenForProduct);
        pageBenForProduct.setTotalCount(allCount);
        return productMapper.findAllProduct(pageBenForProduct);
    }

    @Override
    public List<Category> findCateone() {
        return productMapper.findCateone();
    }

    @Override
    public List<CategorySecond> findCatetwo(Integer cid) {
        return productMapper.findCatetwo(cid);
    }

    @Override
    public List<Category> findCate(Integer cid) {
        return productMapper.findCate(cid);
    }

    /*添加商品和商品图片的方法*/
    @Override
    @Transactional
    public boolean aps(MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct, MultipartFile filename) {
        CategorySecond findtwocsid = productMapper.findtwocsid(pageBenForProduct.getCsname());
        productImageExt.setCsid(findtwocsid.getCsid());
        String stringdate = publictool.getStringdate();
        productImageExt.setPdate(stringdate);
        /*调用修改上传缩略图的方法*/
        changeaddimage(productImageExt, filename);
        productMapper.aps(productImageExt);
        /*拿到刚才添加商品的PID
         * 调用修改图片表的增加图片的方法*/
        Integer pid = productImageExt.getPid();
        pageBenForProduct.setPid(pid);
        changeproductimage(files, productImageExt, pageBenForProduct);

        return true;
    }


    @Override
    public void addProductimage(ProductImage productImage) {
        productImageExtMapper.addProductimage(productImage);
    }

    @Override
    public CategorySecond findtwocsid(String csname) {
        return iProductService.findtwocsid(csname);
    }

    @Override
    @Transactional
    /*通过商品的id删除商品列表里的商品*/
    public Integer deleproduct(PageBenForProduct pageBenForProduct, ProductImageExt productImageExt) {
        /*拿到商品图片表里的集合然后调用删除方法删除图片表本地和数据库的本商品的信息*/
        List<ProductImage> productImageList = productImageExt.getProductImageList();
        for (ProductImage productImages : productImageList) {
            delImage1(pageBenForProduct, productImages.getImage());
        }
        /*断点*/
        delImage(pageBenForProduct);
        return productMapper.deleproduct(pageBenForProduct);
    }

    @Override
    /*删除数据库商品图片表里的图片和本地*/
    public int delImage1(PageBenForProduct pageBenForProduct, String path) {
        Integer i = productMapper.deleproductimage(pageBenForProduct);
        /*通过传来的文件路径*/
        File file = new File(path);
        if (file.exists()) {
            file.delete();
        }
        return i;
    }

    /*删除数据库商品表里的本地图片*/
    @Override
    public int delImage(PageBenForProduct pageBenForProduct) {
        Product findimage = productMapper.getAllProduct(pageBenForProduct);
        File file = new File(findimage.getPstate());
        if (file.exists()) {
            file.delete();
        }
        return 0;
    }

    @Override
    public List<ProductImage> selectImageByPid(PageBenForProduct pageBenForProduct) {
        return productMapper.selectImageByPid(pageBenForProduct);
    }

    @Override
    /*查询所有二级类目用于复合查询回显*/
    public List<CategorySecond> findallseconds() {
        return productMapper.findallseconds();
    }


    @Override
    @Transactional
    public void changeproduct(MultipartFile filename, MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct) {
        if (files != null && filename != null && pageBenForProduct.getPid() != null && pageBenForProduct.getCsname() != null) {
            CategorySecond findtwocsid = productMapper.findtwocsid(pageBenForProduct.getCsname());
            productImageExt.setCsid(findtwocsid.getCsid());
            /*修改商品表里的图片*/
            changeaddimage(productImageExt, filename);
            Integer pid = productImageExt.getPid();
            pageBenForProduct.setPid(pid);

            System.out.println(productImageExt + "你好，有吗");
            System.out.println(pageBenForProduct + "有啥");
            changeproductimage(files, productImageExt, pageBenForProduct);
            productMapper.changeproduct(productImageExt);
        }


    }

    public void changeproductimage(MultipartFile[] files, ProductImageExt productImageExt, PageBenForProduct pageBenForProduct) {

        if (files != null && pageBenForProduct.getPid() != null && pageBenForProduct.getCsname() != null) {
            /*调用创建文件夹的方法*/
            File newfolder = newfolder(pageBenForProduct);
            for (MultipartFile file : files) {

                /*路径+时间+正常上传的名字*/
                String fileimagename = newfolder + "/" + new Date().getTime() + file.getOriginalFilename();
                String fileimagename1 = fileimagename.substring(42);
                /*把文件上传到path的路径，文件名改为当前时间+加上原来的文件名扩展名*/
                File localFile = new File(newfolder + "/" + new Date().getTime() + file.getOriginalFilename());

                /*创建productImage对象把图片放入这个对象里*/
                ProductImage productImage = new ProductImage();
                productImage.setImage(fileimagename);
                productImage.setThumbnail(fileimagename1);
                productImageExt.setProductImage(productImage);
                /*执行上传*/
                try {
                    file.transferTo(localFile);
                } catch (IOException e) {
                    e.printStackTrace();
                }
                //写入图片
                ProductImage productImages = productImageExt.getProductImage();
                productImages.setPid(pageBenForProduct.getPid());
                productImageExtMapper.addProductimage(productImages);
            }
        }

    }


    /*修改上传商品缩略图方法*/
    public void changeaddimage(ProductImageExt productImageExt, MultipartFile filename) {
        if (filename != null) {
            String realPath = application.getRealPath("upload");
            File save2 = new File(realPath);
            /*如果文件夹不存在，创建新的文件夹*/
            if (!save2.exists()) {
                save2.mkdirs();
            }
            save2 = new File(realPath + "/" + "缩略图");
            if (!save2.exists()) {
                save2.mkdirs();
            }
            String ff = save2 + "/" + new Date().getTime() + filename.getOriginalFilename();
            String fx = ff.substring(42);
            productImageExt.setPimage(fx);
            productImageExt.setPstate(ff);
            File localFilexiaotu = new File(save2 + "/" + new Date().getTime() + filename.getOriginalFilename());
            try {
                filename.transferTo(localFilexiaotu);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

    }


    public File newfolder(PageBenForProduct pageBenForProduct) {
        /*设置文件路径*/
        String realPath = application.getRealPath("upload");
        File save = new File(realPath);

        /*如果文件夹不存在，创建新的文件夹*/
        if (!save.exists()) {
            save.mkdirs();
        }
        List<Category> cateone = iProductService.findCate(pageBenForProduct.getCid());
        for (Category o : cateone) {
            save = new File(realPath + "/" + o.getCname());
            List<CategorySecond> catetwo = iProductService.findCatetwo(pageBenForProduct.getCid());
            for (CategorySecond t : catetwo) {
                save = new File(realPath + "/" + o.getCname() + "/" + pageBenForProduct.getCsname());
                if (!save.exists()) {
                    save.mkdirs();
                }
            }
            if (!save.exists()) {
                save.mkdirs();
            }

        }
        return save;
    }

    @Override
    public ProductExt getAllProduct(PageBenForProduct pageBenForProduct) {
        return productMapper.getAllProduct(pageBenForProduct);
    }

    ;


}


function checked(form) {
    var pname = form.pname;
    var cid = form.cid;
    var market_price = form.market_price;
    var shop_price = form.shop_price;
    var addFlie = form.addFlie;

    if (username.value == "") {
        alert("商品名称不能为空");
        return false;
    } else if (cid.value = 0) {
        alert("一级类目不能为空");
        return false;
    } else if (market_price.value == "") {
        alert("价格不能为空");
        return false;
    } else if (shop_price.value == "") {
        alert("价格不能为空");
        return false;
    } else if (addFlie.length = 0) {
        alert("图片不能为空");
        return false;
    }
    ;
}
/**
 * Created by LiuQi on 2017/7/13.
 */
//从数据库中将某位医生删除
function ItemDele(id) {
    layui.use('layer', function(){
        var layer = layui.layer;
        //删除前确认一下
        var index = layer.confirm(
            '您确定要删除吗？',
            {title: "温馨提示",
                //设置弹框的位置
                offset: '100px',
                area: ['240px', '160px'],
                icon: 3},
            function(index){
                $.ajax({
                    url: "delete.do",
                    type: "POST",
                    data: {
                        id : id
                    },
                    dataType: "json",
                    success: function(data) {
                        if(data.msg == "1") {
                            layer.msg('删除成功',{
                                offset: '160px',
                                time: 1500
                            });
                            //删除成功后刷新当前页面
                            setTimeout(function() {
                                location.reload();
                            }, 1500);
                        }else if(data.msg == "2"){
                            layer.msg("删除失败", {
                                offset: "160px",
                                time: 1500
                            });
                        } else {
                            layer.msg("参数有误", {
                                offset: "160px",
                                time: 1500
                            });
                        }
                    },
                    error: function(er) {
                        console.log(er);
                    }
                });
                layer.close(index);
            });
    })
}

//对某位用户的信息进行编辑
function ItemEdit(id) {
    var user;
    $.ajax({
        url: "acquire.do",
        type: "POST",
        data: {id : id},
        dataType: "json",
        async: false,
        success: function(data) {
            user = data.user;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use(['layer','form', 'element'], function() {
        var layer = layui.layer;
        var form = layui.form();
        var element = layui.element();
        //对ajax获取的返回值进行简单判断
        if(user.userName == "paramIsError") {
            layer.msg("获取信息失败",{
                time:1000
            });
            return;
        }
        layer.open({
            type: 1,
            title: "基本信息修改",
            skin: 'layui-layer-rim',
            area: ['480px', '600px'],
            content:$("#edit_user"),
            btn:['提交', '取消'],
            yes: function(index, layero) {
                $("#touimg_edit_").val(tou_img_edit_path);
                $.ajax({
                    url: "update.do",
                    type: "POST",
                    data: $("#edit_user_form").serializeArray(),
                    dataType: "json",
                    success: function(data) {
                        if(data.msg == "success") {
                            layer.msg("更新成功", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        } else if(data.msg() == "error") {
                            layer.msg("更新失败", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        }
                    },
                    error: function(er) {
                        console.log(er);
                    }
                });
            },
            btn2: function(index, layero) {
                layer.close(index);
            }

        });
        /*通过数据库中获取的数据动态确定radio选项*/
        $("input[name=sex][value='"+user.sex+"']").attr("checked", true);
        $("#edit_status option[value='"+user.status+"']").attr("selected", 'selected');
        $("#edit_userName").val(user.userName);
        $("#edit_name").val(user.name);
        $("#edit_sfzNum").val(user.sfzNum);
        $("#edit_address").val(user.address);
        $("#edit_id").val(id);
        $("#edit_birthday").val(new Date(user.birthday).format('yyyy-MM-dd'));
        form.render();
    });
}

/*修改时间的格式*/
Date.prototype.format = function(format) {
    var date = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S+": this.getMilliseconds()
    };
    if (/(y+)/i.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
    }
    for (var k in date) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1
                ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
        }
    }
    return format;
}

/**
 * 编辑时上传头像照片
 */
var tou_img_edit_path;
function uploadTouImgEdit() {
    var formData = new FormData();
    formData.append('file',$("#touimg_edit")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#touimg_edit")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    tou_img_edit_path = data.txt;
                    layer.msg("上传成功", {
                        time: 1000,
                        offset: "160px"
                    })
                }else {
                    layer.msg("上传失败", {
                        time: 1000,
                        offset: "160px"
                    })
                }
            });
        },
        error:function(er){
            console.log(er);
        }
    });
}

//显示某位医生的详细信息
function ItemDetail(id) {
    var user;
    $.ajax({
        url: "acquire.do",
        type: "POST",
        data: {id: id},
        dataType: "json",
        async: false,
        success: function(data) {
            user = data.user;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use("layer", function() {
        var layer = layui.layer;
        if(user.userName == "paramIsError") {
            layer.msg("获取信息失败", {
                time: 1000
            });
            return;
        }
        layer.open({
            type: 1,
            title: "基本信息",
            offset: '120px',
            skin: 'layui-layer-rim',
            area: ['460px', '480px'],
            content: $("#detail_info")
        });
        var user_table = document.getElementById("user_table");
        user_table.rows[0].cells[1].innerHTML = user.userName;
        user_table.rows[1].cells[1].innerHTML = user.name;
        user_table.rows[2].cells[1].innerHTML = user.sex;
        if(user.status == "1") {
            user_table.rows[3].cells[1].innerHTML = "可用";
        } else if(user.status == "2") {
            user_table.rows[3].cells[1].innerHTML = "不可用";
        }
        user_table.rows[4].cells[1].innerHTML = user.sfzNum;
        user_table.rows[5].cells[1].innerHTML = user.birthday != null ? new Date(user.birthday).format("yyyy-MM-dd") : "";
        user_table.rows[6].cells[1].innerHTML = user.createTime != null ? new Date(user.createTime).format("yyyy-MM-dd hh:mm:ss") : "";
        user_table.rows[7].cells[1].innerHTML = user.modifyTime != null ? new Date(user.modifyTime).format("yyyy-MM-dd hh:mm:ss") : "";
        user_table.rows[8].cells[1].innerHTML = user.address;
        $("#user_touImg").attr("src", $("#user_touImg")[0].title + user.touImg);
    })
}

/*添加用户*/
function addUser() {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "新增用户",
            area: ["480px", "600px"],
            content: $("#add_user"),
            btn: ["增加", "取消"],
            yes: function(index, layero) {
                //确定当前选定的医院
                $("#touimg_id_").val(tou_img_path);
                $.ajax({
                    url: "add.do",
                    type: "POST",
                    data: $("#add_user_form").serializeArray(),
                    dataType: "json",
                    success: function(data) {
                        if(data.msg == "success") {
                            layer.msg("添加成功", {
                                time: 1000
                            });
                        } else if(data.msg == "error") {
                            layer.msg("添加失败", {
                                time: 1000
                            });
                        }
                        setTimeout(function() {
                            location.reload();
                        }, 1000)
                    },
                    error: function(er) {
                        console.log(er);
                    }
                });
            },
            btn2: function(index, layero) {
                layer.close(index);
            }
        });
        form.render();
    });
}
/**
 * 上传头像照片
 */
var tou_img_path;
function uploadTouImg() {
    var formData = new FormData();
    formData.append('file',$("#touimg_id")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#touimg_id")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    tou_img_path = data.txt;
                    layer.msg("上传成功", {
                        time: 1000,
                        offset: "160px"
                    })
                }else {
                    layer.msg("上传失败", {
                        time: 1000,
                        offset: "160px"
                    })
                }
            });
        },
        error:function(er){
            console.log(er);
        }
    });
}

/**
 * 显示年月日
 */
layui.use('laydate', function(){
    var laydate = layui.laydate;
    var start = {
        max: laydate.now()
        ,istoday: false
        ,choose: function(datas){
            end.min = datas; //开始日选好后，重置结束日的最小日期
            end.start = datas; //将结束日的初始值设定为开始日
        }
    };

    var end = {
        max: laydate.now()
        ,istoday: false
        ,choose: function(datas){
            start.max = datas; //结束日选好后，重置开始日的最大日期
        }
    };

    document.getElementById('createtime_range_start').onclick = function(){
        start.elem = this;
        laydate(start);
    };
    document.getElementById('createtime_range_end').onclick = function(){
        end.elem = this;
        laydate(end);
    }
});

function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}

/*导出Excel表格*/
function exportExcel() {
    $(document).ready(function() {
        var temp_form = document.createElement("form");
        temp_form.action = getRootPath() + "/exportexcel.do";
        temp_form.method = "post";
        temp_form.style.display = "none";
        document.body.appendChild(temp_form);
        temp_form.submit();
    })
}

/*导入Excel表格中的数据*/
function importExcel() {
    $(document).ready(function() {
        if($("#selectedExcelFile")[0].files[0] == undefined) {
            layui.use('layer', function() {
                var layer = layui.layer;
                layer.msg('请选择文件', {
                    time: 1000,
                    offset: '160px'
                })
            })
            return;
        }
        if($("#selectedExcelFile").val().lastIndexOf(".xls") < 0) {
            layui.use('layer', function() {
                var layer = layui.layer;
                layer.msg('只能上传Excel文件', {
                    time: 1000,
                    offset: '160px'
                })
                setTimeout(function() {
                    location.reload();
                }, 1000)
            })
            return;
        }
        var formData = new FormData();
        formData.append("excelFile", $("#selectedExcelFile")[0].files[0]);
        $.ajax({
            type: "post",
            url: "excelImport.do",
            async: false,
            contentType: false,    //这个一定要写
            processData: false, //这个也一定要写，不然会报错
            data:formData,
            dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
            success:function(data){
                layui.use('layer', function() {
                    var layer = layui.layer;
                    layer.msg(data.msg, {
                        time: 1000,
                        offset: '160px'
                    })
                    setTimeout(function(){
                        location.reload();
                    }, 1000)
                });
            },
            error:function(er){
                console.log(er);
            }
        });
    })
}

/*var temp_form = document.createElement("form");
 temp_form.action = getRootPath() + "/exportexcel.do";
 temp_form.method = "post";
 temp_form.style.display = "none";
 document.body.appendChild(temp_form);
 temp_form.submit();*/

function getRoot(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    return(localhostPaht);
}

layui.use(['layer', 'laypage'], function() {
    var layer = layui.layer;
    var laypage = layui.laypage;
    $(document).ready(function() {
        laypage({
            first: 1,
            last: $("#totalPage").val(),
            cont: $("#page"),
            pages: $("#totalPage").val(),
            curr: $("#pageNo").val(),
            groups: 5,
            skip: true,
            jump: function(obj, first) {
                var pageNum = obj.curr;
                var url;
                if($("#query_flag").val() === "true") {
                    url = getRoot() + "/user/query.do?userName=" + $("#userName_").val() + "&name=" + $("#name").val() + "&status=" + $("#status").val() + "&createTimeStart=" + $("#createTimeStart").val() + "&createTimeEnd=" + $("#createTimeEnd").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/user/list.do?pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})

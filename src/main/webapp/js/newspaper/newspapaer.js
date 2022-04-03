/**
 * Created by LiuQi on 2017/7/31.
 */
/*增加新闻*/
function addNewspaper(){
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "增加广告",
            skin: 'layui-layer-rim', //加上边框
            area: ["480px", "520px"],
            content: $("#add_newspaper"),
            btn: ['增加', '取消'],
            yes: function (index, layero) {
                $("#imgUrl_add_").val(newspaperImg_path);
                $.ajax({
                    url: "add.do",
                    type: "POST",
                    data: $("#add_newspaper_form").serializeArray(),
                    dataType: "json",
                    success: function (data) {
                        if (data.msg == "success") {
                            layer.msg("新增成功", {
                                time: 1000
                            });
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        } else if (data.msg == "error") {
                            layer.msg("新增失败", {
                                time: 100
                            });
                            setTimeout(function () {
                                location.reload();
                            }, 1000);
                        }
                    },
                    error: function (er) {
                        console.log(er);
                    }
                });
            },
            btn2: function (index, layero) {
                layer.close(index);
            }
        });
        form.render();
    });
}

/*上传广告主图*/
var newspaperImg_path;
function uploadPic() {
    var formData = new FormData();
    formData.append('file',$("#imgUrl_add")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#imgUrl_add")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    newspaperImg_path = data.txt;
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

/*删除广告*/
function ItemDele(id) {
    layui.use('layer', function() {
        var layer = layui.layer;
        layer.confirm('您确定要删除吗？',{
            title: '提示',
            icon: 3,
            offset: '100px',
            area: ['240px', '160px']
        }, function(index) {
            $.ajax({
                url: "delete.do",
                type: "POST",
                data: {
                    id: id
                },
                dataType: "json",
                success: function(data) {
                    if(data.msg == "1") {
                        layer.msg('删除成功',{
                            time: 1000,
                            offset: '160px'
                        });
                        setTimeout(function() {
                            location.reload();
                        }, 1000);
                    }
                    else if(data.msg == "2") {
                        layer.msg('删除失败',{
                            offset: '160px',
                            time: 1000
                        });
                    } else if(data.msg == "3") {
                        layer.msg('参数有误',{
                            offset: '160px',
                            time: 1000
                        });
                    }

                },
                error: function(er) {
                    console.log(er);
                }
            });
            layer.close(index);
        })
    })
}

/*编辑广告*/
function ItemEdit(id) {
    var newspaper;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            newspaper = data.newspaper;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        if(newspaper.title == "paramIsError") {
            layer.msg('获取信息失败', {
                time: 1000,
                offset: '160px',
            });
            return;
        }
        layer.open({
            type: 1,
            title: '广告编辑',
            area: ['480px', '520px'],
            skin: "layui-layer-rim",
            content: $("#edit_newspaper"),
            btn: ['提交', '取消'],
            yes: function(index, layero) {
                $("#imgUrl_edit_").val(newspaperImg_edit_path);
                $.ajax({
                    url: "update.do",
                    type: "POST",
                    data: $("#edit_newspaper_form").serializeArray(),
                    dataType: "json",
                    success: function(data) {
                        if(data.msg == "success") {
                            layer.msg("更新成功", {
                                time: 1000,
                                offset: '160px'
                            });
                            setTimeout(function() {
                                location.reload();
                            }, 1000);
                        }else if(data.msg == "error") {
                            layer.msg("更新失败", {
                                time: 1000,
                                offset: '160px'
                            });
                            setTimeout(function() {
                                location.reload();
                            }, 1000);
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
        $("#title_edit").val(newspaper.title);
        $("#contentUrl_edit").val(newspaper.contentUrl);
        $("#type_edit option[value='"+newspaper.type+"']").attr("selected", 'selected');
        $("#status_edit option[value='"+newspaper.status+"']").attr("selected", 'selected');
        $("#descInfo_edit").val(newspaper.descInfo);
        $("#id_edit").val(newspaper.id);
        form.render();
    })
}
/*编辑时上传图片*/
var newspaperImg_edit_path;
function uploadPicEdit() {
    var formData = new FormData();
    formData.append('file',$("#imgUrl_edit")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#imgUrl_edit")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    newspaperImg_edit_path = data.txt;
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

/*显示详情*/
function ItemDetail(id){
    var newspaper;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            newspaper = data.newspaper;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use('layer', function() {
        var layer = layui.layer;
        if(newspaper.title == "paramIsError") {
            layer.msg('获取信息失败', {
                time: 1000,
                offset: '160px',
            });
            return;
        }
        layer.open({
            type: 1,
            title: "详细信息",
            skin: 'layui-layer-rim',
            area: ['600px', '580px'],
            content: $("#detail_newspaper")
        });
        var newspaper_table = document.getElementById("detail_newspaper_table");
        newspaper_table.rows[0].cells[1].innerHTML = newspaper.title;
        var newspaper_type;
        if(newspaper.type == "0") {
            newspaper_type = "客户端广告";
        }else if(newspaper.type == "1") {
            newspaper_type = "医生端广告";
        }else if(newspaper.type == "2") {
            newspaper_type = "护士端广告";
        }
        newspaper_table.rows[1].cells[1].innerHTML = newspaper_type;
        var newspaper_status;
        if(newspaper.status == "0") {
            newspaper_status = "暂存草稿";
        }else if(newspaper.status == "1") {
            newspaper_status = "已发布";
        }else if(newspaper.status == "2") {
            newspaper_status = "取消发布";
        }
        newspaper_table.rows[2].cells[1].innerHTML = newspaper_status;
        var username;
        $.ajax({
            url: "/webUser/acquireUserName.do",
            type: "POST",
            data: {
                createUserid: newspaper.createUserid
            },
            async: false,
            dataType: "json",
            success: function(data) {
                username = data.username;
            },
            error: function(er) {
                console.log(er);
            }
        });
        newspaper_table.rows[3].cells[1].innerHTML = username;
        newspaper_table.rows[4].cells[1].innerHTML = new Date(newspaper.createTime).format(('yyyy-MM-dd hh:mm:ss'));
        newspaper_table.rows[5].cells[1].innerHTML = newspaper.contentUrl;
        newspaper_table.rows[6].cells[1].innerHTML = newspaper.descInfo;
        $("#newspaper_picture").attr("src", $("#newspaper_picture")[0].title + newspaper.imgUrl);
    })
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

/*编辑广告内容*/
function ItemContent(id) {
    layui.use(['layer', 'form'],function(){
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: '广告内容编辑',
            area: ['700px', '600px'],
            content: $("#newspaper_edit_content"),
            zIndex: 99,
            btn: '提交',
            yes: function(){
                /*editor.appendHtml("<body><html>");*/
                editor.sync();
                var html = "<!DOCTYPE html>" + "\n" +
                           "<html>" + "\n" +
                           "<head>" + "\n" +
                           "<meta charset='utf-8'>" + "\n" +
                           "<meta name='viewport' content='width=device-width'>" + "\n" +
                           "<title></title>" + "\n" +
                           "</head>" +"\n" +
                           "<body>" + "\n";
                html = html + $("#editor_id").val();
                html = html + "\n" + "</body>" + "\n"  +
                              "</html>";
                $.ajax({
                    url: "content.do",
                    type: "post",
                    data: {
                        id: id,
                        content: html
                    },
                    dataType: "json",
                    success: function(data) {
                        layui.use('layer', function(){
                            var layer = layui.layer;
                            if(data.msg == "success") {
                                layer.msg("广告内容编辑成功", {
                                    time: 1000,
                                    offset: '160px'
                                });
                                setTimeout(function() {
                                    location.reload();
                                }, 1000);
                            } else {
                                console.log(data.msg);
                                layer.msg("广告内容编辑失败", {
                                    time: 1000,
                                    offset: '160px'
                                });
                                setTimeout(function() {
                                    location.reload();
                                }, 1000);
                            }
                        })
                    },
                    error: function(er) {
                        console.log(er);
                    }

                });
            },
            cancel: function() {
                //editor.remove("#editor_id");
                editor.remove();
            }
        })
        //$(document).off();
        var editor = KindEditor.create("#editor_id", {
            resizeType : 1,
            uploadJson : '/kindedit/upload.do',
            fileManagerJson : '/kindedit/manager.do',
            allowFileManager : true,
            height: '520px'
        });
        form.render();
    });
}

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
                    url = getRoot() + "/newspaper/query.do?title=" + $("#title").val() + "&type=" + $("#type").val() + "&status=" + $("#status").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/newspaper/list.do?&type=" + $("#type").val() + "&pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})
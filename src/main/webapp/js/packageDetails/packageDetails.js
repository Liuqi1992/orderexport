/**
 * Created by LiuQi on 2017/8/7.
 */
/*通过ID删除某个套餐*/
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
/*新增检验细项*/
function addPackageDetails(id) {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "增加套餐",
            skin: 'layui-layer-rim', //加上边框
            area: ["480px", "480px"],
            content: $("#add_packageDetails"),
            btn: ['增加', '取消'],
            yes: function (index, layero) {
                var hisId_check = document.getElementById("hisId_check");
                if($("#hisId_add").val() == "") {
                    hisId_check.innerHTML = "his项目编号不能为空";
                    return;
                } else{
                    hisId_check.innerHTML = "";
                }
                var packageId_check = document.getElementById("packageId_check")
                if($("#packageId_add").val() == "") {
                    packageId_check.innerHTML = "套餐编号不能为空";
                    return;
                } else {
                    packageId_check.innerHTML = "";
                }
                $.ajax({
                    url: "add.do",
                    type: "POST",
                    data: $("#add_packageDetails_form").serializeArray(),
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

/*编辑检验细项*/
function ItemEdit(id) {
    var packageDetails;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            packageDetails = data.packageDetails;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        if(packageDetails.name == "paramIsError") {
            layer.msg('获取信息失败', {
                time: 1000,
                offset: '160px',
            });
            return;
        }
        layer.tab({
            id: "edit_tab",
            area: ['480px', '480px'],
            tab: [
                {
                    title: '检验细项编辑',
                    content: $("#edit_packageDetails").html(),
                },
                {
                    title: '检验细项知识库编辑',
                    content: $("#edit_detail_knowledge").html()
                }
            ],
            btn: ['提交', '取消'],
            yes: function(index, layero) {
                if(tab_flag === 1) {
                    var hisId_check_edit = document.getElementById("hisId_check_edit");
                    if($("#hisId_edit").val() == "") {
                        hisId_check_edit.innerHTML = "his项目编号不能为空";
                        return;
                    } else{
                        hisId_check_edit.innerHTML = "";
                    }
                    var packageId_check_edit = document.getElementById("packageId_check_edit")
                    if($("#packageId_edit").val() == "") {
                        packageId_check_edit.innerHTML = "套餐编号不能为空";
                        return;
                    } else {
                        packageId_check_edit.innerHTML = "";
                    }
                    $.ajax({
                        url: "update.do",
                        type: "POST",
                        data: $("#edit_packageDetails_form").serializeArray(),
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
                }else if(tab_flag === 2) {
                    $.ajax({
                        url: "/knowledgeDetails/update.do",
                        type: "POST",
                        data: $("#edit_packageDetails_knowledge_form").serializeArray(),
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
                }
            },
            btn2: function(index, layero) {
                layer.close(index);
            }
        });
        $("#hisId_edit").attr('value', packageDetails.hisId);
        $("#hisName_edit").attr('value', packageDetails.hisName);
        if(packageDetails.hisPrice != null) {
            $("#hisPrice_edit").attr('value', (parseFloat(packageDetails.hisPrice) / 100).toFixed(2));
        }
        $("#packageId_edit").attr('value', packageDetails.packageId);
        $("#name_edit").attr('value', packageDetails.name);
        if(packageDetails.price != null) {
            $("#price_edit").attr('value', (parseFloat(packageDetails.price) / 100).toFixed(2));
        }
        $("#testId_edit").attr('value', packageDetails.testId);
        $("#edit_id").attr('value', id);

        //知识库
        $("#detail_knowledge_name").attr('value', packageDetails.name);
        $('#edit_knowledge_packagedetails_id').attr('value', id);
        if(packageDetails.knowledgeDetailsModel != null) {
            $("#edit_knowledge_id").attr('value', packageDetails.knowledgeDetailsModel.id);
            $("#edit_knowledge_introduction").attr('value', packageDetails.knowledgeDetailsModel.introduction);
            $("#edit_knowledge_objective").attr('value', packageDetails.knowledgeDetailsModel.objective);
            $("#edit_knowledge_text_time").attr('value', packageDetails.knowledgeDetailsModel.textTime);
            $("#edit_knowledge_clinical").attr('value', packageDetails.knowledgeDetailsModel.clinical);
            //$("#edit_knowledge_need_attention").attr('value', packageDetails.knowledgeDetailsModel.needAttention);
        }
        form.render();

        //确定当前在哪个tab页, 默认在一个tab页
        var tab_flag = 1;

        var edit_tab = document.getElementById("edit_tab");
        //监听选项卡的切换
        var previous = edit_tab.previousElementSibling;
        previous.onclick = function() {
            var childs = previous.childNodes;
            for (var i = 0; i < childs.length; i++) {
                var child = childs[i];
                if (child.getAttribute("class") === 'layui-layer-tabnow') {
                    if (i === 0) {
                        tab_flag = 1;
                    } else {
                        tab_flag = 2;
                    }
                }
            }
        }
    })
}

//详情
function ItemDetail(id) {
    var packageDetails;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            packageDetails = data.packageDetails;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use('layer', function() {
        var layer = layui.layer;
        if(packageDetails.name == "paramIsError") {
            layer.msg('获取信息失败', {
                time: 1000,
                offset: '160px',
            });
            return;
        }
        layer.tab({
            area: ['580px', '640px'],
            tab: [
                {
                    title: '检验细项详情',
                    content: $("#packageDetails_detail").html()
                },{
                    title: '细项知识库详情',
                    content: $("#packageDetails_knowledge").html()
                }
            ]
        });
        var packageDetails_table = document.getElementById('packageDetails_table');
        packageDetails_table.rows[0].cells[1].innerHTML = packageDetails.hisName;
        packageDetails_table.rows[1].cells[1].innerHTML = packageDetails.hisPrice;
        packageDetails_table.rows[2].cells[1].innerHTML = packageDetails.packageModel !=null ? packageDetails.packageModel.name : '';
        packageDetails_table.rows[3].cells[1].innerHTML = packageDetails.name;
        packageDetails_table.rows[4].cells[1].innerHTML = packageDetails.price != null ? (parseFloat(packageDetails.price) / 100).toFixed(2) + " 元" : "";
        packageDetails_table.rows[5].cells[1].innerHTML = packageDetails.testId;

        var packageDetails_knowledge_table = document.getElementById('packageDetails_knowledge_table');
        packageDetails_knowledge_table.rows[0].cells[1].innerHTML = packageDetails.name;
        packageDetails_knowledge_table.rows[1].cells[1].innerHTML = packageDetails.knowledgeDetailsModel.introduction;
        packageDetails_knowledge_table.rows[2].cells[1].innerHTML = packageDetails.knowledgeDetailsModel.objective;
        packageDetails_knowledge_table.rows[3].cells[1].innerHTML = packageDetails.knowledgeDetailsModel.textTime;
        packageDetails_knowledge_table.rows[4].cells[1].innerHTML = packageDetails.knowledgeDetailsModel.clinical;
        //packageDetails_knowledge_table.rows[5].cells[1].innerHTML = packageDetails.knowledgeDetailsModel.needAttention;
    })
}

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
                    url = getRoot() + "/packageDetails/query.do?hisName=" + $("#hisName").val() + "&packageName=" + $("#packageName").val() + "&name=" + $("#name").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/packageDetails/list.do?pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})

$(document).ready(function() {
    $("#threeDepartmentImport").click(function() {
        $.ajax({
            url: "getPackageDetailDataFromThreeDepartment.do",
            type: "POST",
            success: function(data) {
                layui.use('layer', function() {
                    var layer = layui.layer;
                    layer.msg(data.msg, {
                        time: 1000,
                        offset: "160px"
                    });
                    setTimeout(function() {
                        location.reload();
                    }, 1000);
                });
            },
            error: function(er) {
                console.log(er);
            }
        });
    });
})


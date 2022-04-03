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

//对某位医生的信息进行编辑
function ItemEdit(id) {
    var doctor;
    $.ajax({
        url: "getInfo.do",
        type: "POST",
        data: {id : id},
        dataType: "json",
        async: false,
        success: function(data) {
            doctor = data.doctor;
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
        if(doctor.userName == "paramIsError") {
            layer.msg("获取信息失败",{
                time:1000
            });
            return;
        }
        layer.open({
            type: 1,
            title: "基本信息修改",
            skin: 'layui-layer-rim',
            area: ['480px', '680px'],
            content:$("#infoEdit"),
            btn:['提交', '取消'],
            yes: function(index, layero) {
                //获取当前采集点
                var obj = document.getElementById("hospital_Id");
                var selected_index = obj.selectedIndex;
                $("#hospitalName").val(obj.options[selected_index].text); department_num_edit
                //获取当前科室
                var obj = document.getElementById("department_num_edit");
                var selected_index = obj.selectedIndex;
                $("#departmentName_edit").val(obj.options[selected_index].text);
                $("#touimg_edit_").val(tou_img_edit_path);
                if(zzImg_edit_path != null && zzImg_edit_path != '' && zzImg_edit_path != undefined) {
                    $("#zzImg_edit_").val("http://183.247.179.221:9099" + zzImg_edit_path);
                }
                if(zcImg_edit_path != null && zcImg_edit_path != '' && zcImg_edit_path != undefined) {
                    $("#zcImg_edit_id_").val("http://183.247.179.221:9099" + zcImg_edit_path);
                }
                $.ajax({
                    url: "update.do",
                    type: "POST",
                    data: $("#doctorInfo").serializeArray(),
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
        $("input[name=sex][value='"+doctor.sex+"']").attr("checked", true);
        $("#doctor_type option[value='"+doctor.type+"']").attr("selected", 'selected');
        $("#id").val(doctor.id);
        $("#userName").val(doctor.userName);
        $("#hospital_Id option[value='"+doctor.hospitalId+"']").attr("selected", 'selected');
        $("#department_num_edit option[value='"+doctor.departmentNum+"']").attr("selected", 'selected');
        $("#doctorName").val(doctor.doctorName);
        $("#age").val(doctor.age);
        $("#sfzNum_edit").val(doctor.sfzNum);
        $("#zzNum_edit").val(doctor.zzNum);
        $("#zcNum_edit").val(doctor.zcNum);
        $("#position_edit").val(doctor.position);
        $("#title option[value='"+doctor.title+"']").attr("selected", 'selected');
        $("#education_edit option[value='"+doctor.education+"']").attr("selected", 'selected');
        $("#readReportNum").val(doctor.readReportNum);
        $("#diagnosisNum").val(doctor.diagnosisNum);
        $("#introduce").val(doctor.introduce);
        form.render();
    });
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

/**
 * 编辑时上传从业执照图片
 */
var zzImg_edit_path;
function uploadZZImgEdit() {
    var formData = new FormData();
    formData.append('file',$("#zzImg_edit")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#zzImg_edit")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    zzImg_edit_path = data.txt;
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
 * 编辑时上传职称证书图片
 */
var zcImg_edit_path;
function uploadZCImgEdit() {
    var formData = new FormData();
    formData.append('file',$("#zcImg_edit_id")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#zcImg_edit_id")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    zcImg_edit_path = data.txt;
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

//对未审核的医生进行审核
function ItemAudite(id) {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "解读审核",
            skin: 'layui-layer-rim',
            area: ['480px', '300px'],
            content: $("#doctorAudite"),
            btn:['提交', '取消'],
            yes: function(index, layuio) {
                var audit_data = $("#Audite").serializeArray();
                $.ajax({
                    url: "audit.do",
                    type: "POST",
                    data: audit_data,
                    dataType: "json",
                    success: function(data) {
                        //当ajax返回的信息是"success"时，则表示操作成功；否则，表示操作失败
                        if(data.msg == "success") {
                            layer.msg("操作成功", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        } else {
                            //操作失败在后台打印相关信息
                            console.log(data.msg);
                            layer.msg("操作失败", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        }
                    },
                    error: function(er) {
                        console.log();
                    }
                });
            },
            btn2: function(index, layuio) {
                layer.close(index);
            }
        });
        form.render();
        $("#id2").val(id);
    });
}

//对提出申请成为开单医生的解读医生进行审核
function ItemBillAudite(id) {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "开单审核",
            skin: 'layui-layer-rim',
            area: ['480px', '300px'],
            content: $("#doctorBillAudite"),
            btn:['提交', '取消'],
            yes: function(index, layuio) {
                var audit_data = $("#BillAudite").serializeArray();
                $.ajax({
                    url: "billAudit.do",
                    type: "POST",
                    data: audit_data,
                    dataType: "json",
                    success: function(data) {
                        //当ajax返回的信息是"success"时，则表示操作成功；否则，表示操作失败
                        if(data.msg == "success") {
                            layer.msg("操作成功", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        } else {
                            //操作失败在后台打印相关信息
                            console.log(data.msg);
                            layer.msg("操作失败", {
                                time: 1000
                            });
                            setTimeout(function(){
                                location.reload();
                            }, 1000)
                        }
                    },
                    error: function(er) {
                        console.log();
                    }
                });
            },
            btn2: function(index, layuio) {
                layer.close(index);
            }
        });
        form.render();
        $("#id3").val(id);
    });
}

//显示某位医生的详细信息
function ItemDetail(id) {
    var doctor;
    $.ajax({
        url: "getInfo.do",
        type: "POST",
        data: {id: id},
        dataType: "json",
        async: false,
        success: function(data) {
            doctor = data.doctor;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use("layer", function() {
        var layer = layui.layer;
        if(doctor.userName == "paramIsError") {
            layer.msg("获取信息失败", {
                time: 1000
            });
            return;
        }
        layer.open({
            type: 1,
            title: "基本信息",
            skin: 'layui-layer-rim',
            area: ['600px', '680px'],
            content: $("#detail_info")
        });
        var doctor_table = document.getElementById("doctor_table");
        doctor_table.rows[0].cells[1].innerHTML = doctor.doctorName;
        doctor_table.rows[0].cells[3].innerHTML = doctor.sex;
        doctor_table.rows[1].cells[1].innerHTML = doctor.hospitalName;
        doctor_table.rows[1].cells[3].innerHTML = doctor.age;
        doctor_table.rows[2].cells[1].innerHTML = doctor.title;
        if(doctor.type == "1") {
            doctor_table.rows[2].cells[3].innerHTML = "开单医生";
        } else if(doctor.type == "2") {
            doctor_table.rows[2].cells[3].innerHTML = "护士";
        } else if(doctor.type == "3") {
            doctor_table.rows[2].cells[3].innerHTML = "解读医生";
        }
        doctor_table.rows[3].cells[1].innerHTML = doctor.education;
        doctor_table.rows[3].cells[3].innerHTML = doctor.departmentName;
        doctor_table.rows[4].cells[1].innerHTML = doctor.sfzNum;
        doctor_table.rows[5].cells[1].innerHTML = doctor.zzNum;
        doctor_table.rows[5].cells[3].innerHTML = doctor.zcNum;
        doctor_table.rows[6].cells[1].innerHTML = new Date(doctor.createTime).format("yyyy-MM-dd hh:mm:ss");
        doctor_table.rows[6].cells[3].innerHTML = doctor.modifyTime != null ? new Date(doctor.modifyTime).format("yyyy-MM-dd hh:mm:ss") : "";
        doctor_table.rows[8].cells[1].innerHTML = doctor.introduce;
        $("#doctor_picture").attr("src", $("#doctor_picture")[0].title + doctor.touImg);
        $("#doctor_zzImg").attr("src", doctor.zzImg);
        $("#doctor_zcImg").attr("src", doctor.zcImg);
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

/*添加医生*/
function addDoctor() {
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        layer.open({
            type: 1,
            title: "新增医生",
            area: ["480px", "680px"],
            content: $("#add_doctor"),
            btn: ["增加", "取消"],
            yes: function(index, layero) {
                //确定当前选定的医院
                var obj = document.getElementById("hospital_name_select");
                var selected_index = obj.selectedIndex;
                $("#hospital_name").val(obj.options[selected_index].text);
                //确定当前选定的科室
                var obj2 = document.getElementById("department_num_add");
                var selected_index = obj2.selectedIndex;
                $("#departmentName_add").val(obj2.options[selected_index].text);
                $("#touimg_id_").val(tou_img_path);
                if(zzImg_path != null && zzImg_path != '' && zzImg_path != undefined) {
                    $("#zzImg_id_").val("http://183.247.179.221:9099" + zzImg_path);
                }
                if(zcImg_path != null && zcImg_path != '' && zcImg_path != undefined) {
                    $("#zcImg_id_").val("http://183.247.179.221:9099" + zcImg_path);
                }
                $.ajax({
                    url: "add.do",
                    type: "POST",
                    data: $("#add_doctor_form").serializeArray(),
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
 * 上传从业执照图片
 */
var zzImg_path;
function uploadZZImg() {
    var formData = new FormData();
    formData.append('file',$("#zzImg_id")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#zzImg_id")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    zzImg_path = data.txt;
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
 * 上传职称证书图片
 */
var zcImg_path;
function uploadZCImg() {
    var formData = new FormData();
    formData.append('file',$("#zcImg_id")[0].files[0]);    //将文件转成二进制形式
    $.ajax({
        type: "post",
        url: $("#zcImg_id")[0].title,
        async: false,
        contentType: false,    //这个一定要写
        processData: false, //这个也一定要写，不然会报错
        data:formData,
        dataType:'json',    //返回类型，有json，text，HTML。这里并没有jsonp格式，所以别妄想能用jsonp做跨域了。
        success:function(data){
            layui.use('layer', function() {
                var layer = layui.layer;
                if(data.txt != null && data.txt != "" && data.txt != undefined) {
                    zcImg_path = data.txt;
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
 * 获取医院
 */
function requireHospitals() {
    layui.use('form', function() {
        var form = layui.form();
        $.ajax({
            url: "/hospital/listHospitals.do",
            type: "POST",
            data: {},
            dataType: "json",
            success: function(data) {
                var hospitals = data.hospitals;
                var obj1 = document.getElementById("hospital_name_select");
                var obj2 = document.getElementById("query_hospital_id");
                var obj3 = document.getElementById("hospital_Id");
                for(i=0; i<hospitals.length; i++) {
                    obj1.options.add(new Option(hospitals[i].name, hospitals[i].id));
                    obj2.options.add(new Option(hospitals[i].name, hospitals[i].id));
                    obj3.options.add(new Option(hospitals[i].name, hospitals[i].id));
                }
            },
            error: function(er) {
                console.log(er);
            }
        });
    });
}
requireHospitals();

/**
 * 获取科室
 */
function requireDepartments() {
    layui.use('form', function() {
        var form = layui.form();
        $.ajax({
            url: "/department/acquireAllDeparment.do",
            type: "POST",
            data: {},
            dataType: "json",
            success: function(data) {
                var all_departments = data.all_departments;
                var obj1 = document.getElementById("department_num_add");
                var obj2 = document.getElementById("department_num_edit");
                //var obj3 = document.getElementById("hospital_Id");
                for(i=0; i<all_departments.length; i++) {
                    obj1.options.add(new Option(all_departments[i].departmentName, all_departments[i].departmentNum));
                    obj2.options.add(new Option(all_departments[i].departmentName, all_departments[i].departmentNum));
                    //obj3.options.add(new Option(hospitals[i].name, hospitals[i].id));
                }
            },
            error: function(er) {
                console.log(er);
            }
        });
    });
}
requireDepartments();

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

/*
function doctor_query() {
    var query_info = {
        id: $("#query_id").val(),
        hospitalId: $("#query_hospital_id").val(),
        doctorName: $("#query_doctor_name").val(),
        title: $("#query_title").val(),
        status: $("#query_status").val(),
        type: $("#query_type").val(),
        createTimeStart: $("#createtime_range_start").val(),
        createTimeEnd: $("#createtime_range_end").val()
    }
    $.ajax({
        url: "query.do",
        type: "POST",
        data: query_info,
        dataType: "json",
        success: function(data) {

        },
        error: function(er) {
            console.log(er);
        }
    })
}*/
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
                    url = getRoot() + "/doctor/query.do?type=" + $("#type").val() + "&userName=" + $("#userName_").val() + "&hospitalId=" + $("#hospitalId").val() + "&doctorName=" + $("#doctorName_").val() + "&title=" + $("#title_").val() + "&status=" + $("#status").val() + "&createTimeStart=" + $("#createTimeStart").val() + "&createTimeEnd=" + $("#createTimeEnd").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/doctor/list.do?type=" + $("#type").val() + "&pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})

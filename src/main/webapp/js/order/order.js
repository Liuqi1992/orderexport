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

/*编辑订单子项内容*/
function ItemEdit(id) {
    var order;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            order = data.order;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use(['layer', 'form'], function() {
        var layer = layui.layer;
        var form = layui.form();
        if(order.packageName == "paramIsError") {
            layer.msg('获取信息失败', {
                time: 1000,
                offset: '160px',
            });
            return;
        }
        layer.open({
            type: 1,
            title: '套餐编辑',
            area: ['500px', '680px'],
            skin: "layui-layer-rim",
            content: $("#edit_order"),
            btn: ['提交', '取消'],
            yes: function(index, layero) {
                $.ajax({
                    url: "update.do",
                    type: "POST",
                    data: $("#edit_order_form").serializeArray(),
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
        $("#userId_edit").val(order.userId);
        $("#tradeId_edit").val(order.tradeId);
        $("#packageId_edit").val(order.packageId);
        $("#packageName_edit").val(order.packageName);
        $("#packageNum_edit").val(order.packageNum);
        $("#price_edit").val((parseFloat(order.price) / 100).toFixed(2));
        $("#status_edit option[value='"+order.status+"']").attr("selected", 'selected');
        $("#takeTime_edit").val(order.takeTime != null ? new Date(order.takeTime).format("yyyy-MM-dd hh:mm:ss") : "");
        $("#takeDoctorId_edit").val(order.takeDoctorId);
        $("#reportTime_edit").val(order.reportTime);
        $("#reportTimeDesc_edit").val(order.reportTimeDesc);
        $("#barcode_edit").val(order.barcode);
        //$("#reportUrl_edit").val(order.reportUrl);
        $("#reportAcceptTime_edit").val(order.reportAcceptTime);
        $("#unscrambleTime_edit").val(order.unscrambleTime != null ? new Date(order.unscrambleTime).format("yyyy-MM-dd hh:mm:ss") : "");
        //$("#unscrambleAudioUrl_edit").val(order.unscrambleAudioUrl);
        $("#unscrambleAudioTime_edit").val(order.unscrambleAudioTime);
        $("#unscrambleContent_edit").val(order.unscrambleContent);
        $("#remark_edit").val(order.remark);
        $("#edit_id").val(id);
        form.render();
    })
}

/*订单子项详情*/
function ItemDetail(id) {
    var order;
    $.ajax({
        url: 'acquireTrade.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            order = data.order;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use('layer', function() {
        var layer = layui.layer;
        if(order.packageName == "paramIsError") {
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
            area: ['600px', '680px'],
            content: $("#detail_order")
        });
        var detail_order_table = document.getElementById("detail_order_table");
        detail_order_table.rows[0].cells[1].innerHTML = order.userId;
        detail_order_table.rows[0].cells[3].innerHTML = order.userModel.userName;
        detail_order_table.rows[1].cells[1].innerHTML = order.tradeId;
        detail_order_table.rows[1].cells[3].innerHTML = order.tradeModel.tradeNum;
        detail_order_table.rows[2].cells[1].innerHTML = order.packageId;
        detail_order_table.rows[2].cells[3].innerHTML = order.packageName;
        detail_order_table.rows[3].cells[1].innerHTML = order.packageNum + " 个";
        detail_order_table.rows[3].cells[3].innerHTML = (parseFloat(order.price) / 100).toFixed(2) + " 元";
        if(order.status == "-2") {
            detail_order_table.rows[4].cells[1].innerHTML = "未确认（预约医生）";
        }
        if(order.status == "-1") {
            detail_order_table.rows[4].cells[1].innerHTML = "已确认（预约医生）";
        }
        if(order.status == "0") {
            detail_order_table.rows[4].cells[1].innerHTML = "已下单";
        }
        if(order.status == "1") {
            detail_order_table.rows[4].cells[1].innerHTML = "已付款";
        }
        if(order.status == "2") {
            detail_order_table.rows[4].cells[1].innerHTML = "已开医嘱";
        }
        if(order.status == "3") {
            detail_order_table.rows[4].cells[1].innerHTML = "已采集";
        }
        if(order.status == "4") {
            detail_order_table.rows[4].cells[1].innerHTML = "检验中";
        }
        if(order.status == "5") {
            detail_order_table.rows[4].cells[1].innerHTML = "已报告";
        }
        if(order.status == "6") {
            detail_order_table.rows[4].cells[1].innerHTML = "已解读";
        }
        detail_order_table.rows[4].cells[3].innerHTML = order.takeTime != null ? new Date(order.takeTime).format("yyyy-MM-dd hh:mm:ss") : "";
        detail_order_table.rows[5].cells[1].innerHTML = order.takeDoctorId;
        detail_order_table.rows[5].cells[3].innerHTML = order.doctorModel != null ? order.doctorModel.doctorName : '';
        detail_order_table.rows[6].cells[1].innerHTML = order.reportTime
        detail_order_table.rows[6].cells[3].innerHTML = order.reportTimeDesc;
        detail_order_table.rows[7].cells[1].innerHTML = order.barcode;
        detail_order_table.rows[7].cells[3].innerHTML = order.tradeModel.hospitalName;
        detail_order_table.rows[8].cells[1].innerHTML = order.reportAcceptTime;
        detail_order_table.rows[8].cells[3].innerHTML = order.unscrambleTime != null ? new Date(order.unscrambleTime).format("yyyy-MM-dd hh:mm:ss") : "";
        detail_order_table.rows[9].cells[1].innerHTML = order.unscrambleAudioUrl;
        detail_order_table.rows[9].cells[3].innerHTML = order.unscrambleAudioTime;
        detail_order_table.rows[10].cells[1].innerHTML = order.createTime != null ? new Date(order.createTime).format("yyyy-MM-dd hh:mm:ss") : "";
        detail_order_table.rows[10].cells[3].innerHTML = order.modifyTime != null ? new Date(order.modifyTime).format("yyyy-MM-dd hh:mm:ss") : "";
        detail_order_table.rows[11].cells[1].innerHTML = order.unscrambleContent;
        detail_order_table.rows[12].cells[1].innerHTML = order.remark;
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
        //用户名
        var userName_input = document.createElement("input");
        userName_input.type = "text";
        userName_input.name = "userName";
        userName_input.value = $("#userName_query").val();
        temp_form.appendChild(userName_input);
        //订单标号
        var tradeNum_input = document.createElement("input");
        tradeNum_input.type = "text";
        tradeNum_input.name = "tradeNum";
        tradeNum_input.value = $("#tradeNum_query").val();
        temp_form.appendChild(tradeNum_input);
        //套餐名称
        var packageName_input = document.createElement("input");
        packageName_input.type = "text";
        packageName_input.name = "packageName";
        packageName_input.value = $("#packageName_query").val();
        temp_form.appendChild(packageName_input);
        //订单状态
        var status_input = document.createElement("input");
        status_input.type = "text";
        status_input.name = "status";
        status_input.value = $("#status_query").val();
        temp_form.appendChild(status_input);
        //条码号
        var barcode_input = document.createElement("input");
        barcode_input.type = "text";
        barcode_input.name = "barcode";
        barcode_input.value = $("#barcode_query").val();
        temp_form.appendChild(barcode_input);
        //采集点
        var hospitalName_input = document.createElement("input");
        hospitalName_input.type = "text";
        hospitalName_input.name = "hospitalName";
        hospitalName_input.value = $("#hospitalName_query").val();
        temp_form.appendChild(hospitalName_input);
        //采集时间
        var takeTimeStart_input = document.createElement("input");
        takeTimeStart_input.type = "text";
        takeTimeStart_input.name = "takeTimeStart";
        takeTimeStart_input.value = $("#taketime_range_start").val();
        temp_form.appendChild(takeTimeStart_input);
        var takeTimeEnd_input = document.createElement("input");
        takeTimeEnd_input.type = "text";
        takeTimeEnd_input.name = "takeTimeEnd";
        takeTimeEnd_input.value = $("#taketime_range_end").val();
        temp_form.appendChild(takeTimeEnd_input);
        temp_form.submit();
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

    document.getElementById('taketime_range_start').onclick = function(){
        start.elem = this;
        start.istime = true;
        start.format = "YYYY-MM-DD hh:mm:ss";
        laydate(start);
    };
    document.getElementById('taketime_range_end').onclick = function(){
        end.elem = this;
        end.istime = true;
        end.format = "YYYY-MM-DD hh:mm:ss";
        laydate(end);
    }

    //日期时间选择器
    document.getElementById('unscrambleTime_edit').onclick = function() {
        laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})
    }

    document.getElementById('takeTime_edit').onclick = function() {
        laydate({elem: this, istime: true, format: 'YYYY-MM-DD hh:mm:ss'})
    }
 });

function hospitalSelect() {
    layui.use('form', function() {
        var form = layui.form();
        $.ajax({
            url: "/hospital/listHospitals.do",
            type: "POST",
            data: {},
            dataType: "json",
            async: false,
            success: function(data) {
                var hospitals = data.hospitals;
                var hospitalName_query = document.getElementById("hospitalName_query");
                for(i=0; i<hospitals.length; i++) {
                    hospitalName_query.options.add(new Option(hospitals[i].name, hospitals[i].name));
                }
            },
            error: function(er) {
                console.log(er);
            }
        });
        hospitalConfirm();
    });
}
hospitalSelect();

function hospitalConfirm() {
    var hospitalName = $("#hospitalName_query").attr("title") ;
    if(hospitalName != null && hospitalName != '' && hospitalName != undefined) {
        var hospitalName_query = document.getElementById("hospitalName_query");
        for(var i=0; i<hospitalName_query.options.length; i++){
            if(hospitalName_query.options[i].text == hospitalName){
                hospitalName_query.options[i].selected = true;
                break;
            }
        }
    }
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
                    url = getRoot() + "/order/query.do?userName=" + $("#userName").val() + "&tradeNum=" + $("#tradeNum").val() + "&packageName=" + $("#packageName").val() + "&status=" + $("#status").val() + "&barcode=" + $("#barcode").val() + "&hospitalName=" + $("#hospitalName").val() + "&takeTimeStart=" + $("#takeTimeStart").val() + "&takeTimeEnd=" + $("#takeTimeEnd").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/order/list.do?pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})


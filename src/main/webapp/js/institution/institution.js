/**
 * Created by LiuQi on 2017/9/29.
 */

function nameSelect() {
    var institutions;
    $.ajax({
        url: "listAll.do",
        type: "post",
        async: false,
        success: function(data) {
            institutions = data.institutions;
            var institution_all = document.getElementById("institution_all");
            for(var i = 0; i < institutions.length; i++) {
                institution_all.options.add(new Option(institutions[i].name, institutions[i].name));
            }
        },
        error: function(er) {
            console.log(er);
        }
    })
    nameConfirm();
}
nameSelect();

function nameConfirm() {
    var name = $("#name_param").val() ;
    if(name != null && name != '' && name != undefined) {
        var institution_all = document.getElementById("institution_all");
        for(var i=0; i<institution_all.options.length; i++){
            if(institution_all.options[i].text == name){
                institution_all.options[i].selected = true;
                break;
            }
        }
    }
}

function itemDetails(id) {
    var institution;
    $.ajax({
        url: 'acquire.do',
        type: 'POST',
        data: {
            id: id
        },
        async: false,
        dataType: 'json',
        success: function(data) {
            institution = data.institution;
        },
        error: function(er) {
            console.log(er);
        }
    });
    layui.use('layer', function() {
        var layer = layui.layer;
        if (institution.name == "paramIsError") {
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
            area: ['600px', '610px'],
            content: $("#institution_details")
        });
        var detail_info_table = document.getElementById("detail_info_table");
        detail_info_table.rows[0].cells[1].innerHTML = institution.name;
        detail_info_table.rows[1].cells[1].innerHTML = institution.address;
        detail_info_table.rows[2].cells[1].innerHTML = institution.legalpName;
        detail_info_table.rows[3].cells[1].innerHTML = institution.legalpSfz;

        detail_info_table.rows[4].cells[1].getElementsByTagName("img")[0].setAttribute("src", "http://112.17.95.125:9099/" + institution.blImg);
        detail_info_table.rows[4].cells[1].getElementsByTagName("a")[0].setAttribute("href", "http://112.17.95.125:9099/" + institution.blImg);
        detail_info_table.rows[4].cells[1].getElementsByTagName("a")[0].setAttribute("target", "_blank");
        detail_info_table.rows[4].cells[1].getElementsByTagName("a")[0].innerHTML = "查看大图";

        detail_info_table.rows[5].cells[1].getElementsByTagName("img")[0].setAttribute("src", "http://112.17.95.125:9099/" + institution.milImg);
        detail_info_table.rows[5].cells[1].getElementsByTagName("a")[0].setAttribute("href", "http://112.17.95.125:9099/" + institution.milImg);
        detail_info_table.rows[5].cells[1].getElementsByTagName("a")[0].setAttribute("target", "_blank");
        detail_info_table.rows[5].cells[1].getElementsByTagName("a")[0].innerHTML = "查看大图";

        detail_info_table.rows[6].cells[1].getElementsByTagName("img")[0].setAttribute("src", "http://112.17.95.125:9099/" + institution.miaImg);
        detail_info_table.rows[6].cells[1].getElementsByTagName("a")[0].setAttribute("href", "http://112.17.95.125:9099/" + institution.miaImg);
        detail_info_table.rows[6].cells[1].getElementsByTagName("a")[0].setAttribute("target", "_blank");
        detail_info_table.rows[6].cells[1].getElementsByTagName("a")[0].innerHTML = "查看大图";

        detail_info_table.rows[7].cells[1].getElementsByTagName("img")[0].setAttribute("src", "http://112.17.95.125:9099/" + institution.inserverdImg);
        detail_info_table.rows[7].cells[1].getElementsByTagName("a")[0].setAttribute("href", "http://112.17.95.125:9099/" + institution.inserverdImg);
        detail_info_table.rows[7].cells[1].getElementsByTagName("a")[0].setAttribute("target", "_blank");
        detail_info_table.rows[7].cells[1].getElementsByTagName("a")[0].innerHTML = "查看大图";

        detail_info_table.rows[8].cells[1].getElementsByTagName("img")[0].setAttribute("src", "http://112.17.95.125:9099/" + institution.inservernImg);
        detail_info_table.rows[8].cells[1].getElementsByTagName("a")[0].setAttribute("href", "http://112.17.95.125:9099/" + institution.inservernImg);
        detail_info_table.rows[8].cells[1].getElementsByTagName("a")[0].setAttribute("target", "_blank");
        detail_info_table.rows[8].cells[1].getElementsByTagName("a")[0].innerHTML = "查看大图";
        detail_info_table.rows[9].cells[1].innerHTML = institution.linkMan;
        detail_info_table.rows[10].cells[1].innerHTML = institution.linkStyle;
        detail_info_table.rows[11].cells[1].innerHTML = institution.email;
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
                var url = getRoot() + "/institution/list.do?name=" + $("#name").val() + "&pageNo=" + pageNum;
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})

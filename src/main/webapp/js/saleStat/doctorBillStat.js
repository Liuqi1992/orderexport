/**
 * Created by LiuQi on 2017/9/5.
 */
function formRender() {
    layui.use('form', function() {
        var form = layui.form();
        form.render();
    });
}

function selectConfirm() {
    //确定年份的选择框
    var year_input = $("#year_input").val();
    if(year_input != null && year_input != '' && year_input != undefined) {
        var year_id = document.getElementById("year_id");
        for(var i=0; i<year_id.options.length; i++){
            if(year_id.options[i].text == year_input){
                year_id.options[i].selected = true;
                break;
            }
        }
    }
}

function generateSelect() {
    var year = document.getElementById("year_id");
    for(var i = 2017; i <= parseInt(new Date().getFullYear().toString()); i++) {
        year.options.add(new Option(i, i));
    }
    selectConfirm();
}
generateSelect();
//打印
var LODOP;
function f_print() {
    //CheckIsInstall();
    //var LODOP=getLodop(document.getElementById('LODOP_OB'),document.getElementById('LODOP_EM'));
    LODOP = getLodop();
    LODOP.PRINT_INIT("采集点销售统计");
    LODOP.SET_PRINT_PAGESIZE(1, 0, 0, "A4");
    LODOP.SET_PRINT_STYLE("FontSize", 9);
    LODOP.SET_PRINT_STYLE("Bold", 1);
    var strBodyStyle="<style>table,th, td{ border: 1 solid #000000;border-collapse:collapse;text-align: center }</style>";
    var strHtml = strBodyStyle + "<body>" + document.getElementById("table_stat").innerHTML + "</body>";
    LODOP.ADD_PRINT_HTM(50,30,700,950,strHtml);
    LODOP.PREVIEW();
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
                    url = getRoot() + "/doctorBillStat/query.do?doctorName=" + $("#doctorName").val() + "&year=" + $("#year").val() + "&month=" + $("#month").val() + "&pageNo=" + pageNum;
                } else {
                    url = getRoot() + "/doctorBillStat/list.do?pageNo=" + pageNum;
                }
                if(!first) {
                    window.location.href = url;
                }
            }
        })
    })
})
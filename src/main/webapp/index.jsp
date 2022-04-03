<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<style>
    *{
        padding:0px;
        margin:0px;
    }
    a{color:White}
    body{
        font-family:Arial, Helvetica, sans-serif;
       /* background:url(http://keleyi.com/keleyi/phtml/divcss/21/images/grass.jpg) no-repeat center;*/
        font-size:13px;
    }
    img{
        border:0;
    }
    .lg{width:468px; height:468px; margin:100px auto; background:url(http://keleyi.com/keleyi/phtml/divcss/21/images/login_bg.png) no-repeat;}
    .lg_top{ height:200px; width:468px;}
    .lg_main{width:400px; height:180px; margin:0 25px;}
    .lg_m_1{
        width:290px;
        height:100px;
        padding:60px 55px 20px 55px;
    }
    .ur{
        height:37px;
        border:0;
        color:#666;
        width:236px;
        margin:4px 28px;
        background:url(http://keleyi.com/keleyi/phtml/divcss/21/images/user.png) no-repeat;
        padding-left:10px;
        font-size:16pt;
        font-family:Arial, Helvetica, sans-serif;
    }
    .pw{
        height:37px;
        border:0;
        color:#666;
        width:236px;
        margin:4px 28px;
        background:url(http://keleyi.com/keleyi/phtml/divcss/21/images/password.png) no-repeat;
        padding-left:10px;
        font-size:16pt;
        font-family:Arial, Helvetica, sans-serif;
    }
    .bn{width:330px; height:72px; background:url(http://keleyi.com/keleyi/phtml/divcss/21/images/enter.png) no-repeat; border:0; display:block; font-size:18px; color:#FFF; font-family:Arial, Helvetica, sans-serif; font-weight:bolder;}
    .lg_foot{
        height:80px;
        width:330px;
        padding: 6px 68px 0 68px;
    }
</style>
</head>

<body class="b">
<div class="lg">
    <form action="${pageContext.request.contextPath}/webUser/login.do" method="POST">
        <div class="lg_top"></div>
        <div class="lg_main">
            <div class="lg_m_1">

                <input name="userName" value="admin" class="ur" />
                <input name="password" type="password" value="123456" class="pw" />

            </div>
        </div>
        <div class="lg_foot">
            <input type="submit" value="点这里登录" class="bn" /></div>
    </form>
</div>
<script type="application/javascript">

</script>
</body>
</html>

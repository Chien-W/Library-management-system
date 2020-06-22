<%@ page contentType="text/html;charset=UTF-8"  language="java"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>图书馆首页</title>
    <link rel="shortcut icon"  href="img/library.ico" />
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
    <script src="js/js.cookie.js"></script>
    <style>
        #login{
           height: 50%;
            width: 28%;
            margin-left: auto;
            margin-right: auto;
            margin-top: 5%;
            display: block;
            position: center;
        }

        .form-group {
            margin-bottom: 0;
        }
        * {
            padding:0;
            margin:0;
        }
    </style>
</head>
<body background="img/timg.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<c:if test="${!empty error}">
    <script>
            alert("${error}");
            window.location.href="login.html";
</script>
</c:if>
<h2 style="text-align: center; color: white; font-family: '华文行楷'; font-size: 500%">图 书 馆</h2>

<div class="panel panel-default" id="login">
    <div class="panel-heading" style="background-color: #fff">
        <h3 class="panel-title">请登录</h3>
    </div>
    <div class="panel-body">
        <div class="form-group">
            <label for="id">账号</label>
            <input type="text" class="form-control" id="id" placeholder="请输入账号">
        </div>
        <div class="form-group">
            <label for="passwd">密码</label>
            <input type="password" class="form-control" id="passwd" placeholder="请输入密码">
        </div>
        <label>验证码</label><br/>
        <input type="text"   id="yzm"">
       <img id="image" border="0"  οnclick="refresh()" src="/image.html" title="点击更换图片">
        <a href="/index.html">点击刷新</a>
        <div class="checkbox text-left">
            <label>
                <input type="checkbox" id="remember">记住密码
            </label>
        </div>
        <p style="text-align: right;color: red;position: absolute" id="info"></p>
        <button id="loginButton"  class="btn btn-primary  btn-block">登录</button><br>
        <button id="registeredButton"  class="btn btn-primary  btn-block">注册</button>
    </div>
</div>
    <script>

      //  var yzm1="${sessionScope.code}"
      //  console.log(yzm1);
        function refresh() {
            //IE存在缓存,需要new Date()实现更换路径的作用
            document.getElementById("image").src="../image.html?"+new Date();
        }
        $("#id").keyup(
            function () {
                if(isNaN($("#id").val())){
                    $("#info").text("提示:账号只能为数字");
                }
                else {
                    $("#info").text("");
                }
            }
        )
        // 记住登录信息
        function rememberLogin(username, password, checked) {
            Cookies.set('loginStatus', {
                username: username,
                password: password,
                remember: checked
            }, {expires: 30, path: ''})
        }
        // 若选择记住登录信息，则进入页面时设置登录信息
        function setLoginStatus() {
            var loginStatusText = Cookies.get('loginStatus')
            if (loginStatusText) {
                var loginStatus
                try {
                    loginStatus = JSON.parse(loginStatusText);
                    $('#id').val(loginStatus.username);
                    $('#passwd').val(loginStatus.password);
                    $("#remember").prop('checked',true);
                } catch (__) {}
            }
        }

        // 设置登录信息
        setLoginStatus();
        $("#loginButton").click(function () {
            var id =$("#id").val();
            var passwd=$("#passwd").val();
            var yzm=$("#yzm").val();
            var remember=$("#remember").prop('checked');
            if (id == '') {
                alert("提示:账号不能为空");
            }
            else if( passwd ==''){
                alert("提示:密码不能为空");
            }
            else if(isNaN( id )){
                alert("提示:账号必须为数字");
            }
            else if( yzm =='') {
                alert("提示:验证码不能为空");
            }
            else {
                $.ajax({
                    type: "POST",
                    url: "/api/loginCheck",
                    data: {
                        id:id ,
                        passwd: passwd,
                        yzm:yzm
                    },
                    dataType: "json",
                    success: function(data) {
                            if (data.stateCode.trim() === "0") {
                                alert("提示:账号或密码错误！");
                            } else if (data.stateCode.trim() === "1") {
                                $("#info").text("提示:登陆成功，跳转中...");
                                window.location.href = "/admin_main.html";
                            } else if (data.stateCode.trim() === "2") {
                                if (remember) {
                                    rememberLogin(id, passwd, remember);
                                } else {
                                    Cookies.remove('loginStatus');
                                }
                                $("#info").text("提示:登陆成功，跳转中...");
                                window.location.href = "/reader_main.html";
                            } else if (data.stateCode.trim() === "3") {
                                alert("提示:验证码错误！(区分大小写)");
                            }
                    }
                });
            }
        })
        $("#registeredButton").click(function () {
            window.location.href="/reader1_add.html";
        })

    </script>
</div>

</body>
</html>

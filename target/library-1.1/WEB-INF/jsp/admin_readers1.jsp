<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>全部读者</title>
<<<<<<< HEAD
    <link rel="shortcut icon"  href="img/library.ico" />
=======
>>>>>>> d77b5eef39c3e2a8b33d82670a8cae4b5d5e73b4
    <link rel="stylesheet" href="css/bootstrap.min.css">
    <script src="js/jquery-3.2.1.js"></script>
    <script src="js/bootstrap.min.js" ></script>
</head>
<body background="img/u1.jpg" style=" background-repeat:no-repeat ;
background-size:100% 100%;
background-attachment: fixed;">
<div id="header"></div>
<c:if test="${!empty info}">
    <script>alert("${info}");window.location.href="allreaders.html"</script>
</c:if>

<div style="position: relative;top: 15%">
    <c:if test="${!empty succ}">
        <div class="alert alert-success alert-dismissable">
            <button type="button" class="close" data-dismiss="alert"
                    aria-hidden="true">
                &times;
            </button>
                ${succ}
        </div>
    </c:if>
    <c:if test="${!empty error}">
        <div class="alert alert-danger alert-dismissable">
            <button type="button" class="close" data-dismiss="alert"
                    aria-hidden="true">
                &times;
            </button>
                ${error}
        </div>
    </c:if>
</div>


<div class="panel panel-default" style="position:relative;top: 80px;width: 90%;margin-left: 5%">
    <div class="panel-heading">

        <p><em id="num">15</em>秒后，自动跳转主页（请记住自己的读者号）</p>
    </div>
    <div class="panel-body">
        <table class="table table-hover" >
            <thead>
            <tr>
                <th>读者号</th>
                <th>姓名</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${readers}" var="reader">
                <tr>
                    <td><c:out value="${reader.readerId}"></c:out></td>
                    <td><c:out value="${reader.name}"></c:out></td>
                    </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<script>
    var i =15;
    function djs() {
        if(i==0){
            window.location.href = "/index.html";
        }
        document.getElementById("num").innerText=i--;
        setTimeout("djs()",1000);
    }
    djs();
</script>
</body>
</html>

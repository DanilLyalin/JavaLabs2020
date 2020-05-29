<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Автопарк</title>

    <!-- Bootstrap core CSS -->
    <link href="<c:url value="/pages/css/bootstrap.css" />" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="<c:url value="/pages/css/jumbotron-narrow.css" />" rel="stylesheet">

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
    <![endif]-->
</head>

<body>

<div class="container">

    <div class="jumbotron" style="margin-top: 20px;">
        <h2>Автопарк имени Петра Великого</h2>
        <sec:authorize access="!isAuthenticated()">
            <p><a class="btn btn-lg btn-success" href="<c:url value="/login" />" role="button">Войти</a></p>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <p>Здравствуйте, <sec:authentication property="principal.username" /></p>
        </sec:authorize>
        <sec:authorize access="hasRole('USER')">
            <p><a class="btn btn-lg btn-success" href="<c:url value="/drive" />" role="button">Менеджер поездки</a></p>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <p><a class="btn btn-lg btn-info" href="<c:url value="/journal" />" role="button">Журнал выездов</a></p>
            <p><a class="btn btn-lg btn-info" href="<c:url value="/cars" />" role="button">Машины</a></p>
            <p><a class="btn btn-lg btn-info" href="<c:url value="/routes" />" role="button">Маршруты</a></p>
            <p><a class="btn btn-lg btn-info" href="<c:url value="/users" />" role="button">Водители</a></p>
            <p><a class="btn btn-lg btn-danger" href="<c:url value="/logout" />" role="button">Выйти</a></p>
        </sec:authorize>
        <sec:authorize access="hasRole('ADMIN')">
            <p><a class="btn btn-lg btn-link" href="<c:url value="/admin" />" role="button">Панель администратора</a></p>
        </sec:authorize>

    </div>

    <div class="footer">
        <p>&copy; Danil Lyalin 2020</p>
    </div>

</div>
</body>
</html>

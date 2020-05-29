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
        <sec:authorize access="hasRole('ADMIN')">
            <div class="btn-toolbar justify-content-between" role="toolbar" aria-label="Admin panel" >
                <div class="btn-group-vertical" role="group" aria-label="Car options">
                    <a class="btn btn-sm btn-info" href="<c:url value="/cars/addcar" />" type="button">Добавить<br>машину</a>
                    <a class="btn btn-sm btn-danger" href="<c:url value="/cars/deletecar" />" type="button">Удалить<br>машину</a>
                </div>
                <div class="btn-group-vertical" role="group" aria-label="User options">
                    <a class="btn btn-sm btn-info" href="<c:url value="/users/adduser" />" type="button">Добавить<br>пользователя</a>
                    <a class="btn btn-sm btn-danger" href="<c:url value="/users/deleteuser" />" type="button">Удалить<br>пользователя</a>
                </div>
                <div class="btn-group-vertical" role="group" aria-label="Path options">
                    <a class="btn btn-sm btn-info" href="<c:url value="/routes/addroute" />" type="button">Добавить<br>маршрут</a>
                    <a class="btn btn-sm btn-danger" href="<c:url value="/routes/deleteroute" />" type="button">Удалить<br>маршрут</a>
                </div>
                <div class="mb-2 mr-2 ml-2 mt-2 btn-group-vertical" role="group" aria-label="Journal options">
                    <a class="btn btn-sm btn-info" href="<c:url value="/journal/deletefromjournal" />" type="button">Удалить запись</a>
                    <a class="btn btn-sm btn-danger" href="<c:url value="/journal" />" type="button" id="cleanjrbutton">Очистить журнал</a>
                </div>
            </div>
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
            <script>
                document.getElementById('cleanjrbutton').onclick = async function del() {
                    let response = await fetch('/secure/journal/clear', {
                        method: 'post',
                    });
                }
            </script>
        </sec:authorize>
        <sec:authorize access="hasRole('USER')">
            <p><a class="btn btn-lg btn-danger href="<c:url value="/logout" />" role="button">Выйти</a></p>
        </sec:authorize>

    </div>

    <div class="footer">
        <p>&copy; Danil Lyalin 2020</p>
    </div>

</div>
</body>
</html>

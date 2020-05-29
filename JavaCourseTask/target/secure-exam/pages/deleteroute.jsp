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
        <sec:authorize access="!isAuthenticated()">
            <p><a class="btn btn-lg btn-success" href="<c:url value="/login" />" role="button">Войти</a></p>
        </sec:authorize>
        <sec:authorize access="hasRole('ADMIN')">

            <select id="routeSelect"><option selected disabled>Выберите маршрут</option></select>
            <button class="btn btn-lg btn-primary btn-danger" type="submit" id="del_button">Удалить</button>
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
            <script>
                window.onload = function initTable() {
                    fetch('/secure/routes/get/all', {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (selectInitData) {
                            var selection = document.getElementById('routeSelect');
                            for (let i = 0; i < selectInitData.length; i++) {
                                var option = document.createElement("option");
                                option.text = String(selectInitData[i].name);
                                option.value = selectInitData[i].id;
                                selection.add(option);
                            }
                        });
                }
            </script>
            <script>
                document.getElementById('del_button').onclick = async function del() {
                    if (document.getElementById('routeSelect').value.trim() === 'Выберите маршрут') {
                        alert("Выберите маршрут");
                        return;
                    }
                    let route_id = document.getElementById('routeSelect').value.trim()
                    let response = await fetch('/secure/routes/delete?route_id=' + route_id.toString(10), {
                        method: 'post',
                    });
                    if (response.ok) {
                        alert("Маршрут успешно удален")
                    } else {
                        alert("Что-то пошло не так,маршрут не удален")
                    }
                    location.reload();
                }
            </script>
        </sec:authorize>
    </div>

    <div class="footer">
        <p>&copy; Danil Lyalin 2020</p>
    </div>

</div>
</body>
</html>


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
            <style>
                table {
                    width: 90%;
                    margin: auto;
                }
                td {
                    text-align: center;
                }
                caption {
                    text-align: center;
                    font-style: italic;
                }
            </style>
            <h3>Таблица доступных маршрутов</h3>
            <table id='routes' border="1">
                <tbody>
                <td><strong>ID</strong></td>
                <td><strong>Название</strong></td>
                </tbody>
            </table>
            <script>
                window.onload = function initTable() {
                    let table = document.getElementById('routes');
                    fetch('/secure/routes/get/all', {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (tableInitData) {
                            let tbody = table.getElementsByTagName("TBODY")[0];
                            for (let index = 0; index < tableInitData.length; index++) {
                                let row = document.createElement("TR")
                                let td1 = document.createElement("TD")
                                td1.appendChild(document.createTextNode(tableInitData[index].id))
                                let td2 = document.createElement("TD")
                                td2.appendChild(document.createTextNode(tableInitData[index].name))
                                row.appendChild(td1);
                                row.appendChild(td2);
                                tbody.appendChild(row);
                            }
                        });
                }
            </script>
        </sec:authorize>

        <sec:authorize access="isAuthenticated()">
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
        </sec:authorize>

    </div>

    <div class="footer">
        <p>&copy; Danil Lyalin 2020</p>
    </div>

</div>
</body>
</html>

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
            <h3>Таблица водителей автопарка</h3>
            <table id='users' border="1">
                <tbody>
                <td><strong>ID</strong></td>
                <td><strong>Имя</strong></td>
                <td><strong>Фамилия</strong></td>
                <td><strong>Отчество</strong></td>
                <td><strong>Логин в системе</strong></td>
                </tbody>
            </table>
            <script>
                window.onload = function initTable() {
                    let table = document.getElementById('users');
                    fetch('/secure/users/get/all', {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (tableInitData) {
                            let tbody = table.getElementsByTagName("TBODY")[0];
                            for (let i = 0; i < tableInitData.length; i++) {
                                let row = document.createElement("TR")
                                let td1 = document.createElement("TD")
                                td1.appendChild(document.createTextNode(tableInitData[i].id))
                                let td2 = document.createElement("TD")
                                td2.appendChild(document.createTextNode(tableInitData[i].firstName))
                                let td3 = document.createElement("TD")
                                td3.appendChild(document.createTextNode(tableInitData[i].lastName))
                                let td4 = document.createElement("TD")
                                td4.appendChild(document.createTextNode(tableInitData[i].fatherName))
                                let td5 = document.createElement("TD")
                                td5.appendChild(document.createTextNode(tableInitData[i].login))
                                row.appendChild(td1);
                                row.appendChild(td2);
                                row.appendChild(td3);
                                row.appendChild(td4);
                                row.appendChild(td5);
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

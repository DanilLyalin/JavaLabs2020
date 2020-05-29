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
            <input type="text" class="form-control" id="num" placeholder="Гос.номер">
            <input type="text" class="form-control" id="color" placeholder="Цвет">
            <input type="text" class="form-control" id="mark" placeholder="Марка автомобиля">
            <select id="drivers"><option selected disabled>Выберите водителя</option></select>
            <button class="btn btn-lg btn-primary btn-success" type="submit" id="add_button">Добавить</button>
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
            <script>
                window.onload = function initTable() {
                    var selection = document.getElementById('drivers');
                    fetch('/secure/users/get/all', {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (selectInitData) {
                            for (let i = 0; i < selectInitData.length; i++) {
                                var option = document.createElement("option");
                                option.text = String(selectInitData[i].firstName + " " + selectInitData[i].lastName);
                                option.value = selectInitData[i].id;
                                selection.add(option);
                            }
                        });
                }
            </script>
            <script>
                document.getElementById('add_button').onclick = async function add() {
                    if (document.getElementById('num').value.trim() === ''
                        || document.getElementById('color').value.trim() === ''
                        || document.getElementById('mark').value.trim() === ''
                        || document.getElementById('drivers').value.trim() === 'Выберите водителя') {
                        alert("Убедитесь что поля не пустые");
                        return;
                    }
                    let car = {
                        num: document.getElementById('num').value.trim(),
                        color: document.getElementById('color').value.trim(),
                        mark: document.getElementById('mark').value.trim(),
                        persId: document.getElementById('drivers').value.trim()
                    };
                    let response = await fetch('/secure/cars/add?num=' + car.num + '&color=' + car.color + '&mark=' + car.mark + '&personnelId=' + car.persId.toString(10), {
                        method: 'post',
                    });
                    if (response.ok) {
                        alert("Автомобиль успешно добавлен")
                    } else {
                        alert("Неверно указаны параметры автомобиля")
                    }
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


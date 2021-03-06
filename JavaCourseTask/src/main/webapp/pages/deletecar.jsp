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

            <select id="carsSelect"><option selected disabled>Выберите ID машины</option></select>
            <button class="btn btn-lg btn-primary btn-danger" type="submit" id="del_button">Удалить</button>
            <table id='cars' border="1">
                <tbody>
                <td><strong>ID</strong></td>
                <td><strong>Гос. Номер</strong></td>
                <td><strong>Марка авто</strong></td>
                <td><strong>Цвет</strong></td>
                </tbody>
            </table>
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
            <script>
                window.onload = function initTable() {
                    var selection = document.getElementById('carsSelect');
                    let table = document.getElementById('cars');
                    fetch('/secure/cars/get/all', {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (valsInitData) {
                            let tbody = table.getElementsByTagName("TBODY")[0];
                            for (let i = 0; i < valsInitData.length; i++) {
                                var option = document.createElement("option");
                                option.text = String(valsInitData[i].id);
                                option.value = valsInitData[i].id;
                                selection.add(option);
                                let row = document.createElement("TR")
                                let td1 = document.createElement("TD")
                                td1.appendChild(document.createTextNode(valsInitData[i].id))
                                let td2 = document.createElement("TD")
                                td2.appendChild(document.createTextNode(valsInitData[i].num))
                                let td3 = document.createElement("TD")
                                td3.appendChild(document.createTextNode(valsInitData[i].mark))
                                let td4 = document.createElement("TD")
                                td4.appendChild(document.createTextNode(valsInitData[i].color))
                                row.appendChild(td1);
                                row.appendChild(td2);
                                row.appendChild(td3);
                                row.appendChild(td4);
                                tbody.appendChild(row);
                            }
                        });
                }
            </script>
            <script>
                document.getElementById('del_button').onclick = async function del() {
                    if (document.getElementById('carsSelect').value.trim() === 'Выберите ID машины') {
                        alert("Укажите ID Машины");
                        return;
                    }
                    let car_id = document.getElementById('carsSelect').value.trim()
                    let response = await fetch('/secure/cars/delete?auto_id=' + car_id.toString(10), {
                        method: 'post',
                    });
                    if (response.ok) {
                        alert("Автомобиль успешно удален")
                    } else {
                        alert("Что-то пошло не так,автомобиль не удален")
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


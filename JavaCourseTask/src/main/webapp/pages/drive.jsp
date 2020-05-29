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
        <sec:authorize access="hasRole('USER')">
            <input type="hidden" id="curr_login" value="<sec:authentication property="principal.username" />"/>
            <input type="hidden" id="curr_id" value="-1" />
            <h2>Менеджер поездки</h2>
            <h3>Воспользуйтесь кнопками ниже для фиксирования маршрута в журнале</h3>
            <select id="carsSelect" ><option selected disabled>Выберите свою машину</option></select>
            <select id="routeSelect"><option selected disabled>Выберите маршрут</option></select>
            <div class="btn-group" role="group" aria-label="Route options">
                <a class="btn btn-sm btn-success" type="button" id="start">Начать поездку</a>
                <a class="btn btn-sm btn-danger" type="button" id="finish">Закончить поездку</a>
            </div>
        <script>
            const user_login = document.getElementById('curr_login').value.trim();
            let key = 0;
            window.onload = function initTable() {
                fetch('/secure/users/get/ByLogin?login='+user_login, {
                    method: 'get'
                })
                    .then(res => res.json())
                    .then(function (curUserData) {
                        document.getElementById('curr_id').value = curUserData[0].id;
                    });

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
            document.getElementById('carsSelect').onmouseover = function updateCarSelect(){
                if(key == 0) {
                    fetch('/secure/cars/get/userCars?user_id=' + document.getElementById('curr_id').value, {
                        method: 'get'
                    })
                        .then(res => res.json())
                        .then(function (selectInitData) {
                            var selection = document.getElementById('carsSelect');
                            for (let i = 0; i < selectInitData.length; i++) {
                                var option = document.createElement("option");
                                option.text = String(selectInitData[i].mark) + " " + String(selectInitData[i].num);
                                option.value = selectInitData[i].id;
                                selection.add(option);
                            }
                        });
                    key = 1;
                }
            };
            document.getElementById('start').onclick = async function start() {
                if (document.getElementById('carsSelect').value.trim() === 'Выберите свою машину'
                    || document.getElementById('routeSelect').value.trim() === 'Выберите маршрут') {
                    alert("Выберите параметры поездки");
                    return;
                }
                let car_id = document.getElementById('carsSelect').value.trim();
                let route_id = document.getElementById('routeSelect').value.trim();
                let driver_id = document.getElementById('curr_id').value.trim();
                let response = await fetch('/secure/drive/start?car_id='+car_id+"&route_id="+route_id+"&driver_id="+driver_id, {
                    method: 'post',
                });
                if (response.ok) {
                    alert("Поездка началась")
                } else {
                    alert("Не удалось начать поездку,возможно у вас уже есть начатая поездка")
                }
            }
            document.getElementById('finish').onclick = async function finish() {
                let car_id = document.getElementById('carsSelect').value.trim();
                let route_id = document.getElementById('routeSelect').value.trim();
                let response = await fetch('/secure/drive/finish?car_id='+car_id+"&route_id="+route_id, {
                    method: 'post',
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

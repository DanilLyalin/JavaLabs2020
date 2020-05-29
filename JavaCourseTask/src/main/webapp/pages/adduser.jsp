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
            <input type="text" class="form-control" id="first_name" placeholder="Имя">
            <input type="text" class="form-control" id="last_name" placeholder="Фамилия">
            <input type="text" class="form-control" id="father_name" placeholder="Отчество">
            <input type="text" class="form-control" id="login" placeholder="Логин">
            <input type="text" class="form-control" id="password" placeholder="Пароль">
            <button class="btn btn-lg btn-primary btn-success" type="submit" id="add_button">Добавить</button>
            <p><a class="btn btn-lg btn-link" href="<c:url value="/" />" role="button">Главное меню</a></p>
            <script>
                document.getElementById('add_button').onclick = async function add() {
                    if (document.getElementById('first_name').value.trim() === ''
                        || document.getElementById('last_name').value.trim() === ''
                        || document.getElementById('father_name').value.trim() === ''
                        || document.getElementById('login').value.trim() === ''
                        || document.getElementById('password').value.trim() === '') {
                        alert("Убедитесь что поля не пустые");
                        return;
                    }
                    let currentUser = {
                        name: document.getElementById('first_name').value.trim(),
                        surname: document.getElementById('last_name').value.trim(),
                        fatherName: document.getElementById('father_name').value.trim(),
                        login: document.getElementById('login').value.trim(),
                        pas: document.getElementById('password').value.trim()
                    };
                    let response = await fetch('/secure/users/add?firstName='+currentUser.name+'&lastName='+currentUser.surname+'&fatherName='+currentUser.fatherName+'&login='+currentUser.login+'&password='+currentUser.pas, {
                        method: 'post',
                    });
                    if (response.ok) {
                        alert("Пользователь успешно добавлен")
                        location.reload();
                    } else {
                        alert("Неверно указаны параметры пользователя или пароль меньше 8 символов")
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


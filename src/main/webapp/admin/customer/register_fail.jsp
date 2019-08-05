<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html class="bg_none" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<title>회원 가입</title>
<jsp:include page="./ssi.jsp"></jsp:include>


<link
  href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
  rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet"
  href="https://use.fontawesome.com/releases/v5.8.1/css/all.css"
  integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf"
  crossorigin="anonymous">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
  rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/richer.css"
  rel="Stylesheet" type="text/css">

<script type="text/JavaScript"
  src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
  src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
  integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
  crossorigin="anonymous"></script>
<script
  src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
  integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
  crossorigin="anonymous"></script>

</head>
<body class="overflow-hidden" style="">

<div class="rch-topnav d-flex mx-3 pt-3">
    <nav class="nav pt-1 mb-0 mr-auto">
      <a class="nav-link px-2" href="${pageContext.request.contextPath}"><i class="material-icons">arrow_back</i></a>
      <span class="align-middle nav-link"></span>
    </nav>
</div>

<div class="container my-auto">
<div class="row">
  <div class="mx-auto text-center">
      <h2 class="h2 font-weight-light">이런!</h2>
      <h5 class="font-weight-light">가입에 문제가 생겼어요.<br>다시 시도해주세요.</h5><br>
      <a href="${pageContext.request.contextPath}" class="btn btn-warning btn-lg">다시 시도</a><br>
      <br>
      <img src="${pageContext.request.contextPath}/customer/richer_maid_hyaa.png">
  </div>
</div>
</div>















</body>
</html>
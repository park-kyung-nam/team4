<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html class="register" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<title>로그인</title>
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
  <style type="text/css">
  html{
    overflow: hidden;
  }
  html, body, container {
    min-height: 100vh !important;
    height: 100vh;
  }
  </style>

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
  <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
  
  <script src="https://cdn.rawgit.com/PascaleBeier/bootstrap-validate/v2.2.0/dist/bootstrap-validate.js" ></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js" ></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/additional-methods.min.js" ></script>
  
  <script type="text/javascript">
  
  $(function(){
    Cookies.set('checkID', 'FALSE');
  });
  
  function debug(){
    $('#id').val('mizuki');
    $('#passwd').val('mizukichan');
  }
  
  function debug2(){
    $('#id').val('rize');
    $('#passwd').val('rizechan');
  }
  
  </script>

</head>
<body style="">

<div class="rch-topnav d-flex mx-3 pt-3">
    <nav class="nav pt-1 mb-0 mr-auto">
      <a class="nav-link px-2" href="javascript:history.back();"><i class="material-icons">arrow_back</i></a>
      <span class="align-middle nav-link"></span>
    </nav>
</div>

<div style="
    height: 75vh;
    display: flex;
    align-items: center;">
<div class="container">
<div class="row">
  <div class="col-md-8 col-lg-6 col-xl-5 card">
  <div class="card-body">
    <form class="" name='frm_login' method="POST">
      <h3 class="h3">Login</h3>
      <p>로그인이 필요한 기능입니다.</p>
      
      <div class="input-group mb-3">
        <input type="text" id="id" name="id" class="form-control" placeholder="관리자 아이디" aria-label="admin id" aria-describedby="basic-addon2">
        <div class="input-group-append">
          <span class="input-group-text" id="basic-addon2"><i class="material-icons">account_box</i></span>
        </div>
      </div>
      
      <div class="input-group mb-3">
        <input type="password" id="passwd" name="passwd" class="form-control" placeholder="비밀번호">
        <div class="input-group-append">
          <span class="input-group-text" id="basic-addon2"><i class="material-icons">lock</i></span>
        </div>
      </div>
      
      <button type="button" onclick="debug()" id="btn_debug" class="btn btn-link btn-block">개발용 계정 입력</button>
      <button type="button" onclick="debug2()" id="btn_debug" class="btn btn-link btn-block">개발용 계정 입력 2</button>
      <button type="submit" id="btn_login" class="btn btn-primary btn-block">로그인</button>
    </form>
  </div>
  </div>
</div>
</div>
</div>















</body>
</html>
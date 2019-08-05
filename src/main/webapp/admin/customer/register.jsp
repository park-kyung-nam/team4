<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html class="register" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport"
  content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<title>일반 회원 가입</title>
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
  <script src="https://cdn.jsdelivr.net/npm/js-cookie@2/src/js.cookie.min.js"></script>
  
  <script src="https://cdn.rawgit.com/PascaleBeier/bootstrap-validate/v2.2.0/dist/bootstrap-validate.js" ></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/jquery.validate.min.js" ></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.0/additional-methods.min.js" ></script>
  
  <script type="text/javascript">
  
  $(function(){
    Cookies.set('checkID', 'FALSE'); // Cookie 생성
    //bootstrapValidate('#username', 'min:2:이름은 2글자 이상으로 입력해주세요.');
    //bootstrapValidate('#email', 'email:이메일을 입력해주세요.');
    //bootstrapValidate('#passwd', 'min:8:비밀번호는 8자 이상으로 입력해주세요.');
    //bootstrapValidate('#passwd', 'regex:/^.*(?=^.{8,}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/:비밀번호는 8자 이상으로 입력해주세요.');
    //bootstrapValidate('#phone1', 'numeric|min:9:전화번호를 입력해주세요.');
    
    $('#id').keyup(function(event){
      if($('#id').val().length >= 4){
        $('#btn_idcheck').prop('disabled', false);
      }else{
        $('#btn_idcheck').prop('disabled', true);
      }
    });
    
    $('#userid').keyup(function(event){
      //event.preventDefault();
      if($('#userid').val().length == 0){
        $('#id_val').html('아이디를 입력해주세요.');
        $('#userid').removeClass('is-valid');
        $('#userid').addClass('is-invalid');
        return false;
      }
      if($('#userid').val().length < 4){
        $('#id_val').html('아이디는 4글자 이상이여야 해요.');
        $('#userid').removeClass('is-valid');
        $('#userid').addClass('is-invalid');
        return false;
      }
      var frm = $('#frm');
      var params = 'userid='+$('#userid').val(); // #: id
      //alert('params: ' + params);
      //console.log('userid='+$('#userid').val());
      
      $.ajax({
        url: "./register/check.latte",
        type: "GET",
        cache: false,
        dataType: "json", // or html
        data: params,
        success: function(data){
          //console.log('success');
          var msg = "";
          if (data.count > 0) {
            $('#id_val').html('이미 누군가가 아이디를 쓰고 있어요!');
            $('#userid').removeClass('is-valid');
            $('#userid').addClass('is-invalid');
          } else {
            $('#userid').removeClass('is-invalid');
            $('#userid').addClass('is-valid');
            Cookies.set('checkID', 'TRUE'); // Cookie 값 변경
          }
          
        },
        // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
        error: function (request, status, error){  
          console.log('failure');
          //console.log('userid='+$('#userid', frm).val());
          var msg = "에러가 발생했습니다. <br><br>";
          msg += "request.status: " + request.status + "<br>";
          msg += "request.responseText: " + request.responseText + "<br>";
          msg += "status: " + status + "<br>";
          msg += "error: " + error;
          console.log(msg);
          
        }
      });
      Cookies.set('checkID', 'FALSE'); // Cookie 값 변경
   
    });
    
    $("#frm_id").validate({
      submitHandler: function(form) {
        form.submit();
      },
      rules: {
        name: {
          required: true,
          minlength: 2
        },
        email:{
          required: true,
          email: true
        },
        passwd:{
          required: true,
          minlength: 8
        },
        passwd2:{
          required: true,
          minlength: 8,
          passwordMatch: true // set this on the field you're trying to match
        }
      },
      messages: {
        name: {
          required: "이름을 입력해주세요",
          minlength: "이름은 2글자 이상이여야 됩니다."
        },
        email: {
            required: "이메일을 입력해주세요",
            minlength: "유효한 이메일을 입력해주세요."
        },
        passwd: {
            required: "비밀번호를 입력해주세요",
            minlength: "비밀번호는 8자 이상이여야 됩니다."
        },
        passwd2: {
            required: "비밀번호를 확인해주세요",
            minlength: "비밀번호는 8자 이상이여야 됩니다.",
            passwordMatch: "비밀번호가 일치하지 않습니다." // custom message for mismatched passwords
        }
      }
    });
    
    
    
  });
  
  //validator.form();
  
  function check_id(){
    var params = 'id='+$('#id').val(); // #: id
    $.ajax({
    url: "./customer/id.scan",
    type: "GET",
    cache: false,
    dataType: "json", // or html
    data: params,
    success: function(data){
      //console.log('success');
      var msg = "";
      if (data.count > 0) {
        $('#id').addClass('is-invalid');
        $('#adv').addClass('d-none');
        $('#btn_idcheck').removeClass('d-none');
        $('#id').prop('disabled', false);
      } else {
        $('#id').addClass('is-valid');
        $('#btn_idcheck').addClass('d-none');
        $('#adv').removeClass('d-none');
        $('#id_m').val($('#id').val());
        Cookies.set('checkID', 'TRUE'); // Cookie 값 변경
      }
      
    },
    // 통신 에러, 요청 실패, 200 아닌 경우, dataType이 다른경우
    error: function (request, status, error){  
      console.log('failure');
      //console.log('userid='+$('#userid', frm).val());
      var msg = "에러가 발생했습니다. <br><br>";
      msg += "request.status: " + request.status + "<br>";
      msg += "request.responseText: " + request.responseText + "<br>";
      msg += "status: " + status + "<br>";
      msg += "error: " + error;
      console.log(msg);
      $('#id').prop('disabled', false);
      
    }
  });

    $('#id').removeClass('is-invalid');
    $('#id').removeClass('is-valid');
    $('#id').prop('disabled', true);
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

<div class="container my-auto">
<div class="row">
  <div class="col-md-8 col-lg-6 col-xl-5">
    <form class="needs-validation" name='frm_id' onsubmit="return validator">
      <h3 class="h3">회원 가입</h3>
      
      <div class="form-group">
        <label for="id">아이디 (4글자 이상)</label>
        <input type="text" class="form-control" id="id" name="id" aria-describedby="emailHelp" placeholder="richer">
        <div id="id_val"class="invalid-feedback">
          이미 누가 아이디를 쓰고 있네요!
        </div>
        <div class="valid-feedback">
          아이디를 쓸 수 있어요! 계속해 주세요.
        </div>
      <!--   
      <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="isEmail">
        <label class="custom-control-label" for="isEmail">이메일을 아이디로 사용</label>
      </div>
       -->
      </div>
      <button type="button" id="btn_idcheck" onclick="check_id()" class="btn btn-primary" disabled>다음</button>
    </form>
    <form class="" name='frm' method='POST' action='./register'>
      <input type="hidden" id="id_m" name="id">
      <div id="adv" class="d-none">
      <div class="form-group">
        <label for="name">이름</label>
        <input type="text" class="form-control" id="name" name="name" aria-describedby="emailHelp" placeholder="시오노미야 리셰">
      </div>
      <div class="form-group">
        <label for="email">이메일</label>
        <input type="email" class="form-control" id="email" name="email" aria-describedby="emailHelp" placeholder="richer@gmail.com">

      </div>
      <div class="form-group">
        <label for="passwd">비밀번호</label>
        <input type="password" class="form-control" id="passwd" name="passwd" placeholder="************">
        <small id="emailHelp" class="form-text text-muted">비밀번호는 숫자나 특수문자를 포함하여 8자리 이상 사용을 권장합니다.</small>
      </div>
      <div class="form-group">
        <label for="passwd_2">비밀번호 확인</label>
        <input type="password" class="form-control" id="passwd_2" name="passwd_2" placeholder="************">
      </div>
      
      
      <div class="form-group">
        <label for="phone1">전화번호</label>
        <input type="text" class="form-control" id="phone1" name="phone1" aria-describedby="phone1" placeholder="01012345678">
      </div>
      
      <button type="submit" class="btn btn-primary">가입</button>
      </div>
    </form>
  </div>
</div>
</div>















</body>
</html>
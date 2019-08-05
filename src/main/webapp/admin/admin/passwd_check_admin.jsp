<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath();
%>
<!DOCTYPE html>
<html class="admin" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<title>리셰</title>
<jsp:include page="/admin/ssi.jsp"></jsp:include>

      <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"/>
      
      <link href="${pageContext.request.contextPath}/css/richer.css" rel="Stylesheet" type="text/css"> 
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
      

    <!-- Bootstrap-Iconpicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-iconpicker/1.10.0/css/bootstrap-iconpicker.min.css"/>
    
      <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>   
      <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>  -->  
      
    <!-- Bootstrap-Iconpicker Bundle -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-iconpicker/1.10.0/js/bootstrap-iconpicker.bundle.min.js"></script>
        
      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      
      $(function(){
        //window.history.replaceState("", "", "./list.do");
        //$('[data-toggle="tooltip"]').tooltip();
      });
      
      function send() {
        /* 
        var check = Cookies.get('checkID'); // 쿠키값
        
        if (check != 'TRUE') {
          var msg = "ID 중복확인이 되지 않았습니다.<br>";
          msg += "ID [중복확인] 버튼을 클릭하세요.<br>";
     
          $('#modal_title').html('ID 체크 확인');
          $('#modal_content').attr('class', 'alert alert-danger');
          $('#modal_content').html(msg);
          $('#modal_panel').modal(); // 다이얼로그 출력   
          
          return false; // submit 중지
        }
        
        if ($('#passwd').val() != $('#passwd2').val()) {
          var msg = "입력된 패스워드가 일치하지 않습니다.<br>";
          msg += "패스워드를 다시 입력해주세요.<br>";
     
          $('#modal_title').html('패스워드 일치여부 확인');
          $('#modal_content').attr('class', 'alert alert-danger');
          $('#modal_content').html(msg);
          $('#modal_panel').modal(); // 다이얼로그 출력   
          
          return false; // submit 중지
        }
         */
        
        return true; // submit 진행
      }
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
  
<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="./"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="./list.do">관리자</a></li>
    <li class="breadcrumb-item"><a href="./bio?adminno=${adminno }">${name }</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">비밀번호 변경</a></li>
  </ol>
  </nav>
  <div class="container col-xs-12">
  
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
  
   <form name="frm" id="frm" method='POST' action='./check_passwd.do' 
              onsubmit="return send();" >
    <input type="hidden" name="adminno" value="${adminno }">
    <input type="hidden" name="name" value="${name }">
    <div class="d-flex">
    <h3 class="flex-grow-1">비밀번호 변경</h3>
    <button type="button" onclick="location.href='./list.do'" class="btn btn-outline-secondary" role="button">취소</button>
    <button type="submit" class="btn btn-warning ml-1">계속</button>
    </div>
    <br>
    
    <div class="form-group">
      <label for="passwd_old">계속하시려면 현재 비밀번호를 입력해주세요.</label>
      <input type="password" class="form-control" name="passwd" id="passwd" aria-describedby="name" placeholder="********">
    </div>
 
 
   </form>
  </div> <!-- end col -->
 </div> <!-- end row -->
</div> <!-- end content-wrapper -->
</div>
  
  <div class="pt-5">
  
  </div>
  
  
  
  <!-- 스크롤 문제 해결을 위해 아래 여백 설정-->
  <div class="p-5"></div>
  <jsp:include page="/menu/bottom_admin.jsp" flush='false' />
</body>
</html>
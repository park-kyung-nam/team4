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
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
    
    <!-- bootstrap-select : 카테고리 및 코드 선택용 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/i18n/defaults-*.min.js"></script>
    
      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      
      $(function(){
        //window.history.replaceState("", "", "./list.do");
        //$('[data-toggle="tooltip"]').tooltip();
        //bsCustomFileInput.init()
      });
      
      function send() {
        
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
    <li class="breadcrumb-item"><a href="./list.do">관리자 활동 기록</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">관리자 활동 기록 수정</a></li>
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
  
   <form name="frm" id="frm" method='POST' action='./update.do' 
              onsubmit="return send();" enctype="multipart/form-data">
   <input type="hidden" name="logno" value="${alog.logno }">
   <input type="hidden" name="adminno" value="${alog.adminno }">
    <div class="d-flex">
    <h3 class="flex-grow-1">기록된 로그 수정</h3>
    <button type="button" onclick="location.href='./list.do'" class="btn btn-outline-secondary" role="button">취소</button>
    <button type="submit" class="btn btn-primary ml-1">수정</button>
    </div>
    <br>
    <div class="form-group">
      <label for="id">분류</label>
      <select name="logtype" id="logtype" class="selectpicker form-control" title="로그 분류 선택" data-style="btn-info">
        <c:forEach var="typelist" items="${typelist}" varStatus="info">
          <option value="${typelist.logtype}" ${typelist.logtype == alog.logtype ? 'selected="selected"':'' }>${typelist.typedesc}</option>
        </c:forEach>
      </select>
    </div>
    
    <div class="form-group">
      <label for="id">등록자</label>
      <input type="text" class="form-control" name="name" id="name" aria-describedby="name" placeholder="gildong" value="${alog.adminno }" disabled>
    </div>
    
    <div class="form-group">
      <label for="id">로그 내용</label>
      <input type="text" class="form-control" name="logdesc" id="logdesc" aria-describedby="name" placeholder="상품 등록" value="${alog.logdesc }">
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
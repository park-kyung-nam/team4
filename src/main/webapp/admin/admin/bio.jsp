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
      
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
<jsp:include page="/admin/admin/update_priv.jsp"></jsp:include>
<jsp:include page="/admin/admin/update_unreg.jsp"></jsp:include>
  
<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="./"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="./list.do">관리자</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">${adminInclVO.name }</a></li>
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
  
  <c:choose>
    <c:when test="${adminInclVO.admincodeno == -8 }">
    <div class="alert alert-warning" role="alert">
      <h4 class="alert-heading">이미 탈퇴된 회원입니다.</h4>
      <p>관리자에 의해 탈퇴되거나 사용 중지된 관리자 계정이므로 더 이상 사용할 수 없는 계정입니다.
      해당 계정 정보는 탈퇴로부터 5년간 유지되며 해당 기간이 경과할 경우 계정 정보가 삭제됩니다.</p>
    </div>
    <div class="card bg-dark text-white">
      <img class="card-img" src="../css/tu10.jpg" alt="Card image">
      <div class="card-img-overlay text-muted">
        <img src="./bio/imgs/${adminInclVO.profileimg }" alt="..." class="img-thumbnail float-right" style="max-height: 200px;max-width: 360px; filter: grayscale(100%);">
        <div class="btn-group float-right mr-2" role="group">
        <a role="button" href="" class="btn btn-danger disabled">탈퇴됨</a>
        <button type="button" class="btn btn-secondary " onclick="priv_con(${adminInclVO.adminno})" disabled>${adminInclVO.privchar }</button>
        </div>
        
        <span class="card-title h4">${adminInclVO.name }</span><span class="h5 text-muted">#${adminInclVO.adminno }</span>
        <p class="card-text">@${adminInclVO.id }</p>
        <p class="card-text">${adminInclVO.email }</p>
        <p class="card-text">${adminInclVO.phone1 }</p>
        <p class="card-text">${adminInclVO.phone2 }</p>
        <p class="card-text">${adminInclVO.address }</p>
        <p class="card-text">${adminInclVO.rdate }에 가입</p>
      </div>
    </div>
    </c:when>
    <c:otherwise>
    <c:if test="${adminInclVO.admincodeno == -2 }">
    <div class="alert alert-info" role="alert">
      <h4 class="alert-heading">승인 대기 중인 관리자입니다.</h4>
      <p>해당 관리자 계정은 승인 대기 중에 있으며 총괄 관리자의 승인이 필요합니다.
      승인되어 관리자 권한이 부여되면 해당 계정을 사용할 수 있습니다.</p>
    </div>
    </c:if>
    <div class="card bg-dark text-white">
      <img class="card-img" src="./bio/imgs/bioimg_unset.jpg" alt="Card image">
      <div class="card-img-overlay">
        <img src="./bio/imgs/${adminInclVO.profileimg }" alt="..." class="img-thumbnail float-right" style="max-height: 200px;max-width: 360px;">
        
        <c:if test="${adminInclVO.adminno == sessionScope.adminno || sessionScope.admincodeno == 0 }">
        <div class="btn-group float-right mr-2" role="group">
        <c:if test="${sessionScope.admincodeno == 0 && adminInclVO.adminno != sessionScope.adminno }">
        <button type="button" class="btn btn-danger" onclick="del_con(${adminInclVO.adminno})">${adminInclVO.admincodeno == -2 ? '승인 취소': '탈퇴' }</button>
        </c:if>
        <button type="button" class="btn btn-info" onclick="priv_con(${adminInclVO.adminno})">${adminInclVO.privdesc }</button>
        <c:if test="${adminInclVO.adminno == sessionScope.adminno }">
        <a role="button" href="./check_passwd.do?adminno=${adminInclVO.adminno }" class="btn btn-warning">비밀번호 변경</a>
        </c:if>
        <a role="button" href="./update.do?adminno=${adminInclVO.adminno }" class="btn btn-primary">수정</a>
        </div>
        </c:if>
        
        
        
        
        <span class="card-title h4">${adminInclVO.name }</span><span class="h5 text-muted">#${adminInclVO.adminno }</span>
        <p class="card-text">@${adminInclVO.id }</p>
        <p class="card-text">${adminInclVO.privdesc }</p>
        <p class="card-text">${adminInclVO.email }</p>
        <p class="card-text">${adminInclVO.phone1 }</p>
        <p class="card-text">${adminInclVO.phone2 }</p>
        <p class="card-text">${adminInclVO.address }</p>
        <p class="card-text">${adminInclVO.rdate }에 가입</p>
      </div>
    </div>
    </c:otherwise>
  
  </c:choose>
    
    
 
 
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
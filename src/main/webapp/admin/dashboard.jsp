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
      <link href="${pageContext.request.contextPath}/css/nanami.css" rel="Stylesheet" type="text/css"> 
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
        window.history.replaceState("", "", "${pageContext.request.contextPath}/admin");
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      
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
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item" aria-current="page">대시보드</li>
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
  <div>
    <div class="row mb-4">
    <div class="col-md-6 col-lg-4">
      <div class="card-counter primary">
        <i class="fa fa-code-fork"></i>
        <span class="count-numbers">307</span>
        <span class="count-name">판매량(+108)</span>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="card-counter danger">
        <i class="fa fa-ticket"></i>
        <span class="count-numbers">11.2(억)</span>
        <span class="count-name">매출(+0.41억)</span>
      </div>
    </div>

    <div class="col-md-6 col-lg-4">
      <div class="card-counter info">
        <i class="fa fa-users"></i>
        <span class="count-numbers">350</span>
        <span class="count-name">회원수(+21)</span>
      </div>
    </div>
  </div>
    <div class="row mb-4">
      <div class="col-xs-12 col-sm-6 col-md-4">
      
      <div class="card bg-primary text-white">
            <div class="card-header">
                <div class="text-center">Small Package</div>
            </div>
            <div class="card-body">                
                <h2 class="display-3 text-center">$9.99</h2>
                <p class="card-text text-center">per month</p>
            </div>
            <ul class="list-group list-group-flush">
                <li class="list-group-item list-group-item-primary">
                    <i class="fa fa-check" aria-hidden="true"></i> 
                    Cras justo odio
                </li>
                <li class="list-group-item list-group-item-primary">
                    <i class="fa fa-check" aria-hidden="true"></i> 
                    Dapibus ac facilisis in
                </li>
                <li class="list-group-item list-group-item-primary">
                    <i class="fa fa-check" aria-hidden="true"></i> 
                    Vestibulum at eros
                </li>
            </ul>
            <div class="card-body">
                <button class="btn btn-primary btn-block">Buy Now</button>
            </div>
        </div>  
      </div>
      
      <div class="col-xs-12 col-sm-6 col-md-4">
      
<div class="card card-custom bg-white border-white">
  <div class="card-custom-img" style="background-image: url(http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg);"></div>
  <div class="card-custom-avatar">
    <img class="img-fluid" src="http://res.cloudinary.com/d3/image/upload/c_pad,g_center,h_200,q_auto:eco,w_200/bootstrap-logo_u3c8dx.jpg" alt="Avatar" />
  </div>
  <div class="card-body" style="overflow-y: auto">
    <h4 class="card-title">관리자 승인 대기 중</h4>
    <p class="card-text">새로운 관리자 계정이 승인을 기다리고 있습니다. </p>
  </div>
  <div class="card-footer" style="background: inherit; border-color: inherit;">
    <a href="./admin/admin/list.do" class="btn btn-primary">관리자 목록</a>
    <a href="#" class="btn btn-outline-primary">닫기</a>
  </div>
</div>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-4">
<div class="card card-custom bg-success border-success text-white">
  <div class="card-custom-img" style="background-image: url(http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg);"></div>
  <div class="card-custom-avatar">
    <img class="img-fluid" src="http://res.cloudinary.com/d3/image/upload/c_pad,g_center,h_200,q_auto:eco,w_200/bootstrap-logo_u3c8dx.jpg" alt="Avatar" />
  </div>
  <div class="card-body" style="overflow-y: auto">
    <h4 class="card-title">종료된 이벤트가 있습니다.</h4>
    <p class="card-text">이벤트가 종료되었으나 당첨자가 발표되지 않았습니다.</p>
    <p class="card-text">발표일자 : 2023/01/01</p>
  </div>
  <div class="card-footer" style="background: inherit; border-color: inherit;">
    <a href="#" class="btn btn-light">이벤트 정보</a>
    <a href="#" class="btn btn-outline-light">닫기</a>
  </div>
</div>
      </div>
      <div class="col-xs-12 col-sm-6 col-md-4">
<div class="card card-custom bg-danger border-danger text-white">
  <div class="card-custom-img" style="background-image: url(http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg);"></div>
  <div class="card-custom-avatar">
    <img class="img-fluid" src="http://res.cloudinary.com/d3/image/upload/c_pad,g_center,h_200,q_auto:eco,w_200/bootstrap-logo_u3c8dx.jpg" alt="Avatar" />
  </div>
  <div class="card-body" style="overflow-y: auto">
    <h4 class="card-title">제품 재고 부족</h4>
    <p class="card-text">23개 제품의 재고가 부족합니다. </p>
  </div>
  <div class="card-footer" style="background: inherit; border-color: inherit;">
    <a href="#" class="btn btn-dark">상품 목록</a>
    <a href="#" class="btn btn-outline-light">닫기</a>
  </div>
</div>
      </div>
    </div>
  
  <div class="card card-custom-wide">
  <div class="card-custom-wide-img" style="background-image: url(http://res.cloudinary.com/d3/image/upload/c_scale,q_auto:good,w_1110/trianglify-v1-cs85g_cc5d2i.jpg);"></div>
  <div class="card-custom-avatar">
    <img class="img-fluid" src="http://res.cloudinary.com/d3/image/upload/c_pad,g_center,h_200,q_auto:eco,w_200/bootstrap-logo_u3c8dx.jpg" alt="Avatar" />
  </div>
  <div class="card-body">
    <h4 class="card-title">최근 등록된 상품</h4>
    <p class="card-text">This is wide variant without the upper picture cut. It will extend to adapt to text, buttons, etc... whatever you put in card body.</p>
    <p class="card-text">Some example text. Lorem ipsum dolor sit amet, te vix omittam fastidii, enim paulo omnes ea has, illud luptatum no qui. Sed ea qualisque urbanitas, purto elit nec te. Possim inermis antiopam ut eum. Eos te zril labore laboramus, quem erant nam in. Ut sed molestie antiopam. At altera facilisis mel.</p>
  </div>
</div>
  
  </div>
  
  
  
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
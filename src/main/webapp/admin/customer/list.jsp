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
<jsp:include page="/admin/customer/ssi.jsp"></jsp:include>

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
      var nameurl='${search_name}';
      var pagingurl='';
      
      $(function(){
        nameurl='${search_name}';
        if('${nowPage}' != null){
          pagingurl = '&nowPage='+'${nowPage}';
        }
        window.history.replaceState("", "", "${pageContext.request.contextPath}/admin/customer/list.do?name="+nameurl+pagingurl);
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
<jsp:include page="/admin/customer/update_priv.jsp"></jsp:include>
<jsp:include page="/admin/customer/update_unreg.jsp"></jsp:include>
<jsp:include page="/admin/customer/delete.jsp"></jsp:include>

<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">회원 목록</a></li>
  </ol>
  </nav>
    <div class="container col-xs-12">
   <!--  
  <div id="favnav" class="d-flex mx-3">
    <nav class="nav pt-0 mb-0 mr-auto">
       <a class="nav-link px-2" href="javascript:void(0);">
         <i class="material-icons">favorite</i> 12345
       </a>
    </nav>
  </div>   -->
  
  <!-- 
  
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong>케이쨩</strong> 카테고리 그룹을 생성하였습니다.
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
   -->
   
   <!-- 
    alert-primary
    alert-secondary
    alert-success
    alert-warning
    alert-danger
    alert-info
    alert-light
    alert-dark
    -->
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
  <div class="d-flex">
  <h3 class="flex-grow-1">전체 회원 목록</h3>
  
  <nav class="mr-2 my-1">${paging }</nav>
  <form class="form-inline"name='sfrm' id='sfrm' method="get" action="./list.do">
  <div class="input-group mr-2">
  <input type="text" name="name" id="s_name" value="${search_name }" class="form-control" placeholder="이름" aria-label="이름" aria-describedby="button-addon2">
  <div class="input-group-append">
    <a href="${pageContext.request.contextPath}/admin/customer/list.do"class="btn btn-light btn-outline-danger" id="button-addon2">
      <i class="material-icons">clear</i>
    </a>
    <button class="btn btn-light btn-outline-secondary" type="submit" id="button-addon2">
      <i class="material-icons">search</i>
    </button>
  </div>
  </div>
  
  <a href="${pageContext.request.contextPath}/rinon" class="btn btn-secondary mr-2">임의 회원 생성</a>
  <a href="${pageContext.request.contextPath}/register" class="btn btn-success">회원 추가</a>
  </form>
  </div>
  <br>
  <c:choose>
  <c:when test="${sessionScope.admincodeno == 0 || sessionScope.admincodeno == 5 }">
  <TABLE class='table table-sm table-striped table-hover' >
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 28%;'/>
    <col style='width: 15%;'/>
    <col style='width: 12%;'/>
  </colgroup>
  <thead>
    <tr>
      <TH style='text-align: center ;'>#</TH>
      <TH style='text-align: center ;'>@</TH>
      <TH style='text-align: center ;'>ID</TH>
      <TH style='text-align: center ;'>이름</TH>
      <TH style='text-align: center ;'>주소</TH>
      <TH style='text-align: center ;'>가입일/탈퇴일</TH>
      <TH style='text-align: center ;'>기타</TH>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="cus" items="${list}" varStatus="info">
  <c:choose>
  <c:when test="${cus.customerstatscodeno > 1}">
  <tr class="text-danger">
      <td>${cus.customerno }</td>
      <td><a href=""class="align-baseline btn btn-block btn-outline-danger btn-sm p-0 disabled">${cus.customerstatschar }</a></td>
      <td><strong><del>${cus.id }</del></strong></td>
      <td>
      <del><a href="./bio?customerno=${cus.customerno }" class="text-danger">${cus.name }</a></del>
      </td>
      <td class="">-</td>
      <td>${cus.ddate }</td>
      <td>
        (사용 불가)
      </td>
    </tr>
  </c:when>
  <c:otherwise>
  <tr>
      <td>${cus.customerno }</td>
      <td><a href="javascript:customerstats_con(${cus.customerno })" class="align-baseline btn btn-block btn-secondary btn-sm p-0" data-toggle="tooltip" data-placement="right" title="${cus.customerstatsdesc }">${cus.customerstatschar }</a></td>
      <td><strong>${cus.id }</strong></td>
      <td>
      <a href="./bio?customerno=${cus.customerno }">${cus.name }</a>
      </td>
      <td class="">${cus.address }</td>
      <td>${cus.rdate }</td>
      <td>
      <div class="btn-group btn-group-sm btn-block" role="group" aria-label="">
      <a href="./update.do?customerno=${cus.customerno }"role="button" class="btn btn-sm btn-info py-0" data-toggle="tooltip" data-placement="left" title="수정">
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        <a href="javascript:del_con(${cus.customerno })"role="button" class="btn btn-sm btn-danger py-0" data-toggle="tooltip" data-placement="left" title="강제 탈퇴">
         <span>
          <i class="material-icons">highlight_off</i>
         </span>
        </a>
        <a href="javascript:rem_con(${cus.customerno })"role="button" class="btn btn-sm btn-dark py-0" data-toggle="tooltip" data-placement="left" title="회원 정보 삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </div>
        
      </td>
    </tr>
  </c:otherwise>
  </c:choose>
  
  
    
  </c:forEach>
  </tbody>
  </TABLE>
  </c:when>
  <c:otherwise>
  <TABLE class='table table-sm table-striped table-hover' >
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 30%;'/>
    <col style='width: 25%;'/>
    <col style='width: 20%;'/>
    <col style='width: 14%;'/>
  </colgroup>
  <thead>
    <tr>
      <TH style='text-align: center ;'>#</TH>
      <TH style='text-align: center ;'>@</TH>
      <TH style='text-align: center ;'>ID</TH>
      <TH style='text-align: center ;'>이름</TH>
      <TH style='text-align: center ;'>가입일/탈퇴일</TH>
      <TH style='text-align: center ;'>기타</TH>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="cus" items="${list}" varStatus="info">
  <c:choose>
  <c:when test="${cus.customerstatscodeno > 1}">
  <tr class="text-danger">
      <td>${cus.customerno }</td>
      <td><a href=""class="align-baseline btn btn-block btn-outline-danger btn-sm p-0 disabled">${cus.customerstatschar }</a></td>
      <td><strong><del>${cus.id }</del></strong></td>
      <td>
      <del><a href="./bio?customerno=${cus.customerno }" class="text-danger">${cus.name }</a></del>
      </td>
      <td>${cus.ddate }</td>
      <td>
        (이용 제한)
      </td>
    </tr>
  </c:when>
  <c:otherwise>
  <tr>
      <td>${cus.customerno }</td>
      <td><a href="javascript:customerstats_con(${cus.customerno })" class="align-baseline btn btn-block btn-secondary btn-sm p-0" data-toggle="tooltip" data-placement="right" title="${cus.customerstatsdesc }">${cus.customerstatschar }</a></td>
      <td><strong>${cus.id }</strong></td>
      <td>
      <a href="./bio?customerno=${cus.customerno }">${cus.name }</a>
      </td>
      <td>${cus.rdate }</td>
      <td>
      <div class="btn-group btn-group-sm btn-block" role="group" aria-label="">
      <a href="#"role="button" class="btn btn-sm btn-info py-0 disabled" data-toggle="tooltip" data-placement="left" title="수정">
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        <a href="#"role="button" class="btn btn-sm btn-danger py-0 disabled" data-toggle="tooltip" data-placement="left" title="이용 제한">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </div>
        
      </td>
    </tr>
  </c:otherwise>
  </c:choose>
  
  
    
  </c:forEach>
  </tbody>
  </TABLE>
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
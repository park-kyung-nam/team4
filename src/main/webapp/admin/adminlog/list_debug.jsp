<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
        
    <!-- bootstrap-select : 카테고리 및 코드 선택용 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/i18n/defaults-*.min.js"></script>    
    
      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      var typeurl='${logtype}';
      var descurl='${logdesc}';
      var pagingurl='';
      
      $(function(){
        descurl='${logdesc}';
        typeurl='${logtype}';
        if('${nowPage}' != null){
          pagingurl = '&nowPage='+'${nowPage}';
        }
        window.history.replaceState("", "", "${pageContext.request.contextPath}/admin/adminlog/list.do?logtype="+typeurl+'&logdesc='+descurl+pagingurl);
        $('[data-toggle="tooltip"]').tooltip();
      });
        
      
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
<jsp:include page="/admin/adminlog/delete.jsp"></jsp:include>


<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/logs">로그</a></li>
    
  <c:choose>
    <c:when test="${logdesc != ''}">
    <li class="breadcrumb-item" aria-current="page">
    <a href="${pageContext.request.contextPath}/admin/adminlog/list.do">관리자 로그</a>
    </li>
    <li class="breadcrumb-item active" aria-current="page">[${logdesc }] 검색</li>
    </c:when>
    <c:otherwise>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">관리자 활동 전체 기록</a></li>
    </c:otherwise>
  </c:choose>
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
  <h3 class="flex-grow-1">
  <c:choose>
    <c:when test="${logdesc != ''}">
    [${logdesc }] 검색 결과(${search_count }건)
    </c:when>
    <c:otherwise>
    전체 관리자 로그 기록
    </c:otherwise>
  </c:choose>
  
  </h3>
  
  <form class="form-inline"name='sfrm' id='sfrm' method="get" action="./list.do">
  ${paging }
  <div class="input-group mx-2">
  <input type="text" name="logdesc" id="logdesc" value="${logdesc }" class="form-control" placeholder="내용 검색" aria-label="내용 검색" aria-describedby="button-addon2">
  <div class="input-group-append">
  <c:if test="${logdesc != ''}">
    <a href="${pageContext.request.contextPath}/admin/adminlog/list.do"class="btn btn-light btn-outline-danger" id="button-addon2"data-toggle="tooltip"
      data-placement="top" title="검색 초기화">
      <i class="material-icons">clear</i>
    </a>
   </c:if>
    
    <button class="btn btn-light btn-outline-info" type="button" id="button-more" data-toggle="tooltip"
      data-placement="top" title="상세 검색">
      <i class="material-icons">add</i>
    </button>
    <button class="btn btn-light btn-outline-secondary" type="submit" id="button-addon2">
      <i class="material-icons">search</i>
    </button>
  </div>
  </div>
  
  <a href="${pageContext.request.contextPath}/adminlog/create.do" class="btn btn-success">수동 기록</a>
  </form>
  
  </div>
  <br>
  
  <TABLE class='table table-sm table-striped table-hover' >
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 55%;'/>
    <col style='width: 15%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <thead>
    <tr>
      <TH style='text-align: center ;'>#</TH>
      <TH style='text-align: center ;'>분류</TH>
      <TH style='text-align: center ;'>이름</TH>
      <TH style='text-align: center ;'>기록</TH>
      <TH style='text-align: center ;'>등록일</TH>
      <TH style='text-align: center ;'>기타</TH>
    </tr>
  </thead>
  <tbody>
  <!-- 
  <tr>
    <td>-</td>
    <td>-</td>
    <td>
      <a class="btn btn-sm btn-warning py-0 px-1" data-toggle="tooltip" data-placement="right" title="카테고리가 정해지지 않음">
        <i class="material-icons">error_outline</i>
      </a>
        &nbsp;
        (없음)
    </td>
    <td>-</td>
    <td>-</td>
  </tr>
   -->
  <c:forEach var="list" items="${list}" varStatus="info">
  <c:choose>
  <c:when test="${list.adminno == -1}">
  <tr class="text-danger">
      <td>${list.logno }</td>
      <td><a class="align-baseline btn btn-block btn-info btn-sm text-light p-0" data-toggle="tooltip" 
      href="./list.do?logtype=${list.logtype }"
      data-placement="right" title="클릭하여 ${list.typedesc } 분류의 로그 검색">${list.typedesc }</a></td>
      <td><del>${list.name }</del></td>
      <td><del><a href="./check.do?logno=${list.logno }" class="text-danger">${list.logdesc }</a></del></td>
      <fmt:parseDate value="${list.logdate}" pattern="yyyy-MM-dd HH:mm" var="logdate_t"/>
      <td><fmt:formatDate value="${logdate_t}" pattern="yyyy-MM-dd"/></td>
      <td>
        <a href="./update.do?logno=${list.logno }"role="button" class="btn btn-sm btn-info p-0" data-toggle="tooltip" data-placement="left" title="로그 수정">
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        &nbsp;
        <a href="javascript:del_con(${list.logno })"role="button" class="btn btn-sm btn-danger p-0" data-toggle="tooltip" data-placement="left" title="로그 삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </td>
  </tr>
  </c:when>
  <c:otherwise>
  <tr>
      <td>${list.logno }</td>
      <td><a class="align-baseline btn btn-block btn-info btn-sm text-light p-0" data-toggle="tooltip" 
      href="./list.do?logtype=${list.logtype }"
      data-placement="right" title="클릭하여 ${list.typedesc } 분류의 로그 검색">${list.typedesc }</a></td>
      <td>${list.name }</td>
      <td><a href="./check.do?logno=${list.logno }">${list.logdesc }</a></td>
      <fmt:parseDate value="${list.logdate}" pattern="yyyy-MM-dd HH:mm" var="logdate_t"/>
      <td><fmt:formatDate value="${logdate_t}" pattern="yyyy-MM-dd"/></td>
      <td>
        <a href="./update.do?logno=${list.logno }"role="button" class="btn btn-sm btn-info p-0" data-toggle="tooltip" data-placement="left" title="로그 수정">
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        &nbsp;
        <a href="javascript:del_con(${list.logno })"role="button" class="btn btn-sm btn-danger p-0" data-toggle="tooltip" data-placement="left" title="로그 삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </td>
  </tr>
  </c:otherwise>
  </c:choose>
  
  
    
  </c:forEach>
  </tbody>
  </TABLE>
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
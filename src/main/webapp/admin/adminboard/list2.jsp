<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
        var name = "";
        var id = "";
        var content = "";
        var word = "";
        if('${param.name}' != ''){
          name= '&name=${param.name}';
        }
        if('${param.id}' != ''){
          id= '&id=${param.id}';
        }
        if('${param.content}' != ''){
          content= '&content=${param.content}';
        }
        if('${param.word}' != ''){
          word= '&word=${param.word}';
        }
        
        
        window.history.replaceState("", "", "./list.do?"+name+id+content+word);
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
<jsp:include page="/admin/adminboard/delete.jsp"></jsp:include>
<%-- 
<jsp:include page="/admin/admin/update_priv.jsp"></jsp:include>
<jsp:include page="/admin/admin/update_unreg.jsp"></jsp:include>
 --%>
<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="../"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">관리자 게시판</a></li>
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
  <h3 class="flex-grow-1">관리자 게시판 목록</h3>
  
  
  <form class="form-inline"name='sfrm' id='sfrm' method="get" action="./list.do">
  ${paging }
  <div class="input-group mx-2">
  <input type="text" name="content" id="content" value="${param.content }" class="form-control" placeholder="내용 검색" aria-label="내용 검색" aria-describedby="button-addon2">
  <div class="input-group-append">
  <c:if test="${param.content != null}">
    <a href="./list.do"class="btn btn-light btn-outline-danger" id="button-addon2"data-toggle="tooltip"
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
  
  <a href="./create.do" class="btn btn-primary">게시글 작성</a>
  </form>
  
  </div>
  <br>
  
  <TABLE class='table table-sm table-striped table-hover' >
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 58%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 12%;'/>
  </colgroup>
  <thead>
    <tr>
      <TH style='text-align: center ;'>#</TH>
      <TH style='text-align: center ;'>제목</TH>
      <TH style='text-align: center ;'>게시자</TH>
      <TH style='text-align: center ;'>등록일</TH>
      <TH style='text-align: center ;'>기타</TH>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="blist" items="${list}" varStatus="info">
    <tr>
      <td>${blist.adminboardno }</td>
      <td>
        <a href="./read.do?adminboardno=${blist.adminboardno }" 
          role="button" class="btn btn-link text-decoration-none py-0 my-0 pr-0">
        ${blist.title }
        <%-- TODO : 댓글 테이블 구현시 수정 --%>
        <c:if test="${1 == 1 }">
          &nbsp;<span class="badge badge-danger"> ${blist.cnt }</span>
        </c:if>
          &nbsp;<span class="badge badge-secondary"> ${blist.cnt }</span>
        </a>
      </td>
      <td>${blist.name }</td>
      <td>${fn:substring(blist.rdate, 0, 10)}</td>
      <td>
      <div class="btn-group btn-group-sm btn-block" role="group" aria-label="">
      <a href="./update.do?adminboardno=${blist.adminboardno }"role="button" 
        class="btn btn-sm btn-info py-0 ${(sessionScope.admincodeno == 0 || blist.adminno == sessionScope.adminno) ? '':'disabled'}" 
        data-toggle="tooltip" data-placement="left" title="수정"
        >
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        <a href="javascript:del(${blist.adminboardno })"role="button" 
        class="btn btn-sm btn-danger py-0 ${(sessionScope.admincodeno == 0 || blist.adminno == sessionScope.adminno) ? '':'disabled'}" 
        data-toggle="tooltip" data-placement="left" title="삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </div>
        
      </td>
    </tr>
  
    
  </c:forEach>
  </tbody>
  </TABLE>
  <div>
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
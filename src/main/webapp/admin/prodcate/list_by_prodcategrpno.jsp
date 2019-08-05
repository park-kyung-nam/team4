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
        //window.history.replaceState("", "", "./empty.jsp");
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      
      </script>
      
      <script type="text/javascript">

//출력 유무 Y -> N
function nonvisible(prodcateno) {
  var frm_visible = $('#frm_seqno');
  frm_visible.attr('action', './nonvisible.do');
  $('#prodcateno', frm_visible).val(prodcateno);
  frm_visible.submit();
}
//출력 유무 N -> Y
function visible(prodcateno) {
  var frm_visible = $('#frm_seqno');
  frm_visible.attr('action', './visible.do');
  $('#prodcateno', frm_visible).val(prodcateno);
  frm_visible.submit();
}

// 우선순위 up 10 -> 1
function seqnoUp(prodcateno) {
  var frm_seqno = $('#frm_seqno');
  frm_seqno.attr('action', './update_seqno_up.do');
  $('#prodcateno', frm_seqno).val(prodcateno);
  frm_seqno.submit();
}

// 우선순위 down 1 -> 10
function seqnoDown(prodcateno) {
  var frm_seqno = $('#frm_seqno');
  frm_seqno.attr('action', './update_seqno_down.do');
  $('#prodcateno', frm_seqno).val(prodcateno);
  frm_seqno.submit();
}

function cancel() {
  $('#panel_update').hide();
  $('#panel_delete').hide();
  $('#panel_create').show();
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
  <!-- 페이지 위치 구간 -->
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="../prodcategrp/list.do">카테고리</a></li>
    <li class="breadcrumb-item active" aria-current="page"><A href='./list_by_prodcategrpno.do?prodcategrpno=${param.prodcategrpno }'>${prodcategrpVO.prodgrp_title }</A> </li>
  </ol>
  </nav>
  <!-- /페이지 위치 구간 종료 -->
  
  <div class="container col-xs-12">
  <!-- 알림 메시지 구간 -->
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
  <!-- /알림 메시지 구간 종료 -->
  <!-- 내용 합치는 구간 -->
  
  
  <!-- 우선 순위 증가 감소 폼, GET -> POST -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='prodcateno' id='prodcateno' value=''>
    <input type='hidden' name='viewno' id='viewno' value='1'>
  </FORM>
  
  <!-- 출력 유무 폼, GET -> POST -->
  <FORM name='frm_visible' id='frm_visible' method='post' action=''>
    <input type='hidden' name='prodcateno' id='prodcateno' value=''>
    <input type='hidden' name='viewno' id='viewno' value='1'>
  </FORM>

  <div class="d-flex">
  <h3 class="flex-grow-1">${prodcategrpVO.prodgrp_title }<span class="h4">의 서브 카테고리</span></h3>
  
  <!-- 검색 기능이 없으므로 일단 주석 -->
  <form class="form-inline"name='sfrm' id='sfrm' method="get" action="./list_by_prodcateno.do">
  <%-- 
    <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
  <div class="input-group mx-2">
  <input type="text" name="content" id="content" value="${param.word }" class="form-control" placeholder="검색" aria-label="검색" aria-describedby="button-addon2">
  <div class="input-group-append">
  <c:if test="${param.content != null}">
    <a href="./list_by_prodcateno.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }"class="btn btn-light btn-outline-danger" id="button-addon2"data-toggle="tooltip"
      data-placement="top" title="검색 초기화">
      <i class="material-icons">clear</i>
    </a>
   </c:if>
    <button class="btn btn-light btn-outline-secondary" type="submit" id="button-addon2">
      <i class="material-icons">search</i>
    </button>
  </div>
  </div>
   --%>
  
  <a href="./create.do?prodcategrpno=${param.prodcategrpno }" class="btn btn-primary">카테고리 추가</a>
  </form>
  </div>
  <br>


<TABLE class='table table-striped table-sm'>
  <colgroup>
    <col style='width: 7%;'/>
    <col style='width: 7%;'/>
    <col style='width: 10%;'/>
    <col style='width: 29%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 7%;'/>
    <col style='width: 15%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>#</TH>
    <TH style='text-align: center ;'>순서</TH>
    <TH style='text-align: center ;'>대분류</TH>
    <TH style='text-align: center ;'>분류명</TH>
    <TH style='text-align: center ;'>계정</TH>
    <TH style='text-align: center ;'>날짜</TH>
    <TH style='text-align: center ;'>출력</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="prodcategrp_ProdcateVO" items="${list }" varStatus="info">
  <TR>
    <TD style='text-align: center ;'>${info.count }</TD>
    <TD style='text-align: center ;'>${prodcategrp_ProdcateVO.prodcate_seqno }</TD>
    <TD style='text-align: center ;'>${prodcategrp_ProdcateVO.prodgrp_title }</TD>
    <TD><A href='../product/list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&viewno=1&nowPage=1&prod_word=&customerno=${sessionScope.customerno}'>${prodcategrp_ProdcateVO.prodcate_title }</A></TD>
    <TD>${prodcategrp_ProdcateVO.prodcate_ids }</TD>
    <TD style='text-align: center ;'>${prodcategrp_ProdcateVO.prodcate_rdate.substring(0, 10) }</TD>
    <TD style='text-align: center ;'>
    <c:choose>
      <c:when test="${prodcategrp_ProdcateVO.prodcate_visible == 'Y'}">
      <a href="javascript:nonvisible(${prodcategrp_ProdcateVO.prodcateno })"role="button" 
        class="btn btn-sm btn-success py-0" 
        data-toggle="tooltip" data-placement="left" title="현재 공개됨. 클릭하여 비공개로 전환"
        >
         <span>
          <i class="material-icons">visibility</i>
         </span>
        </a>
      </c:when>
      <c:when test="${prodcategrp_ProdcateVO.prodcate_visible == 'N'}">
      <a href="javascript:visible(${prodcategrp_ProdcateVO.prodcateno })"role="button" 
        class="btn btn-sm btn-outline-dark py-0" 
        data-toggle="tooltip" data-placement="left" title="현재 공개되지 않음. 클릭하여 공개로 전환"
        >
         <span>
          <i class="material-icons">visibility_off</i>
         </span>
        </a>
      </c:when>
    </c:choose>
    </TD>
    <TD style='text-align: center ;'>
    
    
      <div class="btn-group btn-group-sm btn-block" role="group" aria-label="">
      <a href="../product/create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"role="button" 
        class="btn btn-sm btn-success py-0" 
        data-toggle="tooltip" data-placement="left" title="이 카테고리에서 신규 제품 추가"
        >
         <span>
          <i class="material-icons">add</i>
         </span>
        </a>
      <a href="./update.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"role="button" 
        class="btn btn-sm btn-info py-0" 
        data-toggle="tooltip" data-placement="left" title="수정"
        >
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        <a href="javascript:seqnoUp(${prodcategrp_ProdcateVO.prodcateno })"role="button" 
          class="btn btn-sm btn-dark py-0 " 
          data-toggle="tooltip" data-placement="left" title="위로 이동"
          >
         <span>
          <i class="material-icons">arrow_upward</i>
         </span>
        </a>
        <a href="javascript:seqnoDown(${prodcategrp_ProdcateVO.prodcateno })"role="button" 
          class="btn btn-sm btn-dark py-0 " 
          data-toggle="tooltip" data-placement="left" title="아래로 이동"
          >
         <span>
          <i class="material-icons">arrow_downward</i>
         </span>
        </a>
        
        <a href="./delete.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"role="button" 
        class="btn btn-sm btn-danger py-0 " 
        data-toggle="tooltip" data-placement="left" title="카테고리 삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </div>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
  
</TABLE>


  <!-- /내용 합치는 구간 종료 -->
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
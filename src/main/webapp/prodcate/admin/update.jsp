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
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item" aria-current="page">대시보드</li>
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
  
  <DIV class='content' style='width: 50%;'>

<DIV class='title_line' style='width: 70%;'>
  『${prodcategrp_ProdcateVO.prodgrp_title } > ${prodcategrp_ProdcateVO.prodcate_title}』 카테고리 수정
</DIV>

<FORM name='frm' method='POST' action='./update.do'>
  <!-- 개발시 임시 값 사용: 1 -->
  <input type='hidden' name='prodcategrpno' id='prodcategrpno' value='${prodcategrp_ProdcateVO.prodcategrpno }'>
  <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
  <input type='hidden' name='viewno' id='viewno' value='1'>
  
  <fieldset class='fieldset_basic'>
    <ul>
      <li class='li_none'>
        <label>카테고리를 수정합니다.</label>
      </li>
    
      <li class='li_none'>
        <label for='title'>카테고리 이름</label>
        <input type='text' name='prodcate_title' id='title' value='${prodcategrp_ProdcateVO.prodcate_title }' required="required" autofocus="autofocus">
      </li>
      <li class='li_none'>
        <label for='seqno'>출력 순서</label>
        <input type='number' name='prodcate_seqno' id='seqno' value='${prodcategrp_ProdcateVO.prodcate_seqno }' required="required" placeholder="${seqno }" min="1" max="1000" style='width: 70%;'>
      </li>
      <li class='li_none'>
        <label for='visible'>출력 형식</label>
        <select name='prodcate_visible'>
          <option value='Y' ${prodcategrp_ProdcateVO.prodcate_visible == 'Y' ? "selected='selected'" : "" }>Y</option>
          <option value='N' ${prodcategrp_ProdcateVO.prodcate_visible == 'N' ? "selected='selected'" : "" }>N</option>
        </select>
      </li>
      <li class='li_none'>
        <label for='ids'>접근 계정</label>
        <input type='text' name='prodcate_ids' id='ids' value='${prodcategrp_ProdcateVO.prodcate_ids }' required="required">
      </li>

      <li class='li_right'>
        <button type="submit">수정</button>
        <button type="button" onclick="location.href='./list_by_prodcategrpno.do?prodcategrpno=${param.prodcategrpno}'">취소[목록]</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
  
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
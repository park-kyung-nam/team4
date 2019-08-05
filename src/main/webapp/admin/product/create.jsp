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
    
      <!-- tagsinput -->
    <link href="${pageContext.request.contextPath}/rinon/tagsinput/tagsinput.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/rinon/tagsinput/tagsinput.js"></script>
    
    
      <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/ckeditor/ckeditor.js"></script>
      <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
      
        
      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      
      $(function(){
        //window.history.replaceState("", "", "./empty.jsp");
        bsCustomFileInput.init()
        $('[data-toggle="tooltip"]').tooltip();
        CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
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
    <li class="breadcrumb-item"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="../prodcategrp/list.do">카테고리</a></li>
    <li class="breadcrumb-item"><A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> </li>
    <li class="breadcrumb-item"><A href='../product/list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>${prodcategrp_ProdcateVO.prodcate_title }</A> </li>
    
    <li class="breadcrumb-item active" aria-current="page"><A href='javascript:location.reload();'>새로운 제품 등록</A></li>
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

  <DIV class='content' style='width: 100%;'>
    <FORM name='frm' method='POST' action='./create.do'
               enctype="multipart/form-data" class="form-horizontal">
               
      <!-- 테스트를 위하여 카테고리를 1번 지정 -->         
      <input type='hidden' name='prodcateno' id='prodcateno' value='${param.prodcateno }'>
      
      <!-- 테스트를 위하여 회원번호를 1번 지정 -->
      <input type='hidden' name='adminno' id='mno' value='1'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      <input type='hidden' name='viewno' id='viewno' value='${param.viewno }'>
      <input type='hidden' name='customerno' id='customerno' value='${param.customerno }'>
      <input type='hidden' name='ip' id='ip' value='127.0.0.1'>
      
      
      
  <div class="form-row">
    <div class="form-group col">
      <label for="title">제품명</label>
      <input class="form-control" type='text' name='prod_title' id='title' value='CPU 제품' required="required" autofocus="autofocus">
    </div>
    <div class="form-group col">
      <label for="title">제품 가격</label>
      <input type='number' class="form-control" name='prod_price' id='prod_price' value='0'>
    </div>
    <div class="form-group col">
      <label for="title">제조사</label>
      <input class="form-control" type='text' name='prod_maker' id='prod_maker' value='인텔' required="required" autofocus="autofocus">
    </div>
  </div>

  
  <div class="mx-auto mb-3">
    <textarea class="form-control input-lg" name='prod_content' id='content'>제품 설명을 입력하세요.</textarea>
  </div>

  <div class="form-row">
    <div class="form-group mb-3 col">
      <input type="text" data-role="tagsinput" name='prod_word' id='word' class="form-control" placeholder="태그" aria-label="mainurl" aria-describedby="basic-addon1"
        value='CPU,SSD,RAM,ODD'>
    </div>
  </div>
  
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="inputGroupFileAddon01"><i class="material-icons">attachment</i>&nbsp;&nbsp;파일 업로드</span>
      </div>
      <div class="custom-file">
        <input type="file" name='filesMF' class="custom-file-input" id="filesMF" aria-describedby="filesMF" data-browse="파일 찾기" multiple="multiple">
        <label class="custom-file-label" for="filesMF">업로드할 파일 선택</label>
      </div>
    </div>
      
      
  <div class="form-row">
    <div class="form-group col-lg-6">
      <button type="button" class="btn btn-block btn-outline-dark" onclick="history.back()">취소[목록]</button>
    </div>
    <div class="form-group col-lg-6">
      <button type="submit" class="btn btn-block btn-success">등록</button>
    </div>
  </div>

    </FORM>
  </DIV>


  
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
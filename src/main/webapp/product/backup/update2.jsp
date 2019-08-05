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
<title>지능형PC쇼핑몰</title>
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
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>
      
<script type="text/JavaScript">
window.onload=function(){
  CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
};
</script>
      
<script type="text/JavaScript">

  function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 13.5%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
  
    $('#main_panel').html(panel);
    $('#main_panel').show();
  
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
  
  <DIV class='content'>     

  <ASIDE style='float: left;'>
    <!-- 카테고리 그룹 > 해외 여행 > 스위스 -->
    <A href='../prodcategrp/list.do'>카테고리 그룹</A> >
    <A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> > 
    <A href='./list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&viewno=1&nowPage=1&prod_word=&customerno=${sessionScope.customerno}'>${prodcategrp_ProdcateVO.prodcate_title }</A>
    <!--<A href='./list.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>${prodcategrp_ProdcateVO.prodcate_title }</A> -->
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?prodcateno=${prodcategoryVO.prodcateno }'>등록</A>

  </ASIDE> 

  <div class='menu_line'></div>
  <FORM name='frm' method='POST' action='./update.do'
               enctype="multipart/form-data" class="form-horizontal">
      <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
      <input type='hidden' name='productno' id='productno' value='${productVO.productno }'>
      <input type='hidden' name='viewno' id='viewno' value='${param.viewno }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      <input type='hidden' name='customerno' id='customerno' value='${param.customerno }'>
      
      <div class="form-group">   
        <label for="title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-md" name='prod_title' id='title' value='${productVO.prod_title}' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-md" name='prod_content' id='content'  rows='10'>${productVO.prod_content}</textarea>
        </div>
      </div>
      
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label"><span style='font-size: 0.99em;'>검색어</span></label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='prod_word' id='word' value='${productVO.prod_word }' placeholder="검색어">
        </div>
      </div>
      
      <div id='file1Panel' class="form-group">
        
        <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
        
        <label class="col-md-2 control-label"></label>
        <div class="col-md-10">
          <c:if test="${file_list.size() > 0 }">
              <DIV>
                <c:forEach var ="fileVO"  items="${file_list }">
                  <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
                </c:forEach>
              </DIV>
            </c:if>
        </div>
      </div>
      <div class="form-group">   
        <label for="content" class="col-md-1 control-label">가격</label>
        <div class="col-md-4">
          <input type='text' class="form-control input-lg" name='prod_price' id='prod_price' value='0'>
        </div>
        <label for="content" class="col-md-1 control-label">ip</label>
        <div class="col-md-5">
          <input type='text' class="form-control input-lg" name='ip' id='ip' value='http://'>
        </div>
        <label for="content" class="col-md-1 control-label">제조사</label>
        <div class="col-md-4">
          <input type='text' class="form-control input-lg" name='prod_maker' id='prod_maker' value='인텔'>
        </div>
      </div>
      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">파일</label>
        
        <div class="col-md-11">
          <input type="file" class="form-control input-md" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">변경된 내용 저장</button>
        <!--<button type="button" onclick="location.href='./list.do?prodcateno=${prodcateVO.prodcateno}'">취소[목록]</button>-->
        <button type='button' onclick='history.back()'>취소[제품 목록]</button>
      </DIV>
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
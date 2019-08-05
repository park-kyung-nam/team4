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

function prod_good_up(productno, prodcateno, viewno, nowPage, prod_word){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  var frm_prodg = $('#frm_prodg');
  frm_prodg.attr('action', './prod_good_up.do');
  $('#productno', frm_prodg).val(productno);
  $('#prodcateno', frm_prodg).val(prodcateno);
  $('#viewno', frm_prodg).val(viewno);
  $('#nowPage', frm_prodg).val(nowPage);
  $('#prod_word', frm_prodg).val(prod_word);
  frm_prodg.submit();
}

function prod_good_down(productno, prodcateno, viewno, nowPage, prod_word){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  var frm_prodg = $('#frm_prodg');
  frm_prodg.attr('action', './prod_good_down.do');
  $('#productno', frm_prodg).val(productno);
  $('#prodcateno', frm_prodg).val(prodcateno);
  $('#viewno', frm_prodg).val(viewno);
  $('#nowPage', frm_prodg).val(nowPage);
  $('#prod_word', frm_prodg).val(prod_word);
  frm_prodg.submit();
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
  
  <DIV class='content' style='width: 100%;'>

  <!-- 제품 추천 증가 감소 폼 -->
  <FORM name='frm_prodg' id='frm_prodg' method='post' action=''>
    <input type='hidden' name='productno' id='productno' value=''>
    <input type='hidden' name='prodcateno' id='prodcateno' value='1'>
    <input type='hidden' name='viewno' id='viewno' value='1'>
    <input type='hidden' name='nowPage' id='nowPage' value='1'>
    <input type='hidden' name='prod_word' id='prod_word' value=''>
  </FORM>


  <form name='frm' id='frm' method="get" action="./list_by_prodcateno_search_paging.do">
  <ASIDE style='float: left;'>
    <A href='../prodcategrp/list.do'>카테고리 그룹</A> >
    <A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> > 
    <A href='./list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&viewno=1&nowPage=1&prod_word='>${prodcategrp_ProdcateVO.prodcate_title }</A>
    <!--<A href='./list_by_prodcateno_search.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>${prodcategrp_ProdcateVO.prodcate_title }</A>  -->
 
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건)
    </c:if>

  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
    <A href='./create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&nowPage=${param.nowPage }&viewno=${param.viewno }&customerno=${param.customerno}'>등록</A>
    
    <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.prod_word != '' }">
        <input type='text' name='prod_word' id='prod_word' value='${param.prod_word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='prod_word' id='prod_word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_prodcateno.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'">전체 보기</button>
  </ASIDE>
  </form>
  
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 40%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>조회수</th>
          <th>추천수</th>
          <th>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="productVO" items="${list }">
          <tr>
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${productVO.thumb != ''}">
                <IMG id='thumb' src='./storage/${productVO.thumb}' > <!-- 이미지 파일명 출력 -->
              </c:when>
              <c:otherwise>
                <IMG id='thumb' src='./images/none1.png' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>          
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${productVO.prod_ansnum == 0 }"> <!-- 부모글인 경우 -->
                  <img src='./images/ting1.png'>
                </c:when>
                <c:when test="${productVO.prod_ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/white.png' style='width: ${productVO.prod_indent * 20}px; opacity: 0.0;'>
                  <img src='./images/reply3.png'>
                </c:when>
              </c:choose>
              <a href="./read.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&prod_word=${param.prod_word}&nowPage=${param.nowPage}&viewno=${param.viewno}&customerno=${param.customerno}">${productVO.prod_title}</a> 
            </td> 

            <td style='vertical-align: middle;'>${productVO.prod_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${productVO.prod_viewcnt}</td>
            <td style='vertical-align: middle;'>${productVO.prod_good}
            <a href="javascript:prod_good_up(${productVO.productno}, ${prodcategrp_ProdcateVO.prodcateno }, ${param.viewno }, ${param.nowPage }, '${param.prod_word }', '${sessionScope.customerno}');"><IMG src='./images/up.png' title='추천증가' style='width: 16px;'></a>
            <a href="javascript:prod_good_down(${productVO.productno}, ${prodcategrp_ProdcateVO.prodcateno }, ${param.viewno }, ${param.nowPage }, '${param.prod_word }', '${sessionScope.customerno}');"><IMG src='./images/down.png' title='추천감소' style='width: 16px;'></a>
            </td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}&viewno=${param.viewno }&customerno=${param.customerno }"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}&viewno=${param.viewno }&customerno=${param.customerno }"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              G${productVO.prod_grpno}/A${productVO.prod_ansnum}
              <a name='${productVO.productno}' href="javascript:prodest(${productVO.productno}, '${sessionScope.customerno}', ${prodcategrp_ProdcateVO.prodcateno }, ${param.viewno }, ${param.nowPage }, '${param.prod_word }'); window.location.reload(true);"><img src="./images/youtube.png" title="견적" border='0'/></a>
              <!-- <a name='${productVO.productno}' href="javascript:estimate(${productVO.productno });"><img src="./images/youtube.png" title="견적" border='0'/></a> -->
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  
  
  <DIV class='bottom_menu'>${paging }</DIV>
  <br><br>


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
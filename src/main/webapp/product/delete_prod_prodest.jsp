<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html class="index" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<meta name="theme-color" content="#333399" />
<title>리셰</title>

<link rel="apple-touch-icon" sizes="57x57" href="./chimaki/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="./chimaki/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="./chimaki/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="./chimaki/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="./chimaki/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="./chimaki/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="./chimaki/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="./chimaki/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="./chimaki/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="./chimaki/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="./chimaki/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="./chimaki/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="./chimaki/favicon-16x16.png">
<link rel="manifest" href="./chimaki/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="./chimaki/ms-icon-144x144.png">

      <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet">
      
      <link href="./css/kori.css" rel="Stylesheet" type="text/css"> 
      <link href="./css/richer.css" rel="Stylesheet" type="text/css"> 
      <link href="./css/footer.css" rel="Stylesheet" type="text/css"> 
      
      
      <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>   

      <script type="text/javascript">
      $(function () {
      });
      
      </script>
      
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_index.jsp" flush='false' />
  <div class="container" style="min-height : 100vh;">
  
  <!-- 사용자 페이지 -->
  
  <DIV class='content' style='width: 50%;'>

<DIV class='title_line' style='width: 70%;'>
  <!--『${productVO.prod_title }』 견적서 관련 글 삭제-->
</DIV>

<FORM name='frm' method='POST' action='./delete_prod_prodest.do'>
  <!-- 개발시 임시 값 사용: 1
  <input type='hidden' name='prodcategrpno' id='prodcategrpno' value='${prodcategrp_ProdcateVO.prodcategrpno }'>
  <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>-->
  <input type='hidden' name='productno' id='productno' value='${productVO.productno }'>
  <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
  <input type='hidden' name='viewno' id='viewno' value='${param.viewno }'>
  <input type='hidden' name='nowPage' id='nowPage' value='${param.prod_word }'>
  <input type='hidden' name='prodcateno' id='prodcateno' value='${param.prodcateno }'>
  <input type='hidden' name='customerno' id='customerno' value='${param.customerno }'>

  <fieldset class='fieldset_basic'>
    <ul>
    
      <li class='li_none'>
        <label>견적서내에 관련 제품을 삭제합니다.</label>
      </li>
    
      <li class='li_none'>
        <label for='title'>견적서내에 제품이름: </label>
        ${productVO.prod_title }
      </li>
      
      <li class='li_none'>
        <label for='title'>견적서내에 ${productVO.prod_title} 갯수: </label>
        ${count }개
      </li>
  
      <li class='li_none' style='text-align: center; font-size: 1.2em;'>
        <span class='span_warning'>기존에 견적서내 상품을 삭제되면 복구 할 수 없습니다.</span>
      </li>  

      <li class='li_right'>
        <button type="submit">삭제</button>
        <button type="button" onclick="location.href='../product/list_by_prodcateno_search_paging.do?prodcateno=${param.prodcateno}&viewno=${param.viewno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}&customerno=${param.customerno }'">취소[목록]</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
  
  <!-- /사용자 페이지 -->
  
  </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
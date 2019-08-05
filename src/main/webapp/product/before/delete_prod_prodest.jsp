<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(function(){

  });
</script>

</head> 

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
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
        <button type="button" onclick="location.href='../product/list_by_prodcateno_search_paging.do?prodcateno=${param.prodcateno}&viewno=${param.viewno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}'">취소[목록]</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 
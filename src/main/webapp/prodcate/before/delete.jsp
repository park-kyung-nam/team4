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
  『${prodcategrp_ProdcateVO.prodgrp_title } > ${prodcategrp_ProdcateVO.prodcate_title}』 카테고리 삭제
</DIV>

<FORM name='frm' method='POST' action='./delete.do'>
  <!-- 개발시 임시 값 사용: 1 -->
  <input type='hidden' name='prodcategrpno' id='prodcategrpno' value='${prodcategrp_ProdcateVO.prodcategrpno }'>
  <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
  <input type='hidden' name='viewno' id='viewno' value='1'>
  
  <fieldset class='fieldset_basic'>
    <ul>
    <li class='li_none' style='text-align: center; font-size: 1.2em;'>
        <span class='span_alert'>카테고리의 등록된 제품(글)이 없습니다.</span>
      </li>    
    
      <li class='li_none'>
        <label>카테고리를 삭제합니다.</label>
      </li>
    
      <li class='li_none'>
        <label for='title'>카테고리 이름: </label>
        ${prodcategrp_ProdcateVO.prodcate_title }
      </li>
      <li class='li_none'>
        <label for='seqno'>출력 순서: </label>
        ${prodcategrp_ProdcateVO.prodcate_seqno }
      </li>
      <li class='li_none'>
        <label for='visible'>출력 형식: </label>
        ${prodcategrp_ProdcateVO.prodcate_visible }
      </li>
      <li class='li_none'>
        <label for='ids'>접근 계정: </label>
        ${prodcategrp_ProdcateVO.prodcate_ids }
      </li>

      <li class='li_right'>
        <button type="submit">삭제</button>
        <button type="button" onclick="location.href='./list_by_prodcategrpno.do?prodcategrpno=${param.prodcategrpno}'">취소[목록]</button>
      </li>         
    </ul>
  </fieldset>
</FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 
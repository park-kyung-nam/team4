<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
  $(document).ready(function(){ // window.onload = function() { ... }

  });

  function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 5%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    
  }
</script>
</head>

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

  <ASIDE style='float: left;'>
    <!-- 카테고리 그룹 > 해외 여행 > 스위스 -->
    <A href='../prodcategrp/list.do'>카테고리 그룹</A> >
    <A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> > 
    <A href='./list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&viewno=1&nowPage=1&prod_word=&customerno=${sessionScope.customerno}'>${prodcategrp_ProdcateVO.prodcate_title }</A>
    <!--<A href='./list.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>${prodcategrp_ProdcateVO.prodcate_title }</A> -->
  </ASIDE>
  <ASIDE style='float: right;'>
    <c:if test="${productVO.files.length() > 0 }">
      <A href='./download.do?productno=${productVO.productno}'>다운로드</A>
      <span class='menu_divide' >│</span> 
    </c:if>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='./reply.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&productno=${productVO.productno }'>답변</A>
    <span class='menu_divide' >│</span> 
    <A href='./list_by_prodcateno_search_paging.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&word=${param.word}&nowPage=${param.nowPage }'>목록</A>
    <span class='menu_divide' >│</span> 
    <A href='./update.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&productno=${productVO.productno }&nowPage=${param.nowPage }'>수정</A>
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?productno=${productVO.productno }&prodcateno=${prodcategrp_ProdcateVO.prodcateno }&nowPage=${param.nowPage }'>삭제</A>
  </ASIDE> 
  
  <div class='menu_line'></div>

  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="productno" value="${productVO.productno}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none">
            <span>${productVO.prod_title}</span>
            (<span>${productVO.prod_good}</span>)
            <span>${productVO.prod_rdate.substring(0, 16)}</span>
            <DIV>
              <c:forEach var ="fileVO"  items="${file_list }">
                <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
              </c:forEach>
            </DIV>
          </li>
          <li class="li_none">
            <DIV>${productVO.prod_content }</DIV>
          </li>
          <li class="li_none">
            <DIV style='text-decoration: underline;'>검색어:(키워드) ${productVO.prod_word }</DIV>
          </li>
        </ul>
      </fieldset>
  </FORM>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


   
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){

});
</script>

<script type="text/javascript">
function page_replace(prodcateno, viewno) {
  // alert('viewno: '+  viewno);
  // var frm_replace = $('#frm_replace');
  // $('#prodcateno', frm_replace).val(prodcateno);
  // $('#viewno', frm_replace).val(viewno);
  // frm_replace.submit();
  
  // var nowPage = ${param.nowPage};
  // alert( nowPage );
  location.href="./list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
                    +"&viewno="+viewno;
}
</script>
</head>

<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 100%;'>

<!-- 출력 폼-->
  <DIV id='panel_replace' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_replace' id='frm_replace' method='GET' 
                action='./list_by_prodcateno_search_paging.do'> 
      <input type='hidden' name='prodcateno' id='prodcateno' value=''>
      <input type='hidden' name='viewno' id='viewno' value='2'>
      <button type="submit" id='submit'></button>
    </FORM>
  </DIV>
  
  <form name='frm' id='frm' method="get" action="./list_by_prodcateno_search_paging.do">
  <ASIDE style='float: left;'>
    <A href='../prodcategrp/list.do'>카테고리 그룹</A> >
    <A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> > 
    <A href='./list_by_prodcateno_search.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>${prodcategrp_ProdcateVO.prodcate_title }</A>  
 
    <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건)
    </c:if>

  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>

    <span class='menu_divide' >│</span> 
    <A href='./create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>등록</A>
    
    <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
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
  
  <table width="980" border="0" align="center" cellpadding="0" cellspacing="0" style="border-top:2px solid #6cad2c">
    <tbody>
    <tr> 
      <td width="17%" height="35" align="center" bgcolor="ffffff" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno },1);" style="padding:3px 0 0 0; border-bottom:1px solid #ffffff; border-right:1px solid #cccccc; border-left:1px solid #cccccc; cursor:pointer">인기순</td>
      <td width="17%" align="center" bgcolor="fafafa" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 2);" style="padding:3px 0 0 0; border-bottom:1px solid #cccccc; border-right:1px solid #cccccc; cursor:pointer">신제품순</td>
      <td width="17%" align="center" bgcolor="fafafa" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 3);" style="padding:3px 0 0 0; border-bottom:1px solid #cccccc; border-right:1px solid #cccccc; cursor:pointer">낮은가격순</td>
      <td width="17%" align="center" bgcolor="fafafa" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 4);" style="padding:3px 0 0 0; border-bottom:1px solid #cccccc; border-right:1px solid #cccccc; cursor:pointer">높은가격순</td>
      <td width="17%" align="center" bgcolor="fafafa" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 5);" style="padding:3px 0 0 0; border-bottom:1px solid #cccccc; border-right:1px solid #cccccc; cursor:pointer">상품명순</td>
      <td width="17%" align="center" bgcolor="fafafa" onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 6);" style="padding:3px 0 0 0; border-bottom:1px solid #cccccc; border-right:1px solid #cccccc; cursor:pointer">제조사순</td>
    </tr>
    </tbody>
  </table>
    
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 50%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>추천</th>
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
              <a href="./read.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&word=${param.word}&nowPage=${param.nowPage}">${productVO.prod_title}</a> 
            </td> 

            <td style='vertical-align: middle;'>${productVO.prod_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${productVO.prod_good}</td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&word=${param.word}"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              G${productVO.prod_grpno}/A${productVO.prod_ansnum}
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  <DIV class='bottom_menu'>${paging }</DIV>
  <br><br>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


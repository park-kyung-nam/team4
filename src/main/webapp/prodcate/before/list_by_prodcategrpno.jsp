<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    
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

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'>
  
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
  
<DIV class='title_line'>${prodcategrpVO.prodgrp_title } 카테고리 목록</DIV>

<DIV class='aside_menu'>
  <ASIDE style='float: left;'>
    <A href='../prodcategrp/list.do'>카테고리 그룹</A> >
    <A href='./list_by_prodcategrpno.do?prodcategrpno=${param.prodcategrpno }'>${prodcategrpVO.prodgrp_title }</A> 
  </ASIDE> 
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
 
 <span class='menu_divide' >│</span> 
 <A href='./create.do?prodcategrpno=${param.prodcategrpno }'>등록</A>
 
    <!--<c:if test="${sessionScope.id ne null }">
      <span class='menu_divide' >│</span> 
      <A href='./create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'>등록</A>
    </c:if>-->
    
    <input type='hidden' name='prodcateno' id='prodcateno' value='${prodcategrp_ProdcateVO.prodcateno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word_find' id='word_find' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list_by_prodcateno.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }'">전체 보기</button>
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>

<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 25%;'/>
    <col style='width: 15%;'/>
    <col style='width: 5%;'/>
    <col style='width: 15%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>순서</TH>
    <TH style='text-align: center ;'>구분</TH>
    <TH style='text-align: center ;'>분류</TH>
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
          <A href="javascript:nonvisible(${prodcategrp_ProdcateVO.prodcateno })"><IMG src='./images/display_show.png'></A>
        </c:when>
        <c:when test="${prodcategrp_ProdcateVO.prodcate_visible == 'N'}">
          <A href="javascript:visible(${prodcategrp_ProdcateVO.prodcateno })"><IMG src='./images/display_hide.png'></A>
        </c:when>
      </c:choose>
    </TD>
    <TD style='text-align: center ;'>
      <A href="../product/create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"><IMG src='./images/create.png' title='등록'></A>
    
      <A href="javascript:seqnoUp(${prodcategrp_ProdcateVO.prodcateno })"><IMG src='./images/up.png' title='우선순위 높임' style='width: 16px;'></A>
      <A href="javascript:seqnoDown(${prodcategrp_ProdcateVO.prodcateno })"><IMG src='./images/down.png' title='우선순위 높임' style='width: 16px;'></A>
     
      <A href="./update.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"><IMG src='./images/update.png' title='수정'></A>
      
      <A href="./delete.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }&prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }"><IMG src='./images/delete.png' title='삭제'></A>
      
      
    </TD>
  </TR>
  </c:forEach> 
  </tbody>
  
</TABLE>


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

 
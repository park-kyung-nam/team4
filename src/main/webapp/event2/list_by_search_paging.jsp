<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>PC world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
$(function(){

});
</script>

<script type="text/javascript">
</script>
</head>

<body>
<DIV class='container' style='width: 100%;'> </DIV>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 70%;'>
<form method="get" action="./list_by_search_paging.do">
<ASIDE style='float: left;'>
 <A href='./list_by_search_paging.do?nowPage=${param.nowPage}' >이벤트</A> 

   <c:if test="${param.word.length() > 0}"> 
      >
      [${param.word}] 검색 목록(${search_count } 건) 
    </c:if>
 </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로 고침</A> 
    <span class='menu_divide'> |</span>
    <A href='./create.do'>글쓰기</A> 
    <input type='hidden' name='eventno' id='eventno' value='${eventVO.eventno }'>
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.word != '' }">
        <input type='text' name='word' id='word' value='${param.word }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='word' id='word' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    </ASIDE> 
</form>
  <div class='menu_line' style='clear: both;'></div>       

 <TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 15%;'/>
    <col style='width: 50%;'/>
    <col style='width: 20%;'/>
    <col style='width: 20%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>      </TH>
    <TH style='text-align: center ;'>제목</TH>
    <TH style='text-align: center ;'>날짜</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>
      <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="eventVO" items="${list }" varStatus="info">
  <TR>
    <TD style='text-align: center ;'>${info.count }</TD>
        
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${eventVO.e_thumb1 != ''}">
                <a href="./read.do?eventno=${eventVO.eventno}&word=${param.word}&nowPage=${param.nowPage}">
                <IMG id='e_thumb1' src='./storage/${eventVO.e_thumb1}' > <!-- 이미지 파일명 출력 -->
                </a>
              </c:when>
              <c:otherwise>
                <IMG id='e_thumb1' src='./images/none1.png' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>
     <td style='vertical-align: middle;'>              
    <a href="./read.do?eventno=${eventVO.eventno}&word=${param.word}&nowPage=${param.nowPage}">${eventVO.e_title }</a>
    </td>
    <td style='text-align: center ;'>${eventVO.rdate.substring(0, 10) }</td>
    <TD>
      <A href="./update.do?eventno=${eventVO.eventno }&word=${param.word}&nowPage=${param.nowPage}"><IMG src='./images/update.png' title='수정'></A>
      <A href='./delete.do?eventno=${eventVO.eventno }&word=${param.word}&nowPage=${param.nowPage}'><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
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


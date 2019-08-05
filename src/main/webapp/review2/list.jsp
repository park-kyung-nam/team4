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

  
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 70%;'>
  
<DIV class='title_line'>리뷰</DIV>

<DIV class='aside_menu'>
<!--   <ASIDE style='float: left;'><A href='../categrp/list.do'>카테고리 그룹</A></ASIDE>  -->
  <ASIDE style='float: right;'>
    <A href='./create.do'>리뷰 등록</A> <span class='menu_divide'> |</span>
    <A href='./list.do'>새로 고침</A> 
  </ASIDE> 
  <DIV class='menu_line' style='clear: both;'></DIV>
</DIV>

<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 60%;'/>
    <col style='width: 20%;'/>
    <col style='width: 10%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>제목</TH>
    <TH style='text-align: center ;'>날짜</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
    <c:forEach var="reviewVO" items="${list }" varStatus="info">
  <TR>
    <TD style='text-align: center ;'>${info.count }</TD>
    <td>
    <a href="./read.do?reviewno=${reviewVO.reviewno}">${reviewVO.r_title }</a>
    </td>
    <TD style='text-align: center ;'>${reviewVO.rdate.substring(0, 10) }</TD>
    <TD>
      <A href="./update.do?reviewno=${reviewVO.reviewno }"><IMG src='./images/update.png' title='수정'></A>
      <A href='./delete.do?reviewno=${reviewVO.reviewno }&nowPage=${param.nowPage }'><IMG src='./images/delete.png' title='삭제'></A>
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

 
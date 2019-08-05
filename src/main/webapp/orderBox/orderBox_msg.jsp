<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title></title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
 
</head> 
<body>
<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>

<DIV class='title_line'>알림</DIV> 

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 1 }">
          <LI class='li_none'>장바구니에 등록 되었습니다.</LI>
        </c:when>
        <c:otherwise>
          <LI class='li_none'>장바구니 등록에 실패하였습니다.</LI> 
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
       
       <!-- <button type="button" onclick="location.href='./orderBox.do?customerno=${orderBoxVO.customerno }'" class="btn btn-primary btn-md">장바구니 확인</button> -->
       <button type="button" onclick="location.href='./list_orderBox.do?customerno=1'" class="btn btn-primary btn-md">장바구니 확인</button>
       
        <button type="button" onclick="location.href='../index.jsp'" class="btn btn-primary btn-md">홈으로</button>
      </LI>   
  
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

   
  
<%@ page contentType="text/html; charset=UTF-8" %>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> 
    
  
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>장바구니 목록</title> 
 
<link href="../css/style.css" rel="Stylesheet" type="text/css">
  
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
 
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
 
<script type="text/javascript" src="../js/jquery.cookie.js"></script>
  
  
  
</head>  
 
 
<body>

<DIV class='container'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>
 
  <DIV id='main_panel'>장바구니</DIV> 
    
  <div class='menu_line'></div>
 <c:choose>
        <c:when test="${count == 0}"> 
            장바구니가 비어있습니다.
        </c:when> 
        <c:otherwise>  
        
 <!-- action="./update_orderBox.do" -> formaction으로 대체-->
<FORM method="post">
<table border="0" style="width:100%; height:80%">  
<thead> 
<tr> 
    <th style="text-align:center" width="20%">상품 이미지</th>
    <th style="text-align:center" width="30%">상품명</th>
    <th style="text-align:center" width="30%">단가</th>
    <th style="text-align:center" width="10%">수량</th>
    <th style="text-align:center" width="10%">삭제</th>
</tr>  
 
</thead> 

<tbody>
  
<c:forEach var="orderBoxVO" items="${map.list}" > 
<tr>   
  <td>
      <img src=".${orderBoxVO.productImg }" width="100%" height="100px">
  </td>  
  <td style="text-align:center">${orderBoxVO.productName } </td>  
  <td style="text-align:center">
      <fmt:formatNumber pattern="###,###,###" value="${orderBoxVO.productPrice }"/> 원
  </td>   
  <td style="text-align:center"> 
      <!-- <input type="number" style="width:80% " name="orderAmount" value="${orderBoxVO.orderAmount }" min="1">개-->
     <input type="hidden" name="orderBoxno" value="${orderBoxVO.orderBoxno }" >
     <input type="submit" value="수량 변경" formaction="./update_orderBox.do"/>          
  </td>       
  <td style="text-align:center"> 
    <a href="./delete_orderBox.do?orderBoxno=${orderBoxVO.orderBoxno}">삭제</a>
  </td>   
</tr>        
 
 </c:forEach>    
  
  
<tr> 


</tbody>
<tfoot>

</tfoot>
</table>

</FORM>

</c:otherwise>
</c:choose>

 
  
 <!-- ---------- -->

<div align="right">
      <div class="col-md-offset-2 col-md-10">   
        <button type="button"  class="btn btn-primary btn-md">배송정보 입력</button>
        <button type="button" onclick="location.href='../index.jsp'" class="btn btn-primary btn-md">취소</button>
      </div> 
 </div>


  
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' /> 
</DIV> <!-- container END -->
</body>
 
</html> 
  

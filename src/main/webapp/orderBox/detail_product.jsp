<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<title>상품 정보</title> 
  
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
 
  <DIV id='main_panel'>상품 정보</DIV>
     
  <div class='menu_line'></div>
     
      <table border="1" style="width:100%; height:80%; border-collapse:collapse">
        <tr>    
            <td style="width:50%">
                <img src=".${orderBoxVO.productImg }" width="100%" height="300px">
            </td>   
            <td style="width:50%;">     
                <table border="1" style="width: 100%; hight:300px; border-collapse:collapse"> 
                  <tr align="center">
                      <td>상품명</td> 
                      <td>${orderBoxVO.productName }</td>  
                  </tr>
                  <tr align="center">
                      <td>가격</td> 
                      <td>${orderBoxVO.productPrice }</td>
                  </tr>
                  <tr align="center"> 
                      <td>상품 정보</td> 
                      <td>상품 정보란입니다</td>  
                   </tr>
                   <tr align="center">
                      <td colspan="2">  
                          <FORM name='frm' id='frm' method='POST' action='./orderBox.do' 
                                      onsubmit="return send();" class="form-horizontal">
                              <input type="hidden" name="productno" value="${orderBoxVO.productno }">
                                  <select name="orderAmount">
                                      <c:forEach begin="1" end="10" var="i"> 
                                        <option value="${i }">${i }</option> 
                                        </c:forEach> 
                                  </select>&nbsp; 개 <br><br> 
                             
                               
          <div class="form-group">
      <div class="col-md-offset-2 col-md-10">
        <button type="submit" class="btn btn-primary btn-md">장바구니 담기</button>
        <button type="button" onclick="history.go(-1);" class="btn btn-primary btn-md">이전으로</button>
 
 	         </div> 
           </div>   
            </form>
         </td> 
        </tr>
        </table>
      </table>

 <!-- ---------- -->

 
 
</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' /> 
</DIV> <!-- container END -->
</body>
 
</html> 
  
  
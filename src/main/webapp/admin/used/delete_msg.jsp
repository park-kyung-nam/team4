<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>PC world</title>

<link href="../css/style.css" rel="Stylesheet" type="text/css">
<script type="text/JavaScript"
          src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

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
<c:import url="/menu/top.jsp" />
<DIV class='content'>

<DIV class='title_line'>리뷰 삭제 알림</DIV>

<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count == 0}">
          <li class='li_none'>『${param.r_title } 』 삭제에 실패했습니다.</li>
          <li class='li_none'>다시한번 시도해주세요.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick='history.back()'>다시 시도</button>
            <button type='button' onclick="location.href='./list_by_search_paging.do?reviewno=${param.reviewno}&nowPage=${param.nowPage }'">목록</button>
          </li>
                     
        </c:when>
        <c:when test="${param.count == 1}">
          <li class='li_none'>『${param.r_title } 』 삭제에 성공했습니다.</li>
          <li class='li_none'>
            <br>
            <button type='button' onclick="location.href='./list_by_search_paging.do?reviewno=${param.reviewno}&nowPage=${param.nowPage }'">목록</button>
          </li>          
        </c:when>
      </c:choose>    

    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

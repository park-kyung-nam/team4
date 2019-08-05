<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html> 
<html lang="ko"> 
<head> 
<meta charset="UTF-8"> 
<meta name="viewport" content="user-scalable=yes, initial-scale=1.0, maximum-scale=3.0, width=device-width" /> 
<title>Resort world</title>

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

<DIV class='title_line'>알림</DIV>
<DIV class='message'>
  <fieldset class='fieldset_basic'>
    <UL>
      <c:choose>
        <c:when test="${param.count > 0 }">
          <LI class='li_none'>${param.prodcateno }번 카테고리의 제품을 삭제했습니다.</LI>
          계속 해서 카테고리 삭제를 진행 하시려면 하단의 카테고리 삭제 버튼을 눌러 주세요.<br><br>
         <button type='button' onclick="location.href='../prodcate/delete.do?prodcateno=${param.prodcateno }&prodcategrpno=${param.prodcategrpno}'">카테고리 삭제</button>

        </c:when>
        <c:otherwise>
          <LI class='li_none'>${param.prodcateno }번 카테고리의 제품 삭제 실패했습니다.</LI>
        </c:otherwise>
      </c:choose>
      <LI class='li_none'>
        <br>
        <c:if test="${param.count == 0 }">
          <button type='button' onclick="javascript:history.back();">다시 시도</button>        
        </c:if>
        <button type='button' onclick="location.href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${param.prodcategrpno}'">목록</button>
      </LI>
 
    </UL>
  </fieldset>

</DIV>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

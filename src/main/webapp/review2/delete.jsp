<%@ page contentType="text/html; charset=UTF-8" %>
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

</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 
     
  
<ASIDE style='float: left;'>
  <A href='./list_by_search_paging.do'> 리뷰</A> 
 </ASIDE>
 <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./update.do?reviewno=${reviewVO.reviewno }'>수정</A>

  </ASIDE> 
  
<DIV class='title_line' style='width: 40%;'>리뷰 삭제</DIV>


<FORM name='frm' method='POST' action='./delete.do'
            enctype="multipart/form-data" class="form-horizontal">
  
      <input type='hidden' name='reviewno' id='reviewno' value='${reviewVO.reviewno }'>
      <%-- <input type='hidden' name='prodno' id='prodno' value='${reviewVO.prodno }'> --%>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <div class="form-group">   
        <div class="col-md-12" style='text-align: center; margin: 30px;'>
          삭제 되는글: ${reviewVO.r_title }<br><br>
          삭제하시겠습니까? 삭제하시면 복구 할 수 없습니다.<br>
          <br>
          <button type = "submit">삭제 진행</button>
          <button type = "button" onclick = "history.back()">취소</button>
        </div>
      </div>   
  </FORM>

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 

  
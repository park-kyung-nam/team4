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
  $(document).ready(function(){ // window.onload = function() { ... }

  });

   function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 5%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
    
    $('#main_panel').html(panel);
    $('#main_panel').show();
    
  } 
</script>
</head>

<body>
<DIV class='container' style='width: 90%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content'>   

  <ASIDE style='float: left;'>
    <A href='./list_by_search_paging.do'> 리뷰</A> 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?reviewno=${reviewVO.reviewno }'>등록</A>
    <span class='menu_divide' >│</span> 
    <A href='./reply.do?reviewno=${reviewVO.reviewno }&nowPage=${param.nowPage}'>답변</A>
    <span class='menu_divide' >│</span> 
    <A href='./list_by_search_paging.do'>목록</A>
    <span class='menu_divide' >│</span> 
    <A href='./update.do?reviewno=${reviewVO.reviewno }&nowPage=${param.nowPage }'>수정</A>
    <span class='menu_divide' >│</span> 
    <A href='./delete.do?reviewno=${reviewVO.reviewno }&nowPage=${param.nowPage }'>삭제</A>
  </ASIDE> 
  <div class='menu_line'></div>

  <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
  
  <FORM name='frm' method="get" action='./update.do'>
      <input type="hidden" name="reviewno" value="${reviewVO.reviewno}">
      <fieldset class="fieldset">
        <ul>
          <li class="li_none">
          <DIV>
              <c:forEach var ="fileVO"  items="${file_list }">
                <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
              </c:forEach>
            </DIV>
            <span>${reviewVO.r_title}</span><br><br>
            <span>${reviewVO.r_content}</span>
            <li class="li_none">
            <DIV style='text-decoration: underline;'>검색어:(키워드) ${reviewVO.word }</DIV>
            </li>
            <li>
            <span>${reviewVO.rdate.substring(0, 16)}</span>
            <span>${reviewVO.rname }</span>
          </li>
        </ul>
      </fieldset>
  </FORM>
  



</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html>


   
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html class="index" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<meta name="theme-color" content="#333399" />
<title>리셰</title>

<link rel="apple-touch-icon" sizes="57x57" href="./chimaki/apple-icon-57x57.png">
<link rel="apple-touch-icon" sizes="60x60" href="./chimaki/apple-icon-60x60.png">
<link rel="apple-touch-icon" sizes="72x72" href="./chimaki/apple-icon-72x72.png">
<link rel="apple-touch-icon" sizes="76x76" href="./chimaki/apple-icon-76x76.png">
<link rel="apple-touch-icon" sizes="114x114" href="./chimaki/apple-icon-114x114.png">
<link rel="apple-touch-icon" sizes="120x120" href="./chimaki/apple-icon-120x120.png">
<link rel="apple-touch-icon" sizes="144x144" href="./chimaki/apple-icon-144x144.png">
<link rel="apple-touch-icon" sizes="152x152" href="./chimaki/apple-icon-152x152.png">
<link rel="apple-touch-icon" sizes="180x180" href="./chimaki/apple-icon-180x180.png">
<link rel="icon" type="image/png" sizes="192x192"  href="./chimaki/android-icon-192x192.png">
<link rel="icon" type="image/png" sizes="32x32" href="./chimaki/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="96x96" href="./chimaki/favicon-96x96.png">
<link rel="icon" type="image/png" sizes="16x16" href="./chimaki/favicon-16x16.png">
<link rel="manifest" href="./chimaki/manifest.json">
<meta name="msapplication-TileColor" content="#ffffff">
<meta name="msapplication-TileImage" content="./chimaki/ms-icon-144x144.png">

      <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet">
      
      <link href="${pageContext.request.contextPath}/css/kori.css" rel="Stylesheet" type="text/css"> 
      <link href="${pageContext.request.contextPath}/css/richer.css" rel="Stylesheet" type="text/css"> 
      <link href="${pageContext.request.contextPath}/css/footer.css" rel="Stylesheet" type="text/css"> 
      
      
      <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>   

      <script type="text/javascript">
      $(function () {
      });
      
      </script>
      
<script type="text/javascript">
function vi(vis){
    var panel = '';
    if(visible == N){
    panel += "<>";
    }
  
    $('#main_panel').html(panel);
    $('#main_panel').show();
  
  }
  
</script>
      
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_index.jsp" flush='false' />
  <div class="container" style="min-height : 100vh;">
  
  <!-- 사용자 페이지 -->
<DIV class='content' style='width: 90%;'>
  
<DIV class='title_line'>고객센터</DIV>

<DIV class='aside_menu'>

</DIV>
<c:if test="${param.contents.length() > 0}"> 
      >
      [${param.contents}] 검색 목록(${search_count } 건) 
    </c:if>
    
    <form name='frm' id='frm' method="get" action="./list_by_search.do">
  
  <ASIDE style='float: left;'>
    <!-- 카테고리 그룹 > 해외 여행 > 스위스 -->
  <ASIDE style='float: left;'><A href='../service/list.do'>고객센터</A></ASIDE> 
    <A href='../cate/list_by_categrpno.do?categrpno=${categrp_CateVO.categrpno }'>${categrp_CateVO.name }</A> > 
    <A href='./list_by_cateno_search.do?cateno=${categrp_CateVO.cateno }'>${categrp_CateVO.title }</A>  
 
    <c:if test="${param.contents.length() > 0}"> 
      >
      [${param.contents}] 검색 목록(${search_count } 건)  
    </c:if>
 
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href='./create.do'>글 등록</A> <span class='menu_divide'> |</span>
    <A href='./list.do'>새로 고침</A> 
    
    <span class='menu_divide' >│</span> 
    <c:choose>
      <c:when test="${param.contents != '' }">
        <input type='text' name='contents' id='contents' value='${param.contents }' style='width: 35%;'>
      </c:when>
      <c:otherwise>
        <input type='text' name='contents' id='contents' value='' style='width: 35%;'>
      </c:otherwise>
    </c:choose>
    <button type='submit'>검색</button>
    <button type='button' 
                 onclick="location.href='./list.do'">전체 보기</button>
  </ASIDE>
  </form>

<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 15%;'/>
    <col style='width: 40%;'/>
     <col style='width: 10%;'/>
    <col style='width: 15%;'/>
  </colgroup>
  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH style='text-align: center ;'>회원번호</TH>
    <TH style='text-align: center ;'>제목</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>기타</TH>
    
  </TR>
  </thead>

  <tbody id='tbody_panel' data-nowPage='0' data-endPage='0'>
<c:forEach var="ServiceVO" items="${list }" varStatus="info">
  <TR>
    <TD style='text-align: center ;'>${ServiceVO.question_no }</TD>
    <TD style='text-align: center ;'>${ServiceVO.member_no }</TD>
    <TD style='text-align: center ;'><A href='../service/read.do?question_no=${ServiceVO.question_no }'>${ServiceVO.title }</A></TD>
    <TD style='text-align: center ;'>${ServiceVO.rdate.substring(0, 10) }</TD>

    <TD style='text-align: center ;'>
      <A href="./update.do?question_no=${ServiceVO.question_no }"><IMG src='./images/update.png' title='수정'></A>
      <A href="./delete.do?question_no=${ServiceVO.question_no }"><IMG src='./images/delete.png' title='삭제'></A>
      <A href="../reply/create.do?question_no=${ServiceVO.question_no }"><IMG src='' title='답변 구현 X'></A>
    </TD>
  </TR>
</c:forEach>
  </tbody>
  
</TABLE>


</DIV> <!-- content END -->
  <!-- /사용자 페이지 -->
  
  </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>

 
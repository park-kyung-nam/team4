<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
        
        
<style type="text/css">

</style>

<style type="text/css">
/* fieldset 전체 적용 */
.prodcategrp_prodcate_left{
  width: 100%;
  margin: 0px auto; 
  border-left: none; 
  border-right: none;
  border-top: solid 1px #DDDDDD;  
  border-bottom: solid 1px #DDDDDD;  
  text-align: left;
}

/* <UL> 태그에 적용 */
.prodcategrp_prodcate_list_left{
  padding-left: 10%; 
  line-height: 20px;
}

/* 카테고리 그룹 이름에 적용, Spring에서 사용 */
.prodcategrp_name{
  margin-left: 5%;
  font-weight: bold;
  list-style-image: url("${pageContext.request.contextPath}/prodcate/images/prodcategrp.png");
}

/* 카테고리에 적용, Spring에서 사용 */
.prodcate_title{
  margin-left: 5%;
  list-style-image: url("${pageContext.request.contextPath}/prodcate/images/prodcate.png");
}
</style>


</head>
<body style="">
<jsp:include page="/menu/top_index.jsp" flush='false' />
  <div class="container" style="min-height : 100vh;">
  
  <!-- 사용자 페이지 -->
  
  <fieldset class='prodcategrp_prodcate_left' >
  <DIV>
    ▷
    <A href="${pageContext.request.contextPath}/contents/list_all_prodcate.do">전체 보기</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <UL class='prodcategrp_prodcate_list_left' >
    <c:forEach var="title" items="${name_title_list}">
      ${title}
    </c:forEach>
  </UL>
</fieldset>
<br>
  
  <!-- /사용자 페이지 -->
  
  </div>
<jsp:include page="/menu/bottom.jsp" flush='false' />
</body>
</html>
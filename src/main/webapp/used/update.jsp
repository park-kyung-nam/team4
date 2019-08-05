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
      
<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('u_content');  // <TEXTAREA>태그 id 값
  };

   function panel_img(file){
    var panel = '';
    panel += "<DIV id='panel' class='popup_img' style='width: 80%; margin: 0px 13.5%;'>";
    panel += "  <A href=\"javascript: $('#main_panel').hide();\"><IMG src='./storage/"+file+"' style='width: 100%;'></A>";
    panel += "</DIV>";
  
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

<ASIDE style='float: left;'>
  <A href='./list.do'> 중고 PC</A> 
 </ASIDE>
 <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?usedno=${usedVO.usedno }'>등록</A>

  </ASIDE> 
 
<DIV class='title_line' style='width: 40%;'> 수정</DIV>

<FORM name='frm' method='POST' action='./update.do'
            enctype="multipart/form-data" class="form-horizontal">
  
   <!-- 테스트를 위하여 1번 지정 -->        
      <%-- <input type='hidden' name='adminno' id='adminno' value='${eventVO.adminno }'>  --%>
      <input type='hidden' name='customerno' id='customerno' value='${usedVO.customerno }'> 
      <input type='hidden' name='usedno' id='usedno' value='${usedVO.usedno }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      
      <div class="form-group">   
        <label for="u_title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='u_title' id='u_title' value='${usedVO.u_title}' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="u_content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='u_content' id='u_content'  rows='10'>${usedVO.u_content}</textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="word" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value= '${usedVO.word }'>
        </div>
        </div>
      <div id='file1Panel' class="form-group">
        
        <DIV id='main_panel'></DIV>  <!-- 이미지 출력 -->
        
        <label class="col-md-2 control-label"></label>
        <div class="col-md-10">
          <c:if test="${file_list.size() > 0 }">
              <DIV>
                <c:forEach var ="fileVO"  items="${file_list }">
                  <A href="javascript: panel_img('${fileVO.file }')"><IMG src='./storage/${fileVO.thumb }' style='margin-top: 2px;'></A>
                </c:forEach>
              </DIV>
            </c:if>
        </div>
      </div>
      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">파일</label>
        
        <div class="col-md-11">
          <input type="file" class="form-control input-md" name='filesMF' id='filesMF' size='40' multiple="multiple">
          </div>
       </div>   
      <div class="form-group">   
        <label for='rname' class="col-md-1 control-label">작성자: </label>
        <div class="col-md-11">
        <input type='text'  class="form-control input-lg" name='rname' id='rname' value='${usedVO.rname }' size='10'>
          
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">변경된 내용 저장</button>
        <button type="button" onclick="location.href='./list_by_search_paging.do'">취소[목록]</button>
      </DIV>
    </FORM>
  

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 
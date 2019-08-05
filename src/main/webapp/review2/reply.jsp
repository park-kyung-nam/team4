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

<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/javascript">
window.onload=function(){
  CKEDITOR.replace('r_content');  // <TEXTAREA>태그 id 값
};
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'> </DIV>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 

<ASIDE style='float: left;'>
   <A href='list_by_search_paging.do'>목록</A>  
  </ASIDE>
  <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do'>등록</A>
  </ASIDE> 

<div class='menu_line'></div>
 <DIV class='content' style='width: 100%;'>
<FORM name='frm' method='POST' action='./reply.do'
            enctype="multipart/form-data" class="form-horizontal">
  
   <!-- 테스트를 위하여 1번 지정        -->      
      <input type='hidden' name='prodno' id='prodno' value='1'> 
      <input type='hidden' name='word' id='word' value='${param.word }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
      <input type='hidden' name='reviewno' id='reviewno' value='${param.reviewno }'>
 
      <!-- <input type='hidden' name='customerno' id='customerno' value='1'>  -->
       
      <div class="form-group">   
        <label for="r_title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='r_title' id='r_title' value='' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="r_content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='r_content' id='r_content'  rows='10'></textarea>
        </div>
         <div class="form-group">   
        <label for="word" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value='${reviewVO.word }'>
        </div>
       </div>
      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          </div>
       </div>   
      <div class="form-group">   
        <label for='rname' class="col-md-1 control-label">작성자: </label>
        <div class="col-md-11">
        <input type='text'  class="form-control input-lg" name='rname' id='rname' value='왕눈이' size='10'>
          
          
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
   </div>
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list_by_search_paging.do'">취소[목록]</button>
      </DIV>
    </FORM>
  


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
   
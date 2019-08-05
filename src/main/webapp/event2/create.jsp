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

<!-- bootstrap-select : 카테고리 및 코드 선택용 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/i18n/defaults-*.min.js"></script>
    

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/javascript">
window.onload=function(){
  CKEDITOR.replace('e_content');  // <TEXTAREA>태그 id 값
};
</script>

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 

<DIV class='title_line' style='width: 40%;'>이벤트 등록</DIV>

<FORM name='frm' method='POST' action='./create.do'
            enctype="multipart/form-data" class="form-horizontal">
  
   <!-- 테스트를 위하여 1번 지정 -->        
      <input type='hidden' name='adminno' id='adminno' value='${sessionScope.adminno}'> 
   <!-- 테스트를 위하여 1번 지정 -->        
      <input type='hidden' name='productno' id='productno' value='1'> 
 
      <div class="form-group">   
        <label for="e_title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='e_title' id='e_title' value='이벤트 제목' required="required" style='width: 80%;'>
        </div>
      </div>   
      
    <br>
    <div class="form-group">
      <label for="productno"></label>
      <select name="productno" id="productno" class="selectpicker form-control" title="대상 제품 선택" data-style="btn-info">
        <c:forEach var="productlist" items="${productlist}" varStatus="info">
          <option value="${productlist.productno}">${productlist.prod_title}</option>
        </c:forEach>
      </select>
    </div>
      
      <div class="form-group">   
        <label for="e_content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='e_content' id='e_content'  rows='10'>이벤트 입력.</textarea>
        </div>
       </div>
       <div class="form-group">   
        <label for="word" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value='이벤트'>
        </div>
        </div>
      <div class="form-group">   
        <label for="filesMF" class="col-md-1 control-label">업로드 파일</label>
        <div class="col-md-11">
          <input type="file" class="form-control input-lg" name='filesMF' id='filesMF' size='40' multiple="multiple">
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   
   
      <DIV style='text-align: right;'>
        <button type="submit">등록</button>
        <button type="button" onclick="location.href='./list.do'">취소[목록]</button>
      </DIV>
    </FORM>
  


</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
  
   
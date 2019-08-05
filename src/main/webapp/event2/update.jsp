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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>


<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<script type="text/javascript" src="../ckeditor/ckeditor.js"></script>

<script type="text/JavaScript">
  window.onload=function(){
    CKEDITOR.replace('e_content');  // <TEXTAREA>태그 id 값
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

</head> 

<body>
<DIV class='container' style='width: 100%;'>
<jsp:include page="/menu/top.jsp" flush='false' />
<DIV class='content' style='width: 90%;'> 

<ASIDE style='float: left;'>
  <A href='./list.do'> 이벤트</A> 
 </ASIDE>
 <ASIDE style='float: right;'>
    <A href="javascript:location.reload();">새로고침</A>
    <span class='menu_divide' >│</span> 
    <A href='./create.do?eventno=${eventVO.eventno }'>등록</A>

  </ASIDE> 
 
<DIV class='title_line' style='width: 40%;'>이벤트 수정</DIV>

<FORM name='frm' method='POST' action='./update.do'
            enctype="multipart/form-data" class="form-horizontal">
  
   <!-- 테스트를 위하여 1번 지정 -->        
      <input type='hidden' name='adminno' id='adminno' value='${eventVO.adminno }'> 
      <input type='hidden' name='prodno' id='prodno' value='${eventVO.prodno }'> 
      <input type='hidden' name='eventno' id='eventno' value='${eventVO.eventno }'>
      <input type='hidden' name='nowPage' id='nowPage' value='${param.nowPage }'>
    
      <div class="form-group">   
        <label for="e_title" class="col-md-1 control-label">제목</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='e_title' id='e_title' value='${eventVO.e_title}' required="required" style='width: 80%;'>
        </div>
      </div>   
      <div class="form-group">   
        <label for="e_content" class="col-md-1 control-label">내용</label>
        <div class="col-md-11">
          <textarea class="form-control input-lg" name='e_content' id='e_content'  rows='10'>${eventVO.e_content}</textarea>
        </div>
      </div>
      <div class="form-group">   
        <label for="word" class="col-md-1 control-label">검색어</label>
        <div class="col-md-11">
          <input type='text' class="form-control input-lg" name='word' id='word' value='${eventVO.word }'>
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
          <br>
          Preview(미리보기) 이미지는 자동 생성됩니다.
        </div>
      </div>   

      <DIV style='text-align: right;'>
        <button type="submit">변경된 내용 저장</button>
        <button type="button" onclick="location.href='./list.do'">취소[목록]</button>
      </DIV>
    </FORM>
  

</DIV> <!-- content END -->
<jsp:include page="/menu/bottom.jsp" flush='false' />
</DIV> <!-- container END -->
</body>

</html> 
 
 
 
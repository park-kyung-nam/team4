
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html class="" lang="ko" style="">
    <head>
      <title>게시글 작성</title>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet">
      <link href="${pageContext.request.contextPath}/css/richer.css" rel="Stylesheet" type="text/css"> 
      
      <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>   
      
      <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/ckeditor/ckeditor.js"></script>
      <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
      
      <!-- bootstrap-select : 카테고리 및 코드 선택용 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/css/bootstrap-select.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/bootstrap-select.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.9/dist/js/i18n/defaults-*.min.js"></script>
    
      <!-- tagsinput -->
    <link href="${pageContext.request.contextPath}/rinon/tagsinput/tagsinput.css" rel="stylesheet" type="text/css">
    <script src="${pageContext.request.contextPath}/rinon/tagsinput/tagsinput.js"></script>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker3.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker.ko.min.js"></script>
    
    
      <script type="text/javascript">
      $(function () {
        bsCustomFileInput.init()
        CKEDITOR.replace('content');  // <TEXTAREA>태그 id 값
        $(document).scroll(function () {
          var $nav = $(".rch-topnav");
          $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
          var $nav_btn = $(".rch-nav-mobile-scroll");
          $nav_btn.toggleClass('scrolled', $(this).scrollTop() > $nav_btn.height());
        });
        
        $("#visible").change(function(){
          if($("#visible").is(":checked")){
            //alert("체크박스 체크했음!");
            $('#visible').val("Y");
            //$('#visible-btn').removeClass("btn-outline-danger");
            $('#visible-btn').addClass("btn-outline-success");
            $('#word').attr("placeholder","검색 태그");
            $('#visible_icon').html("visibility");
          }else{
              //alert("체크박스 체크 해제!");
            $('#visible').val("N");
            $('#visible-btn').removeClass("btn-outline-success");
            //$('#visible-btn').addClass("btn-outline-danger");
            $('#word').attr("placeholder","이 게시글은 비공개 게시글로 올라가므로 검색되지 않습니다.");
            $('#visible_icon').html("visibility_off");
          }
      });
         
      });
      
      </script>
    </head>
    
   <body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />
    
<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="../manage"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="./list.do">관리자 게시판</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">게시글 수정</a></li>
  </ol>
  </nav>
    <div class="container col-xs-12">
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <h3>게시글 수정 - <span class="h6">${board.title }</span></h3>
    <br>
    
    <FORM class="form" name='frm' method='POST' action='./update.do' 
           enctype='multipart/form-data'>
      
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text bg-dark text-light" id="basic-addon1"><i class="material-icons">title</i>&nbsp;&nbsp;제목</span>
      </div>
      <input type="text" value="${board.title }" name='title' id='title' class="form-control" placeholder="" aria-label="title" aria-describedby="basic-addon1">
    </div>
    
    <div class="form-group mb-3">
      <input type="text" value="${board.word }" data-role="tagsinput" name='word' id='word' class="form-control" placeholder="태그" aria-label="mainurl" aria-describedby="basic-addon1">
    </div>
    
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="inputGroupFileAddon01"><i class="material-icons">attachment</i>&nbsp;&nbsp;파일 업로드</span>
      </div>
      <div class="custom-file">
        <input type="file" value="${board.files }" name='filesMF' class="custom-file-input" id="filesMF" aria-describedby="filesMF" data-browse="파일 찾기" multiple="multiple">
        <label class="custom-file-label" for="filesMF">업로드할 파일 선택</label>
      </div>
    </div>
    
    <div class="input-group date mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="inputGroupFileAddon01"><i class="material-icons">date_range</i>&nbsp;&nbsp;마감일 (optional)</span>
      </div>
      <input type="text" name="ddate" value="${board.ddate.substring(0,10) }" class="form-control">
    </div>
    <script type="text/javascript">
    var date = '${board.ddate }';
    $('.input-group.date').datepicker({
      format: "yyyy-mm-dd",
      language: "ko",
      defaultViewDate: { year: date.substring(0,4), month: date.substring(6,7), day: date.substring(9,10) }
    });
    </script>
    
    <div class="mx-auto mb-3">
      <textarea class="form-control input-lg" name='content' id='content' rows='50' cols='70'>${board.content }</textarea>
    </div>
    
    
    <input class='form_input' type='hidden' name='adminboardno' id='adminboardno' value='${board.adminboardno }' required>
    <input class='form_input' type='hidden' name='adminno' id='adminno' value='${board.adminno }' required>
    
    <button class="btn btn-secondary btn-block" type="submit">수정</button>
    
    
    
    </FORM>
    
    
    <div class="p-4"></div>
    </div> <!-- end col -->
  </div> <!-- end row -->
</div> <!-- end content-wrapper -->
</div>
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    </body>
</html>

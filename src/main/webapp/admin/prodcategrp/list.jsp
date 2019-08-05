<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath();
%>
<!DOCTYPE html>
<html class="admin" lang="ko" style="">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=2.0">
<title>리셰</title>
<jsp:include page="/admin/ssi.jsp"></jsp:include>

      <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
      <link href="https://fonts.googleapis.com/icon?family=Material+Icons"
            rel="stylesheet">
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css"/>
      
      <link href="${pageContext.request.contextPath}/css/richer.css" rel="Stylesheet" type="text/css"> 
      <link href="${pageContext.request.contextPath}/css/nanami.css" rel="Stylesheet" type="text/css"> 
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/material-design-iconic-font/2.2.0/css/material-design-iconic-font.min.css">
      

    <!-- Bootstrap-Iconpicker -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-iconpicker/1.10.0/css/bootstrap-iconpicker.min.css"/>
    
      <script type="text/JavaScript"
        src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>   
      <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.bundle.min.js"></script>  -->  
      
    <!-- Bootstrap-Iconpicker Bundle -->
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-iconpicker/1.10.0/js/bootstrap-iconpicker.bundle.min.js"></script>
        
      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      
      $(function(){
        //window.history.replaceState("", "", "./empty.jsp");
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      
      </script>
        
<script type="text/javascript">
  function update(prodcategrpno) {
    $('#panel_create').hide();
    $('#panel_update').show();
    
    var params = 'prodcategrpno=' + prodcategrpno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var frm_update = $('#frm_update'); // 폼이 여러개인경우
        $('#prodcategrpno', frm_update).val(rdata.prodcategrpno);
        $('#title', frm_update).val(rdata.prodgrp_title);
        $('#seqno', frm_update).val(rdata.prodgrp_seqno);
        $('#visible', frm_update).val(rdata.prodgrp_visible);
        //$('#visible', frm_update).val(rdata.list);
        
        $('#main_panel').hide(); 
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });

    // 처리중 출력
    $('#main_panel').html("<IMG src='./images/ani01.gif' style='width: 5%;'>");
    $('#main_panel').show();
    
  }

  // 하나의 그룹 삭제
  function deleteOne(prodcategrpno) {
    $('#panel_create').hide();
    $('#panel_update').hide();
    
    var params = 'prodcategrpno=' + prodcategrpno;
    $.ajax({
      url: "./read.do",
      type: "get", // get
      cache: false,
      async: true,  // true: 비동기
      dataType: "json", // 응답 형식: json, xml, html...
      data: params,
      success: function(rdata) {
        // alert(rdata);
        var str = '';
        var frm_delete = $('#frm_delete'); // 폼이 여러개인경우

        if (rdata.prodgrp_cnt > 0){
          str = rdata.prodgrp_title + " ("+ rdata.prodgrp_rdate+")"
          + "<span> 카테고리그룹 관련 카테고리  " + rdata.prodgrp_cnt + " 건이 발견되었습니다.</span><br>"
          + rdata.prodgrp_title +" 카테고리그룹을 삭제하려면 관련 카테고리를 모두 삭제해야합니다.<br><br>"
          + "[<A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno="+rdata.prodcategrpno+"'>관련 카테고리 보러가기</A>]<br><br>"
          + "[<A style='color:red' href='../prodcate/delete_cascade.do?prodcategrpno="+rdata.prodcategrpno+"'>[위험]관련카테고리 강제로 삭제하러 가기</A>]";
        }else if(rdata.prodgrp_cnt == 0){
          str = rdata.prodgrp_title + " ("+ rdata.prodgrp_rdate+")"
          + " 카테고리그룹 관련 카테고리  " + rdata.prodgrp_cnt + " 건이 발견되었습니다.<br><br>"
          + rdata.prodgrp_title +" 카테고리그룹을 삭제하시겠습니까? 삭제하면 복구 할 수 없습니다.";
        }else if(rdata.prodgrp_cnt < 0){
          str = "[ERROR] 카테고리그룹 관련 카테고리 수가 음수 입니다."
        }
        $('#prodcategrpno', frm_delete).val(rdata.prodcategrpno);
        
        // str = '';
        // str = rdata.prodgrp_title + " ("+ rdata.prodgrp_rdate+")";

        $('#main_panel').hide();
        $('#msg_delete').html(str);
        $('#panel_delete').show();
      },
      // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
      error: function(request, status, error) { // callback 함수
        var msg = 'ERROR<br><br>';
        msg += '<strong>request.status</strong><br>'+request.status + '<hr>';
        msg += '<strong>error</strong><br>'+error + '<hr>';
        console.log(msg);
      }
    });

    // 처리중 출력
    $('#main_panel').html("<IMG src='./images/ani01.gif' style='width: 5%;'>");
    $('#main_panel').show();
    
  }
  
 //출력 유무 Y -> N
  function nonvisible(prodcategrpno) {
    var frm_visible = $('#frm_visible');
    frm_visible.attr('action', './nonvisible.do');
    $('#prodcategrpno', frm_visible).val(prodcategrpno);
    frm_visible.submit();
  }
 //출력 유무 N -> Y
  function visible(prodcategrpno) {
    var frm_visible = $('#frm_visible');
    frm_visible.attr('action', './visible.do');
    $('#prodcategrpno', frm_visible).val(prodcategrpno);
    frm_visible.submit();
  }
  
  // 우선순위 up 10 -> 1
  function seqnoUp(prodcategrpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_up.do');
    $('#prodcategrpno', frm_seqno).val(prodcategrpno);
    frm_seqno.submit();
  }
  
  // 우선순위 down 1 -> 10
  function seqnoDown(prodcategrpno) {
    var frm_seqno = $('#frm_seqno');
    frm_seqno.attr('action', './update_seqno_down.do');
    $('#prodcategrpno', frm_seqno).val(prodcategrpno);
    frm_seqno.submit();
  }
  
  function cancel() {
    $('#panel_update').hide();
    $('#panel_delete').hide();
    $('#panel_create').show();
  }
  
</script>
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />

<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <!-- 페이지 위치 구간 -->
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">전체 대분류 목록</a></li>
  </ol>
  </nav>
  <!-- /페이지 위치 구간 종료 -->
  
  <div class="container col-xs-12">
  <!-- 알림 메시지 구간 -->
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
  
  
  <h3>카테고리 그룹 관리</h3>
  <div class="alert alert-info" role="alert">
    <h4 class="alert-heading">대분류 및 소분류 중 대분류 수정 페이지입니다.</h4>
    <p>
      해당 페이지는 대분류를 수정할 수 있는 페이지입니다.
      현재 출력되는 대분류 및 카테고리는 왼쪽 위 메뉴 버튼을 통해 확인할 수 있습니다.
    </p>
  </div>
  <!-- /알림 메시지 구간 종료 -->
  <!-- 내용 합치는 구간 -->
  
  <!-- 우선 순위 증가 감소 폼, GET -> POST -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>
  </FORM>
  
  <!-- 출력 유무 폼, GET -> POST -->
  <FORM name='frm_visible' id='frm_visible' method='post' action=''>
    <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>
  </FORM>
  
  
 <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
  <DIV id='panel_create' class="form-row mb-3">
   <div class="col-lg-6 mx-lg-0">
    <div class="input-group">
      <div class="input-group-prepend">
        <span class="input-group-text bg-dark text-light" id="basic-addon1"><i class="material-icons">title</i>&nbsp;&nbsp;그룹명</span>
      </div>
      <input type="text" name='prodgrp_title' id='title' required="required" class="form-control" placeholder="" aria-label="title" aria-describedby="basic-addon1">
    </div>
   </div>
    
   <div class="col-lg-2 mx-lg-0">
    <div class="input-group">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">flip_to_front</i>&nbsp;&nbsp;순서</span>
      </div>
      <input type="number" name='prodgrp_seqno' id='seqno' value='1' min='1' max='1000' step='1' required="required" class="form-control" placeholder="" aria-label="title" aria-describedby="basic-addon1">
    </div>
   </div>
    
   <div class="col-lg-2 mx-lg-0">
   
      <select name='prodgrp_visible' id='visible' class="custom-select">
        <option value='Y' selected="selected">공개</option>
        <option value='N' class="text-danger">비공개</option>
      </select>
   </div>
       
   <div class="col-auto mx-lg-0">
      <button class="btn btn-primary" type="submit" id='submit'>등록</button>
      <button class="btn btn-secondary" type="button" onclick="cancel();">취소</button>
   </div>
  </DIV>
    </FORM>

    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
  <DIV id='panel_update' style='display: none;' class="form-row mb-3">
   <div class="col-lg-6 mx-lg-0">
    <div class="input-group">
      <div class="input-group-prepend">
        <span class="input-group-text bg-info text-light" id="basic-addon1"><i class="material-icons">title</i>&nbsp;&nbsp;그룹명</span>
      </div>
      <input type="text" name='prodgrp_title' id='title' required="required" class="border-info form-control" placeholder="" aria-label="title" aria-describedby="basic-addon1">
    </div>
   </div>
    
   <div class="col-lg-2 mx-lg-0">
    <div class="input-group">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">flip_to_front</i>&nbsp;&nbsp;순서</span>
      </div>
      <input type="number" name='prodgrp_seqno' id='seqno' value='1' min='1' max='1000' step='1' required="required" class="border-info form-control" placeholder="" aria-label="title" aria-describedby="basic-addon1">
    </div>
   </div>
    
   <div class="col-lg-2 mx-lg-0">
   
      <select name='prodgrp_visible' id='visible' class="custom-select">
        <option value='Y' selected="selected">공개</option>
        <option value='N' class="text-danger">비공개</option>
      </select>
   </div>
       
   <div class="col-auto mx-lg-0">
      <button class="btn btn-info" type="submit" id='submit'>수정</button>
      <button class="btn btn-secondary" type="button" onclick="cancel();">취소</button>
   </div>
  </DIV>
  
  <!-- 
      <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>

      <label for='title'>그룹 이름</label>
      <input type='text' name='prodgrp_title' id='title' size='15' value='' required="required" style='width: 30%;'>

      <label for='seqno'>순서</label>
      <input type='number' name='prodgrp_seqno' id='seqno' value='' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label for='visible'>출력</label>
      <select name='prodgrp_visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>

      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
       -->
      
    </FORM>
  
  <!-- 삭제 폼-->
  <DIV id='panel_delete' style='display: none;'class="alert alert-danger">
    <FORM name='frm_delete' id='frm_delete' method='POST' 
                action='./delete.do'> 
      <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>

      <DIV id='msg_delete' class="alert-text"></DIV>
      <button class="btn btn-danger" type="submit" id='submit'>삭제</button>
      <button class="btn btn-outline-primary" type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='main_panel' class='main_panel'></DIV>
  
<TABLE class='table table-striped table-sm'>
  <colgroup>
    <col style='width: 10%;'/>
    <col style='width: 40%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>    
    <col style='width: 20%;'/>
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>순서</TH>
    <TH>대분류명</TH>
    <TH style='text-align: center ;'>카테고리 갯수</TH>
    <TH style='text-align: center ;'>등록일</TH>
    <TH style='text-align: center ;'>출력</TH>
    <TH style='text-align: center ;'>기타</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="prodcategrpVO" items="${list }">
  <TR>
    <TD style='text-align: center ;'>${prodcategrpVO.prodgrp_seqno }</TD>
    <TD><A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrpVO.prodcategrpno }'>${prodcategrpVO.prodgrp_title }</A></TD>
    <TD style='text-align: center ;'>${prodcategrpVO.prodgrp_cnt }</TD>
    <TD style='text-align: center ;'>${prodcategrpVO.prodgrp_rdate.substring(0, 10) }</TD>
    <!-- <TD style='text-align: center ;'>${prodcategrpVO.prodgrp_cnt }</TD> 등록된 자료수 -->
    <TD style='text-align: center ;'>
    <c:choose>
      <c:when test="${prodcategrpVO.prodgrp_visible == 'Y'}">
      <a href="javascript:nonvisible(${prodcategrpVO.prodcategrpno })"role="button" 
        class="btn btn-sm btn-success py-0" 
        data-toggle="tooltip" data-placement="left" title="현재 공개됨. 클릭하여 비공개로 전환"
        >
         <span>
          <i class="material-icons">visibility</i>
         </span>
        </a>
      </c:when>
      <c:when test="${prodcategrpVO.prodgrp_visible == 'N'}">
      
      <a href="javascript:visible(${prodcategrpVO.prodcategrpno })"role="button" 
        class="btn btn-sm btn-outline-dark py-0" 
        data-toggle="tooltip" data-placement="left" title="현재 공개되지 않음. 클릭하여 공개로 전환"
        >
         <span>
          <i class="material-icons">visibility_off</i>
         </span>
        </a>
      </c:when>
    </c:choose>
    
    </TD>
    <TD style='text-align: center ;'>
    
      <div class="btn-group btn-group-sm btn-block" role="group" aria-label="">
      <a href="javascript:update(${prodcategrpVO.prodcategrpno })"role="button" 
        class="btn btn-sm btn-info py-0" 
        data-toggle="tooltip" data-placement="left" title="수정"
        >
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        <a href="javascript:seqnoUp(${prodcategrpVO.prodcategrpno })"role="button" 
          class="btn btn-sm btn-dark py-0 " 
          data-toggle="tooltip" data-placement="left" title="위로 이동"
          >
         <span>
          <i class="material-icons">arrow_upward</i>
         </span>
        </a>
        <a href="javascript:seqnoDown(${prodcategrpVO.prodcategrpno })"role="button" 
          class="btn btn-sm btn-dark py-0 " 
          data-toggle="tooltip" data-placement="left" title="아래로 이동"
          >
         <span>
          <i class="material-icons">arrow_downward</i>
         </span>
        </a>
        
        <a href="javascript:deleteOne(${prodcategrpVO.prodcategrpno })"role="button" 
        class="btn btn-sm btn-danger py-0 " 
        data-toggle="tooltip" data-placement="left" title="대분류 삭제">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </div>
    
    </TD>
  </TR>
  </c:forEach> 
  </tbody>

</TABLE>

  
  <!-- /내용 합치는 구간 종료 -->
  </div> <!-- end col -->
  </div> <!-- end row -->
</div> <!-- end content-wrapper -->
</div>
  
  <div class="pt-5">
  
  </div>
  
  
  
  <!-- 스크롤 문제 해결을 위해 아래 여백 설정-->
  <div class="p-5"></div>
  <jsp:include page="/menu/bottom_admin.jsp" flush='false' />
</body>
</html>
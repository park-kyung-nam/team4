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
        $('#visible', frm_update).val(rdata.list);
        
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
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item" aria-current="page">대시보드</li>
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
  <!-- /알림 메시지 구간 종료 -->
  <!-- 내용 합치는 구간 -->
  
  <DIV class='content' style='width: 90%;'>
  <!-- 우선 순위 증가 감소 폼, GET -> POST -->
  <FORM name='frm_seqno' id='frm_seqno' method='post' action=''>
    <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>
  </FORM>
  
  <!-- 출력 유무 폼, GET -> POST -->
  <FORM name='frm_visible' id='frm_visible' method='post' action=''>
    <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>
  </FORM>
  
  <DIV class='title_line'>카테고리 그룹</DIV>

  <DIV id='panel_create' style='padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_create' id='frm_create' method='POST' action='./create.do'>
      <!-- <input type='hidden' name='lang' id='lang' value='en'> --> <!-- ko, en -->
        
      <label for='title'>그룹 이름</label>
      <input type='text' name='prodgrp_title' id='title' value='' required="required" style='width: 25%;'>

      <label for='seqno'>순서</label>
      <input type='number' name='prodgrp_seqno' id='seqno' value='1' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label for='visible'>형식</label>
      <select name='prodgrp_visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>
       
      <button type="submit" id='submit'>등록</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='panel_update' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_update' id='frm_update' method='POST' 
                action='./update.do'>
      <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>

      <label for='title'>그룹 이름</label>
      <input type='text' name='prodgrp_title' id='title' size='15' value='' required="required" style='width: 30%;'>

      <label for='seqno'>순서</label>
      <input type='number' name='prodgrp_seqno' id='seqno' value='' required="required" 
                min='1' max='1000' step='1' style='width: 5%;'>
  
      <label for='visible'>형식</label>
      <select name='prodgrp_visible' id='visible'>
        <option value='Y' selected="selected">Y</option>
        <option value='N'>N</option>
      </select>

      <button type="submit" id='submit'>저장</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>
  
  <!-- 삭제 폼-->
  <DIV id='panel_delete' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_delete' id='frm_delete' method='POST' 
                action='./delete.do'> 
      <input type='hidden' name='prodcategrpno' id='prodcategrpno' value=''>

      <DIV id='msg_delete' style='margin: 20px auto;'></DIV>
      <button type="submit" id='submit'>삭제</button>
      <button type="button" onclick="cancel();">취소</button>
    </FORM>
  </DIV>

  <DIV id='main_panel' class='main_panel'></DIV>
  
<TABLE class='table table-striped'>
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
    <TH>자료수</TH>
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
        <A href="javascript:nonvisible(${prodcategrpVO.prodcategrpno })"><IMG src='./images/display_show.png'></A>
      </c:when>
      <c:when test="${prodcategrpVO.prodgrp_visible == 'N'}">
        <A href="javascript:visible(${prodcategrpVO.prodcategrpno })"><IMG src='./images/display_hide.png'></A>
      </c:when>
    </c:choose>
    
    </TD>
    <TD style='text-align: center ;'>
      <A href="javascript:seqnoUp(${prodcategrpVO.prodcategrpno })"><IMG src='./images/up.png' title='우선순위 높임' style='width: 16px;'></A>
      <A href="javascript:seqnoDown(${prodcategrpVO.prodcategrpno })"><IMG src='./images/down.png' title='우선순위 높임' style='width: 16px;'></A>
     
      <A href="javascript:update(${prodcategrpVO.prodcategrpno })"><IMG src='./images/update.png' title='수정'></A>
      <A href="javascript:deleteOne(${prodcategrpVO.prodcategrpno })"><IMG src='./images/delete.png' title='삭제'></A>
    </TD>
  </TR>
  </c:forEach> 
  </tbody>

</TABLE>

</DIV> <!-- content END -->
  
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
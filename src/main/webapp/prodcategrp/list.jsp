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
<jsp:include page="/menu/top_index.jsp" flush='false' />
  <div class="container" style="min-height : 100vh;">
  
  <!-- 사용자 페이지 -->
  
  <DIV class='title_line'>카테고리 그룹</DIV>
  
  <DIV id='main_panel' class='main_panel'></DIV>
  
<TABLE class='table table-striped'>
  <colgroup>
    <col style='width: 20%;'/>
    <col style='width: 60%;'/>
    <col style='width: 20%;'/>   
  </colgroup>

  <thead>  
  <TR>
    <TH style='text-align: center ;'>번호</TH>
    <TH>카테고리 그룹명</TH>
    <TH style='text-align: center ;'>등록일</TH>
  </TR>
  </thead>
  
  <tbody>
  <c:forEach var="prodcategrpVO" items="${list }" varStatus="info">
  <TR>
    <TD style='text-align: center ;'>${info.count }</TD>
    <TD><A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrpVO.prodcategrpno }'>${prodcategrpVO.prodgrp_title }</A></TD>
    <TD style='text-align: center ;'>${prodcategrpVO.prodgrp_rdate.substring(0, 10) }</TD>
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
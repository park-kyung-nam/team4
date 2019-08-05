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

function prod_good_up(productno, prodcateno, viewno, nowPage, prod_word, customerno){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  var frm_prodg = $('#frm_prodg');
  frm_prodg.attr('action', './prod_good_up.do');
  $('#productno', frm_prodg).val(productno);
  $('#prodcateno', frm_prodg).val(prodcateno);
  $('#viewno', frm_prodg).val(viewno);
  $('#nowPage', frm_prodg).val(nowPage);
  $('#prod_word', frm_prodg).val(prod_word);
  $('#customerno', frm_prodg).val(customerno);
  frm_prodg.submit();
}

function prod_good_down(productno, prodcateno, viewno, nowPage, prod_word, customerno){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  
  var frm_prodg = $('#frm_prodg');
  frm_prodg.attr('action', './prod_good_down.do');
  $('#productno', frm_prodg).val(productno);
  $('#prodcateno', frm_prodg).val(prodcateno);
  $('#viewno', frm_prodg).val(viewno);
  $('#nowPage', frm_prodg).val(nowPage);
  $('#prod_word', frm_prodg).val(prod_word);
  $('#customerno', frm_prodg).val(customerno);
  frm_prodg.submit();
}

function cntUp(prodestno, prodcateno, viewno, nowPage, prod_word, customerno){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  if(prodcateno == undefined){
    prodcateno = 1;
  }
  
  var frm_cnt = $('#frm_cnt');
  frm_cnt.attr('action', './update_cnt_up.do');
  $('#prodestno', frm_cnt).val(prodestno);
  $('#prodcateno', frm_cnt).val(prodcateno);
  $('#viewno', frm_cnt).val(viewno);
  $('#nowPage', frm_cnt).val(nowPage);
  $('#prod_word', frm_cnt).val(prod_word);
  $('#customerno', frm_cnt).val(customerno);
  frm_cnt.submit();
}

function cntDown(prodestno, prodcateno, viewno, nowPage, prod_word, customerno){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  if(prodcateno == undefined){
    prodcateno = 1;
  }
  var frm_cnt = $('#frm_cnt');
  frm_cnt.attr('action', './update_cnt_down.do');
  $('#prodestno', frm_cnt).val(prodestno);
  $('#prodcateno', frm_cnt).val(prodcateno);
  $('#viewno', frm_cnt).val(viewno);
  $('#nowPage', frm_cnt).val(nowPage);
  $('#prod_word', frm_cnt).val(prod_word);
  $('#customerno', frm_cnt).val(customerno);
  frm_cnt.submit();
}

function prodestDelete(prodestno, prodcateno, viewno, nowPage, prod_word, customerno){
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  if(prodcateno == undefined){
    prodcateno = 1;
  }
  var prodest_delete = $('#prodest_delete');
  prodest_delete.attr('action', './prodest_delete.do');
  $('#prodestno', prodest_delete).val(prodestno);
  $('#prodcateno', prodest_delete).val(prodcateno);
  $('#viewno', prodest_delete).val(viewno);
  $('#nowPage', prodest_delete).val(nowPage);
  $('#prod_word', prodest_delete).val(prod_word);
  $('#customerno', prodest_delete).val(customerno);
  prodest_delete.submit();
}


function page_replace(prodcateno, viewno, nowPage, prod_word, customerno) {
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(customerno == undefined){
    customerno = 1;
  }

  location.href="./list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
                    +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno;
  //location.href="./list_by_prodcateno_search_paging.do?prodcateno="+prodcateno +"&viewno="+viewno;
}

function prodest(productno, customerno, prodcateno, viewno, nowPage, prod_word){
  
  // alert("customerno="+customerno);
  if(nowPage == undefined){
    nowPage = 1;
  }
  if(prod_word == undefined){
    prod_word = "";
  }
  if(viewno == undefined){
    viewno = 1;
  }
  if(prodcateno == undefined){
    prodcateno = 1;
  }

  var frm_prodest = $('#frm_prodest');
  frm_prodest.attr('action', './prodest_create.do');
  $('#productno', frm_prodest).val(productno);
  $('#customerno', frm_prodest).val(customerno);
  $('#prodcateno', frm_prodest).val(prodcateno);
  $('#viewno', frm_prodest).val(viewno);
  $('#nowPage', frm_prodest).val(nowPage);
  $('#prod_word', frm_prodest).val(prod_word);

  frm_prodest.submit();
}



function estimate_add(prod_price){
  var count = $('#count').val()
  // alert('count: ' + count);
  // alert('prod_price: ' + prod_price);
  $('#count_panel').html(prod_price*count)
  
}

function estimate(productno){
  $('#panel_estimate').show();
  var params = 'productno=' + productno;
  $.ajax({
    url: "./readp.do",
    type: "get", // get
    cache: false,
    async: true,  // true: 비동기
    dataType: "json", // 응답 형식: json, xml, html...
    data: params,
    success: function(rdata) {
      /* var frm_update = $('#frm_update'); // 폼이 여러개인경우
      $('#prodcategrpno', frm_update).val(rdata.prodcategrpno);
      $('#title', frm_update).val(rdata.prod_title);
      $('#seqno', frm_update).val(rdata.prod_seqno);
      $('#visible', frm_update).val(rdata.prod_visible);
      $('#visible', frm_update).val(rdata.list); */
      
      var count = 0
      if(count == 0){
        count = 1;
      }else if(count > 0){
        count = $('#count').val();
      }
      $('#estimate_td').append('<tr>');
      $('#estimate_td').append('<td><span class="category">'+rdata.prodcate_title+'</span></td>');
      $('#estimate_td').append('<td><span class="category">'+rdata.prod_title+'</span></td>');
      $('#estimate_td').append('<td><span class="category">'+rdata.prod_price+'</span></td>');
      $('#estimate_td').append('<td><input type="number" onchange="javascript:estimate_add('+rdata.prod_price+');" name="period" id="count" size="10" value="1" min="1" max="60" step="1"></td>');
      $('#estimate_td').append('<td><span id="count_panel" name="" class="category" ></span></td></tr>');
      $('#estimate_td').append('</tr>');
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
    <li class="breadcrumb-item"><a href="../prodcategrp/list.do">카테고리</a></li>
    <li class="breadcrumb-item"><A href='../prodcate/list_by_prodcategrpno.do?prodcategrpno=${prodcategrp_ProdcateVO.prodcategrpno }'>${prodcategrp_ProdcateVO.prodgrp_title }</A> </li>
    <li class="breadcrumb-item active"aria-current="page"><A href='javascript:location.reload();'>${prodcategrp_ProdcateVO.prodcate_title }</A> </li>
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
  
  <!-- 제품 추천 증가 감소 폼 -->
  <FORM name='frm_prodg' id='frm_prodg' method='post' action=''>
    <input type='hidden' name='productno' id='productno' value=''>
    <input type='hidden' name='customerno' id='customerno' value='1'>
    <input type='hidden' name='prodcateno' id='prodcateno' value='1'>
    <input type='hidden' name='viewno' id='viewno' value='1'>
    <input type='hidden' name='nowPage' id='nowPage' value='1'>
    <input type='hidden' name='prod_word' id='prod_word' value=''>
  </FORM>

<!-- 출력 폼-->
  <DIV id='panel_replace' style='display: none; padding: 10px 0px 10px 0px; background-color: #F9F9F9; width: 100%; text-align: center;'>
    <FORM name='frm_replace' id='frm_replace' method='GET' 
                action='./list_by_prodcateno_search_paging.do'> 
      <input type='hidden' name='prodcateno' id='prodcateno' value=''>
      <input type='hidden' name='viewno' id='viewno' value='2'>
      <button type="submit" id='submit'></button>
    </FORM>
  </DIV>
  
  <div class="d-flex">
  <c:choose>
    <c:when test="${param.word.length() > 0}">
      <h3 class="flex-grow-1">${param.word }<span class="h5"> 검색 결과 (${search_count } 건)</span></h3>
    </c:when>
    <c:otherwise>
      <h3 class="flex-grow-1">${prodcategrp_ProdcateVO.prodcate_title }<span class="h5"> 카테고리 제품 목록</span></h3>
    </c:otherwise>
  </c:choose>
  
  <form class="form-inline"name='sfrm' id='sfrm' method="get" action="./list_by_prodcateno_search_paging.do">
  
  <div class="input-group mx-2">
  <input type="text" name="prod_word" id="prod_word" value="${param.prod_word }" class="form-control" placeholder="태그 검색" aria-label="내용 검색" aria-describedby="button-addon2">
  <div class="input-group-append">
  <c:if test="${param.prod_word != null}">
    <a href="./list.do"class="btn btn-light btn-outline-danger" id="button-addon2"data-toggle="tooltip"
      data-placement="top" title="검색 초기화">
      <i class="material-icons">clear</i>
    </a>
   </c:if>
    
    <button class="btn btn-light btn-outline-secondary" type="submit" id="button-addon2">
      <i class="material-icons">search</i>
    </button>
  </div>
  </div>
  
  <a href="./create.do?prodcateno=${prodcategrp_ProdcateVO.prodcateno }" class="btn btn-primary"><i class="material-icons">add</i> 새 제품 등록</a>
  
  </form>
  
  </div>
  
  <table width="980" border="0" align="center" cellpadding="0" cellspacing="0" style="border-top:2px solid #6cad2c">
    <tbody id= 'replace_product'>
    <tr> 
      <!--<td id="page_replace_6"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 6, ${nowPage }, '${param.prod_word }'); page_replace_add(this.id);" class="table_product${param.viewno == 6 ? '_cursor' : '' }">제조사순</td>-->
      <td id="page_replace_1"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 1, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 1 ? '_cursor' : '' }">인기순</td>
      <td id="page_replace_2"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 2, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 2 ? '_cursor' : '' }">조회순</td>
      <td id="page_replace_3"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 3, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 3 ? '_cursor' : '' }">낮은가격순</td>
      <td id="page_replace_4"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 4, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 4 ? '_cursor' : '' }">높은가격순</td>
      <td id="page_replace_5"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 5, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 5 ? '_cursor' : '' }">신제품순</td>
      <td id="page_replace_6"  onclick="javascript:page_replace(${prodcategrp_ProdcateVO.prodcateno }, 6, 1, '${param.prod_word }' , ${param.customerno }); page_replace_add(this.id);" class="table_product${param.viewno == 6 ? '_cursor' : '' }">상품명순</td>
    </tr>
    </tbody>
  </table>
  
  <div class='menu_line' style='clear: both;'></div>       

  <table class="table table-striped" style='width: 100%;'>
      <colgroup>
        <col style="width: 5%;"></col>
        <col style="width: 40%;"></col>
        <col style="width: 20%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 10%;"></col>
        <col style="width: 15%;"></col>
        
      </colgroup>
      <%-- table 컬럼 --%>
      <thead>
        <tr>
          <th>파일</th>
          <th>제목</th>
          <th>등록일</th>
          <th>조회수</th>
          <th>추천수</th>
          <th>기타</th>
        </tr>
      
      </thead>
      
      <%-- table 내용 --%>
      <tbody>
        <c:forEach var="productVO" items="${list }">
          <tr>
            <td style='vertical-align: middle;'>
            <c:choose>
              <c:when test="${productVO.thumb != ''}">
                <IMG id='thumb' src='./storage/${productVO.thumb}' > <!-- 이미지 파일명 출력 -->
              </c:when>
              <c:otherwise>
                <IMG id='thumb' src='./images/none1.png' style='width: 120px; height: 80px;'> <!-- 파일이 존재하지 않는 경우 -->
              </c:otherwise>
            </c:choose>
            </td>          
            <td style='vertical-align: middle;'>
              <c:choose>
                <c:when test="${productVO.prod_ansnum == 0 }"> <!-- 부모글인 경우 -->
                  <img src='./images/ting1.png'>
                </c:when>
                <c:when test="${productVO.prod_ansnum > 0}">    <!-- 답변글인 경우 -->
                  <img src='./images/white.png' style='width: ${productVO.prod_indent * 20}px; opacity: 0.0;'>
                  <img src='./images/reply3.png'>
                </c:when>
              </c:choose>
              <a href="./read.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&prod_word=${param.prod_word}&nowPage=${param.nowPage}&customerno=${param.customerno}">${productVO.prod_title}</a> 
            </td> 

            <td style='vertical-align: middle;'>${productVO.prod_rdate.substring(0, 16)}</td>
            <td style='vertical-align: middle;'>${productVO.prod_viewcnt}</td>
            <td style='vertical-align: middle;'>${productVO.prod_good}
            <a href="javascript:prod_good_up(${productVO.productno}, ${prodcategrp_ProdcateVO.prodcateno }, ${param.viewno }, ${param.nowPage }, '${param.prod_word }', '${sessionScope.customerno}');"><IMG src='./images/up.png' title='추천증가' style='width: 16px;'></a>
            <a href="javascript:prod_good_down(${productVO.productno}, ${prodcategrp_ProdcateVO.prodcateno }, ${param.viewno }, ${param.nowPage }, '${param.prod_word }', '${sessionScope.customerno}');"><IMG src='./images/down.png' title='추천감소' style='width: 16px;'></a>
            </td>
            <td style='vertical-align: middle;'>
              <a href="./update.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}&viewno=${param.viewno }&customerno=${param.customerno }"><img src="./images/update.png" title="수정" border='0'/></a>
              <a href="./delete.do?productno=${productVO.productno}&prodcateno=${productVO.prodcateno}&nowPage=${param.nowPage}&prod_word=${param.prod_word}&viewno=${param.viewno }&customerno=${param.customerno }"><img src="./images/delete.png" title="삭제"  border='0'/></a>
              G${productVO.prod_grpno}/A${productVO.prod_ansnum}
              <!-- <a name='${productVO.productno}' href="javascript:estimate(${productVO.productno });"><img src="./images/youtube.png" title="견적" border='0'/></a> -->
            </td>
          </tr>
        </c:forEach>
        
      </tbody>
  </table>
  
  
  <DIV class='bottom_menu'>${paging }</DIV>
  <br><br>

  
  
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
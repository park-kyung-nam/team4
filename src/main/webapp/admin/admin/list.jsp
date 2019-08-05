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
        window.history.replaceState("", "", "./list.do");
        $('[data-toggle="tooltip"]').tooltip();
      });
      
      function del_con(adminno){
        
        var params = 'adminno='+adminno;
        $.ajax({
          url:"./admin.scan",
          type:'get', //form type
          cache:false,
          async:true, // 비동기
          dataType:'json', //응답 형식 : html, json, xml...
          data:params,
          success:function(rdata){
            $('#adminno_del').val(adminno);
            $('#del_name').html(rdata.name);
            $('#unreg_modal').modal('show');
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            //
          }
        })
        
      }
      
      function priv_con(adminno){
      var params = 'adminno='+adminno;
      
      $.ajax({
        url:"./admin.scan",
        type:'get', //form type
        cache:false,
        async:true, // 비동기
        dataType:'json', //응답 형식 : html, json, xml...
        data:params,
        success:function(rdata){
          if(rdata.admincodeno > 0){
          $('#adminno_priv').val(adminno);
          $('#name_priv').val(rdata.name);
          $('#priv_name').html(rdata.name);
          $('#admincodeno_'+rdata.admincodeno).prop('checked', true);
          $('#priv_modal').modal('show');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          //
        }
      })
        
      }
      
      </script>
        
        
<style type="text/css">

</style>
</head>
<body style="">
<jsp:include page="/menu/top_admin.jsp" flush='false' />

<!-- Modal -->
<form id="frm_del" method='POST' action='./dereg.do' onsubmit="return del();">
<input type="hidden" id="adminno_del" name="adminno" value="">
<div class="modal" id="unreg_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-danger">
        <h5 class="modal-title" id="unreg_modal_title">관리자 탈퇴 처리</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-danger">
        
        정말로 <strong id="del_name"></strong> 관리자를 탈퇴시키겠습니까?<br>
        한 번 탈퇴하면 복구할 수 없으며 일정 기간이 지난 뒤 삭제됩니다.
      </div>
      <div class="modal-footer bg-danger">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-outline-light">탈퇴</button>
      </div>
    </div>
  </div>
</div>
</form>

<!-- priv modal -->
<form id="frm_priv" method='POST' action='./update_priv.do' onsubmit="return priv();">
<input type="hidden" id="adminno_priv" name="adminno" value="">
<input type="hidden" id="name_priv" name="name" value="">
<div class="modal" id="priv_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-info">
        <h5 class="modal-title" id="unreg_modal_title"><strong id="priv_name"></strong> 관리자 권한 변경</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-info">
      <c:forEach var="codes" items="${codes}" varStatus="codesinfo">
      
      <div class="custom-control custom-radio">
        <input type="radio" id="admincodeno_${codes.admincodeno }" name="admincodeno" 
          value="${codes.admincodeno }" class="custom-control-input">
        <label class="custom-control-label" for="admincodeno_${codes.admincodeno }">
          <strong>${codes.privchar }</strong> - ${codes.privdesc }
        </label>
      </div>
      
      </c:forEach>
      
      </div>
      <div class="modal-footer bg-info">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-outline-light">권한 변경</button>
      </div>
    </div>
  </div>
</div>
</form>

<div class="content-wrapper flex-fill px-2 pr-md-4">
  <div class="row clearfix">
  <div class="pt-5 pb-4"></div>
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="./"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="#">관리자</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">관리자 목록</a></li>
  </ol>
  </nav>
    <div class="container col-xs-12">
   <!--  
  <div id="favnav" class="d-flex mx-3">
    <nav class="nav pt-0 mb-0 mr-auto">
       <a class="nav-link px-2" href="javascript:void(0);">
         <i class="material-icons">favorite</i> 12345
       </a>
    </nav>
  </div>   -->
  
  <!-- 
  
  <div class="alert alert-success alert-dismissible fade show" role="alert">
    <strong>케이쨩</strong> 카테고리 그룹을 생성하였습니다.
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
   -->
   
   <!-- 
    alert-primary
    alert-secondary
    alert-success
    alert-warning
    alert-danger
    alert-info
    alert-light
    alert-dark
    -->
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
  <div class="d-flex">
  <h3 class="flex-grow-1">전체 관리자 목록</h3>
  <a href="./create.do" class="btn btn-primary">관리자 추가</a>
  </div>
  <br>
  
  <TABLE class='table table-sm table-striped table-hover' >
  <colgroup>
    <col style='width: 5%;'/>
    <col style='width: 5%;'/>
    <col style='width: 10%;'/>
    <col style='width: 10%;'/>
    <col style='width: 25%;'/>
    <col style='width: 15%;'/>
    <col style='width: 15%;'/>
    <col style='width: 15%;'/>
  </colgroup>
  <thead>
    <tr>
      <TH style='text-align: center ;'>#</TH>
      <TH style='text-align: center ;'>@</TH>
      <TH style='text-align: center ;'>ID</TH>
      <TH style='text-align: center ;'>이름</TH>
      <TH style='text-align: center ;'>주소</TH>
      <TH style='text-align: center ;'>이메일</TH>
      <TH style='text-align: center ;'>등록일</TH>
      <TH style='text-align: center ;'>기타</TH>
    </tr>
  </thead>
  <tbody>
  <!-- 
  <tr>
    <td>-</td>
    <td>-</td>
    <td>
      <a class="btn btn-sm btn-warning py-0 px-1" data-toggle="tooltip" data-placement="right" title="카테고리가 정해지지 않음">
        <i class="material-icons">error_outline</i>
      </a>
        &nbsp;
        (없음)
    </td>
    <td>-</td>
    <td>-</td>
  </tr>
   -->
  <c:forEach var="AdminInclVO" items="${list}" varStatus="info">
  <c:choose>
  <c:when test="${AdminInclVO.admincodeno == -8}">
  <tr class="text-danger">
      <td>${info.count }</td>
      <td><a href=""class="align-baseline btn btn-block btn-outline-danger btn-sm p-0 disabled">${AdminInclVO.privchar }</a></td>
      <td><strong><del>${AdminInclVO.id }</del></strong></td>
      <td>
      <del><a href="./bio?adminno=${AdminInclVO.adminno }" class="text-danger">${AdminInclVO.name }</a></del>
      </td>
      <td class="">-</td>
      <td>-</td>
      <td>-</td>
      <td>
        (사용 불가)
      </td>
    </tr>
  </c:when>
  <c:otherwise>
  <tr>
      <td>${info.count }</td>
      <td><a href="javascript:priv_con(${AdminInclVO.adminno })" class="align-baseline btn btn-block btn-secondary btn-sm p-0">${AdminInclVO.privchar }</a></td>
      <td><strong>${AdminInclVO.id }</strong></td>
      <td>
      <a href="./bio?adminno=${AdminInclVO.adminno }">${AdminInclVO.name }</a>
      </td>
      <td class="">${AdminInclVO.address }</td>
      <td>${AdminInclVO.email }</td>
      <td>${AdminInclVO.rdate }</td>
      <td>
        <a href="./update.do?adminno=${AdminInclVO.adminno }"role="button" class="btn btn-sm btn-info p-0" data-toggle="tooltip" data-placement="left" title="수정">
         <span>
          <i class="material-icons">edit</i>
         </span>
        </a>
        &nbsp;
        <a href="./update_passwd.do?adminno=${AdminInclVO.adminno }"role="button" class="btn btn-sm btn-warning p-0" data-toggle="tooltip" data-placement="left" title="비밀번호 변경">
         <span>
          <i class="material-icons">lock</i>
         </span>
        </a>
        &nbsp;
        <a href="javascript:del_con(${AdminInclVO.adminno })"role="button" class="btn btn-sm btn-danger p-0" data-toggle="tooltip" data-placement="left" title="탈퇴">
         <span>
          <i class="material-icons">delete</i>
         </span>
        </a>
      </td>
    </tr>
  </c:otherwise>
  </c:choose>
  
  
    
  </c:forEach>
  </tbody>
  </TABLE>
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
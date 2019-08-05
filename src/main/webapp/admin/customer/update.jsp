<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath();
%>
<!DOCTYPE html>
<html class="customer" lang="ko" style="">
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
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker3.min.css"/>
    <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/rinon/bsdatapicker/bootstrap-datepicker.ko.min.js"></script>

      <script type="text/javascript">
      var frm = $('#frm');//폼이 여러개 있을 경우
      
      $(function(){
        //window.history.replaceState("", "", "./list.do");
        //$('[data-toggle="tooltip"]').tooltip();
      });
      
      function send() {
        /* 
        var check = Cookies.get('checkID'); // 쿠키값
        
        if (check != 'TRUE') {
          var msg = "ID 중복확인이 되지 않았습니다.<br>";
          msg += "ID [중복확인] 버튼을 클릭하세요.<br>";
     
          $('#modal_title').html('ID 체크 확인');
          $('#modal_content').attr('class', 'alert alert-danger');
          $('#modal_content').html(msg);
          $('#modal_panel').modal(); // 다이얼로그 출력   
          
          return false; // submit 중지
        }
        
        if ($('#passwd').val() != $('#passwd2').val()) {
          var msg = "입력된 패스워드가 일치하지 않습니다.<br>";
          msg += "패스워드를 다시 입력해주세요.<br>";
     
          $('#modal_title').html('패스워드 일치여부 확인');
          $('#modal_content').attr('class', 'alert alert-danger');
          $('#modal_content').html(msg);
          $('#modal_panel').modal(); // 다이얼로그 출력   
          
          return false; // submit 중지
        }
         */
        
        return true; // submit 진행
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
  <nav aria-label="breadcrumb">
  <ol class="breadcrumb bg-transparent">
    <li class="breadcrumb-item"><a href="./"><i class="material-icons">home</i></a></li>
    <li class="breadcrumb-item"><a href="./list.do">관리자</a></li>
    <li class="breadcrumb-item"><a href="./bio?customerno=${customerVO.customerno }">${customerVO.name }</a></li>
    <li class="breadcrumb-item active" aria-current="page"><a href="javascript:location.reload();">정보 수정</a></li>
  </ol>
  </nav>
  <div class="container col-xs-12">
  
  <c:if test="${result == 1 }">
  <div class="alert alert-dismissible fade show  ${al_class }" role="alert">
    <strong>${name }</strong> ${msg }
    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
      <span aria-hidden="true">&times;</span>
    </button>
  </div>
  </c:if>
    <div class="alert alert-danger" role="alert">
      <h4 class="alert-heading">경고</h4>
      <p>모든 회원 정보는 관리자가 수정할 수 없고 회원 본인만이 수정할 수 있으며 이 페이지는 디버그 용도로만 사용할 수 있습니다. 
      단, 행정구역 주소 표기 변경으로 인하여 해당 주소가 없는 주소가 될 경우 총괄 관리자 및 개인정보 보호 관리자에 한하여 대표 주소 정보를 삭제할 수 있습니다.</p>
    </div>
  
   <form name="frm" id="frm" method='POST' action='./update.do' 
              onsubmit="return send();" >
    <input type="hidden" name="customerno" value="${customerVO.customerno }">
    <div class="d-flex">
    <h3 class="flex-grow-1">회원 정보 수정 (임시 페이지)</h3>
    <button type="button" onclick="location.href='./list.do'" class="btn btn-outline-secondary" role="button">취소</button>
    <button type="submit" class="btn btn-info ml-1">수정</button>
    </div>
    <br>
    <div class="card alert-primary">
    <div class="card-body">
    <h5 class="card-title">필수 정보</h5>
    
    <div class="form-group">
      <label for="name">이름*</label>
      <input type="text" class="form-control" name="name" id="name" aria-describedby="name" value="${customerVO.name }" placeholder="홍길동">
    </div>
    <div class="form-group">
      <label for="id">아이디</label>
      <input type="text" class="form-control" name="id" id="id" aria-describedby="name" value="${customerVO.id }" placeholder="gildong" disabled>
    </div>
    <div class="form-group">
      <label for="email">이메일*</label>
      <input type="email" class="form-control" name="email" id="email" aria-describedby="name" value="${customerVO.email }" placeholder="gildong@naver.com">
    </div>
    <div class="form-group">
      <label for="phone1">전화번호*</label>
      <input type="text" class="form-control" name="phone1" id="phone1" aria-describedby="name" value="${customerVO.phone1 }" placeholder="01012345678">
    </div>
    
    </div>
    </div>
    
    <div class="card alert-info mt-3">
    <div class="card-body">
    <h5 class="card-title">상세 정보</h5>
    
    <div class="form-group">
    <label for="bdate">생년월일</label>
    <div class="input-group date">
      <input type="text" name="bdate" value="${customerVO.bdate.substring(0,10) }" class="form-control"><span class="input-group-append"><i class="material-icons">calendar_today</i></span>
    </div>
    </div>
    <script type="text/javascript">
    var date = '${customerVO.bdate }';
    $('.input-group.date').datepicker({
      format: "yyyy-mm-dd",
      language: "ko",
      defaultViewDate: { year: date.substring(0,4), month: date.substring(6,7), day: date.substring(9,10) }
    });
    </script>
    
    <div class="form-group">
      <label for="zipcode">우편번호</label>
      <div class="input-group mb-3">
        <input type="text" class="form-control" id="zipcode" name="zipcode" value="${customerVO.zipcode }" placeholder="12234" aria-label="Recipient's username" aria-describedby="button-addon2">
        <div class="input-group-append">
          <button class="btn btn-secondary" onclick="DaumPostcode()" type="button" id="button-addon2">우편번호 찾기</button>
        </div>
      </div>
    </div>
    
    <div class="form-group">
      <label for="address">대표 주소</label>
      <input type="text" class="form-control" name="address" id="address1" aria-describedby="name" value="${customerVO.address }" placeholder="한양">
    </div>
    
    <div class="form-group">
      <label for="address">대표 주소(상세)</label>
      <input type="text" class="form-control" name="address2" id="address2" aria-describedby="name" value="${customerVO.address2 }" placeholder="한양">
    </div>
    
    <!-- ----- DAUM 우편번호 API 시작 ----- -->
<div id="wrap" style="display:none;border:1px solid;height:300px;margin:5px 110px;position:relative">
  <img src="//i1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>
 
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');
 
    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }
 
    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = data.address; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수
 
                // 기본 주소가 도로명 타입일때 조합한다.
                if(data.addressType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }
 
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address1').value = fullAddr;
 
                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';
 
                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
                
                $('#address2').focus();
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
 
        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<!-- ----- DAUM 우편번호 API 종료----- -->
    
    <div class="form-group">
      <label for="phone2">전화번호2</label>
      <input type="text" class="form-control" name="phone2" id="phone2" aria-describedby="name" value="${customerVO.phone2 }" placeholder="">
    </div>
    
    <div class="custom-control custom-checkbox">
      <input type="checkbox" class="custom-control-input" id="notifemail" name="notifemail" ${customerVO.notifemail == 'Y' ? 'checked="checked"':'' } value="Y">
      <label class="custom-control-label" for="notifemail">이메일로 중요 알림을 수신합니다.</label>
    </div>
    <div class="custom-control custom-checkbox">
      <input type="checkbox" class="custom-control-input" id="notifphone" id="notifphone" ${customerVO.notifphone == 'Y' ? 'checked="checked"':'' } value="Y">
      <label class="custom-control-label" for="notifphone">휴대전화(SMS)로 중요 알림을 수신합니다.</label>
    </div>
    
    </div>
    </div>
 
   </form>
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
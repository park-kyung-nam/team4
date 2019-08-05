<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%@ page import="java.util.ArrayList" %>
 
 
<!-- 화면 상단 메뉴 --> 
   
<script type="text/javascript">
$(function () {
  $(document).scroll(function () {
    var $nav = $(".rch-topnav");
    $nav.toggleClass('scrolled', $(this).scrollTop() > $nav.height());
    $('#admin_menu').toggleClass('text-primary', $(this).scrollTop() < $nav.height());
  });
  
  $('#admin_menu').on('click', function(){
    $('#sidebar-main').toggleClass('d-table-cell');
    $('#sidebar-dimmer').toggleClass('d-block');
  });
  
});
/* Get the documentElement (<html>) to display the page in fullscreen */
var elem = document.documentElement;

/* View in fullscreen */
function toggleFullScreen() {
  if (!document.fullscreenElement &&    // alternative standard method
      !document.mozFullScreenElement && !document.webkitFullscreenElement) {  // current working methods
    if (document.documentElement.requestFullscreen) {
      document.documentElement.requestFullscreen();
    } else if (document.documentElement.mozRequestFullScreen) {
      document.documentElement.mozRequestFullScreen();
    } else if (document.documentElement.webkitRequestFullscreen) {
      document.documentElement.webkitRequestFullscreen(Element.ALLOW_KEYBOARD_INPUT);
    }
      $('#btn_top_fullscreen').html('fullscreen_exit');
  } else {
    if (document.cancelFullScreen) {
      document.cancelFullScreen();
    } else if (document.mozCancelFullScreen) {
      document.mozCancelFullScreen();
    } else if (document.webkitCancelFullScreen) {
      document.webkitCancelFullScreen();
    }
    $('#btn_top_fullscreen').html('fullscreen');
  }
}
   
</script>
   
<div class="rch-topnav fixed-top d-flex mx-3 mt-3">
    <nav class="nav pt-1 mb-0 mr-auto">
      <a class="nav-link px-2" href="javascript:history.back();"><i class="material-icons">arrow_back</i></a>
      
      <!-- <a class="nav-link px-2 text-light" href="javascript:void(0);"><i class="material-icons">all_inclusive</i></a> -->
      
      <div class="dropdown">
        <a class="nav-link px-2" href="javascript:void(0);" role="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="material-icons">menu</i>
        </a>
        <div class="dropdown-menu rch-dropdown-scroll" aria-labelledby="dropdownMenu">
          <h5 class="dropdown-header">카테고리 그룹</h5>
          <a class="dropdown-item" href="#">카테고리 항목</a>
          <div class="dropdown-divider"></div>
          <p class="px-4 text-muted">Powered by Kanade-chan.</p>
          
        </div>
      </div>
      
      <a class="nav-link px-2 d-block d-md-none text-primary" id="admin_menu" role="button">
      <i class="material-icons">settings</i>
      </a>
      
      
      <span class="align-middle nav-link">PC 쇼핑몰 관리</span>
  <!-- 알림 패널 -->
  
      
    </nav>
    <nav class="nav pt-1 mb-0">
    <a class="nav-link px-2" href="javascript:toggleFullScreen();"><i class="material-icons" id="btn_top_fullscreen">fullscreen</i></a>
   <div class="dropdown">
   <a class="nav-link px-2" href="javascript:void(0);" role="button" id="dropdownMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="material-icons">notifications</i>
        </a>
        <div class="dropdown-menu rch-dropdown-scroll" aria-labelledby="dropdownMenu">
          <h5 class="dropdown-header">알림</h5>
          <div class="dropdown-divider"></div>
          <div class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">전체 알림 보기</a>
          
        </div>
   </div>
    </nav>
    
    <!-- logged -->
  <!-- 관리자 패널 -->
  <div class="nav dropdown" style="transform: rotate(0);">
    <nav class="nav pt-1 mb-0">
      <span class="pr-0 nav-link">${sessionScope.name }</span>
    </nav>
    <nav class="nav mb-0 ">
      <a href="#" class="align-baseline nav-link stretched-link" role="button" id="dropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.profileimg }" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <img alt="" src="${pageContext.request.contextPath}/kori_demo/home_demo1.png" style="width : 100%; max-width : 90vw; max-height: 400px;">
       <%--  <img alt="" src="${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.img }" style="width : 100%; max-width : 90vw; max-height: 400px;"> --%>
        <div class="dropdown-divider"></div>
        <h5 class="dropdown-header">${sessionScope.name }님, 환영합니다</h5>
        <h6 class="dropdown-header">${sessionScope.email }</h6>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/">
          <i class="material-icons">home</i> 쇼핑몰 메인 화면으로
        </a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin"><i class="material-icons">settings</i> 쇼핑몰 관리</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/admin/bio?adminno=${sessionScope.adminno }">
        <i class="material-icons">account_box</i> 내 정보
        </a>
        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="material-icons">exit_to_app</i> 로그아웃</a>
        <div class="dropdown-divider"></div>
        <p class="px-4 text-muted">Copyright © 2019 지능형 PC 쇼핑몰</p>
      </div>
    </nav>
  </div>
  
  
  
  
</div>

<div class="pt-5"></div>
<div class="pt-2"></div>

<div class="d-flex">
<!-- Main sidebar -->
<div id="sidebar-dimmer" class="sidebar-dimmer"></div>
<div id="sidebar-main" class="sidebar sidebar-default sidebar-separate sidebar-fixed flex-grow-0 flex-shrink-0">
  <div class="sidebar-content">
    <div class="sidebar-category sidebar-default">
      <div class="sidebar-user">
      
        <div class="category-content"
          style="background-image: url('${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.profileimg }');
                  background-repeat: no-repeat;
                  background-position: center center;
                  background-size: cover;">
          <h6>${sessionScope.name }</h6>
          <small>${sessionScope.email }</small>
          <br>
          <small>${sessionScope.privdesc }</small>
        </div> 
      </div>
      <div class="category-content">
        <ul id="fruits-nav3" class="nav flex-column">
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/admin/bio?adminno=${sessionScope.adminno }" class="nav-link">
              <i class="material-icons">account_box</i>
              내 정보
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/admin/bio?adminno=${sessionScope.adminno }" class="nav-link">
              <i class="material-icons">notifications</i>
              알림
            </a>
          </li>
        </ul>
      </div>
    </div>
    <div class="sidebar-category sidebar-default">
      <div class="category-content">
        <ul id="fruits-nav" class="nav flex-column">
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin" class="nav-link">
              <i class="material-icons">dashboard</i>
              대시보드
            </a>
          </li>
         </ul>
       </div>
    </div>
    <!-- /Sidebar Category -->
    <div class="sidebar-category sidebar-default">
        <div class="category-title">
          <span>회원</span>
        </div>
      <div class="category-content">
        <ul id="fruits-nav" class="nav flex-column">
          <li class="nav-item ">
            <a href="${pageContext.request.contextPath}/admin/board/list.do" class="nav-link">
              <i class="material-icons" aria-hidden="true">developer_board</i>
              직원 게시판
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/admin/list.do" class="nav-link">
              <i class="material-icons">account_box</i>
              전체 관리자 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/customer/list.do" class="nav-link">
              <i class="material-icons">account_circle</i>
              회원 정보 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="#other-logs" class="nav-link" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="other-fruits">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              로그 관리
            </a>
            <ul id="other-logs" class="flex-column collapse">
              <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/admin/adminlog/list.do" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  관리자 활동 기록
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  회원 처리 기록
                </a>
              </li>
            </ul>
            <!-- /Sub Nav -->
          </li>
          
        </ul>
        <!-- /Nav -->
      </div>
      <!-- /Category Content -->
    </div>
    <!-- /Sidebar Category -->
    <div class="sidebar-category sidebar-default">
        <div class="category-title">
          <span>상품 관리</span>
        </div>
      <div class="category-content">
        <ul id="sidebar-editable-nav" class="nav flex-column">
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/prodcategrp/list.do" class="nav-link">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              카테고리 그룹 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/prodcate/list.do" class="nav-link">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              카테고리 관리
            </a>
          </li>
          <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/admin/notice/list_by_search_paging.do?nowPage=1">공지</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/admin/event/list_by_search_paging.do?nowPage=1">이벤트</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/admin/review/list_by_search_paging.do?nowPage=1">리뷰</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/admin/used/list_by_search_paging.do?nowPage=1">중고</a>
    </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/product/list.do" class="nav-link">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              제품 관리
            </a>
          </li>
        </ul>
        <!-- /Nav -->
      </div>
      <!-- /Category Content -->
    </div>
    <!-- /Sidebar Category -->
    <div class="sidebar-category sidebar-default">
        <div class="category-title">
          <span>공지사항</span>
        </div>
      <div class="category-content">
        <ul id="sidebar-editable-nav" class="nav flex-column">
          <li class="nav-item">
            <a href="./manager.manage" class="nav-link">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              공지사항 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="./files.manage" class="nav-link">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              이벤트 관리
            </a>
          </li>
        </ul>
        <!-- /Nav -->
      </div>
      <!-- /Category Content -->
    </div>
    
    
    
    <c:if test="${(sessionScope.admincodeno == 0)}">
    <!-- /Sidebar Category -->
    <div class="sidebar-category sidebar-default">
        <div class="category-title">
          <span>총괄 권한</span>
        </div>
      <div class="category-content">
        <ul id="fruits-nav" class="nav flex-column">
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/admin/list.do" class="nav-link">
              <i class="material-icons">account_box</i>
              전체 관리자 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/customer/list.do" class="nav-link">
              <i class="material-icons">account_circle</i>
              회원 정보 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="#other-roles" class="nav-link" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="other-roles">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              권한 관리
            </a>
            <ul id="other-roles" class="flex-column collapse">
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  관리 페이지 현황
                </a>
              </li>
              <li class="nav-item ">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  관리자별 권한 범위 수정
                </a>
              </li>
              <li class="nav-item ">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  상품 등록 내역
                </a>
              </li>
            </ul>
            <!-- /Sub Nav -->
          </li>
          <li class="nav-item">
            <a href="#other-types" class="nav-link" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="other-roles">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              분류 관리
            </a>
            <ul id="other-types" class="flex-column collapse">
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  관리자 직책 및 등급표
                </a>
              </li>
              <li class="nav-item ">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  회원 등급 및 상태표
                </a>
              </li>
              <li class="nav-item ">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  관리자 활동 내역 분류표
                </a>
              </li>
              <li class="nav-item ">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  회원 활동 내역 분류표
                </a>
              </li>
            </ul>
            <!-- /Sub Nav -->
          </li>
        </ul>
        <!-- /Nav -->
      </div>
      <!-- /Category Content -->
    </div>
    </c:if>
    
  </div>
</div>
<!-- /main sidebar -->


    
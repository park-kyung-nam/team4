<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%@ page import="java.util.ArrayList" %>
 
<%
String root = request.getContextPath();
// out.println("root: " + root);
%>
 
<!-- 화면 상단 메뉴 --> 
<nav class="navbar navbar-expand sticky-top navbar-light bg-light">
  <ul class="navbar-nav">
    <li class="nav-item dropdown">
      <a class="btn btn-primary mr-3" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="material-icons">menu</i> <span class="d-none d-md-inline-flex">카테고리</span>
      </a>
      <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
        <a class="dropdown-item" href="#">추천</a>
        <a class="dropdown-item" href="#">견적</a>
        <a class="dropdown-item" href="#">커뮤니티</a>
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <a class="dropdown-item" href="#">Something else here</a>
      </div>
    </li>
  </ul>
  <a class="navbar-brand mr-auto mr-md-0" href="#">Computer</a>
  <ul class="navbar-nav d-none d-md-inline-flex">
  <!-- 
    <li class="nav-item active">
      <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
    </li>
     -->
    <li class="nav-item">
      <a class="nav-link" href="#">추천</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="#">견적</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="javascript:void(0);">커뮤니티</a>
    </li>
    <li class="nav-item">
      <a class="nav-link" href="${pageContext.request.contextPath}/prodcategrp/list.do">카테고리그룹</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/prodcate/list.do">전체 카테고리</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/notice/list_by_search_paging.do?nowPage=1">공지</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/event/list_by_search_paging.do?nowPage=1">이벤트</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/review/list_by_search_paging.do?nowPage=1">리뷰</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/used/list_by_search_paging.do?nowPage=1">중고</a>
    </li>
    <li>
      <a class="nav-link" href="${pageContext.request.contextPath}/service/list.do">서비스</a>
    </li>
  </ul>
  <form class="form-inline d-none d-md-inline-flex mx-2 flex-grow-1">
    <div class="input-group w-100">
      <div class="input-group-prepend">
        <button type="button" class="btn btn-outline-secondary"><i class="material-icons">search</i></button>
        <button type="button" class="btn btn-outline-secondary dropdown-toggle dropdown-toggle-split" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
          <span class="sr-only">Toggle Dropdown</span>
        </button>
        <div class="dropdown-menu">
          <a class="dropdown-item" href="#">Action</a>
          <a class="dropdown-item" href="#">Another action</a>
          <a class="dropdown-item" href="#">Something else here</a>
          <div role="separator" class="dropdown-divider"></div>
          <a class="dropdown-item" href="#">Separated link</a>
        </div>
      </div>
      <input type="text" class="form-control" placeholder="검색..." aria-label="Search" aria-describedby="basic-addon1">
    </div>
  </form>
 <ul class="navbar-nav">
 <c:choose>
  <c:when test="${sessionScope.usertype == 'C'}">
  <li class="nav-item dropdown">
      <a class="nav-link p-0" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="p-0"> ${sessionScope.name } </span>&nbsp;
        <img src="${pageContext.request.contextPath}/kori_demo/avatar_demo.png" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <%-- <img alt="" src="${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.img }" style="width : 100%; max-width : 90vw; max-height: 400px;"> --%>
        <div class="dropdown-divider"></div>
        <h5 class="dropdown-header">${sessionScope.name }님, 환영합니다</h5>
        <h6 class="dropdown-header">${sessionScope.email }</h6>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage/bio?customerno=${sessionScope.customerno }">
        <i class="material-icons">account_box</i> 마이페이지
        </a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 영수증</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 주문/배송 조회</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 혜택</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 장바구니</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 내 문의 내역</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/mypage"><i class="material-icons">settings</i> 고객센터</a>
        
        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="material-icons">exit_to_app</i> 로그아웃</a>
        <div class="dropdown-divider"></div>
        <p class="px-4 text-muted">Copyright © 2019 지능형 PC 쇼핑몰</p>
      </div>
  </li>
  </c:when>
  <c:when test="${sessionScope.usertype == 'A'}">
  <li class="nav-item dropdown">
      <a class="nav-link p-0" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <span class="p-0">${sessionScope.name } </span>&nbsp;
        <img src="${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.profileimg }" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <img alt="" src="${pageContext.request.contextPath}/admin/admin/bio/imgs/${sessionScope.img }" style="width : 100%; max-width : 90vw; max-height: 400px;">
        <div class="dropdown-divider"></div>
        <h5 class="dropdown-header">${sessionScope.name }님, 환영합니다</h5>
        <h6 class="dropdown-header">${sessionScope.email }</h6>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin"><i class="material-icons">settings</i> 쇼핑몰 관리</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/admin/bio?adminno=${sessionScope.adminno }">
        <i class="material-icons">account_box</i> 내 정보
        </a>
        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="material-icons">exit_to_app</i> 로그아웃</a>
        <div class="dropdown-divider"></div>
        <p class="px-4 text-muted">Copyright © 2019 지능형 PC 쇼핑몰</p>
      </div>
  </li>
  </c:when>
  <c:otherwise>
  <li class="nav-item dropdown">
      <a class="nav-link" href="#" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        LOGIN
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdownMenuLink">
      
      <form class="px-4 py-3" style="width : 400px; max-width : 90vw;"
   name="login_frm" id="login_frm"
   method='POST' action='${pageContext.request.contextPath}/nyan'>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">person</i></span>
      </div>
      <input type="text" class="form-control" name="id" id="id" placeholder="아이디 입력" >
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">lock</i></span>
      </div>
      <input type="password" class="form-control" name="passwd" id="passwd" placeholder="비밀번호 입력" >
    </div>
  
    <div class="form-group">
      <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="login_remeber" name="login_remeber">
        <label class="custom-control-label" for="login_remeber">
          자동 로그인
        </label>
      </div>
    </div>
    <button type="submit" class="btn btn-primary" >로그인</button>
    <button type="button" onclick="location.href = '${pageContext.request.contextPath}/register'" class="btn btn-secondary">가입</button>
  </form>
  <div class="dropdown-divider"></div>
  <a class="dropdown-item" href="#">아이디 및 비밀번호 찾기</a>
  <a class="dropdown-item" href="#">(테스트 링크)</a>
  <a class="dropdown-item" href="${pageContext.request.contextPath}/login_admin">협력사/관리자 로그인</a>
      
      </div>
    </li>
  </c:otherwise>
 </c:choose>
 </ul>
    
</nav>
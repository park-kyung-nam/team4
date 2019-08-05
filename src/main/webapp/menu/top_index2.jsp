<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%@ page import="java.util.ArrayList" %>
 
<%
String root = request.getContextPath();
// out.println("root: " + root);
%>
 
<!-- 화면 상단 메뉴 --> 

<nav class="navbar navbar-dark sticky-top bg-primary">
  <ul class="navbar-nav mr-auto">
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <i class="material-icons">menu</i>
      </a>
      <div class="dropdown-menu" aria-labelledby="navbarDropdown">
        <a class="dropdown-item" href="#">Action</a>
        <a class="dropdown-item" href="#">Another action</a>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="#">Something else here</a>
      </div>
    </li>
  </ul>

  <a class="navbar-brand" href="#">
    <img src="/docs/4.3/assets/brand/bootstrap-solid.svg" width="30" height="30" class="d-inline-block align-top" alt="">
    리셰쨩
  </a>
  <ul class="navbar-nav mr-auto">
    <li class="nav-item dropdown">
      <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        LOGIN
      </a>
      <div class="dropdown-menu dropdown-menu-right">
  <form class="px-4 py-3" style="width : 400px; max-width : 90vw;"
   name="login_frm" id="login_frm"
   method='POST' action='${pageContext.request.contextPath}/nyan'>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">person</i></span>
      </div>
      <input type="text" class="form-control" name="id" id="id" placeholder="아이디 입력">
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">lock</i></span>
      </div>
      <input type="password" class="form-control" name="passwd" id="passwd" placeholder="비밀번호 입력">
    </div>
  
    <div class="form-group">
      <div class="custom-control custom-checkbox">
        <input type="checkbox" class="custom-control-input" id="login_remeber" name="login_remeber">
        <label class="custom-control-label" for="login_remeber">
          자동 로그인
        </label>
      </div>
    </div>
    <button type="submit" class="btn btn-primary">로그인</button>
    <button type="button" class="btn btn-secondary">가입</button>
  </form>
  <div class="dropdown-divider"></div>
  <a class="dropdown-item" href="./login_admin">관리자 전용 로그인</a>
  <a class="dropdown-item" href="#">아이디 및 비밀번호 찾기</a>
  <a class="dropdown-item" href="#">(테스트 링크)</a>
  </div>
    </li>
  </ul>
  
  
</nav>


 <c:choose>
  <c:when test="${sessionScope.usertype == 'C'}">
  <div class="nav dropdown" style="transform: rotate(0);">
    <nav class="nav pt-1 mb-0">
      <span class="pr-0 nav-link">${sessionScope.name }</span>
    </nav>
    <nav class="nav mb-0 ">
      <a href="#" class="align-baseline nav-link stretched-link" role="button" id="dropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="${pageContext.request.contextPath}/admin/bio/imgs/${sessionScope.profileimg }" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <img alt="" src="${pageContext.request.contextPath}/admin/bio/imgs/${sessionScope.img }" style="width : 100%; max-width : 90vw; max-height: 400px;">
        <div class="dropdown-divider"></div>
        <h5 class="dropdown-header">${sessionScope.name }님, 환영합니다</h5>
        <h6 class="dropdown-header">${sessionScope.email }</h6>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin"><i class="material-icons">settings</i> 쇼핑몰 관리</a>
        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/bio?adminno=${sessionScope.adminno }">
        <i class="material-icons">account_box</i> 내 정보
        </a>
        <a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/logout"><i class="material-icons">exit_to_app</i> 로그아웃</a>
        <div class="dropdown-divider"></div>
        <p class="px-4 text-muted">Copyright © 2019 지능형 PC 쇼핑몰</p>
      </div>
    </nav>
  </div>
  </c:when>
  <c:when test="${sessionScope.usertype == 'A'}">
  <div class="nav dropdown" style="transform: rotate(0);">
    <nav class="nav pt-1 mb-0">
      <span class="pr-0 nav-link">${sessionScope.name }</span>
    </nav>
    <nav class="nav mb-0 ">
      <a href="#" class="align-baseline nav-link stretched-link" role="button" id="dropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="${pageContext.request.contextPath}/admin/bio/imgs/${sessionScope.profileimg }" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <img alt="" src="${pageContext.request.contextPath}/admin/bio/imgs/${sessionScope.img }" style="width : 100%; max-width : 90vw; max-height: 400px;">
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
    </nav>
  </div>
  </c:when>
  <c:otherwise>
  
  </c:otherwise>
</c:choose>
  
  
  
  
    
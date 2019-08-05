<%@ page contentType="text/html; charset=UTF-8" %>
 
<%@ page import="java.util.ArrayList" %>
<%@ page import="nation.web.tool.Tool" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%
String root = request.getContextPath();
// out.println("root: " + root);
%>
 
<!-- 화면 상단 메뉴 --> 

<c:choose>
  <c:when test="${sessionScope.id == null}">
  
  </c:when>
  <c:otherwise>
  
  </c:otherwise>
</c:choose>
   
   
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
      
      
      <span class="align-middle nav-link">리셰쨩</span>
      
    </nav>
    
    
<c:choose>
  <c:when test="${sessionScope.userid == null}">
  <div class="nav dropdown" style="transform: rotate(0);">
    <nav class="nav pt-1 mb-0 px-2">
      <span class="pr-0 nav-link stretched-link" role="button" id="dropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">LOGIN</span>
    
      <div class="dropdown-menu dropdown-menu-right">
  <form class="px-4 py-3" style="width : 400px; max-width : 90vw;"
   name="login_frm" id="login_frm"
   method='POST' action='${pageContext.request.contextPath}/nyan'>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">person</i></span>
      </div>
      <input type="text" class="form-control" id="userid" placeholder="아이디 입력">
    </div>
    <div class="input-group mb-3">
      <div class="input-group-prepend">
        <span class="input-group-text" id="basic-addon1"><i class="material-icons">lock</i></span>
      </div>
      <input type="password" class="form-control" id="passwd" placeholder="비밀번호 입력">
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
  <a class="dropdown-item" href="#">아이디 및 비밀번호 찾기</a>
  <a class="dropdown-item" href="#">(테스트 링크)</a>
</div>
    </nav>
  </div>
  </c:when>
  <c:otherwise>
  <div class="nav dropdown" style="transform: rotate(0);">
    <nav class="nav pt-1 mb-0">
      <span class="pr-0 nav-link">${sessionScope.username }</span>
    </nav>
    <nav class="nav mb-0 ">
      <a href="#" class="align-baseline nav-link stretched-link" role="button" id="dropdownProfile" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
        <img src="./chino.gif" class="avatar">
      </a>
      <div class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownProfile" style="width : 400px; max-width : 90vw;">
        <img alt="" src="<%=root %>/manage/images/login_admin_t.png" style="width : 100%; max-width : 90vw;">
        <div class="dropdown-divider"></div>
        <h5 class="dropdown-header">${sessionScope.username }님, 환영합니다</h5>
        <h6 class="dropdown-header">${sessionScope.email }</h6>
        <div class="dropdown-divider"></div>
        <a class="dropdown-item" href="richer/manage"><i class="material-icons">settings</i> 블로그 관리</a>
        <a class="dropdown-item" href="richer/manage"><i class="material-icons">settings</i> 새 글 작성</a>
        <a class="dropdown-item" href="richer/manage"><i class="material-icons">settings</i> 마이페이지</a>
        <a class="dropdown-item text-danger" href="logout"><i class="material-icons">exit_to_app</i> 로그아웃</a>
      </div>
    </nav>
  </div>
  </c:otherwise>
</c:choose>
    <!-- login -->
    <!-- 
  
     -->
    <!-- logged -->
    
  
  
  
  
  
</div>
    
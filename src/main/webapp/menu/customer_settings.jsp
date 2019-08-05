<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 
<%@ page import="java.util.ArrayList" %>
 
 
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
          <span>내 정보</span>
        </div>
      <div class="category-content">
        <ul id="fruits-nav" class="nav flex-column">
          <li class="nav-item ">
            <a href="${pageContext.request.contextPath}/admin/board/list.do" class="nav-link">
              <i class="material-icons" aria-hidden="true">developer_board</i>
              주문/배송 조회
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/admin/list.do" class="nav-link">
              <i class="material-icons">account_box</i>
              내 정보 관리
            </a>
          </li>
          <li class="nav-item">
            <a href="${pageContext.request.contextPath}/admin/customer/list.do" class="nav-link">
              <i class="material-icons">account_circle</i>
              비밀번호 변경
            </a>
          </li>
          <li class="nav-item">
            <a href="#other-logs" class="nav-link" data-toggle="collapse" role="button" aria-expanded="false" aria-controls="other-fruits">
              <i class="fa fa-pencil" aria-hidden="true"></i>
              기타
            </a>
            <ul id="other-logs" class="flex-column collapse">
              <li class="nav-item ">
                <a href="${pageContext.request.contextPath}/admin/adminlog/list.do" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  배송지 관리
                </a>
              </li>
              <li class="nav-item">
                <a href="#" class="nav-link">
                  <i class="fa fa-pencil" aria-hidden="true"></i>
                  회원 탈퇴
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
          <li class="nav-item">
            <a href="/admin/usersprofiles" class="nav-link">
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


    
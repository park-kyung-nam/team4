<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<style type="text/css">
/* fieldset 전체 적용 */
.categrp_cate_left{
  width: 100%;
  margin: 0px auto; 
  border-left: none; 
  border-right: none;
  border-top: solid 1px #DDDDDD;  
  border-bottom: solid 1px #DDDDDD;  
  text-align: left;
}

/* <UL> 태그에 적용 */
.categrp_cate_list_left{
  padding-left: 10%; 
  line-height: 20px;
}

/* 카테고리 그룹 이름에 적용, Spring에서 사용 */
.categrp_name{
  margin-left: 5%;
  font-weight: bold;
  list-style-image: url("${pageContext.request.contextPath}/notice/images/categrp.png");
}

/* 카테고리에 적용, Spring에서 사용 */
.cate_title{
  margin-left: 5%;
  list-style-image: url("${pageContext.request.contextPath}/notice/images/cate.png");
}
</style>

<fieldset class='notice_left' >
  <DIV>
    ▷
    <A href="${pageContext.request.contextPath}/notice/list.do">공지사항</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <DIV>
    ▷
    <A href="${pageContext.request.contextPath}/ event/list.do">이벤트</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <DIV>
    ▷
    <A href="${pageContext.request.contextPath}/review/list.do">리뷰</A>
    <span style='font-size:0.9em; color: #555555;'>(${total_count })</span>
  </DIV>
  <UL class='notice_left' >
    <c:forEach var="n_title" items="${name_n_title_list}">
      ${n_title}
    </c:forEach>
  </UL>
</fieldset>
<br>
   
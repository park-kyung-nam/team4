<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath();
%>
        
<script type="text/javascript">
var code = '${sessionScope.admincodeno}';
function customerstats_con(customerno){
 if(code == 0 | code == 5){
  var params = 'customerno='+customerno;
      
  $.ajax({
        url:"./customer.scan",
        type:'get', //form type
        cache:false,
        async:true, // 비동기
        dataType:'json', //응답 형식 : html, json, xml...
        data:params,
        success:function(rdata){
          if(1==1){
          $('#customerno_priv').val(customerno);
          $('#name_priv').val(rdata.name);
          $('#priv_name').html(rdata.name);
          $('#customerstatscodeno_'+rdata.customerstatscodeno).prop('checked', true);
          $('#priv_modal').modal('show');
          }
        },
        // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
        error: function(request, status, error) { // callback 함수
          //
        }
      })
   }
}
      
</script>

<!-- priv modal -->
<form id="frm_priv" method='POST' action='./update_priv.do' onsubmit="return priv();">
<input type="hidden" id="customerno_priv" name="customerno" value="">
<input type="hidden" id="name_priv" name="name" value="">
<div class="modal" id="priv_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-info">
        <h5 class="modal-title" id="unreg_modal_title"><strong id="priv_name"></strong> 회원 상태</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-info">
      <c:forEach var="codes" items="${codes}" varStatus="codesinfo">
      
      <div class="custom-control custom-radio">
        <input type="radio" id="customerstatscodeno_${codes.customerstatscodeno }" name="customerstatscodeno" 
          value="${codes.customerstatscodeno }" class="custom-control-input" disabled="disabled">
        <label class="custom-control-label" for="customerstatscodeno_${codes.customerstatscodeno }">
          <strong>${codes.customerstatschar }</strong> - ${codes.customerstatsdesc }
        </label>
      </div>
      
      </c:forEach>
      
      </div>
      <div class="modal-footer bg-info">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        <!-- <button type="submit" class="btn btn-outline-light">권한 변경</button> -->
      </div>
    </div>
  </div>
</div>
</form>

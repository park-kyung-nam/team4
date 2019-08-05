<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("utf-8"); 
String root = request.getContextPath();
%>
        

<script type="text/javascript">
var code = '${sessionScope.admincodeno}';
console.log(code)
function priv_con(adminno){
 if(code == 0){
  var params = 'adminno='+adminno;
      
  $.ajax({
        url:"./admin.scan",
        type:'get', //form type
        cache:false,
        async:true, // 비동기
        dataType:'json', //응답 형식 : html, json, xml...
        data:params,
        success:function(rdata){
          console.log(rdata.admincodeno)
          if(rdata.admincodeno > 0){
          $('#adminno_priv').val(adminno);
          $('#btn_priv_submit').html('권한 변경');
          $('#name_priv').val(rdata.name);
          $('#priv_name').html(rdata.name);
          $('#admincodeno_'+rdata.admincodeno).prop('checked', true);
          $('#priv_modal').modal('show');
          }else if(rdata.admincodeno == -2){
            $('#adminno_priv').val(adminno);
            $('#btn_priv_submit').html('승인');
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
   }else{
     console.log('총괄 관리자가 아닙니다.')
   }
}
      
</script>

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
        <button type="submit" id="btn_priv_submit" class="btn btn-outline-light">권한 변경</button>
      </div>
    </div>
  </div>
</div>
</form>

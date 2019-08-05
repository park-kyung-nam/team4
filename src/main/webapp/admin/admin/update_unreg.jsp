<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        
      <script type="text/javascript">
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
      
      </script>

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
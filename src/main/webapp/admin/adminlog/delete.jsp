<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        
      <script type="text/javascript">
      var code = '${sessionScope.admincodeno}';
      function del_con(logno){

        if(1 == 1){
        var params = 'logno='+logno;
        $.ajax({
          url:"./log.scan",
          type:'get', //form type
          cache:false,
          async:true, // 비동기
          dataType:'json', //응답 형식 : html, json, xml...
          data:params,
          success:function(rdata){
            $('#logno_del').val(logno);
            $('#del_desc').html(rdata.logdesc);
            $('#del_modal').modal('show');
          },
          // Ajax 통신 에러, 응답 코드가 200이 아닌경우, dataType이 다른경우 
          error: function(request, status, error) { // callback 함수
            //
          }
        })
       }
        
      }
      
      </script>

<!-- Modal -->
<form id="frm_del" method='POST' action='./delete.do' onsubmit="return del();">
<input type="hidden" id="logno_del" name="logno" value="">
<div class="modal" id="del_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-danger">
        <h5 class="modal-title" id="del_modal_title">로그 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-danger">
        
        정말로 해당 로그를 삭제하시겠습니까?<br>
        로그의 내용은 아래와 같습니다.<br>
        <p id="del_desc"></p>
      </div>
      <div class="modal-footer bg-danger">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-outline-light">삭제</button>
      </div>
    </div>
  </div>
</div>
</form>
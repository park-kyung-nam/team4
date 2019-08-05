<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        
      <script type="text/javascript">
      var code = '${sessionScope.admincodeno}';
      function rem_con(adminno){

        if(code == 0 | code == 5){
        var params = 'adminno='+adminno;
        $.ajax({
          url:"./admin.scan",
          type:'get', //form type
          cache:false,
          async:true, // 비동기
          dataType:'json', //응답 형식 : html, json, xml...
          data:params,
          success:function(rdata){
            $('#adminno_rem').val(adminno);
            $('.rel_name_area').html(rdata.name + '(@' + rdata.id + ')');
            $('#rem_name').html(rdata.name);
            $('#rem_modal').modal('show');
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
<form id="frm_rem" method='POST' action='./delete.do' onsubmit="return del();">
<input type="hidden" id="adminno_rem" name="adminno" value="">
<input type="hidden" id="name" name="name" value="${search_name }">
<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
<div class="modal" id="rem_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-dark">
        <h5 class="modal-title" id="rem_modal_title">관리자 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-dark">
        <p class="text-danger"> 관리자 정보 삭제 이후 모든 이벤트 및 공지사항은 총괄 관리자가 관리할 수 있습니다.</p>
        <a href="#" class="btn btn-warning btn-block btn-sm"> <span class="rel_name_area"></span> 관리자가 작성한 모든 공지사항 보기</a>
        <br>
        <a href="#" class="btn btn-warning btn-block btn-sm"> <span class="rel_name_area"></span> 관리자가 작성한 모든 이벤트 보기</a>
        <br>
        <hr>
        <p>정말로 [<strong id="rem_name"></strong>] 관리자 정보를 삭제하시겠습니까?</p>
        <p><strong class="text-danger">해당 작업은 되돌릴 수 없습니다.</strong></p>
      </div>
      <div class="modal-footer bg-dark">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
        <button type="submit" class="btn btn-outline-light">삭제</button>
      </div>
    </div>
  </div>
</div>
</form>
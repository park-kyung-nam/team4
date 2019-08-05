<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        
      <script type="text/javascript">
      var code = '${sessionScope.admincodeno}';
      function rem_con(customerno){

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
            $('#customerno_rem').val(customerno);
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
<input type="hidden" id="customerno_rem" name="customerno" value="">
<input type="hidden" id="name" name="name" value="${search_name }">
<input type="hidden" id="nowPage" name="nowPage" value="${nowPage }">
<div class="modal" id="rem_modal" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header alert-dark">
        <h5 class="modal-title" id="rem_modal_title">회원 삭제</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body alert-dark">
        <p class="text-danger"> 주문 정보가 존재하므로 삭제할 수 없습니다.</p>
        <a href="#" class="btn btn-danger btn-block btn-sm"> <span class="rel_name_area"></span> 회원의 주문 정보 보기</a>
        <br>
        <p class="text-danger"> 회원 정보 삭제 시 더 이상 해당 회원의 상품 후기를 삭제할 수 없습니다.</p>
        <a href="#" class="btn btn-warning btn-block btn-sm"> <span class="rel_name_area"></span> 회원의 모든 후기 보기</a>
        <br>
        <p class="text-danger"> 해당 회원의 모든 고객센터 작성 내용이 삭제됩니다.</p>
        <a href="#" class="btn btn-warning btn-block btn-sm"> <span class="rel_name_area"></span> 회원의 모든 고객센터 내용 보기</a>
        <br>
        <hr>
        <p>정말로 [<strong id="rem_name"></strong>] 회원 정보를 삭제하시겠습니까?</p>
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
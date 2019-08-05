package dev.mvc.adminlog;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.admin.AdminDAOInter;
import dev.mvc.admin.AdmincodeDAOInter;
import dev.mvc.customer.Customer;
import dev.mvc.customer.CustomerInclVO;

@Component("dev.mvc.adminlog.AdminlogProc")
public class AdminlogProc implements AdminlogProcInter {
  /*
  @Autowired
  private AdminDAOInter adminDAO;
  */
  @Autowired
  private AdminlogDAOInter adminlogDAO;
  @Autowired
  private AdminlogtypeDAOInter adminlogtypeDAO;

  @Override
  public ArrayList<AdminlogtypeVO> view_codes_list(){
    return this.adminlogtypeDAO.view_codes_list();
  }

  @Override
  public int record_log(AdminlogVO adminlogVO){
    return this.adminlogDAO.record_log(adminlogVO);
  }
  
  @Override
  public int record_log(HttpServletRequest request,int logtype, int adminno, String logdesc){
    AdminlogVO adminlogVO = new AdminlogVO();
    adminlogVO.setAdminno(adminno);
    adminlogVO.setIpv4(request.getRemoteAddr());
    adminlogVO.setLogdesc(logdesc);
    adminlogVO.setLogtype(logtype);
    return this.adminlogDAO.record_log(adminlogVO);
  }

  @Override
  public ArrayList<AdminlogVO> log_list(){
    return this.adminlogDAO.log_list();
  }

  @Override
  public AdminlogVO log_check(int logno) {
    return this.adminlogDAO.log_check(logno);
  }

  @Override
  public int log_update(AdminlogVO adminlogVO){
    return this.adminlogDAO.log_update(adminlogVO);
  }

  @Override
  public int log_update_for_delete_admin(int adminno){
    return this.adminlogDAO.log_update_for_delete_admin(adminno);
  }
  
  @Override
  public int log_delete(int logno) {
    return this.adminlogDAO.log_delete(logno);
  }

  @Override
  public ArrayList<AdminlogInclVO> log_list_full(HashMap<String, Object> map) {

    /*
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * ADMINLOG.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + ADMINLOG.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<AdminlogInclVO> list = adminlogDAO.log_list_full(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      AdminlogInclVO adminlogVO = list.get(i);
    }
    return list;
  }

  @Override
  public int search_count(HashMap<String, Object> map) {
    int count = adminlogDAO.search_count(map);
    return count;
  }
  

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param cateno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param name 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(int search_count, int nowPage, String logdesc, int logtype){ 
    int totalPage = (int)(Math.ceil((double)search_count/ADMINLOG.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/ADMINLOG.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/ADMINLOG.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = (nowPage - ADMINLOG.PAGE_PER_BLOCK); // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowPage + ADMINLOG.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<ul class='pagination my-0'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
    
    if(startPage < 1){
      startPage = 1;
    }
    if(endPage > totalPage){
      endPage = totalPage;
    }
 
    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowPage-1);  
    if (nowPage >= 2){ 
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&logdesc="+logdesc+"&nowPage="+_nowPage+"&logtype="+logtype+"'><span aria-hidden='true'>&laquo;</span> 이전</A></li>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<li class='page-item active'><A class='page-link' href=''>"+i+"</a></li>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<li class='page-item'><A class='page-link' href='./list.do?logdesc="+logdesc+"&nowPage="+i+"&logtype="+logtype+"'>"+i+"</A></li>");   
      } 
    } 
 
    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowPage+1);  
    if (nowPage < totalPage){ 
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&logdesc="+logdesc+"&nowPage="+_nowPage+"&logtype="+logtype+"'>다음 <span aria-hidden='true'>&raquo;</span></A></li>"); 
    } 
    str.append("</ul>"); 
     
    return str.toString(); 
  }

}

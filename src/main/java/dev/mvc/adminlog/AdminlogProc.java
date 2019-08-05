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
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * ADMINLOG.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + ADMINLOG.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
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
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param name �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(int search_count, int nowPage, String logdesc, int logtype){ 
    int totalPage = (int)(Math.ceil((double)search_count/ADMINLOG.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/ADMINLOG.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/ADMINLOG.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = (nowPage - ADMINLOG.PAGE_PER_BLOCK); // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowPage + ADMINLOG.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<ul class='pagination my-0'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 
    
    if(startPage < 1){
      startPage = 1;
    }
    if(endPage > totalPage){
      endPage = totalPage;
    }
 
    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowPage-1);  
    if (nowPage >= 2){ 
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&logdesc="+logdesc+"&nowPage="+_nowPage+"&logtype="+logtype+"'><span aria-hidden='true'>&laquo;</span> ����</A></li>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<li class='page-item active'><A class='page-link' href=''>"+i+"</a></li>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<li class='page-item'><A class='page-link' href='./list.do?logdesc="+logdesc+"&nowPage="+i+"&logtype="+logtype+"'>"+i+"</A></li>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowPage+1);  
    if (nowPage < totalPage){ 
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&logdesc="+logdesc+"&nowPage="+_nowPage+"&logtype="+logtype+"'>���� <span aria-hidden='true'>&raquo;</span></A></li>"); 
    } 
    str.append("</ul>"); 
     
    return str.toString(); 
  }

}

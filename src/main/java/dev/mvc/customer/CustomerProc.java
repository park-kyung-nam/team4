package dev.mvc.customer;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;




@Component("dev.mvc.customer.CustomerProc")
public class CustomerProc implements CustomerProcInter {
  @Autowired
  private CustomerDAOInter customerDAO;
  @Autowired
  private CustomercodeDAOInter customercodeDAO;

  @Override
  public ArrayList<CustomerInclVO> list_customer_withcodes() {
    return this.customerDAO.list_customer_withcodes();
  }
  

  @Override
  public int search_count(HashMap map) {
    int count = customerDAO.search_count(map);
    return count;
  }

  @Override
  public ArrayList<CustomerInclVO> list_customer_withcodes_search_paging(HashMap<String, Object> map) {
    /*
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Customer.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Customer.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<CustomerInclVO> list = customerDAO.list_customer_withcodes_search_paging(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      CustomerInclVO customerVO = list.get(i);
    }
    
    return list;
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
  public String pagingBox(int search_count, int nowPage, String name){ 
    int totalPage = (int)(Math.ceil((double)search_count/Customer.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Customer.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Customer.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = (nowPage - Customer.PAGE_PER_BLOCK); // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowPage + Customer.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&name="+name+"&nowPage="+_nowPage+"'><span aria-hidden='true'>&laquo;</span> ����</A></li>"); 
    } 
 
    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<li class='page-item active'><A class='page-link' href=''>"+i+"</a></li>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<li class='page-item'><A class='page-link' href='./list.do?name="+name+"&nowPage="+i+"'>"+i+"</A></li>");   
      } 
    } 
 
    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowPage+1);  
    if (nowPage < totalPage){ 
      str.append("<li class='page-item'><A class='page-link' href='./list.do?&name="+name+"&nowPage="+_nowPage+"'>���� <span aria-hidden='true'>&raquo;</span></A></li>"); 
    } 
    str.append("</ul>"); 
     
    return str.toString(); 
  }
  
  
  
  @Override
  public int check_id(String id) {
    return this.customerDAO.check_id(id);
  }

  @Override
  public int check_email(String email) {
    return this.customerDAO.check_email(email);
  }

  @Override
  public int check_login(String id, String passwd) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
    return this.customerDAO.check_login(map);
  }

  @Override
  public int register_customer(CustomerVO customerVO) {
    return this.customerDAO.register_customer(customerVO);
  }

  @Override
  public ArrayList<CustomercodeVO> view_codes_list() {
    return this.customercodeDAO.view_codes_list();
  }

  @Override
  public CustomerInclVO select_customer_withcodes(int customerno) {
    return this.customerDAO.select_customer_withcodes(customerno);
  }
  
  @Override
  public CustomerInclVO select_customer_withcodes_id(String id) {
    return this.customerDAO.select_customer_withcodes_id(id);
  }

  @Override
  public CustomerVO select_customer(int customerno) {
    return this.customerDAO.select_customer(customerno);
  }

  @Override
  public int update_customer_priv(int customerno, int customerstatscodeno) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("customerno", customerno);
    map.put("customerstatscodeno", customerstatscodeno);
    return this.customerDAO.update_customer_priv(map);
  }
  
  public void create_random_demo(int count){
    for (int i = 1; i<=count; i++){
      CustomerVO customerVO = new CustomerVO();
      String name = "";
      String passwd="";
      String id="";
      String email="";
      String tel="010";
      name = Tool.randomHangulName();
      for (int s = 1; s <= 8; s++) {
        passwd = passwd + (char) ((Math.random() * 26) + 97);
        id = id + (char) ((Math.random() * 26) + 97);
        email = email + (char) ((Math.random() * 26) + 97);
        tel = tel + (int)(Math.random() * 10);
      }
      email = email+"@demo.io";
      customerVO.setName(name);
      customerVO.setPasswd(passwd);
      customerVO.setId(id);
      customerVO.setEmail(email);
      customerVO.setPhone1(tel);
      this.customerDAO.register_customer(customerVO);
    }
  }


  @Override
  public int delete_customer(int customerno) {
    return this.customerDAO.delete_customer(customerno);
  }


  @Override
  public int update_customer_profile(CustomerVO customerVO) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("customerno", customerVO.getCustomerno());
    map.put("customerstatscodeno", -2);
    this.customerDAO.update_customer_priv(map);
    return this.customerDAO.update_customer_profile(customerVO);
  }

}

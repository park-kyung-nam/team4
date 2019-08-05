package dev.mvc.customer;

import java.util.ArrayList;
import java.util.HashMap;


public interface CustomerProcInter {
  
  /**
   * ���̵� �ߺ� Ȯ��
   * @param id
   * @return �ߺ� ����(1 = �ߺ�, 0 = ���� ����)
   */
  public int check_id(String id);
  
  /**
   * �̸��� �ߺ� Ȯ��
   * @param email
   * @return �ߺ� ����(1 = �ߺ�, 0 = ���� ����)
   */
  public int check_email(String email);

  /**
   * �α��� ���� Ȯ��
   * @param ���̵�,��й�ȣ
   * @return ���� ����(1 = ����, 0 = ����)
   */
  public int check_login(String id, String passwd);
  /**
   * �α��ο� ȸ�� ����
   * @return ȸ�� ����
   */
  public CustomerInclVO select_customer_withcodes_id(String id);
  
  /**
   * �������� ��¿� ȸ�� ����Ʈ(��й�ȣ ����)
   * @return ȸ�� ����Ʈ
   */
  public ArrayList<CustomerInclVO> list_customer_withcodes();
  
  /**
   * �������� ��¿� �˻� + ����¡ ȸ�� ����Ʈ(��й�ȣ ����)
   * @return ȸ�� ����Ʈ
   */
  public ArrayList<CustomerInclVO> list_customer_withcodes_search_paging(HashMap<String, Object> map);
  

  /**
   * ȸ�� ������ ȸ�� ����(��й�ȣ ���� / ����� �뵵�θ� ���)
   * @return ȸ�� ����
   */
  public CustomerVO select_customer(int customerno);
  
  /**
   * �������� ��¿� ȸ�� ����(��й�ȣ ����)
   * @return ȸ�� ����
   */
  public CustomerInclVO select_customer_withcodes(int customerno);
  
  /**
   * ȸ�� ���� ����
   * @param customerVO
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int register_customer (CustomerVO customerVO);
  
  /**
   * ȸ�� ���� �ڵ带 ���ϴ�.
   * @return
   */
  public ArrayList<CustomercodeVO> view_codes_list();

  
  /**
   * ȸ�� ���� ����
   * @param customerVO
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int update_customer_profile (CustomerVO customerVO);
  
  /**
   * ȸ�� ���� ����
   * @param customerVO
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int update_customer_priv (int customerno, int customercodeno);

  public void create_random_demo(int i);

  public String pagingBox(int search_count, int nowPage, String word);

  public int search_count(HashMap<String, Object> map);

  /**
   * ȸ�� ���� ����(����� �뵵�θ� ���)
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int delete_customer(int customerno);
}

package dev.mvc.customer;

import java.util.ArrayList;
import java.util.HashMap;

public interface CustomerDAOInter {
  
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
   * @param map(���̵�, ��й�ȣ�� ������)
   * @return ���� ����(1 = ����, 0 = ����)
   */
  public int check_login(HashMap<String, Object> map);
  
  /**
   * �������� ��¿� ȸ�� ����Ʈ(��й�ȣ ����)
   * @return ȸ�� ����Ʈ
   */
  public ArrayList<CustomerInclVO> list_customer_withcodes();
  

  public int search_count(HashMap<String, Object> map);
  
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
   * �α��ο� ȸ�� ����
   * @return ȸ�� ����
   */
  public CustomerInclVO select_customer_withcodes_id(String id);
  
  /**
   * ȸ�� ���� ����
   * @param customerVO
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int register_customer (CustomerVO customerVO);
  
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
  public int update_customer_priv (HashMap<String, Object> map);
  
  /**
   * ȸ�� ���� ����(����� �뵵�θ� ���)
   * @return ó�� ����(1 = ����, �̿��� �� = ����)
   */
  public int delete_customer(int customerno);

}

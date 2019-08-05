package dev.mvc.admin;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminDAOInter {
  /**
   * ������ �ڵ带 ������ ������ ����Ʈ�� ����մϴ�.
   * @return ������ ����Ʈ ���
   */
  public ArrayList<AdminInclVO> list_admin_withcodes();
  
  /**
   * ������ ����Ʈ�� ����մϴ�.
   * @return ������ ����Ʈ ���
   */
  public ArrayList<AdminVO> list_admin();
  
  /**
   * ���ο� �����ڸ� ����մϴ�.
   * @param adminVO
   * @return ó�� ����
   */
  public int register_admin(AdminVO adminVO);
  
  /**
   * �ϳ��� ������ ������ �ҷ��ɴϴ�.
   * @param adminno
   * @return ������ ����
   */
  public AdminVO select_admin(int adminno);
  
  /**
   * �ϳ��� ������ ������ �ҷ��ɴϴ�.
   * @param adminno
   * @return ������ ����
   */
  public AdminInclVO select_admin_id(String id);
  
  /**
   * �ϳ��� ������ ������ �ҷ��ɴϴ�.
   * @param adminno
   * @return ������ ����
   */
  public AdminInclVO select_admin_withcodes(int adminno);
  
  /**
   * ������ �⺻ ������ �����մϴ�.
   * @param adminVO
   * @return ó�� ����
   */
  public int update_admin_profile(AdminVO adminVO);
  
  /**
   * ������ ������ �����մϴ�.
   * @param map
   * @return ó�� ����
   */
  public int update_admin_priv(HashMap<String, Object> map);
  
  /**
   * ��й�ȣ�� �˻��մϴ�.
   * @param map
   * @return ��ġ ����
   */
  public int check_passwd(HashMap<String, Object> map);
  
  /**
   * ��й�ȣ�� �����մϴ�.
   * @param map
   * @return ó�� ����
   */
  public int update_passwd(HashMap<String, Object> map);
  
  /**
   * �ϳ��� ������ ������ �����մϴ�.
   * @param adminno
   * @return ó�� ����
   */
  public int delete_admin(int adminno);
  
  /**
   * ��й�ȣ�� �����մϴ�.
   * @param map
   * @return ó�� ����
   */
  public int login_admin(HashMap<String, Object> map);

}

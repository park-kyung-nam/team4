package dev.mvc.admin;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminProcInter {

  /**
   * ������ �ڵ带 ������ ������ ����Ʈ�� ����մϴ�.
   * @return ������ ����Ʈ ���
   */
  public ArrayList<AdminInclVO> list_admin_withcodes();
  
  /**
   * ���ο� �����ڸ� ����մϴ�.
   * @param adminVO
   * @return ó�� ����
   */
  public int register_admin(AdminVO adminVO);
  
  /**
   * ������ �α����� ó���մϴ�.
   * @param adminno
   * @return �α��� ���
   */
  public int login_admin(String id, String passwd);
  
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
   * @param adminVO
   * @return ó�� ����
   */
  public int update_admin_priv(int adminno, int admincodeno);
  
  /**
   * ��й�ȣ�� �˻��մϴ�.
   * @param map
   * @return ��ġ ����
   */
  public int check_passwd(int adminno, String passwd);
  
  /**
   * ��й�ȣ�� �����մϴ�.
   * @param map
   * @return ó�� ����
   */
  public int update_passwd(int adminno, String passwd);
  
  /**
   * ������ �ڵ带 ���ϴ�.
   * @return
   */
  public ArrayList<AdmincodeVO> view_codes_list();
  
  /**
   * �ϳ��� ������ ������ �����մϴ�.
   * @param adminno
   * @return ó�� ����
   */
  public int delete_admin(int adminno);

}

package dev.mvc.admin;

import java.util.ArrayList;

public interface AdmincodeDAOInter {
  
  public ArrayList<AdmincodeVO> view_codes_list();
  
  /**
   * ������ �߰� �� ���
   * @param adminVO
   * @return
   */
  public int register_admin(AdminVO adminVO);

  /**
   * ������ ����Ʈ
   * @return
   */
  public ArrayList<AdminVO> list_admin();

  /**
   * ������ ����Ʈ(������ ���� ���� �߰�)
   * @param adminVO
   * @return
   */
  public ArrayList<AdminVO> list_admin_withcodes(AdminVO adminVO);

  /**
   * ������ ����
   * @param adminno
   * @return
   */
  public AdminVO select_admin(int adminno);

  /**
   * ������ ����(������ ���� ���� �߰�)
   * @param adminVO
   * @return
   */
  public AdminVO select_admin_withcodes(AdminVO adminVO);

  /**
   * ������ ���� ����
   * @param adminVO
   * @return
   */
  public int update_admin_profile(AdminVO adminVO);

  /**
   * ������ ���� �� ���� ����
   * @param adminVO
   * @return
   */
  public int update_admin_priv(AdminVO adminVO);

  /**
   * ������ ����(�������� ����)
   * @param adminno
   * @return
   */
  public int delete_admin(int adminno);

}

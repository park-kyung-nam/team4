package dev.mvc.admin;

import java.util.ArrayList;

public interface AdmincodeDAOInter {
  
  public ArrayList<AdmincodeVO> view_codes_list();
  
  /**
   * 관리자 추가 및 등록
   * @param adminVO
   * @return
   */
  public int register_admin(AdminVO adminVO);

  /**
   * 관리자 리스트
   * @return
   */
  public ArrayList<AdminVO> list_admin();

  /**
   * 관리자 리스트(관리자 상태 정보 추가)
   * @param adminVO
   * @return
   */
  public ArrayList<AdminVO> list_admin_withcodes(AdminVO adminVO);

  /**
   * 관리자 선택
   * @param adminno
   * @return
   */
  public AdminVO select_admin(int adminno);

  /**
   * 관리자 선택(관리자 상태 정보 추가)
   * @param adminVO
   * @return
   */
  public AdminVO select_admin_withcodes(AdminVO adminVO);

  /**
   * 관리자 정보 수정
   * @param adminVO
   * @return
   */
  public int update_admin_profile(AdminVO adminVO);

  /**
   * 관리자 권한 및 상태 수정
   * @param adminVO
   * @return
   */
  public int update_admin_priv(AdminVO adminVO);

  /**
   * 관리자 삭제(권장하지 않음)
   * @param adminno
   * @return
   */
  public int delete_admin(int adminno);

}

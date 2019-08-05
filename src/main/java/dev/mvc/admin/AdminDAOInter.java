package dev.mvc.admin;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminDAOInter {
  /**
   * 관리자 코드를 포함한 관리자 리스트를 출력합니다.
   * @return 관리자 리스트 목록
   */
  public ArrayList<AdminInclVO> list_admin_withcodes();
  
  /**
   * 관리자 리스트를 출력합니다.
   * @return 관리자 리스트 목록
   */
  public ArrayList<AdminVO> list_admin();
  
  /**
   * 새로운 관리자를 등록합니다.
   * @param adminVO
   * @return 처리 여부
   */
  public int register_admin(AdminVO adminVO);
  
  /**
   * 하나의 관리자 정보를 불러옵니다.
   * @param adminno
   * @return 관리자 정보
   */
  public AdminVO select_admin(int adminno);
  
  /**
   * 하나의 관리자 정보를 불러옵니다.
   * @param adminno
   * @return 관리자 정보
   */
  public AdminInclVO select_admin_id(String id);
  
  /**
   * 하나의 관리자 정보를 불러옵니다.
   * @param adminno
   * @return 관리자 정보
   */
  public AdminInclVO select_admin_withcodes(int adminno);
  
  /**
   * 관리자 기본 정보를 수정합니다.
   * @param adminVO
   * @return 처리 여부
   */
  public int update_admin_profile(AdminVO adminVO);
  
  /**
   * 관리자 권한을 수정합니다.
   * @param map
   * @return 처리 여부
   */
  public int update_admin_priv(HashMap<String, Object> map);
  
  /**
   * 비밀번호를 검사합니다.
   * @param map
   * @return 일치 여부
   */
  public int check_passwd(HashMap<String, Object> map);
  
  /**
   * 비밀번호를 변경합니다.
   * @param map
   * @return 처리 여부
   */
  public int update_passwd(HashMap<String, Object> map);
  
  /**
   * 하나의 관리자 정보를 삭제합니다.
   * @param adminno
   * @return 처리 여부
   */
  public int delete_admin(int adminno);
  
  /**
   * 비밀번호를 변경합니다.
   * @param map
   * @return 처리 여부
   */
  public int login_admin(HashMap<String, Object> map);

}

package dev.mvc.adminlog;

import java.util.ArrayList;
import java.util.HashMap;

public interface AdminlogDAOInter {
  
  /**
   * 로그 기록
   * @param adminlogVO
   * @return 기록 확인 (1= 성공)
   */
  public int record_log(AdminlogVO adminlogVO);
  
  /**
   * 데이터베이스용 로그 리스트
   * 실제 웹페이지 상에서는 출력하지 않음
   * @return 리스트
   */
  public ArrayList<AdminlogVO> log_list();
  
  /**
   * 데이터베이스용 로그 리스트
   * 실제 웹페이지 상에서는 출력하지 않음
   * @return 리스트
   */
  public ArrayList<AdminlogInclVO> log_list_full(HashMap<String, Object> map);
  
  /**
   * 데이터베이스용 로그 리스트
   * 실제 웹페이지 상에서는 출력하지 않음
   * @return 리스트
   */
  public int search_count(HashMap<String, Object> map);
  
  /**
   * 데이터베이스용 개별 로그 확인
   * 실제 웹페이지 상에서는 출력하지 않음
   * @param logno
   * @return 로그 항목
   */
  public AdminlogVO log_check(int logno);
  
  /**
   * 로그 수정
   * @param adminlogVO
   * @return 수정 확인 (1= 성공)
   */
  public int log_update(AdminlogVO adminlogVO);
  
  /**
   * 로그 삭제
   * @param 로그 번호
   * @return 수정 확인 (1= 성공)
   */
  public int log_delete(int logno);

  /**
   * 관리자 삭제 시 로그 일괄 수정
   * 관리자가 삭제될 경우 관리자 번호가 -1로 변경되어
   * 출력 페이지 상에서는 '탈퇴한 회원'으로 표시됨
   * @param adminno
   * @return 수정 확인 (1= 성공)
   */
  public int log_update_for_delete_admin(int adminno);
}

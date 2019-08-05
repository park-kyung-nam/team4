package dev.mvc.customer;

import java.util.ArrayList;
import java.util.HashMap;

public interface CustomerDAOInter {
  
  /**
   * 아이디 중복 확인
   * @param id
   * @return 중복 여부(1 = 중복, 0 = 가입 가능)
   */
  public int check_id(String id);
  
  /**
   * 이메일 중복 확인
   * @param email
   * @return 중복 여부(1 = 중복, 0 = 가입 가능)
   */
  public int check_email(String email);
  
  /**
   * 로그인 성공 확인
   * @param map(아이디, 비밀번호로 구성됨)
   * @return 성공 여부(1 = 성공, 0 = 실패)
   */
  public int check_login(HashMap<String, Object> map);
  
  /**
   * 웹페이지 출력용 회원 리스트(비밀번호 제외)
   * @return 회원 리스트
   */
  public ArrayList<CustomerInclVO> list_customer_withcodes();
  

  public int search_count(HashMap<String, Object> map);
  
  /**
   * 웹페이지 출력용 검색 + 페이징 회원 리스트(비밀번호 제외)
   * @return 회원 리스트
   */
  public ArrayList<CustomerInclVO> list_customer_withcodes_search_paging(HashMap<String, Object> map);
  
  /**
   * 회원 수정용 회원 정보(비밀번호 제외 / 디버그 용도로만 사용)
   * @return 회원 정보
   */
  public CustomerVO select_customer(int customerno);
  
  /**
   * 웹페이지 출력용 회원 정보(비밀번호 제외)
   * @return 회원 정보
   */
  public CustomerInclVO select_customer_withcodes(int customerno);
  
  /**
   * 로그인용 회원 정보
   * @return 회원 정보
   */
  public CustomerInclVO select_customer_withcodes_id(String id);
  
  /**
   * 회원 가입 진행
   * @param customerVO
   * @return 처리 여부(1 = 성공, 이외의 값 = 실패)
   */
  public int register_customer (CustomerVO customerVO);
  
  /**
   * 회원 정보 수정
   * @param customerVO
   * @return 처리 여부(1 = 성공, 이외의 값 = 실패)
   */
  public int update_customer_profile (CustomerVO customerVO);
  
  /**
   * 회원 상태 변경
   * @param customerVO
   * @return 처리 여부(1 = 성공, 이외의 값 = 실패)
   */
  public int update_customer_priv (HashMap<String, Object> map);
  
  /**
   * 회원 정보 삭제(디버그 용도로만 사용)
   * @return 처리 여부(1 = 성공, 이외의 값 = 실패)
   */
  public int delete_customer(int customerno);

}

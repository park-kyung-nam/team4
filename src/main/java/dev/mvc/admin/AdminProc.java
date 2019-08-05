package dev.mvc.admin;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.adminlog.AdminlogDAOInter;


@Component("dev.mvc.admin.AdminProc")
public class AdminProc implements AdminProcInter {
  @Autowired
  private AdminDAOInter adminDAO;
  @Autowired
  private AdmincodeDAOInter admincodeDAO;
  @Autowired
  private AdminlogDAOInter adminlogDAO;

  @Override
  public ArrayList<AdminInclVO> list_admin_withcodes() {
    return this.adminDAO.list_admin_withcodes();
  }

  @Override
  public int register_admin(AdminVO adminVO) {
    //System.out.println("img"+adminVO.getImg());
    return this.adminDAO.register_admin(adminVO);
  }

  @Override
  public AdminVO select_admin(int adminno) {
    return this.adminDAO.select_admin(adminno);
  }

  @Override
  public AdminInclVO select_admin_id(String id) {
    return this.adminDAO.select_admin_id(id);
  }

  @Override
  public AdminInclVO select_admin_withcodes(int adminno) {
    return this.adminDAO.select_admin_withcodes(adminno);
  }

  @Override
  public int update_admin_profile(AdminVO adminVO) {
    return this.adminDAO.update_admin_profile(adminVO);
  }

  @Override
  public int update_admin_priv(int adminno, int admincodeno) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("adminno", adminno);
    map.put("admincodeno", admincodeno);
    
    return this.adminDAO.update_admin_priv(map);
  }

  @Override
  public int check_passwd(int adminno, String passwd) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("adminno", adminno);
    map.put("passwd", passwd);
    
    return this.adminDAO.check_passwd(map);
  }

  @Override
  public int update_passwd(int adminno, String passwd) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("adminno", adminno);
    map.put("passwd", passwd);
    return this.adminDAO.update_passwd(map);
  }

  @Override
  public ArrayList<AdmincodeVO> view_codes_list() {
    return this.admincodeDAO.view_codes_list();
  }

  /**
   * 관리자 삭제
   * 관리자 삭제 시 이벤트와 공지사항은 총괄 관리자 작성(0번)으로 일괄 업데이트
   * 관리자 삭제 시 로그는 탈퇴 회원(-8번)으로 일괄 업데이트
   */
  @Override
  public int delete_admin(int adminno) {
    // this.eventDAO.delete(adminno);
    // this.noticeDAO.delete(adminno);
    this.adminlogDAO.log_update_for_delete_admin(adminno);
    return this.adminDAO.delete_admin(adminno);
  }

  @Override
  public int login_admin(String id, String passwd) {
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("id", id);
    map.put("passwd", passwd);
    return this.adminDAO.login_admin(map);
  }
  
  

}

package dev.mvc.customer;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.admin.AdminInclVO;
import dev.mvc.admin.AdminVO;
import dev.mvc.admin.AdmincodeVO;
import dev.mvc.adminlog.ADMINLOG;
import dev.mvc.adminlog.AdminlogProcInter;
import nation.web.tool.AES256Util;
import nation.web.tool.Tool;


@Controller
public class CustomerContAdmin {
  @Autowired
  @Qualifier("dev.mvc.customer.CustomerProc")
  CustomerProcInter customerProc;

  @Autowired
  @Qualifier("dev.mvc.adminlog.AdminlogProc")
  AdminlogProcInter adminlogProc;
  
  AES256Util k;

  public CustomerContAdmin() throws UnsupportedEncodingException{
    k = new AES256Util();
  }
  
  private ModelAndView getList(ModelAndView mav){
    return getList(mav, "", 1);
  }

  private ModelAndView getList(ModelAndView mav, String name, int nowPage){
    mav.setViewName("/admin/customer/list");
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("name", name);                  // #{name}
    hashMap.put("nowPage", nowPage);       
    int search_count = customerProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    
    // 검색 목록
    ArrayList<CustomerInclVO> list = customerProc.list_customer_withcodes_search_paging(hashMap);
    
    String paging = customerProc.pagingBox(search_count, nowPage, name);
    mav.addObject("paging", paging);
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("name", name);
    if(customerProc.search_count(map) % Customer.RECORD_PER_PAGE == 0){
      nowPage = nowPage - 1;
      if(nowPage < 1){
        nowPage = 1;
      }
    }
    mav.addObject("search_name", name);
    mav.addObject("nowPage", nowPage);
    
    
    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("list", list);
    mav.addObject("navbarmode", "list_bar");
    return mav;
  }

  @RequestMapping(value="/nyan", method=RequestMethod.POST)
  private ModelAndView login(
      String id,
      String passwd,
      HttpSession session,
      HttpServletRequest request,
      HttpServletResponse response){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/");
    String passwd_s;
    int count = 0;
    try {
      passwd_s = k.aesEncode(passwd);
      count = customerProc.check_login(id, passwd_s);
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
      return mav;
    }
    if(session.getAttribute("usertype") != null){
      return mav;
    }

    CustomerInclVO cvo = customerProc.select_customer_withcodes_id(id);
    if(count == 1){
      session.setAttribute("usertype",  "C"); // session 내부 객체
      session.setAttribute("customerno",  cvo.getCustomerno()); // session 내부 객체
      session.setAttribute("name", cvo.getName());
      session.setAttribute("email", cvo.getEmail());
      session.setAttribute("customerstatscodeno", cvo.getCustomerstatscodeno());
      session.setAttribute("customerstatsdesc", cvo.getCustomerstatsdesc());
      session.setAttribute("userid", id);
      //session.setAttribute("passwd", passwd);
      Cookie ck_id = new Cookie("ck_id", id);
      ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
      response.addCookie(ck_id);
      mav.setViewName("redirect:/");
      adminlogProc.record_log(request, ADMINLOG.CUSTOMER_LOGIN, -2, "회원 "+cvo.getName()+"(이)가 로그인에 성공함.");
    }
    else{
      if(cvo == null){
        adminlogProc.record_log(request, ADMINLOG.CUSTOMER_LOGIN, -2, "불특정 회원 '"+id+"' 의 로그인 시도가 실패함(아이디가 존재하지 않음)");
      }else{
        adminlogProc.record_log(request, ADMINLOG.CUSTOMER_LOGIN, -2, "회원 "+cvo.getName()+"(이)가 로그인에 실패함.");
      }
      mav.setViewName("redirect:/");
    }
    
    return mav;
  }
  
  @RequestMapping(value="/admin/customer/list2.do", method=RequestMethod.GET)
  public ModelAndView list_admin(){
    ModelAndView mav = new ModelAndView();
    mav = getList(mav);
    return mav;
    
  }
  

  /**
   * 목록 + 검색 + 페이징 지원
   * @param cateno
   * @param name
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/admin/customer/list.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_cate_search_paging(
      @RequestParam(value="name", defaultValue="") String name,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ) { 
    // System.out.println("--> list_by_cate() GET called.");
    System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();

    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    // 검색 기능 추가,  /webapp/Customer/list_by_cate_search_paging.jsp
    mav.setViewName("/admin/customer/list");   
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> hashMap = new HashMap<String, Object>();
    hashMap.put("name", name);                  // #{name}
    hashMap.put("nowPage", nowPage);       
    
    // 검색 목록
    ArrayList<CustomerInclVO> list = customerProc.list_customer_withcodes_search_paging(hashMap);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = customerProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
  
    //Categrp_CateVO cateVO = cateProc.read_by_join(cateno);
    //mav.addObject("cateVO", cateVO);
    
    // mav.addObject("name", name);
  
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     *
     * @param cateno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param name 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = customerProc.pagingBox(search_count, nowPage, name);
    mav.addObject("paging", paging);
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("name", name);
    if(customerProc.search_count(map) % Customer.RECORD_PER_PAGE == 0){
      nowPage = nowPage - 1;
      if(nowPage < 1){
        nowPage = 1;
      }
    }
    mav.addObject("search_name", name);
    mav.addObject("nowPage", nowPage);
    
    return mav;
  } 
  

  
  @RequestMapping(value="/admin/customer/bio", method=RequestMethod.GET)
  public ModelAndView bio(int customerno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/customer/bio");
    /*
    ArrayList<CatgroupVO> groups = catgroupProc.list();
    mav.addObject("groups", groups);
    */
    CustomerInclVO customerInclVO = customerProc.select_customer_withcodes(customerno);
    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("customerInclVO", customerInclVO);
    
    return mav;
    
  }
  

  @RequestMapping(value="/admin/customer/update.do", method=RequestMethod.GET)
  public ModelAndView update_customer_foradmin(int customerno){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/customer/update"); // webapp/member/read.jsp

    CustomerInclVO customerInclVO = customerProc.select_customer_withcodes(customerno);
    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("customerVO", customerInclVO);
    
    return mav;
  }  

  @RequestMapping(value="/admin/customer/update.do", method=RequestMethod.POST)
  public ModelAndView update_customer_foradmin(CustomerVO customerVO,
      HttpSession session,
      HttpServletRequest request,
      @RequestParam(value="name", defaultValue="") String name,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.addObject("name", customerVO.getName());

    int count = customerProc.update_customer_profile(customerVO);

    mav.addObject("result",1);
    mav = getList(mav);
    if(count == 1){
      mav = getList(mav, name, nowPage);
      mav.addObject("al_class","alert-success");
      mav.addObject("msg", " 회원 데이터를 수정하였습니다.");
      adminlogProc.record_log(request, ADMINLOG.MEMBER, Integer.parseInt((String) session.getAttribute("adminno")), session.getAttribute("name")+" 관리자가 "+"회원 "+customerVO.getName()+"의 정보를 수정함");
    }else{
      mav = getList(mav, name, nowPage);
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 회원 데이터 수정에 실패하였습니다. 다시 시도해 주세요.");
    }
    
    return mav;
  }  
  

  @ResponseBody
  @RequestMapping(value="/admin/customer/customer.scan", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String read_json(int customerno) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    CustomerVO customerVO = customerProc.select_customer(customerno);
    //System.out.println(adminVO.getName());
    JSONObject json = new JSONObject(customerVO);
    
    return json.toString();
  }
  
  
  
  @RequestMapping(value="/register", method=RequestMethod.GET)
  public ModelAndView register(){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/customer/register");
    return mav;
    
  }

  @ResponseBody
  @RequestMapping(value="/customer/id.scan", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String check_id(String id) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    int count = customerProc.check_id(id);
    //System.out.println(adminVO.getName());
    JSONObject json = new JSONObject();
    json.put("count", count);
    
    return json.toString();
  }

  @ResponseBody
  @RequestMapping(value="/customer/email.scan", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String check_email(String email) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    int count = customerProc.check_email(email);
    //System.out.println(adminVO.getName());
    JSONObject json = new JSONObject();
    json.put("count", count);
    
    return json.toString();
  }
  
  @RequestMapping(value="/register", method=RequestMethod.POST)
  public ModelAndView register_proc(CustomerVO customerVO,HttpServletRequest request){
    ModelAndView mav = new ModelAndView();
    
    try {
      String passwd = k.aesEncode(customerVO.getPasswd());
      customerVO.setPasswd(passwd);
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    int count = customerProc.register_customer(customerVO);
    mav.addObject("result",1);
    if(count == 1){
      mav.setViewName("/admin/customer/register_success");
      adminlogProc.record_log(request, ADMINLOG.MEMBER, -2, "회원 "+customerVO.getName()+"(이)가 간편 가입에 성공함.");
    }else{
      mav.setViewName("/admin/customer/register_fail");
    }
    return mav;
    
  }
  

  
  @RequestMapping(value="/rinon", method=RequestMethod.GET)
  public ModelAndView register_random(){
    ModelAndView mav = new ModelAndView();
    customerProc.create_random_demo(10);
    mav = getList(mav);
    
    return mav;
    
  }

  @RequestMapping(value="/admin/customer/dereg.do", method=RequestMethod.POST)
  public ModelAndView dereg_admin(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request,
                                        HttpSession session,
                                        int customerno){
    ModelAndView mav = new ModelAndView();
    
    
    //System.out.println("profileimg = "+adminVO.getProfileimg());
    int count = customerProc.update_customer_priv(customerno, 5);
    //int count = 0;

    CustomerVO customerVO = customerProc.select_customer(customerno);
    mav.addObject("name", customerVO.getName());
    mav.addObject("result",1);
    mav = getList(mav);
    if(count == 1){
      mav.addObject("al_class","alert-success");
      mav.addObject("msg", " 회원 이용을 제한하였습니다.");
      adminlogProc.record_log(request, ADMINLOG.MEMBER, Integer.parseInt((String) session.getAttribute("adminno")), session.getAttribute("name")+" 관리자가 "+"회원 "+customerVO.getName()+"의 이용을 제한함");

      mav.setViewName("/admin/customer/list");
    }else{
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 회원 이용 제한 처리에 실패하였습니다. 다시 시도해 주세요.");
      mav.setViewName("/admin/customer/list");
    }
    return mav;
  }
  

  @RequestMapping(value="/admin/customer/delete.do", method=RequestMethod.POST)
  public ModelAndView delete_admin(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request,
                                        HttpSession session,
                                        int customerno,
                                        @RequestParam(value="name", defaultValue="") String name,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage){
    ModelAndView mav = new ModelAndView();

    CustomerVO customerVO = customerProc.select_customer(customerno);
    mav.addObject("name", customerVO.getName());
    
    //System.out.println("profileimg = "+adminVO.getProfileimg());
    int count = customerProc.delete_customer(customerno);
    //int count = 0;

    mav.addObject("result",1);
    mav = getList(mav);
    if(count == 1){
      mav = getList(mav, name, nowPage);
      mav.addObject("al_class","alert-success");
      mav.addObject("msg", " 회원 데이터를 삭제하였습니다.");
      adminlogProc.record_log(request, ADMINLOG.MEMBER, Integer.parseInt((String) session.getAttribute("adminno")), session.getAttribute("name")+" 관리자가 "+"회원 "+customerVO.getName()+"의 정보를 삭제함");

    }else{
      mav = getList(mav, name, nowPage);
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 회원 데이터를 삭제에 실패하였습니다. 다시 시도해 주세요.");
    }
    return mav;
  }
  
  
}

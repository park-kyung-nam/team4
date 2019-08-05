package dev.mvc.adminlog;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.admin.AdminInclVO;
import dev.mvc.admin.AdminProcInter;
import dev.mvc.admin.AdminVO;
import dev.mvc.admin.AdmincodeVO;
import dev.mvc.customer.Customer;

@Controller
public class AdminlogCont {
  @Autowired
  /*
  @Qualifier("dev.mvc.admin.AdminProc")
  AdminProcInter adminProc;
  */
  @Qualifier("dev.mvc.adminlog.AdminlogProc")
  AdminlogProcInter adminlogProc;
  

  //http://localhost:9090/ojt/member/create.do
 @RequestMapping(value = "/admin/adminlog/create.do", method = RequestMethod.GET)
 public ModelAndView create_log_admin() {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/adminlog/create"); // /webapp/member/create.jsp
   ArrayList<AdminlogtypeVO> typelist = adminlogProc.view_codes_list();
   mav.addObject("typelist", typelist);
  return mav;
   
 }
 

 
 @RequestMapping(value="/admin/adminlog/create.do", method=RequestMethod.POST)
 public ModelAndView create_log_admin(HttpServletRequest request, AdminlogVO adminlogVO){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   
   adminlogVO.setLogdesc("[Manual] "+adminlogVO.getLogdesc());
   adminlogVO.setIpv4(request.getRemoteAddr());


   int count = adminlogProc.record_log(adminlogVO);

   mav.addObject("result",1);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("name",adminlogVO.getAdminno());
     mav.addObject("msg","가 로그를 생성하는 데 성공하였습니다.");
     mav = list_log_debug();
   }else{
     mav.setViewName("/admin/adminlog/create"); // /webapp/member/create.jsp
     mav.addObject("al_class","alert-danger");
     mav.addObject("name",adminlogVO.getAdminno());
     mav.addObject("msg","가 로그를 생성하는 데 실패하였습니다.");
     
   }
   
   return mav;
 }  
 

 @RequestMapping(value="/admin/adminlog/list2.do", method=RequestMethod.GET)
 public ModelAndView list_log_debug(){
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/admin/adminlog/list_debug");
   ArrayList<AdminlogVO> list = adminlogProc.log_list();
   mav.addObject("list", list);
   
   return mav;
   
 }
 

 @RequestMapping(value="/admin/adminlog/list.do", method=RequestMethod.GET)
 public ModelAndView list_log_debug_incl(
     @RequestParam(value="logtype", defaultValue="-1") int logtype,
     @RequestParam(value="logdesc", defaultValue="") String logdesc,
     @RequestParam(value="nowPage", defaultValue="1") int nowPage
     ){
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/admin/adminlog/list_debug");
   HashMap<String, Object> hashMap = new HashMap<String, Object>();
   if(logtype != -1){
     hashMap.put("logtype", logtype);
   }
   hashMap.put("logdesc", logdesc);
   hashMap.put("nowPage", nowPage);       
   
   ArrayList<AdminlogInclVO> list = adminlogProc.log_list_full(hashMap);
   mav.addObject("list", list);
   

   // 검색된 레코드 갯수
   int search_count = adminlogProc.search_count(hashMap);
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
   String paging = adminlogProc.pagingBox(search_count, nowPage, logdesc, logtype);
   mav.addObject("paging", paging);
   
   HashMap<String, Object> map = new HashMap<String, Object>();
   if(logtype != -1){
     hashMap.put("logtype", logtype);
   }
   hashMap.put("logdesc", logdesc);
   if(adminlogProc.search_count(map) % Customer.RECORD_PER_PAGE == 0){
     nowPage = nowPage - 1;
     if(nowPage < 1){
       nowPage = 1;
     }
   }
   if(logtype != -1){
     mav.addObject("logtype", logtype);
   }
   mav.addObject("logdesc", logdesc);
   mav.addObject("nowPage", nowPage);
   
   return mav;
   
 }

 @RequestMapping(value="/admin/adminlog/check.do", method=RequestMethod.GET)
 public ModelAndView check_log_debug(int logno){
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/admin/adminlog/check");
   AdminlogVO alog = adminlogProc.log_check(logno);
   mav.addObject("alog", alog);
   
   return mav;
   
 }
 

 
 @ResponseBody
 @RequestMapping(value="/admin/adminlog/log.scan", 
                          method=RequestMethod.GET,
                          produces="text/plain;charset=UTF-8")
 public String read_json(int logno) {
   try {
     Thread.sleep(100);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }

   AdminlogVO alog = adminlogProc.log_check(logno);
   //System.out.println(adminVO.getName());
   JSONObject json = new JSONObject(alog);
   
   return json.toString();
 }

 @RequestMapping(value="/admin/adminlog/update.do", method=RequestMethod.GET)
 public ModelAndView update_log_debug(int logno){
   ModelAndView mav = new ModelAndView();

   mav.setViewName("/admin/adminlog/update");
   AdminlogVO alog = adminlogProc.log_check(logno);
   mav.addObject("alog", alog);
   ArrayList<AdminlogtypeVO> typelist = adminlogProc.view_codes_list();
   mav.addObject("typelist", typelist);
   
   return mav;
   
 }
 

 @RequestMapping(value="/admin/adminlog/update.do", method=RequestMethod.POST)
 public ModelAndView update_log_manual(HttpServletRequest request, AdminlogVO adminlogVO){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   int count = adminlogProc.log_update(adminlogVO);

   mav.addObject("result",1);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("name",adminlogVO.getAdminno());
     mav.addObject("msg","가 로그를 수정하는 데 성공하였습니다.");
     mav = list_log_debug();
   }else{
     mav.setViewName("/admin/adminlog/update"); // /webapp/member/create.jsp
     mav.addObject("al_class","alert-danger");
     mav.addObject("name",adminlogVO.getAdminno());
     mav.addObject("msg","가 로그를 수정하는 데 실패하였습니다.");
     
   }
   
   return mav;
 }  
 

 @RequestMapping(value="/admin/adminlog/delete.do", method=RequestMethod.POST)
 public ModelAndView delete_log_manual(HttpServletRequest request, int logno){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   int count = adminlogProc.log_delete(logno);

   mav.addObject("result",1);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg","로그를 삭제하였습니다.");
     mav = list_log_debug();
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg","로그 삭제에 실패하였습니다. 다시 시도해 주세요.");
     mav = list_log_debug();
   }
   
   return mav;
 }  
 

}

package dev.mvc.admin;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.adminlog.ADMINLOG;
import dev.mvc.adminlog.AdminlogDAOInter;
import dev.mvc.adminlog.AdminlogProcInter;
import nation.web.tool.AES256Util;
import nation.web.tool.Tool;
import nation.web.tool.Upload;




@Controller
public class AdminCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  AdminProcInter adminProc;

  @Autowired
  @Qualifier("dev.mvc.adminlog.AdminlogProc")
  AdminlogProcInter adminlogProc;
  
  AES256Util k;
  public AdminCont() throws UnsupportedEncodingException{
    k = new AES256Util();
  }
  
  
  private ModelAndView getList(ModelAndView mav){
    mav.setViewName("/admin/admin/list2");
    ArrayList<AdminInclVO> list = adminProc.list_admin_withcodes();
    ArrayList<AdmincodeVO> codes = adminProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("list", list);
    return mav;
  }
  
  @RequestMapping(value="/admin", method=RequestMethod.GET)
  public ModelAndView dashboard(){
    ModelAndView mav = new ModelAndView();
    /*if(session.getAttribute("id") != null){
      //이미 로그인 상태이므로 넘어감
      mav.setViewName("redirect:/admin");
    }*/
    mav.setViewName("/admin/dashboard");
    return mav;
    
  }
  
  @RequestMapping(value="/admin/admin/list.do", method=RequestMethod.GET)
  public ModelAndView list_admin(){
    ModelAndView mav = new ModelAndView();
    mav = getList(mav);
    return mav;
    
  }
  
  @RequestMapping(value="/admin/admin/bio", method=RequestMethod.GET)
  public ModelAndView bio(int adminno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/admin/bio");
    /*
    ArrayList<CatgroupVO> groups = catgroupProc.list();
    mav.addObject("groups", groups);
    */
    AdminInclVO adminInclVO = adminProc.select_admin_withcodes(adminno);
    ArrayList<AdmincodeVO> codes = adminProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("adminInclVO", adminInclVO);
    
    return mav;
    
  }
  
  //http://localhost:9090/ojt/member/create.do
 @RequestMapping(value = "/admin/admin/create.do", method = RequestMethod.GET)
 public ModelAndView create_admin() {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/admin/create"); // /webapp/member/create.jsp
  return mav;
   
 }
 

 @RequestMapping(value="/admin/admin/create.do", method=RequestMethod.POST)
 public ModelAndView create_admin(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, AdminVO adminVO){
   ModelAndView mav = new ModelAndView();
   
   String passwd = adminVO.getPasswd();
   try{
     passwd = k.aesEncode(passwd);
     adminVO.setPasswd(passwd);
   }catch(Exception e){
     e.printStackTrace();
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " 관리자 가입에 실패하였습니다. 다시 시도해 주세요.");
     mav.setViewName("/admin/admin/create"); // /webapp/member/create.jsp
     return mav;
   }
   
// -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/admin/admin/bio/imgs");
   // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
   List<MultipartFile> filesMF = adminVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = "";        // DBMS 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";       // DBMS 컬럼에 저장할 파일 크기
   long sizes_item = 0;   // 하나의 파일 사이즈

   int count = filesMF.size(); // 업로드된 파일 갯수

   // Spring은 파일 선택을 안해도 1개의 MultipartFile 객체가 생성됨.
   // System.out.println("--> 업로드된 파일 갯수 count: " + count);

   if (count > 0) { // 전송 파일이 존재한다면
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0: 첫번째 파일, 1:두번째 파일 ~
       // System.out.println("multipartFile.getName(): " + multipartFile.getName());

       if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
         // System.out.println("전송 파일이 있습니다.");
         files_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
         sizes_item = multipartFile.getSize(); // 서버에 저장된 파일 크기
         

         // 1개 이상의 다중 파일 처리
         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           
         // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
         } else if (multipartFile.getSize() > 0) { 
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   adminVO.setProfileimg(files);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------
   
   System.out.println("profileimg = "+adminVO.getProfileimg());
   int cnt = adminProc.register_admin(adminVO);
   
   
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   if(cnt == 1){
     adminlogProc.record_log(request, ADMINLOG.ADMIN, adminVO.getAdminno(), "새로운 관리자("+adminVO.getName()+")의 가입 승인 요청");
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " 관리자를 생성하였습니다.");
     mav = getList(mav);
   }else{
     String referer = request.getHeader("Referer");
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " 관리자 가입에 실패하였습니다. 다시 시도해 주세요.");
     mav.setViewName("/admin/admin/create"); // /webapp/member/create.jsp
   }
   return mav;
 }

 @RequestMapping(value="/login_admin", method=RequestMethod.GET)
 public ModelAndView login_admin(HttpSession session){
   ModelAndView mav = new ModelAndView();
   if(Tool.checkNull((String)session.getAttribute("usertype")).equals("A")){
     //이미 로그인 상태이므로 넘어감
     mav.setViewName("redirect:/admin");
   }else{
     mav.setViewName("/admin/login_admin");
   }
   return mav;
 }
 

 @RequestMapping(value="/login_admin", method=RequestMethod.POST)
 public ModelAndView login_admin(
     String id, 
     String passwd,
     HttpSession session,
     HttpServletRequest request,
     HttpServletResponse response){
   ModelAndView mav = new ModelAndView();
   int count = 0;

   try {
     AES256Util aes256 = new AES256Util();
     String l_pw = aes256.aesEncode(passwd);
     count = adminProc.login_admin(id, l_pw);
   } catch (Exception e) {
     e.printStackTrace();
     System.out.println("you came here");
   }
   if(session.getAttribute("usertype") != null){
     return mav;
   }
   
   if(count == 1){
     AdminInclVO avo = adminProc.select_admin_id(id);
     session.setAttribute("usertype",  "A"); // session 내부 객체
     session.setAttribute("adminno",  avo.getAdminno()); // session 내부 객체
     session.setAttribute("name", avo.getName());
     session.setAttribute("email", avo.getEmail());
     session.setAttribute("admincodeno", avo.getAdmincodeno());
     session.setAttribute("privdesc", avo.getPrivdesc());
     session.setAttribute("userid", id);
     session.setAttribute("profileimg", avo.getProfileimg());
     session.setAttribute("img", avo.getImg());
     //session.setAttribute("passwd", passwd);
     Cookie ck_id = new Cookie("ck_id", id);
     ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
     response.addCookie(ck_id);
     mav.setViewName("redirect:/admin");
     adminlogProc.record_log(request, ADMINLOG.LOGIN, avo.getAdminno(), avo.getName()+"(이)가 로그인에 성공함.");
     
   }else{
     mav.setViewName("/admin/login_admin");
   }
   //String referer = request.getHeader("Referer");
   //request.getSession().setAttribute("redirectURI", referer);
   //mav.setViewName("redirect:"+ referer); 
   return mav;
 }
 
 /**
  * 로그아웃 처리
  * @param request
  * @param session
  * @return
  */
 @RequestMapping(value="/logout", method=RequestMethod.GET)
 public ModelAndView logout(
     HttpServletRequest request, 
     HttpServletResponse response,
     HttpSession session){
   // System.out.println("--> logout() GET called.");
   ModelAndView mav = new ModelAndView();

   session.invalidate(); // session 내부 객체의 등록된 모든 session 변수 삭제

   mav.setViewName("redirect:/"); 
   
   return mav;
 }
 
 @RequestMapping(value="/admin/admin/update.do", method=RequestMethod.GET)
 public ModelAndView update_admin(int adminno){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/admin/update"); // webapp/member/read.jsp
   
   AdminVO adminVO = adminProc.select_admin(adminno);
   mav.addObject("adminVO", adminVO);
   
   return mav;
 }  
 

 @RequestMapping(value="/admin/admin/update.do", method=RequestMethod.POST)
 public ModelAndView update_admin_profile(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request,
                                       HttpSession session,
                                       HttpServletResponse response,
                                       AdminVO adminVO){
   ModelAndView mav = new ModelAndView();

   //System.out.println(adminVO.getFilesMF());
   AdminVO adminVO_prev = adminProc.select_admin(adminVO.getAdminno());
   List<MultipartFile> filesMF = adminVO.getFilesMF(); 
   String upDir = Tool.getRealPath(request, "/admin/admin/bio/imgs");

   int count = filesMF.size(); // 업로드된 파일 갯수
   
   String files = ""; // 컬럼에 저장할 파일명
   String files_item = ""; // 하나의 파일명
   String sizes = "";
   long sizes_item = 0; // 하나의 파일 사이즈
   
   
   if(filesMF.get(0).getSize() > 0){

     // 원본 파일 삭제
     String files_old = Tool.checkNull(adminVO_prev.getProfileimg());
     StringTokenizer files_st = new StringTokenizer(files_old, "/");
     while (files_st.hasMoreTokens()) {
       String fname = upDir + files_st.nextToken();
       Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
     }

     // --------------------------------------------
     // 새로운 파일의 등록 시작
     // --------------------------------------------
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0 ~
       System.out.println("multipartFile.getName(): " + multipartFile.getName());

       // if (multipartFile.getName().length() > 0) { // 전송파일이 있는지 체크, filesMF
       if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
         // System.out.println("전송 파일이 있습니다.");
         files_item = Upload.saveFileSpring(multipartFile, upDir);
         sizes_item = multipartFile.getSize();

         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
         } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                   // 크기 체크
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
         }

       }
     } // for END
     // --------------------------------------------
     // 새로운 파일의 등록 종료
     // --------------------------------------------

   }else{
     files = Tool.checkNull(adminVO_prev.getProfileimg());
     
   }
   System.out.println(files);
   adminVO.setProfileimg(files);
   
   
   //System.out.println("profileimg = "+adminVO.getProfileimg());
   int cnt = adminProc.update_admin_profile(adminVO);
   //int count = 0;
   
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   if(cnt == 1){
     if(session.getAttribute("userid").equals(adminVO.getId())){
       AdminInclVO avo = adminProc.select_admin_withcodes(adminVO.getAdminno());
       session.setAttribute("usertype",  "A"); // session 내부 객체
       session.setAttribute("adminno",  avo.getAdminno()); // session 내부 객체
       session.setAttribute("name", avo.getName());
       session.setAttribute("email", avo.getEmail());
       session.setAttribute("admincodeno", avo.getAdmincodeno());
       session.setAttribute("privdesc", avo.getPrivdesc());
       session.setAttribute("userid", avo.getId());
       session.setAttribute("profileimg", avo.getProfileimg());
       session.setAttribute("img", avo.getImg());
       //session.setAttribute("passwd", passwd);
       Cookie ck_id = new Cookie("ck_id", avo.getId());
       ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, 초단위
       response.addCookie(ck_id);
     }

     adminlogProc.record_log(request, ADMINLOG.ADMIN, adminVO.getAdminno(), session.getAttribute("name")+"(이)가 "+adminVO.getName()+"의 정보를 수정함.");
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " 관리자 정보를 수정하였습니다.");
     mav = getList(mav);
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " 관리자 정보 수정에 실패하였습니다. 다시 시도해 주세요.");
     mav.setViewName("/admin/admin/update");
   }
   return mav;
 }


 @RequestMapping(value="/admin/admin/check_passwd.do", method=RequestMethod.GET)
 public ModelAndView check_passwd_admin(int adminno){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/admin/passwd_check_admin"); // webapp/member/read.jsp
   mav.addObject("adminno", adminno);
   mav.addObject("name", adminProc.select_admin(adminno).getName());
   
   return mav;
 }  
 

 @RequestMapping(value="/admin/admin/check_passwd.do", method=RequestMethod.POST)
 public ModelAndView check_passwd_admin_proc(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, AdminVO adminVO){
   ModelAndView mav = new ModelAndView();
   int adminno_ = adminVO.getAdminno();
   String passwd = adminVO.getPasswd();
   try{
     passwd = k.aesEncode(passwd);
   }catch(Exception e){
   }
   
   int count = 0;
   count = adminProc.check_passwd(adminno_, passwd);
   
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   if(count == 1){
     mav.setViewName("redirect:/admin/admin/update_passwd.do?adminno="+adminno_);
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", "의 비밀번호를 잘못 입력하였습니다. 다시 시도해 주세요.");
     mav.addObject("adminno_", adminno_);
     mav.setViewName("/admin/admin/passwd_check_admin");
   }
   return mav;
 }
 

 @RequestMapping(value="/admin/admin/update_passwd.do", method=RequestMethod.GET)
 public ModelAndView update_passwd_admin(int adminno){
   // System.out.println("--> read(int mno) GET called.");
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/admin/update_passwd"); // webapp/member/read.jsp
   
   
   mav.addObject("adminno", adminno);
   mav.addObject("name", adminProc.select_admin(adminno).getName());
   
   return mav;
 }  
 

 @RequestMapping(value="/admin/admin/update_passwd.do", method=RequestMethod.POST)
 public ModelAndView update_passwd_admin(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, AdminVO adminVO, String passwd, String passwd2){
   ModelAndView mav = new ModelAndView();
   int adminno = adminVO.getAdminno();
   try{
     passwd = k.aesEncode(passwd);
     passwd2 = k.aesEncode(passwd2);
   }catch(Exception e){
   }
   
   int count = 0;
   if(passwd.equals(passwd2)){
     count = adminProc.update_passwd(adminno,passwd);
     
   }
   
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", "의 비밀번호를 변경하였습니다.");
     mav = getList(mav);
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", "의 비밀번호를 변경에 실패하였습니다. 다시 시도해 주세요.");
     mav.addObject("adminno", adminno);
     mav.setViewName("/admin/admin/update_passwd");
   }
   return mav;
 }
 


 @RequestMapping(value="/admin/admin/update_priv.do", method=RequestMethod.POST)
 public ModelAndView update_priv_admin(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request, AdminVO adminVO){
   ModelAndView mav = new ModelAndView();
   
   
   //System.out.println("profileimg = "+adminVO.getProfileimg());
   int count = adminProc.update_admin_priv(adminVO.getAdminno(),adminVO.getAdmincodeno());
   //int count = 0;
   
   mav.addObject("name", adminVO.getName());
   mav = getList(mav);
   mav.addObject("result",1);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", "의 권한을 변경하였습니다.");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", "의 권한 변경에 실패하였습니다. 다시 시도해 주세요.");
   }
   return mav;
 }
 
 @ResponseBody
 @RequestMapping(value="/admin/admin/admin.scan", 
                          method=RequestMethod.GET,
                          produces="text/plain;charset=UTF-8")
 public String read_json(int adminno) {
   try {
     Thread.sleep(100);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }

   AdminVO adminVO = adminProc.select_admin(adminno);
   //System.out.println(adminVO.getName());
   JSONObject json = new JSONObject(adminVO);
   
   return json.toString();
 }
 

 
 @ResponseBody
 @RequestMapping(value="/admin/admin/list.codes", 
                          method=RequestMethod.GET,
                          produces="text/plain;charset=UTF-8")
 public String list_codes() {
   try {
     Thread.sleep(100);
   } catch (InterruptedException e) {
     e.printStackTrace();
   }

   ArrayList<AdmincodeVO> codes = adminProc.view_codes_list();
   //System.out.println(adminVO.getName());
   JSONObject json = new JSONObject();
   json.put("codes", codes);
   
   return json.toString();
 }
 
 @RequestMapping(value="/admin/admin/dereg.do", method=RequestMethod.POST)
 public ModelAndView dereg_admin(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request,
                                       HttpSession session,
                                       int adminno){
   ModelAndView mav = new ModelAndView();
   
   
   //System.out.println("profileimg = "+adminVO.getProfileimg());
   int count = adminProc.update_admin_priv(adminno, -8);
   //int count = 0;

   AdminVO adminVO = adminProc.select_admin(adminno);
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   mav = getList(mav);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " 관리자를 탈퇴 처리 하였습니다.");
     mav.setViewName("/admin/admin/list");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " 관리자 탈퇴 처리에 실패하였습니다. 다시 시도해 주세요.");
     mav.setViewName("/admin/admin/list");
   }
   return mav;
 }
 

 @RequestMapping(value="/admin/admin/delete.do", method=RequestMethod.POST)
 public ModelAndView delete_admin(RedirectAttributes redirectAttributes,
                                       HttpServletRequest request,
                                       HttpSession session,
                                       int adminno){
   ModelAndView mav = new ModelAndView();

   AdminVO adminVO = adminProc.select_admin(adminno);
   

   String upDir = Tool.getRealPath(request, "/admin/admin/bio/imgs");
   
   String files_old = adminVO.getProfileimg();
   StringTokenizer files_st = new StringTokenizer(files_old, "/");
   while (files_st.hasMoreTokens()) {
     String fname = upDir + files_st.nextToken();
     Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
   }
   
   mav.addObject("name", adminVO.getName());
   
   
   
   //System.out.println("profileimg = "+adminVO.getProfileimg());
   int count = adminProc.delete_admin(adminno);
   //int count = 0;

   mav.addObject("result",1);
   mav = getList(mav);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " 관리자를 탈퇴 처리 하였습니다.");
     mav.setViewName("/admin/admin/list");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " 관리자 탈퇴 처리에 실패하였습니다. 다시 시도해 주세요.");
     mav.setViewName("/admin/admin/list");
   }
   return mav;
 }
 

}

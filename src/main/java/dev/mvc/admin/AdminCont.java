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
      //�̹� �α��� �����̹Ƿ� �Ѿ
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
     mav.addObject("msg", " ������ ���Կ� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
     mav.setViewName("/admin/admin/create"); // /webapp/member/create.jsp
     return mav;
   }
   
// -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/admin/admin/bio/imgs");
   // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
   List<MultipartFile> filesMF = adminVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String files = "";        // DBMS �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";       // DBMS �÷��� ������ ���� ũ��
   long sizes_item = 0;   // �ϳ��� ���� ������

   int count = filesMF.size(); // ���ε�� ���� ����

   // Spring�� ���� ������ ���ص� 1���� MultipartFile ��ü�� ������.
   // System.out.println("--> ���ε�� ���� ���� count: " + count);

   if (count > 0) { // ���� ������ �����Ѵٸ�
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0: ù��° ����, 1:�ι�° ���� ~
       // System.out.println("multipartFile.getName(): " + multipartFile.getName());

       if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
         // System.out.println("���� ������ �ֽ��ϴ�.");
         files_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
         sizes_item = multipartFile.getSize(); // ������ ����� ���� ũ��
         

         // 1�� �̻��� ���� ���� ó��
         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
           
         // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
         } else if (multipartFile.getSize() > 0) { 
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   adminVO.setProfileimg(files);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   
   System.out.println("profileimg = "+adminVO.getProfileimg());
   int cnt = adminProc.register_admin(adminVO);
   
   
   mav.addObject("name", adminVO.getName());
   mav.addObject("result",1);
   if(cnt == 1){
     adminlogProc.record_log(request, ADMINLOG.ADMIN, adminVO.getAdminno(), "���ο� ������("+adminVO.getName()+")�� ���� ���� ��û");
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " �����ڸ� �����Ͽ����ϴ�.");
     mav = getList(mav);
   }else{
     String referer = request.getHeader("Referer");
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " ������ ���Կ� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
     mav.setViewName("/admin/admin/create"); // /webapp/member/create.jsp
   }
   return mav;
 }

 @RequestMapping(value="/login_admin", method=RequestMethod.GET)
 public ModelAndView login_admin(HttpSession session){
   ModelAndView mav = new ModelAndView();
   if(Tool.checkNull((String)session.getAttribute("usertype")).equals("A")){
     //�̹� �α��� �����̹Ƿ� �Ѿ
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
     session.setAttribute("usertype",  "A"); // session ���� ��ü
     session.setAttribute("adminno",  avo.getAdminno()); // session ���� ��ü
     session.setAttribute("name", avo.getName());
     session.setAttribute("email", avo.getEmail());
     session.setAttribute("admincodeno", avo.getAdmincodeno());
     session.setAttribute("privdesc", avo.getPrivdesc());
     session.setAttribute("userid", id);
     session.setAttribute("profileimg", avo.getProfileimg());
     session.setAttribute("img", avo.getImg());
     //session.setAttribute("passwd", passwd);
     Cookie ck_id = new Cookie("ck_id", id);
     ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, �ʴ���
     response.addCookie(ck_id);
     mav.setViewName("redirect:/admin");
     adminlogProc.record_log(request, ADMINLOG.LOGIN, avo.getAdminno(), avo.getName()+"(��)�� �α��ο� ������.");
     
   }else{
     mav.setViewName("/admin/login_admin");
   }
   //String referer = request.getHeader("Referer");
   //request.getSession().setAttribute("redirectURI", referer);
   //mav.setViewName("redirect:"+ referer); 
   return mav;
 }
 
 /**
  * �α׾ƿ� ó��
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

   session.invalidate(); // session ���� ��ü�� ��ϵ� ��� session ���� ����

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

   int count = filesMF.size(); // ���ε�� ���� ����
   
   String files = ""; // �÷��� ������ ���ϸ�
   String files_item = ""; // �ϳ��� ���ϸ�
   String sizes = "";
   long sizes_item = 0; // �ϳ��� ���� ������
   
   
   if(filesMF.get(0).getSize() > 0){

     // ���� ���� ����
     String files_old = Tool.checkNull(adminVO_prev.getProfileimg());
     StringTokenizer files_st = new StringTokenizer(files_old, "/");
     while (files_st.hasMoreTokens()) {
       String fname = upDir + files_st.nextToken();
       Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
     }

     // --------------------------------------------
     // ���ο� ������ ��� ����
     // --------------------------------------------
     // for (MultipartFile multipartFile: filesMF) {
     for (int i = 0; i < count; i++) {
       MultipartFile multipartFile = filesMF.get(i); // 0 ~
       System.out.println("multipartFile.getName(): " + multipartFile.getName());

       // if (multipartFile.getName().length() > 0) { // ���������� �ִ��� üũ, filesMF
       if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
         // System.out.println("���� ������ �ֽ��ϴ�.");
         files_item = Upload.saveFileSpring(multipartFile, upDir);
         sizes_item = multipartFile.getSize();

         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           files = files + "/" + files_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           sizes = sizes + "/" + sizes_item;
         } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                   // ũ�� üũ
           files = files_item; // file1.jpg
           sizes = "" + sizes_item; // 123456
         }

       }
     } // for END
     // --------------------------------------------
     // ���ο� ������ ��� ����
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
       session.setAttribute("usertype",  "A"); // session ���� ��ü
       session.setAttribute("adminno",  avo.getAdminno()); // session ���� ��ü
       session.setAttribute("name", avo.getName());
       session.setAttribute("email", avo.getEmail());
       session.setAttribute("admincodeno", avo.getAdmincodeno());
       session.setAttribute("privdesc", avo.getPrivdesc());
       session.setAttribute("userid", avo.getId());
       session.setAttribute("profileimg", avo.getProfileimg());
       session.setAttribute("img", avo.getImg());
       //session.setAttribute("passwd", passwd);
       Cookie ck_id = new Cookie("ck_id", avo.getId());
       ck_id.setMaxAge(60 * 60 * 72 * 10); // 30 day, �ʴ���
       response.addCookie(ck_id);
     }

     adminlogProc.record_log(request, ADMINLOG.ADMIN, adminVO.getAdminno(), session.getAttribute("name")+"(��)�� "+adminVO.getName()+"�� ������ ������.");
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " ������ ������ �����Ͽ����ϴ�.");
     mav = getList(mav);
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " ������ ���� ������ �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
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
     mav.addObject("msg", "�� ��й�ȣ�� �߸� �Է��Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
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
     mav.addObject("msg", "�� ��й�ȣ�� �����Ͽ����ϴ�.");
     mav = getList(mav);
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", "�� ��й�ȣ�� ���濡 �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
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
     mav.addObject("msg", "�� ������ �����Ͽ����ϴ�.");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", "�� ���� ���濡 �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
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
     mav.addObject("msg", " �����ڸ� Ż�� ó�� �Ͽ����ϴ�.");
     mav.setViewName("/admin/admin/list");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " ������ Ż�� ó���� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
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
     Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
   }
   
   mav.addObject("name", adminVO.getName());
   
   
   
   //System.out.println("profileimg = "+adminVO.getProfileimg());
   int count = adminProc.delete_admin(adminno);
   //int count = 0;

   mav.addObject("result",1);
   mav = getList(mav);
   if(count == 1){
     mav.addObject("al_class","alert-success");
     mav.addObject("msg", " �����ڸ� Ż�� ó�� �Ͽ����ϴ�.");
     mav.setViewName("/admin/admin/list");
   }else{
     mav.addObject("al_class","alert-danger");
     mav.addObject("msg", " ������ Ż�� ó���� �����Ͽ����ϴ�. �ٽ� �õ��� �ּ���.");
     mav.setViewName("/admin/admin/list");
   }
   return mav;
 }
 

}

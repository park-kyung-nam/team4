package dev.mvc.adminboard;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.admin.AdminInclVO;
import dev.mvc.admin.AdminProcInter;
import dev.mvc.admin.AdminVO;
import dev.mvc.admin.AdmincodeVO;
import dev.mvc.adminlog.ADMINLOG;
import dev.mvc.adminlog.AdminlogProcInter;
import nation.web.tool.FileVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class AdminboardCont {
  @Autowired
  @Qualifier("dev.mvc.admin.AdminProc")
  AdminProcInter adminProc;

  @Autowired
  @Qualifier("dev.mvc.adminlog.AdminlogProc")
  AdminlogProcInter adminlogProc;

  @Autowired
  @Qualifier("dev.mvc.adminboard.AdminboardProc")
  AdminboardProcInter adminboardProc;

  @Autowired
  @Qualifier("dev.mvc.adminboard.CommentsProc")
  CommentsProcInter commentsProc;
  
  private ModelAndView getList(){
    ModelAndView mav = new ModelAndView();
    return getList(mav);
  }

  private ModelAndView getList(ModelAndView mav){
    return getList(mav, "", "", "", "", 1);
  }

  private ModelAndView getList(ModelAndView mav, String word, String name, String content, String id, int nowPage){
    mav.setViewName("/admin/adminboard/list2");

    HashMap<String, Object> hashMap = new HashMap<String, Object>();

    hashMap.put("word", word);
    hashMap.put("name", name);
    hashMap.put("id", id);
    hashMap.put("content", content);
    hashMap.put("nowPage", nowPage);       
    
    
    ArrayList<AdminboardInclVO> list = adminboardProc.boardlist_incl_spg(hashMap);
    mav.addObject("list", list);
    

    int search_count = adminboardProc.search_count(hashMap);
    mav.addObject("search_count", search_count);
    

    String paging = adminboardProc.pagingBox(search_count, nowPage, word, name, content, id);
    mav.addObject("paging", paging);
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("word", word);
    if(adminboardProc.search_count(map) % ADMINBOARD.RECORD_PER_PAGE == 0){
      nowPage = nowPage - 1;
      if(nowPage < 1){
        nowPage = 1;
      }
    }
    mav.addObject("nowPage", nowPage);
    if(!word.isEmpty()){
      mav.addObject("richer_topbar_title", "["+word+"] 검색 결과("+search_count+")");
    }
    
    return mav;
  }
  
  @RequestMapping(value="/admin/board/list.do", method=RequestMethod.GET)
  public ModelAndView list_board(
      @RequestParam(value="word", defaultValue="") String word,
      @RequestParam(value="name", defaultValue="") String name,
      @RequestParam(value="id", defaultValue="") String id,
      @RequestParam(value="content", defaultValue="") String content,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage
      ){
    ModelAndView mav = new ModelAndView();
    mav = getList(mav, word, name, content, id, nowPage);
    return mav;
    
  }

  @RequestMapping(value = "/admin/board/create.do", method = RequestMethod.GET)
  public ModelAndView create_board_page() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/adminboard/create"); // /webapp/member/create.jsp
   return mav;
    
  }
  

  @RequestMapping(value="/admin/board/create.do", method=RequestMethod.POST)
  public ModelAndView create_board_proc(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request, AdminboardVO adminboardVO){
    ModelAndView mav = new ModelAndView();
    
    
 // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/wakabastorage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = adminboardVO.getFilesMF(); 

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
    adminboardVO.setFiles(files);
    adminboardVO.setSizes(sizes);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    int cnt = adminboardProc.post(adminboardVO);
    
    String name = adminProc.select_admin(adminboardVO.getAdminno()).getName();
    mav.addObject("name", name);
    mav.addObject("result",1);
    if(cnt == 1){
      int adminboardno = adminboardProc.get_created_no();
      adminlogProc.record_log(request, ADMINLOG.ADMIN, adminboardVO.getAdminno(),
          name+"(이)가 새로운 게시글을 올림. <a class='alert-link' href='../board/read.do?adminboardno="+ adminboardno+"'>자세히</a>");
      mav.setViewName("redirect:/admin/board/read.do?adminboardno="+ adminboardno);
    }else{
      //String referer = request.getHeader("Referer");
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 게시글 작성에 실패하였습니다. 다시 시도해 주세요.");
      mav.setViewName("/admin/adminboard/create"); // /webapp/member/create.jsp
    }
    return mav;
  }
  
  @RequestMapping(value="/admin/board/read.do", method=RequestMethod.GET)
  public ModelAndView read(int adminboardno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/adminboard/read");
    /*
    ArrayList<CatgroupVO> groups = catgroupProc.list();
    mav.addObject("groups", groups);
    */
    AdminboardInclVO adminboardInclVO = adminboardProc.read_incl(adminboardno);
    mav.addObject("board", adminboardInclVO);
    

    ArrayList<FileVO> file_list = adminboardProc.getFiles(adminboardInclVO);
    mav.addObject("file_list", file_list);
    if(file_list.size() > 0){
      mav.addObject("file_sizes", file_list.size());
    }
    
    return mav;
    
  }

  @RequestMapping(value = "/admin/board/update.do", method = RequestMethod.GET)
  public ModelAndView update_board_page(int adminboardno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/adminboard/update");
    AdminboardInclVO adminboardInclVO = adminboardProc.read_incl(adminboardno);
    mav.addObject("board", adminboardInclVO);
   return mav;
    
  }
  

  @RequestMapping(value = "/admin/board/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int adminboardno,
                                         AdminboardVO adminboardVO,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/wakabastorage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = adminboardVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0; // 하나의 파일 사이즈
 
    int count = filesMF.size(); // 업로드된 파일 갯수
 
    // 기존의 등록 정보 조회
    AdminboardVO adminboardVO_old = adminboardProc.read(adminboardVO.getAdminboardno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
 
      // 원본 파일 삭제
      String files_old = adminboardVO_old.getFiles();
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
 
          // 1개 이상의 다중 파일 처리
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
 
    } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
      files = adminboardVO_old.getFiles();
      sizes = adminboardVO_old.getSizes();
    }
    adminboardVO.setFiles(files);
    adminboardVO.setSizes(sizes);
 
    count = adminboardProc.update(adminboardVO);  // DBMS 수정
 
    // mav.setViewName("redirect:/adminboard/update_msg.jsp?count=" + count + "&...);
    
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
 

    redirectAttributes.addAttribute("count", count);
    redirectAttributes.addAttribute("nowPage", nowPage);

    String name = adminProc.select_admin(adminboardVO.getAdminno()).getName();
    if(count == 1){
      redirectAttributes.addAttribute("result",1);
      redirectAttributes.addAttribute("name", name);
      redirectAttributes.addAttribute("richer_topbar_title", adminboardVO.getTitle());
      mav.addObject("richer_topbar_title", adminboardVO.getTitle());
      adminlogProc.record_log(request, ADMINLOG.ADMIN, adminboardVO.getAdminno(),
          name+"(이)가 "+adminboardVO.getTitle()+" 게시글을 수정함. <a class='alert-link' href='../board/read.do?adminboardno="+ adminboardno+"'>자세히</a>");
      mav.setViewName("redirect:/admin/board/read.do?adminboardno="+ adminboardno);
    }else{
      mav.addObject("result",1);
      //String referer = request.getHeader("Referer");
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 게시글 수정에 실패하였습니다. 다시 시도해 주세요.");
      mav.setViewName("/admin/adminboard/update");
      AdminboardInclVO adminboardInclVO = adminboardProc.read_incl(adminboardno);
      mav.addObject("board", adminboardInclVO);
    }
    return mav;
 
  }
  

  @ResponseBody
  @RequestMapping(value="/admin/board/adminboard.scan", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String read_json(int adminboardno) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    AdminboardVO alog = adminboardProc.read(adminboardno);
    JSONObject json = new JSONObject(alog);
    
    return json.toString();
  }
  

  @RequestMapping(value = "/admin/board/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int adminboardno) {
    //ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/admin/wakabastorage");

    // 기존의 등록 정보 조회
    AdminboardVO adminboardVO_old = adminboardProc.read(adminboardno);
 
    // 원본 파일 삭제
    String files_old = adminboardVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
 
    int count = adminboardProc.delete(adminboardno);

    ModelAndView mav = getList();
    
    return mav;
 
  }


  /**
   * 댓글(미구현)
   * @param adminboardno
   * @return
   */
  @ResponseBody
  @RequestMapping(value="/admin/board/reply.do", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String reply_list(int adminboardno) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    ArrayList<CommentsInclVO> comments = commentsProc.comments(adminboardno);
    JSONObject json = new JSONObject(comments);
    System.out.println(json.toString());
    
    return json.toString();
  }
    
  
  
  
  

}

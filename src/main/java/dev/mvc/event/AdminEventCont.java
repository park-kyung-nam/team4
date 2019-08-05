package dev.mvc.event;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.StringTokenizer;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;
import nation.web.tool.FileVO;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.notice.Notice;
import dev.mvc.notice.NoticeVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import dev.mvc.review.ReviewVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class AdminEventCont {
  @Autowired
  @Qualifier("dev.mvc.event.EventProc")
  private EventProcInter eventProc;
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc;

public AdminEventCont() {
  System.out.println("--> EventCont created");
}

   //등록 폼 http://localhost:9090/team4/event/create.do
  @RequestMapping(value = "/admin/event/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView(); 
    
    ArrayList<ProductVO> productlist = productProc.list_all_prodcate();
    mav.addObject("productlist", productlist);
    
    mav.setViewName("/admin/event/create"); // /webapp/event/create.jsp
    
    return mav;
  }

 // http://localhost:9090/team4/event/create.do
 @RequestMapping(value="/admin/event/create.do", method=RequestMethod.POST)
 public ModelAndView create( HttpServletRequest request,
                                          EventVO eventVO) {
   // System.out.println("create called.");
   ModelAndView mav = new ModelAndView();
  
// -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/admin/event/storage");
   // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
   List<MultipartFile> filesMF = eventVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String e_file1 = "";        // DBMS 컬럼에 저장할 파일명
   String e_file1_item = ""; // 하나의 파일명
   String e_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
   long e_size1_item = 0;   // 하나의 파일 사이즈
   String e_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
   String e_thumb1_item = ""; // 하나의 Thumb 파일명

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
         e_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
         e_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

         if (Tool.isImage(e_file1_item)) { // 이미지인지 검사
           e_thumb1_item = Tool.preview(upDir, e_file1_item, 120, 80); // Thumb 이미지 생성
         }

         // 1개 이상의 다중 파일 처리
         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           e_file1 = e_file1 + "/" + e_file1_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           e_size1 = e_size1 + "/" + e_size1_item;
           // 미니 이미지를 조합하여 하나의 컬럼에 저장
           e_thumb1 = e_thumb1 + "/" + e_thumb1_item;
           
         // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
         } else if (multipartFile.getSize() > 0) { 
           e_file1 = e_file1_item; // file1.jpg
           e_size1 = "" + e_size1_item; // 123456
           e_thumb1 = e_thumb1_item; // file1_t.jpg
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   eventVO.setE_file1(e_file1);
   eventVO.setE_size1(e_size1);
   eventVO.setE_thumb1(e_thumb1);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------

   
   count = eventProc.create(eventVO);
   mav.setViewName("redirect:/admin/event/create_msg.jsp?count=" + count);
   
   return mav;
 }  
  
//http://localhost:9090/ojt/notice/list.do
@RequestMapping(value="/admin/event/list.do", method=RequestMethod.GET)
public ModelAndView list() {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/admin/event/list");
  
  ArrayList<EventVO> list = eventProc.list();
  mav.addObject("list", list);
  
  return mav;
}  
/**
 * 조회
 * 
 * @param eventno
 * @return
 */
@RequestMapping(value = "/admin/event/read.do", method = RequestMethod.GET)
public ModelAndView read(int eventno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/admin/event/read"); // /webapp/contents/read.jsp

  EventVO eventVO = eventProc.read(eventno);
  mav.addObject("eventVO", eventVO);
  
  ArrayList<FileVO> file_list = eventProc.getE_thumb1(eventVO);
  mav.addObject("file_list", file_list);

  return mav;
}
//http://localhost:9090/ojt/event/update.do?eventno=1
@RequestMapping(value="/admin/event/update.do", 
                         method=RequestMethod.GET)
public ModelAndView update(int eventno) {
 ModelAndView mav = new ModelAndView();
 
 EventVO eventVO = eventProc.read(eventno);
 mav.addObject("eventVO", eventVO);

 ArrayList<ProductVO> productlist = productProc.list_all_prodcate();
 mav.addObject("productlist", productlist);
 
 ArrayList<FileVO>file_list = eventProc.getE_thumb1(eventVO);
 mav.addObject("file_list", file_list);
 
 mav.setViewName("/admin/event/update"); 
 
 
 return mav;
}

// noticeVO는 Form 태그의 값으로 자동 저장됨.
// http://localhost:9090/ojt/event/update.do
@RequestMapping(value="/admin/event/update.do", 
                         method=RequestMethod.POST)
public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         EventVO eventVO ) {
 ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
 // 파일 전송 코드 시작
 // -------------------------------------------------------------------
 String upDir = Tool.getRealPath(request, "/admin/event/storage");
 // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
 List<MultipartFile> filesMF = eventVO.getFilesMF(); 

 // System.out.println("--> filesMF.get(0).getSize(): " +
 // filesMF.get(0).getSize());

 String e_file1 = "";        // DBMS 컬럼에 저장할 파일명
 String e_file1_item = ""; // 하나의 파일명
 String e_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
 long e_size1_item = 0;   // 하나의 파일 사이즈
 String e_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
 String e_thumb1_item = ""; // 하나의 Thumb 파일명

 int count = filesMF.size(); // 업로드된 파일 갯수
 
//기존의 등록 정보 조회
 EventVO eventVO_old = eventProc.read(eventVO.getEventno());

 if(filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
   // thumbs 파일 삭제
   String E_thumb1_old = eventVO_old.getE_thumb1();
   StringTokenizer E_thumb1_st = new StringTokenizer(E_thumb1_old,  "/");
   while (E_thumb1_st.hasMoreTokens()) {
     String fname = upDir + E_thumb1_st.nextToken();
     Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
   }
 // 원본 파일 삭제
 String E_file_old = eventVO_old.getE_file1();
 StringTokenizer E_file_st = new StringTokenizer(E_file_old, "/");
 while(E_file_st.hasMoreTokens()) {
   String fname = upDir + E_file_st.nextToken();
   Tool.deleteFile(fname); // 기존에 등록된 원본 파일 삭제
 }
 // --------------------------------------------
 // 새로운 파일의 등록 시작
 // --------------------------------------------

 //if (count > 0) { // 전송 파일이 존재한다면
   // for (MultipartFile multipartFile: filesMF) {
   for (int i = 0; i < count; i++) {
     MultipartFile multipartFile = filesMF.get(i); // 0: 첫번째 파일, 1:두번째 파일 ~
      //System.out.println("multipartFile.getName(): " + multipartFile.getName());

     if (multipartFile.getSize() > 0) { // 전송파일이 있는지 체크
       // System.out.println("전송 파일이 있습니다.");
       e_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
       e_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

       if (Tool.isImage(e_file1_item)) { // 이미지인지 검사
         e_thumb1_item = Tool.preview(upDir, e_file1_item, 120, 80); // Thumb 이미지 생성
       }

       // 1개 이상의 다중 파일 처리
       if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
         // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
         e_file1 = e_file1 + "/" + e_file1_item;
         // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
         e_size1 = e_size1 + "/" + e_size1_item;
         // 미니 이미지를 조합하여 하나의 컬럼에 저장
         e_thumb1 = e_thumb1 + "/" + e_thumb1_item;
         
       // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
       } else if (multipartFile.getSize() > 0) { 
         e_file1 = e_file1_item; // file1.jpg
         e_size1 = "" + e_size1_item; // 123456
         e_thumb1 = e_thumb1_item; // file1_t.jpg
       }
     } // if (multipartFile.getSize() > 0) {  END
   } // END for
   // --------------------------------------------
   // 새로운 파일의 등록 종료
   // --------------------------------------------
 } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
   e_file1 = eventVO_old.getE_file1();
   e_size1 = eventVO_old.getE_size1();
   e_thumb1 = eventVO_old.getE_thumb1();
 }
 eventVO.setE_file1(e_file1);
 eventVO.setE_size1(e_size1);
 eventVO.setE_thumb1(e_thumb1);
 
 //eventVO.setAdminno(1);
 
 count = eventProc.update(eventVO); // DBMS 수정
 // mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);
 
 redirectAttributes.addAttribute("count", count); // redirect parameter 적용

 // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
 redirectAttributes.addAttribute("eventno", eventVO.getEventno());
 redirectAttributes.addAttribute("e_title", eventVO.getE_title());
 //redirectAttributes.addAttribute("nowPage", nowPage);

 mav.setViewName("redirect:/admin/event/update_msg.jsp");
 

 return mav;
}  

// http://localhost:9090/ojt/event/delete.do?noticeno=1
@RequestMapping(value="/admin/event/delete.do", method=RequestMethod.GET)
public ModelAndView delete(int eventno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/admin/event/delete"); // /webapp/event/delete.jsp
  
  EventVO eventVO = eventProc.read(eventno);
  mav.addObject("eventVO", eventVO);
  
  return mav;
}

// cateVO는 Form 태그의 값으로 자동 저장됨.
// http://localhost:9090/ojt/event/delete.do
@RequestMapping(value="/admin/event/delete.do", method=RequestMethod.POST)
public ModelAndView delete_proc(RedirectAttributes redirectAttributes, 
                                                HttpServletRequest request, 
                                                int eventno,
                                                @RequestParam(value="word", defaultValue="") String word,
                                                @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
  ModelAndView mav = new ModelAndView();
 
  String upDir = Tool.getRealPath(request, "/admin/event/storage");
  
  // 기존의 등록 정보 조회
  EventVO eventVO_old = eventProc.read(eventno);
 
  String thumbs_old = eventVO_old.getE_thumb1();
  StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
  while (thumbs_st.hasMoreTokens()) {
    String fname = upDir + thumbs_st.nextToken();
    Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
  }
  
  // 원본 파일의 삭제
  String files_old = eventVO_old.getE_file1();
  StringTokenizer files_st = new StringTokenizer(files_old, "/");
  while (files_st.hasMoreTokens()) {
    String fname = upDir + files_st.nextToken();
    Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
  }
  int count = eventProc.delete(eventno);
  
//-------------------------------------------------------------------------------------
  // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
  HashMap<String, Object> map = new HashMap();
  map.put("eventno", eventno);
  map.put("word", word);
  if(eventProc.search_count(map) % Notice.RECORD_PER_PAGE == 0) {
    nowPage = nowPage - 1;
    if (nowPage < 1) {
       nowPage = 1;
    }
  }

  redirectAttributes.addAttribute("count", count);
  redirectAttributes.addAttribute("e_title", eventVO_old.getE_title());
  redirectAttributes.addAttribute("nowPage", nowPage);
  
  //mav.setViewName("redirect:/admin/event/delete_msg.jsp?count=" + count+"&title=" + title );
  mav.setViewName("redirect:/admin/event/delete_msg.jsp");
 
  return mav;
}  

/**
 * 목록 + 검색 + 페이징 지원
 * http://localhost:9090/ojt/contents/list_by_search_paging.do
 * @param noticeno
 * @param word
 * @param nowPage
 * @return
 */
@RequestMapping(value = "/admin/event/list_by_search_paging.do", 
                                     method = RequestMethod.GET)
public ModelAndView list_by_search_paging(
    //@RequestParam(value="noticeno", defaultValue="1") int noticeno,
    @RequestParam(value="word", defaultValue="") String word,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage
    ) { 
  // System.out.println("--> list_by_category() GET called.");
  System.out.println("--> nowPage: " + nowPage);
  
  ModelAndView mav = new ModelAndView();
  
  // 검색 기능 추가,  /webapp/contents/list_by_category_search_paging.jsp
  mav.setViewName("/admin/event/list_by_search_paging");   
  
  // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
  HashMap<String, Object> map = new HashMap<String, Object>();
 // map.put("noticeno", noticeno); // #{noticeno}
  map.put("word", word);     // #{word}
  map.put("nowPage", nowPage);       
  
  // 검색 목록
  List<EventVO> list = eventProc.list_by_search_paging(map);
  mav.addObject("list", list);
  
  // 검색된 레코드 갯수
  int search_count = eventProc.search_count(map);
  mav.addObject("search_count", search_count);

  //NoticeVO NoticeVO = noticeProc.read(noticeno);
  //mav.addObject("NoticeVO", NoticeVO);
  
  // mav.addObject("word", word);

  /*
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   * 
   * @param listFile 목록 파일명 
   * @param categoryno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  String paging = eventProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
  mav.addObject("paging", paging);

  mav.addObject("nowPage", nowPage);
  
  return mav;
}    
/**
 * 답변 폼 http://localhost:9090/team4/event/reply.do?eventno=1
 * 
 * @return
 */
@RequestMapping(value = "/admin/event/reply.do", method = RequestMethod.GET)
public ModelAndView reply(int eventno) {
  ModelAndView mav = new ModelAndView();
  
  System.out.println("답변 대상: " + eventno);
  
  mav.setViewName("/admin/event/reply"); // /webapp/contents/reply.jsp

  return mav;
}

/**
 * 답변 처리
 * 
 * 파일 태그의 연결
 * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
 * ↓
 * private List<MultipartFile> filesMF;
 * 
 * @param request
 * @param eventVO
 * @return
 */
@RequestMapping(value = "/admin/event/reply.do", method = RequestMethod.POST)
public ModelAndView reply(HttpServletRequest request, 
                                      EventVO eventVO,
                                      @RequestParam(value="word", defaultValue="") String word,
                                      @RequestParam(value="nowPage", defaultValue="1") int nowPage                                        
                                      ) {
 //System.out.println("--> create() POST executed");
  ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// 파일 전송 코드 시작
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/admin/event/storage");
// Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
List<MultipartFile> filesMF = eventVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String r_file1 = "";        // DBMS 컬럼에 저장할 파일명
String r_file1_item = ""; // 하나의 파일명
String r_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
long r_size1_item = 0;   // 하나의 파일 사이즈
String r_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
String r_thumb1_item = ""; // 하나의 Thumb 파일명

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
      r_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
      r_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

      if (Tool.isImage(r_file1_item)) { // 이미지인지 검사
        r_thumb1_item = Tool.preview(upDir, r_file1_item, 120, 80); // Thumb 이미지 생성
      }

      // 1개 이상의 다중 파일 처리
      if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
        // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
        r_file1 = r_file1 + "/" + r_file1_item;
        // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
        r_size1 = r_size1 + "/" + r_size1_item;
        // 미니 이미지를 조합하여 하나의 컬럼에 저장
        r_thumb1 = r_thumb1 + "/" + r_thumb1_item;
        
      // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
      } else if (multipartFile.getSize() > 0) { 
        r_file1 = r_file1_item; // file1.jpg
        r_size1 = "" + r_size1_item; // 123456
        r_thumb1 = r_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
}
eventVO.setE_file1(r_file1);
eventVO.setE_size1(r_size1);
eventVO.setE_thumb1(r_thumb1);
// -------------------------------------------------------------------
// 파일 전송 코드 종료
// -------------------------------------------------------------------

//ReviewVO reviewVO = reviewProc.read(reviewVO.getReviewno());

HashMap<String, Object> map = new HashMap<String, Object>();
map.put("ansnum", eventVO.getAnsnum());
eventProc.increaseAnsnum(map); // 현재 등록된 답변 뒤로 +1 처리함.

eventVO.setIndent(eventVO.getIndent() + 1);
eventVO.setAnsnum(eventVO.getAnsnum() + 1);

count = eventProc.reply(eventVO); 

mav.setViewName("redirect:/admin/event/reply_msg.jsp?count=" + count + "&nowPage=" + nowPage);


return mav;

 }  

}

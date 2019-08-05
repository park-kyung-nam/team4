package dev.mvc.used;

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

import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class UsedCont {
  @Autowired
  @Qualifier("dev.mvc.used.UsedProc")
  private UsedProcInter usedProc;

public UsedCont() {
  System.out.println("--> UsedCont created");
}

   //등록 폼 http://localhost:9090/team4/review/create.do
  @RequestMapping(value = "/used/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView(); 

    mav.setViewName("/used/create");
    
    return mav;
  }  

 // http://localhost:9090/team4/review/create.do
 @RequestMapping(value="/used/create.do", method=RequestMethod.POST)
 public ModelAndView create(HttpServletRequest request,
                                          UsedVO usedVO) {
   // System.out.println("create called.");
   ModelAndView mav = new ModelAndView();
  
   // -------------------------------------------------------------------
   // 파일 전송 코드 시작
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/used/storage");
   // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
   List<MultipartFile> filesMF = usedVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String u_file1 = "";        // DBMS 컬럼에 저장할 파일명
   String u_file1_item = ""; // 하나의 파일명
   String u_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
    long u_size1_item = 0;   // 하나의 파일 사이즈
   String u_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
   String u_thumb1_item = ""; // 하나의 Thumb 파일명

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
         u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
         u_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

         if (Tool.isImage(u_file1_item)) { // 이미지인지 검사
           u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb 이미지 생성
         }

         // 1개 이상의 다중 파일 처리
         if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
           // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
           u_file1 = u_file1 + "/" + u_file1_item;
           // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
           u_size1 = u_size1 + "/" + u_size1_item;
           // 미니 이미지를 조합하여 하나의 컬럼에 저장
           u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
           
         // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
         } else if (multipartFile.getSize() > 0) { 
           u_file1 = u_file1_item; // file1.jpg
           u_size1 = "" + u_size1_item; // 123456
           u_thumb1 = u_thumb1_item; // file1_t.jpg
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   usedVO.setU_file1(u_file1);
   usedVO.setU_size1(u_size1);
   usedVO.setU_thumb1(u_thumb1);
   // -------------------------------------------------------------------
   // 파일 전송 코드 종료
   // -------------------------------------------------------------------

   
   count = usedProc.create(usedVO);
   mav.setViewName("redirect:/used/create_msg.jsp?count=" + count);
   
   return mav;
 }  
  
//http://localhost:9090/ojt/used/list.do
@RequestMapping(value="/used/list.do", method=RequestMethod.GET)
public ModelAndView list() {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/used/list");
  
  ArrayList<UsedVO> list = usedProc.list();
  mav.addObject("list", list);
  
  return mav;
}  
/**
 * 조회
 * 
 * @param reviewno
 * @return
 */
@RequestMapping(value = "/used/read.do", method = RequestMethod.GET)
public ModelAndView read(int usedno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/used/read"); // /webapp/contents/read.jsp

  UsedVO usedVO = usedProc.read(usedno);
  mav.addObject("usedVO", usedVO);
  
  ArrayList<FileVO> file_list = usedProc.getU_thumb1(usedVO);
  mav.addObject("file_list", file_list);

  return mav;
}
//ZIP 압축 후 파일 다운로드 
@RequestMapping(value = "/used/download.do", method = RequestMethod.GET)
public ModelAndView download(HttpServletRequest request, int usedno) {
  ModelAndView mav = new ModelAndView();

  UsedVO usedVO = usedProc.read(usedno);
  
  String u_file1 = usedVO.getU_file1();
  String[] u_file1_array = u_file1.split("/");
  
  String dir = "/used/storage";
  String upDir = Tool.getRealPath(request, dir); // 절대 경로 산출
  
  // 다운로드되는 파일, 파일명을 지정하거나 날짜 조합
  String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
  String zip_filename = upDir + zip; // 압축파일이 생성될 폴더 지정
  
  String[] zip_src = new String[u_file1_array.length]; // 파일 갯수만큼 배열 선언
  
  for (int i=0; i < u_file1_array.length; i++) {
    zip_src[i] = upDir + "/" + u_file1_array[i]; // 절대 경로가 조합된 파일 저장      
  }

  byte[] buffer = new byte[4096]; // 4 KB
  
  try {
    ZipOutputStream zipOutputStream = new ZipOutputStream(new FileOutputStream(zip_filename));
    
    for(int index=0; index < zip_src.length; index++) {
      FileInputStream in = new FileInputStream(zip_src[index]);
      
      Path path = Paths.get(zip_src[index]);
      String zip_src_file = path.getFileName().toString();
      // System.out.println("zip_src_file: " + zip_src_file);
      
      ZipEntry zipEntry = new ZipEntry(zip_src_file);
      zipOutputStream.putNextEntry(zipEntry);
      
      int length = 0;
      // 4 KB씩 읽어서 buffer 배열에 저장후 읽은 바이트수를 length에 저장
      while((length = in.read(buffer)) > 0) {
        zipOutputStream.write(buffer, 0, length); // 기록할 내용, 내용에서의 시작 위치, 기록할 길이
        
      }
      zipOutputStream.closeEntry();
      in.close();
    }
    zipOutputStream.close();
    
    File file = new File(zip_filename);
    
    if (file.exists() && file.length() > 0) {
      System.out.println(zip_filename + " 압축 파일 생성.");
    }
    
//    if (file.delete() == true) {
//      System.out.println(zip_filename + " 파일을 삭제했습니다.");
//    }

  } catch (FileNotFoundException e) {
    e.printStackTrace();
  } catch (IOException e) {
    e.printStackTrace();
  }

  // download 서블릿 연결
  mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
  
  return mav;
}

/**
 * 수정
 * 
 * @param usedno
 * @return
 */
//http://localhost:9090/ojt/review/update.do?reviewno=1
@RequestMapping(value="/used/update.do", 
                         method=RequestMethod.GET)
public ModelAndView update(int usedno) {
 ModelAndView mav = new ModelAndView();
 
 UsedVO usedVO = usedProc.read(usedno);
 mav.addObject("usedVO", usedVO);
 
 ArrayList<FileVO>file_list = usedProc.getU_thumb1(usedVO);
 mav.addObject("file_list", file_list);
 
 mav.setViewName("/used/update"); 
 
 return mav;
}

// reviewVO는 Form 태그의 값으로 자동 저장됨.
// http://localhost:9090/ojt/used/update.do
@RequestMapping(value="/used/update.do", 
                         method=RequestMethod.POST)
public ModelAndView update(RedirectAttributes redirectAttributes, 
                                          HttpServletRequest request, 
                                          UsedVO usedVO) {
 ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// 파일 전송 코드 시작
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/used/storage");
// Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
List<MultipartFile> filesMF = usedVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String u_file1 = "";        // DBMS 컬럼에 저장할 파일명
String u_file1_item = ""; // 하나의 파일명
String u_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
long u_size1_item = 0;   // 하나의 파일 사이즈
String u_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
String u_thumb1_item = ""; // 하나의 Thumb 파일명

int count = filesMF.size(); // 업로드된 파일 갯수

//기존의 등록 정보 조회
UsedVO usedVO_old = usedProc.read(usedVO.getUsedno());

if(filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
  // thumbs 파일 삭제
  String U_thumb1_old = usedVO_old.getU_thumb1();
  StringTokenizer U_thumb1_st = new StringTokenizer(U_thumb1_old,  "/");
  while (U_thumb1_st.hasMoreTokens()) {
    String fname = upDir + U_thumb1_st.nextToken();
    Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
  }
// 원본 파일 삭제
String U_file_old = usedVO_old.getU_file1();
StringTokenizer U_file_st = new StringTokenizer(U_file_old, "/");
while(U_file_st.hasMoreTokens()) {
  String fname = upDir + U_file_st.nextToken();
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
      u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
      u_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

      if (Tool.isImage(u_file1_item)) { // 이미지인지 검사
        u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb 이미지 생성
      }

      // 1개 이상의 다중 파일 처리
      if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
        // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
        u_file1 = u_file1 + "/" + u_file1_item;
        // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
        u_size1 = u_size1 + "/" + u_size1_item;
        // 미니 이미지를 조합하여 하나의 컬럼에 저장
        u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
        
      // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
      } else if (multipartFile.getSize() > 0) { 
        u_file1 = u_file1_item; // file1.jpg
        u_size1 = "" + u_size1_item; // 123456
        u_thumb1 = u_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
  // --------------------------------------------
  // 새로운 파일의 등록 종료
  // --------------------------------------------
} else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
  u_file1 = usedVO_old.getU_file1();
  u_size1 = usedVO_old.getU_size1();
  u_thumb1 = usedVO_old.getU_thumb1();
}
usedVO.setU_file1(u_file1);
usedVO.setU_size1(u_size1);
usedVO.setU_thumb1(u_thumb1);

count = usedProc.update(usedVO); // DBMS 수정
// mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);

redirectAttributes.addAttribute("count", count); // redirect parameter 적용

// redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
redirectAttributes.addAttribute("usedno", usedVO.getUsedno());
redirectAttributes.addAttribute("u_title", usedVO.getU_title());
redirectAttributes.addAttribute("u_content", usedVO.getU_content());
//redirectAttributes.addAttribute("nowPage", nowPage);

mav.setViewName("redirect:/used/update_msg.jsp");


return mav;

}  

// http://localhost:9090/ojt/review/delete.do?reviewno=1
@RequestMapping(value="/used/delete.do", method=RequestMethod.GET)
public ModelAndView delete(int usedno) {
  ModelAndView mav = new ModelAndView();
 
  UsedVO usedVO = usedProc.read(usedno);
  mav.addObject("usedVO", usedVO);
  
  mav.setViewName("/used/delete"); // /webapp/review/delete.jsp
  
  
  return mav;
}

// cateVO는 Form 태그의 값으로 자동 저장됨.
// http://localhost:9090/ojt/review/delete.do
@RequestMapping(value="/used/delete.do", 
                          method=RequestMethod.POST)
public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                                HttpServletRequest request, 
                                                int usedno, 
                                                @RequestParam(value="word", defaultValue="") String word,
                                                @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
  ModelAndView mav = new ModelAndView();
 
  String upDir = Tool.getRealPath(request, "/used/storage");

  //기존의 등록 정보 조회
  UsedVO usedVO_old = usedProc.read(usedno);
  
  String thumbs_old = usedVO_old.getU_thumb1();
  StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
  while (thumbs_st.hasMoreTokens()) {
    String fname = upDir + thumbs_st.nextToken();
    Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
  }
  
  // 원본 파일 삭제
  String files_old = usedVO_old.getU_file1();
  StringTokenizer files_st = new StringTokenizer(files_old, "/");
  while (files_st.hasMoreTokens()) {
    String fname = upDir + files_st.nextToken();
    Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
  }
 
  int count = usedProc.delete(usedno);
  
//-------------------------------------------------------------------------------------
  // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
  HashMap<String, Object> map = new HashMap();
  map.put("usedno", usedno);
  map.put("word", word);
  if(usedProc.search_count(map) % Used.RECORD_PER_PAGE == 0) {
    nowPage = nowPage - 1;
    if (nowPage < 1) {
       nowPage = 1;
    }
  }
  
  redirectAttributes.addAttribute("count", count);
  redirectAttributes.addAttribute("u_title", usedVO_old.getU_title());
  redirectAttributes.addAttribute("nowPage", nowPage);
  
  //mav.setViewName("redirect:/review/delete_msg.jsp?count=" + count+"&title=" + title );
  mav.setViewName("redirect:/used/delete_msg.jsp");
 
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
@RequestMapping(value = "/used/list_by_search_paging.do", 
                                     method = RequestMethod.GET)
public ModelAndView list_by_search_paging(
    //@RequestParam(value="usedno", defaultValue="1") int usedno,
    @RequestParam(value="word", defaultValue="") String word,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage
    ) { 
  System.out.println("--> nowPage: " + nowPage);
  
  ModelAndView mav = new ModelAndView();
  
  mav.setViewName("/used/list_by_search_paging");   
  
  // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
  HashMap<String, Object> map = new HashMap<String, Object>();
 // map.put("usedno", usedno); // #{usedno}
  map.put("word", word);     // #{word}
  map.put("nowPage", nowPage);       
  
  // 검색 목록
  List<UsedVO> list = usedProc.list_by_search_paging(map);
  mav.addObject("list", list);
  
  // 검색된 레코드 갯수
  int search_count = usedProc.search_count(map);
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
  String paging = usedProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
  mav.addObject("paging", paging);

  mav.addObject("nowPage", nowPage);
  
  return mav;
}    

/**
 * 답변 폼 http://localhost:9090/team4/review/reply.do?reviewno=1
 * 
 * @return
 */
@RequestMapping(value = "/used/reply.do", method = RequestMethod.GET)
public ModelAndView reply(int usedno) {
  ModelAndView mav = new ModelAndView();
  
  System.out.println("답변 대상: " + usedno);
  
  mav.setViewName("/used/reply"); // /webapp/contents/reply.jsp

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
 * @param reviewVO
 * @return
 */
@RequestMapping(value = "/used/reply.do", method = RequestMethod.POST)
public ModelAndView reply(HttpServletRequest request, 
                                      UsedVO usedVO,
                                      @RequestParam(value="word", defaultValue="") String word,
                                      @RequestParam(value="nowPage", defaultValue="1") int nowPage                                        
                                      ) {
 //System.out.println("--> create() POST executed");
  ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// 파일 전송 코드 시작
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/used/storage");
// Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
List<MultipartFile> filesMF = usedVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String u_file1 = "";        // DBMS 컬럼에 저장할 파일명
String u_file1_item = ""; // 하나의 파일명
String u_size1 = "";       // DBMS 컬럼에 저장할 파일 크기
long u_size1_item = 0;   // 하나의 파일 사이즈
String u_thumb1 = "";    // DBMS 컬럼에 저장할 Thumb 파일들
String u_thumb1_item = ""; // 하나의 Thumb 파일명

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
      u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // 서버에 파일 저장
      u_size1_item = multipartFile.getSize(); // 서버에 저장된 파일 크기

      if (Tool.isImage(u_file1_item)) { // 이미지인지 검사
        u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb 이미지 생성
      }

      // 1개 이상의 다중 파일 처리
      if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
        // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
        u_file1 = u_file1 + "/" + u_file1_item;
        // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
        u_size1 = u_size1 + "/" + u_size1_item;
        // 미니 이미지를 조합하여 하나의 컬럼에 저장
        u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
        
      // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
      } else if (multipartFile.getSize() > 0) { 
        u_file1 = u_file1_item; // file1.jpg
        u_size1 = "" + u_size1_item; // 123456
        u_thumb1 = u_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
}
usedVO.setU_file1(u_file1);
usedVO.setU_size1(u_size1);
usedVO.setU_thumb1(u_thumb1);
// -------------------------------------------------------------------
// 파일 전송 코드 종료
// -------------------------------------------------------------------

usedVO.setCustomerno(1);

UsedVO parentVO = usedProc.read(usedVO.getUsedno());

HashMap<String, Object> map = new HashMap<String, Object>();
map.put("grpno", parentVO.getGrpno());
map.put("ansnum", parentVO.getAnsnum());
usedProc.increaseAnsnum(map); // 현재 등록된 답변 뒤로 +1 처리함.

usedVO.setGrpno(parentVO.getGrpno());
usedVO.setIndent(parentVO.getIndent() + 1);
usedVO.setAnsnum(parentVO.getAnsnum() + 1);

count = usedProc.reply(usedVO); 

mav.setViewName("redirect:/used/reply_msg.jsp?count=" + count + "&nowPage=" + nowPage);


return mav;

 }  

}
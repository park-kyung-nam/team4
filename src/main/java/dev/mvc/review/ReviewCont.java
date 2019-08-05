package dev.mvc.review;

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

import dev.mvc.event.EventVO;
import nation.web.tool.FileVO;
import dev.mvc.notice.Notice;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class ReviewCont {
  @Autowired
  @Qualifier("dev.mvc.review.ReviewProc")
  private ReviewProcInter reviewProc;

public ReviewCont() {
  System.out.println("--> ReviewCont created");
}

   //��� �� http://localhost:9090/team4/review/create.do
  @RequestMapping(value = "/review/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView(); 

    mav.setViewName("/review/create");
    
    return mav;
  }  

 // http://localhost:9090/team4/review/create.do
 @RequestMapping(value="/review/create.do", method=RequestMethod.POST)
 public ModelAndView create(HttpServletRequest request,
                                          ReviewVO reviewVO) {
   // System.out.println("create called.");
   ModelAndView mav = new ModelAndView();
  
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/review/storage");
   // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
   List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String r_file1 = "";        // DBMS �÷��� ������ ���ϸ�
   String r_file1_item = ""; // �ϳ��� ���ϸ�
   String r_size1 = "";       // DBMS �÷��� ������ ���� ũ��
    long r_size1_item = 0;   // �ϳ��� ���� ������
   String r_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
   String r_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

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
         r_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
         r_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

         if (Tool.isImage(r_file1_item)) { // �̹������� �˻�
           r_thumb1_item = Tool.preview(upDir, r_file1_item, 120, 80); // Thumb �̹��� ����
         }

         // 1�� �̻��� ���� ���� ó��
         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           r_file1 = r_file1 + "/" + r_file1_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           r_size1 = r_size1 + "/" + r_size1_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           r_thumb1 = r_thumb1 + "/" + r_thumb1_item;
           
         // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
         } else if (multipartFile.getSize() > 0) { 
           r_file1 = r_file1_item; // file1.jpg
           r_size1 = "" + r_size1_item; // 123456
           r_thumb1 = r_thumb1_item; // file1_t.jpg
         }
       } // if (multipartFile.getSize() > 0) {  END
     } // END for
   }
   reviewVO.setR_file1(r_file1);
   reviewVO.setR_size1(r_size1);
   reviewVO.setR_thumb1(r_thumb1);
   // -------------------------------------------------------------------
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------

   
   count = reviewProc.create(reviewVO);
   mav.setViewName("redirect:/review/create_msg.jsp?count=" + count);
   
   return mav;
 }  
  
//http://localhost:9090/ojt/review/list.do
@RequestMapping(value="/review/list.do", method=RequestMethod.GET)
public ModelAndView list() {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/review/list");
  
  ArrayList<ReviewVO> list = reviewProc.list();
  mav.addObject("list", list);
  
  return mav;
}  
/**
 * ��ȸ
 * 
 * @param reviewno
 * @return
 */
@RequestMapping(value = "/review/read.do", method = RequestMethod.GET)
public ModelAndView read(int reviewno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/review/read"); // /webapp/contents/read.jsp

  ReviewVO reviewVO = reviewProc.read(reviewno);
  mav.addObject("reviewVO", reviewVO);
  
  ArrayList<FileVO> file_list = reviewProc.getR_thumb1(reviewVO);
  mav.addObject("file_list", file_list);

  return mav;
}
//http://localhost:9090/ojt/review/update.do?reviewno=1
@RequestMapping(value="/review/update.do", 
                         method=RequestMethod.GET)
public ModelAndView update(int reviewno) {
 ModelAndView mav = new ModelAndView();
 
 ReviewVO reviewVO = reviewProc.read(reviewno);
 mav.addObject("reviewVO", reviewVO);
 
 ArrayList<FileVO>file_list = reviewProc.getR_thumb1(reviewVO);
 mav.addObject("file_list", file_list);
 
 mav.setViewName("/review/update"); 
 
 return mav;
}

// reviewVO�� Form �±��� ������ �ڵ� �����.
// http://localhost:9090/ojt/review/update.do
@RequestMapping(value="/review/update.do", 
                         method=RequestMethod.POST)
public ModelAndView update(RedirectAttributes redirectAttributes, 
                                          HttpServletRequest request, 
                                          ReviewVO reviewVO) {
 ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/review/storage");
// Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String r_file1 = "";        // DBMS �÷��� ������ ���ϸ�
String r_file1_item = ""; // �ϳ��� ���ϸ�
String r_size1 = "";       // DBMS �÷��� ������ ���� ũ��
long r_size1_item = 0;   // �ϳ��� ���� ������
String r_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
String r_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

int count = filesMF.size(); // ���ε�� ���� ����

//������ ��� ���� ��ȸ
ReviewVO reviewVO_old = reviewProc.read(reviewVO.getReviewno());

if(filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
  // thumbs ���� ����
  String R_thumb1_old = reviewVO_old.getR_thumb1();
  StringTokenizer R_thumb1_st = new StringTokenizer(R_thumb1_old,  "/");
  while (R_thumb1_st.hasMoreTokens()) {
    String fname = upDir + R_thumb1_st.nextToken();
    Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
  }
// ���� ���� ����
String R_file_old = reviewVO_old.getR_file1();
StringTokenizer R_file_st = new StringTokenizer(R_file_old, "/");
while(R_file_st.hasMoreTokens()) {
  String fname = upDir + R_file_st.nextToken();
  Tool.deleteFile(fname); // ������ ��ϵ� ���� ���� ����
}
// --------------------------------------------
// ���ο� ������ ��� ����
// --------------------------------------------

//if (count > 0) { // ���� ������ �����Ѵٸ�
  // for (MultipartFile multipartFile: filesMF) {
  for (int i = 0; i < count; i++) {
    MultipartFile multipartFile = filesMF.get(i); // 0: ù��° ����, 1:�ι�° ���� ~
     //System.out.println("multipartFile.getName(): " + multipartFile.getName());

    if (multipartFile.getSize() > 0) { // ���������� �ִ��� üũ
      // System.out.println("���� ������ �ֽ��ϴ�.");
      r_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
      r_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

      if (Tool.isImage(r_file1_item)) { // �̹������� �˻�
        r_thumb1_item = Tool.preview(upDir, r_file1_item, 120, 80); // Thumb �̹��� ����
      }

      // 1�� �̻��� ���� ���� ó��
      if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
        // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
        r_file1 = r_file1 + "/" + r_file1_item;
        // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
        r_size1 = r_size1 + "/" + r_size1_item;
        // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
        r_thumb1 = r_thumb1 + "/" + r_thumb1_item;
        
      // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
      } else if (multipartFile.getSize() > 0) { 
        r_file1 = r_file1_item; // file1.jpg
        r_size1 = "" + r_size1_item; // 123456
        r_thumb1 = r_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
  // --------------------------------------------
  // ���ο� ������ ��� ����
  // --------------------------------------------
} else { // �۸� �����ϴ� ���, ������ ���� ���� ����
  r_file1 = reviewVO_old.getR_file1();
  r_size1 = reviewVO_old.getR_size1();
  r_thumb1 = reviewVO_old.getR_thumb1();
}
reviewVO.setR_file1(r_file1);
reviewVO.setR_size1(r_size1);
reviewVO.setR_thumb1(r_thumb1);

//eventVO.setAdminno(1);

count = reviewProc.update(reviewVO); // DBMS ����
// mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);

redirectAttributes.addAttribute("count", count); // redirect parameter ����

// redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
redirectAttributes.addAttribute("reviewno", reviewVO.getReviewno());
redirectAttributes.addAttribute("r_title", reviewVO.getR_title());
redirectAttributes.addAttribute("r_content", reviewVO.getR_content());
//redirectAttributes.addAttribute("nowPage", nowPage);

mav.setViewName("redirect:/review/update_msg.jsp");


return mav;

}  

// http://localhost:9090/ojt/review/delete.do?reviewno=1
@RequestMapping(value="/review/delete.do", method=RequestMethod.GET)
public ModelAndView delete(int reviewno) {
  ModelAndView mav = new ModelAndView();
 
  ReviewVO reviewVO = reviewProc.read(reviewno);
  mav.addObject("reviewVO", reviewVO);
  
  mav.setViewName("/review/delete"); // /webapp/review/delete.jsp
  
  
  return mav;
}

// cateVO�� Form �±��� ������ �ڵ� �����.
// http://localhost:9090/ojt/review/delete.do
@RequestMapping(value="/review/delete.do", 
                          method=RequestMethod.POST)
public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                                HttpServletRequest request, 
                                                int reviewno, 
                                                @RequestParam(value="word", defaultValue="") String word,
                                                @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
  ModelAndView mav = new ModelAndView();
 
  String upDir = Tool.getRealPath(request, "/review/storage");

  //������ ��� ���� ��ȸ
  ReviewVO reviewVO_old = reviewProc.read(reviewno);
  
  String thumbs_old = reviewVO_old.getR_thumb1();
  StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
  while (thumbs_st.hasMoreTokens()) {
    String fname = upDir + thumbs_st.nextToken();
    Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
  }
  
  // ���� ���� ����
  String files_old = reviewVO_old.getR_file1();
  StringTokenizer files_st = new StringTokenizer(files_old, "/");
  while (files_st.hasMoreTokens()) {
    String fname = upDir + files_st.nextToken();
    Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
  }
 
  int count = reviewProc.delete(reviewno);
  
//-------------------------------------------------------------------------------------
  // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
  HashMap<String, Object> map = new HashMap();
  map.put("reviewno", reviewno);
  map.put("word", word);
  if(reviewProc.search_count(map) % Notice.RECORD_PER_PAGE == 0) {
    nowPage = nowPage - 1;
    if (nowPage < 1) {
       nowPage = 1;
    }
  }
  
  redirectAttributes.addAttribute("count", count);
  redirectAttributes.addAttribute("r_title", reviewVO_old.getR_title());
  redirectAttributes.addAttribute("nowPage", nowPage);
  
  //mav.setViewName("redirect:/review/delete_msg.jsp?count=" + count+"&title=" + title );
  mav.setViewName("redirect:/review/delete_msg.jsp");
 
      return mav;

} 
/**
 * ��� + �˻� + ����¡ ����
 * http://localhost:9090/ojt/contents/list_by_search_paging.do
 * @param noticeno
 * @param word
 * @param nowPage
 * @return
 */
@RequestMapping(value = "/review/list_by_search_paging.do", 
                                     method = RequestMethod.GET)
public ModelAndView list_by_search_paging(
    //@RequestParam(value="noticeno", defaultValue="1") int noticeno,
    @RequestParam(value="word", defaultValue="") String word,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage
    ) { 
  // System.out.println("--> list_by_category() GET called.");
  System.out.println("--> nowPage: " + nowPage);
  
  ModelAndView mav = new ModelAndView();
  
  // �˻� ��� �߰�,  /webapp/contents/list_by_category_search_paging.jsp
  mav.setViewName("/review/list_by_search_paging");   
  
  // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
  HashMap<String, Object> map = new HashMap<String, Object>();
 // map.put("noticeno", noticeno); // #{noticeno}
  map.put("word", word);     // #{word}
  map.put("nowPage", nowPage);       
  
  // �˻� ���
  List<ReviewVO> list = reviewProc.list_by_search_paging(map);
  mav.addObject("list", list);
  
  // �˻��� ���ڵ� ����
  int search_count = reviewProc.search_count(map);
  mav.addObject("search_count", search_count);

  //NoticeVO NoticeVO = noticeProc.read(noticeno);
  //mav.addObject("NoticeVO", NoticeVO);
  
  // mav.addObject("word", word);

  /*
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   * 
   * @param listFile ��� ���ϸ� 
   * @param categoryno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  String paging = reviewProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
  mav.addObject("paging", paging);

  mav.addObject("nowPage", nowPage);
  
  return mav;
}    

/**
 * �亯 �� http://localhost:9090/team4/review/reply.do?reviewno=1
 * 
 * @return
 */
@RequestMapping(value = "/review/reply.do", method = RequestMethod.GET)
public ModelAndView reply(int reviewno) {
  ModelAndView mav = new ModelAndView();
  
  System.out.println("�亯 ���: " + reviewno);
  
  mav.setViewName("/review/reply"); // /webapp/contents/reply.jsp

  return mav;
}
/**
 * �亯 ó��
 * 
 * ���� �±��� ����
 * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
 * ��
 * private List<MultipartFile> filesMF;
 * 
 * @param request
 * @param reviewVO
 * @return
 */
@RequestMapping(value = "/review/reply.do", method = RequestMethod.POST)
public ModelAndView reply(HttpServletRequest request, 
                                      ReviewVO reviewVO,
                                      @RequestParam(value="word", defaultValue="") String word,
                                      @RequestParam(value="nowPage", defaultValue="1") int nowPage                                        
                                      ) {
 //System.out.println("--> create() POST executed");
  ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/review/storage");
// Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
List<MultipartFile> filesMF = reviewVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String r_file1 = "";        // DBMS �÷��� ������ ���ϸ�
String r_file1_item = ""; // �ϳ��� ���ϸ�
String r_size1 = "";       // DBMS �÷��� ������ ���� ũ��
long r_size1_item = 0;   // �ϳ��� ���� ������
String r_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
String r_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

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
      r_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
      r_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

      if (Tool.isImage(r_file1_item)) { // �̹������� �˻�
        r_thumb1_item = Tool.preview(upDir, r_file1_item, 120, 80); // Thumb �̹��� ����
      }

      // 1�� �̻��� ���� ���� ó��
      if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
        // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
        r_file1 = r_file1 + "/" + r_file1_item;
        // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
        r_size1 = r_size1 + "/" + r_size1_item;
        // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
        r_thumb1 = r_thumb1 + "/" + r_thumb1_item;
        
      // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
      } else if (multipartFile.getSize() > 0) { 
        r_file1 = r_file1_item; // file1.jpg
        r_size1 = "" + r_size1_item; // 123456
        r_thumb1 = r_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
}
reviewVO.setR_file1(r_file1);
reviewVO.setR_size1(r_size1);
reviewVO.setR_thumb1(r_thumb1);
// -------------------------------------------------------------------
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------


//--------------------------- �亯 ���� �ڵ� ���� --------------------------

ReviewVO parentVO = reviewProc.read(reviewVO.getReviewno());

HashMap<String, Object> map = new HashMap<String, Object>();
map.put("grpno", parentVO.getGrpno());
map.put("ansnum", parentVO.getAnsnum());
reviewProc.increaseAnsnum(map); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

reviewVO.setGrpno(parentVO.getGrpno());  // �׷��ȣ �Ҵ�
reviewVO.setIndent(parentVO.getIndent() + 1); // �亯 ���� ����
reviewVO.setAnsnum(parentVO.getAnsnum() + 1); // �θ� �ٷ� �Ʒ� ���
//--------------------------- �亯 ���� �ڵ� ���� --------------------------

count = reviewProc.reply(reviewVO); 

mav.setViewName("redirect:/review/reply_msg.jsp?count=" + count + "&nowPage=" + nowPage);


return mav;

 }  

}
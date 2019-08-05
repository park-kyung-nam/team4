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

   //��� �� http://localhost:9090/team4/review/create.do
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
   // ���� ���� �ڵ� ����
   // -------------------------------------------------------------------
   String upDir = Tool.getRealPath(request, "/used/storage");
   // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
   List<MultipartFile> filesMF = usedVO.getFilesMF(); 

   // System.out.println("--> filesMF.get(0).getSize(): " +
   // filesMF.get(0).getSize());

   String u_file1 = "";        // DBMS �÷��� ������ ���ϸ�
   String u_file1_item = ""; // �ϳ��� ���ϸ�
   String u_size1 = "";       // DBMS �÷��� ������ ���� ũ��
    long u_size1_item = 0;   // �ϳ��� ���� ������
   String u_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
   String u_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

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
         u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
         u_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

         if (Tool.isImage(u_file1_item)) { // �̹������� �˻�
           u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb �̹��� ����
         }

         // 1�� �̻��� ���� ���� ó��
         if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
           // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
           u_file1 = u_file1 + "/" + u_file1_item;
           // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
           u_size1 = u_size1 + "/" + u_size1_item;
           // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
           u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
           
         // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
   // ���� ���� �ڵ� ����
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
 * ��ȸ
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
//ZIP ���� �� ���� �ٿ�ε� 
@RequestMapping(value = "/used/download.do", method = RequestMethod.GET)
public ModelAndView download(HttpServletRequest request, int usedno) {
  ModelAndView mav = new ModelAndView();

  UsedVO usedVO = usedProc.read(usedno);
  
  String u_file1 = usedVO.getU_file1();
  String[] u_file1_array = u_file1.split("/");
  
  String dir = "/used/storage";
  String upDir = Tool.getRealPath(request, dir); // ���� ��� ����
  
  // �ٿ�ε�Ǵ� ����, ���ϸ��� �����ϰų� ��¥ ����
  String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
  String zip_filename = upDir + zip; // ���������� ������ ���� ����
  
  String[] zip_src = new String[u_file1_array.length]; // ���� ������ŭ �迭 ����
  
  for (int i=0; i < u_file1_array.length; i++) {
    zip_src[i] = upDir + "/" + u_file1_array[i]; // ���� ��ΰ� ���յ� ���� ����      
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
      // 4 KB�� �о buffer �迭�� ������ ���� ����Ʈ���� length�� ����
      while((length = in.read(buffer)) > 0) {
        zipOutputStream.write(buffer, 0, length); // ����� ����, ���뿡���� ���� ��ġ, ����� ����
        
      }
      zipOutputStream.closeEntry();
      in.close();
    }
    zipOutputStream.close();
    
    File file = new File(zip_filename);
    
    if (file.exists() && file.length() > 0) {
      System.out.println(zip_filename + " ���� ���� ����.");
    }
    
//    if (file.delete() == true) {
//      System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//    }

  } catch (FileNotFoundException e) {
    e.printStackTrace();
  } catch (IOException e) {
    e.printStackTrace();
  }

  // download ���� ����
  mav.setViewName("redirect:/download?dir=" + dir + "&filename=" + zip);    
  
  return mav;
}

/**
 * ����
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

// reviewVO�� Form �±��� ������ �ڵ� �����.
// http://localhost:9090/ojt/used/update.do
@RequestMapping(value="/used/update.do", 
                         method=RequestMethod.POST)
public ModelAndView update(RedirectAttributes redirectAttributes, 
                                          HttpServletRequest request, 
                                          UsedVO usedVO) {
 ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/used/storage");
// Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
List<MultipartFile> filesMF = usedVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String u_file1 = "";        // DBMS �÷��� ������ ���ϸ�
String u_file1_item = ""; // �ϳ��� ���ϸ�
String u_size1 = "";       // DBMS �÷��� ������ ���� ũ��
long u_size1_item = 0;   // �ϳ��� ���� ������
String u_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
String u_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

int count = filesMF.size(); // ���ε�� ���� ����

//������ ��� ���� ��ȸ
UsedVO usedVO_old = usedProc.read(usedVO.getUsedno());

if(filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
  // thumbs ���� ����
  String U_thumb1_old = usedVO_old.getU_thumb1();
  StringTokenizer U_thumb1_st = new StringTokenizer(U_thumb1_old,  "/");
  while (U_thumb1_st.hasMoreTokens()) {
    String fname = upDir + U_thumb1_st.nextToken();
    Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
  }
// ���� ���� ����
String U_file_old = usedVO_old.getU_file1();
StringTokenizer U_file_st = new StringTokenizer(U_file_old, "/");
while(U_file_st.hasMoreTokens()) {
  String fname = upDir + U_file_st.nextToken();
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
      u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
      u_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

      if (Tool.isImage(u_file1_item)) { // �̹������� �˻�
        u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb �̹��� ����
      }

      // 1�� �̻��� ���� ���� ó��
      if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
        // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
        u_file1 = u_file1 + "/" + u_file1_item;
        // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
        u_size1 = u_size1 + "/" + u_size1_item;
        // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
        u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
        
      // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
      } else if (multipartFile.getSize() > 0) { 
        u_file1 = u_file1_item; // file1.jpg
        u_size1 = "" + u_size1_item; // 123456
        u_thumb1 = u_thumb1_item; // file1_t.jpg
      }
    } // if (multipartFile.getSize() > 0) {  END
  } // END for
  // --------------------------------------------
  // ���ο� ������ ��� ����
  // --------------------------------------------
} else { // �۸� �����ϴ� ���, ������ ���� ���� ����
  u_file1 = usedVO_old.getU_file1();
  u_size1 = usedVO_old.getU_size1();
  u_thumb1 = usedVO_old.getU_thumb1();
}
usedVO.setU_file1(u_file1);
usedVO.setU_size1(u_size1);
usedVO.setU_thumb1(u_thumb1);

count = usedProc.update(usedVO); // DBMS ����
// mav.setViewName("redirect:/contents/update_msg.jsp?count=" + count + "&...);

redirectAttributes.addAttribute("count", count); // redirect parameter ����

// redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
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

// cateVO�� Form �±��� ������ �ڵ� �����.
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

  //������ ��� ���� ��ȸ
  UsedVO usedVO_old = usedProc.read(usedno);
  
  String thumbs_old = usedVO_old.getU_thumb1();
  StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
  while (thumbs_st.hasMoreTokens()) {
    String fname = upDir + thumbs_st.nextToken();
    Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
  }
  
  // ���� ���� ����
  String files_old = usedVO_old.getU_file1();
  StringTokenizer files_st = new StringTokenizer(files_old, "/");
  while (files_st.hasMoreTokens()) {
    String fname = upDir + files_st.nextToken();
    Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
  }
 
  int count = usedProc.delete(usedno);
  
//-------------------------------------------------------------------------------------
  // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
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
 * ��� + �˻� + ����¡ ����
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
  
  // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
  HashMap<String, Object> map = new HashMap<String, Object>();
 // map.put("usedno", usedno); // #{usedno}
  map.put("word", word);     // #{word}
  map.put("nowPage", nowPage);       
  
  // �˻� ���
  List<UsedVO> list = usedProc.list_by_search_paging(map);
  mav.addObject("list", list);
  
  // �˻��� ���ڵ� ����
  int search_count = usedProc.search_count(map);
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
  String paging = usedProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
  mav.addObject("paging", paging);

  mav.addObject("nowPage", nowPage);
  
  return mav;
}    

/**
 * �亯 �� http://localhost:9090/team4/review/reply.do?reviewno=1
 * 
 * @return
 */
@RequestMapping(value = "/used/reply.do", method = RequestMethod.GET)
public ModelAndView reply(int usedno) {
  ModelAndView mav = new ModelAndView();
  
  System.out.println("�亯 ���: " + usedno);
  
  mav.setViewName("/used/reply"); // /webapp/contents/reply.jsp

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
@RequestMapping(value = "/used/reply.do", method = RequestMethod.POST)
public ModelAndView reply(HttpServletRequest request, 
                                      UsedVO usedVO,
                                      @RequestParam(value="word", defaultValue="") String word,
                                      @RequestParam(value="nowPage", defaultValue="1") int nowPage                                        
                                      ) {
 //System.out.println("--> create() POST executed");
  ModelAndView mav = new ModelAndView();

//-------------------------------------------------------------------
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------
String upDir = Tool.getRealPath(request, "/used/storage");
// Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
List<MultipartFile> filesMF = usedVO.getFilesMF(); 

// System.out.println("--> filesMF.get(0).getSize(): " +
// filesMF.get(0).getSize());

String u_file1 = "";        // DBMS �÷��� ������ ���ϸ�
String u_file1_item = ""; // �ϳ��� ���ϸ�
String u_size1 = "";       // DBMS �÷��� ������ ���� ũ��
long u_size1_item = 0;   // �ϳ��� ���� ������
String u_thumb1 = "";    // DBMS �÷��� ������ Thumb ���ϵ�
String u_thumb1_item = ""; // �ϳ��� Thumb ���ϸ�

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
      u_file1_item = Upload.saveFileSpring(multipartFile, upDir); // ������ ���� ����
      u_size1_item = multipartFile.getSize(); // ������ ����� ���� ũ��

      if (Tool.isImage(u_file1_item)) { // �̹������� �˻�
        u_thumb1_item = Tool.preview(upDir, u_file1_item, 120, 80); // Thumb �̹��� ����
      }

      // 1�� �̻��� ���� ���� ó��
      if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
        // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
        u_file1 = u_file1 + "/" + u_file1_item;
        // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
        u_size1 = u_size1 + "/" + u_size1_item;
        // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
        u_thumb1 = u_thumb1 + "/" + u_thumb1_item;
        
      // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
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
// ���� ���� �ڵ� ����
// -------------------------------------------------------------------

usedVO.setCustomerno(1);

UsedVO parentVO = usedProc.read(usedVO.getUsedno());

HashMap<String, Object> map = new HashMap<String, Object>();
map.put("grpno", parentVO.getGrpno());
map.put("ansnum", parentVO.getAnsnum());
usedProc.increaseAnsnum(map); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

usedVO.setGrpno(parentVO.getGrpno());
usedVO.setIndent(parentVO.getIndent() + 1);
usedVO.setAnsnum(parentVO.getAnsnum() + 1);

count = usedProc.reply(usedVO); 

mav.setViewName("redirect:/used/reply_msg.jsp?count=" + count + "&nowPage=" + nowPage);


return mav;

 }  

}
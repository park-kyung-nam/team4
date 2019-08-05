package dev.mvc.notice;

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

import nation.web.tool.Tool;

@Controller
public class NoticeCont {
  @Autowired
  @Qualifier("dev.mvc.notice.NoticeProc")
  private NoticeProcInter noticeProc;

public NoticeCont() {
  System.out.println("--> NoticeCont created");
}

   //��� �� http://localhost:9090/team4/notice/create.do
  @RequestMapping(value = "/notice/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView(); 
 
    mav.setViewName("/notice/create"); // /webapp/notice/create.jsp
    
    return mav;
  }

 // http://localhost:9090/team4/notice/create.do
 @RequestMapping(value="/notice/create.do", method=RequestMethod.POST)
 public ModelAndView create(NoticeVO noticeVO) {
   // System.out.println("create called.");
   ModelAndView mav = new ModelAndView();
  
   int count = noticeProc.create(noticeVO);
   mav.setViewName("redirect:/notice/create_msg.jsp?count=" + count);
   
   return mav;
 }  
  
//http://localhost:9090/ojt/notice/list.do
@RequestMapping(value="/notice/list.do", method=RequestMethod.GET)
public ModelAndView list() {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/notice/list");
  
  ArrayList<NoticeVO> list = noticeProc.list();
  mav.addObject("list", list);
  
  return mav;
}  
/**
 * ��ȸ
 * 
 * @param noticeno
 * @return
 */
@RequestMapping(value = "/notice/read.do", method = RequestMethod.GET)
public ModelAndView read(int noticeno) {
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/notice/read"); // /webapp/contents/read.jsp

  NoticeVO noticeVO = noticeProc.read(noticeno);
  mav.addObject("noticeVO", noticeVO);

  return mav;
}
//http://localhost:9090/ojt/notice/update.do?noticeno=1
@RequestMapping(value="/notice/update.do", 
                         method=RequestMethod.GET)
public ModelAndView update(int noticeno) {
 ModelAndView mav = new ModelAndView();
 mav.setViewName("/notice/update"); 
 
 NoticeVO noticeVO = noticeProc.read(noticeno);
 mav.addObject("noticeVO", noticeVO);
 
 return mav;
}

// noticeVO�� Form �±��� ������ �ڵ� �����.
// http://localhost:9090/ojt/notice/update.do
@RequestMapping(value="/notice/update.do", 
                         method=RequestMethod.POST)
public ModelAndView update(NoticeVO noticeVO) {
 ModelAndView mav = new ModelAndView();

 int count = noticeProc.update(noticeVO);
 
 // Spring controller > JSP View EL
 String title = Tool.spring_param_encoding(noticeVO.getN_title());

 mav.setViewName("redirect:/notice/update_msg.jsp?count=" + count+"&title=" + title);
 
 return mav;
}  

// http://localhost:9090/ojt/notice/delete.do?noticeno=1
@RequestMapping(value="/notice/delete.do", method=RequestMethod.GET)
public ModelAndView delete(int noticeno) {
  ModelAndView mav = new ModelAndView();
  
  NoticeVO noticeVO = noticeProc.read(noticeno);
  mav.addObject("noticeVO", noticeVO);
  
  mav.setViewName("/notice/delete"); // /webapp/notice/delete.jsp
  
  return mav;
}

// http://localhost:9090/team4/notice/delete.do
@RequestMapping(value="/notice/delete.do", method=RequestMethod.POST)
public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                                HttpServletRequest request, 
                                                int noticeno,
                                                @RequestParam(value="word", defaultValue="") String word,
                                                @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
  ModelAndView mav = new ModelAndView();
 
  String upDir = Tool.getRealPath(request, "/notice/storage");
 
  // ������ ��� ���� ��ȸ
  NoticeVO noticeVO_old = noticeProc.read(noticeno);
  //String thumbs_old = noticeVO_old.getN_thumbs();
  
  // ���� ���� ����
  String files_old = noticeVO_old.getN_file1();
  StringTokenizer files_st = new StringTokenizer(files_old, "/");
  while (files_st.hasMoreTokens()) {
    String fname = upDir + files_st.nextToken();
    Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
  }
  
  int count = noticeProc.delete(noticeno);

//-------------------------------------------------------------------------------------
  // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
  HashMap<String, Object> map = new HashMap();
  map.put("noticeno", noticeno);
  map.put("word", word);
  if(noticeProc.search_count(map) % Notice.RECORD_PER_PAGE == 0) {
    nowPage = nowPage - 1;
    if (nowPage < 1) {
       nowPage = 1;
    }
  }
  // -------------------------------------------------------------------------------------
  
  
  redirectAttributes.addAttribute("count", count);
  redirectAttributes.addAttribute("n_title", noticeVO_old.getN_title());
  redirectAttributes.addAttribute("nowPage", nowPage);

  //mav.setViewName("redirect:/notice/delete_msg.jsp?count=" + count+"&title=" + title );
  mav.setViewName("redirect:/notice/delete_msg.jsp");
 
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
      @RequestMapping(value = "/notice/list_by_search_paging.do", method = RequestMethod.GET)
      public ModelAndView list_by_search_paging(
          //@RequestParam(value="noticeno", defaultValue="1") int noticeno,
          @RequestParam(value="word", defaultValue="") String word,
          @RequestParam(value="nowPage", defaultValue="1") int nowPage
          ) { 
        System.out.println("--> nowPage: " + nowPage);
        
        ModelAndView mav = new ModelAndView();
        
        // �˻� ��� �߰�,  /webapp/contents/list_by_category_search_paging.jsp
        mav.setViewName("/notice/list_by_search_paging");   
        
        // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
        HashMap<String, Object> map = new HashMap<String, Object>();
       // map.put("noticeno", noticeno); // #{noticeno}
        map.put("word", word);     // #{word}
        map.put("nowPage", nowPage);       
        
        // �˻� ���
        List<NoticeVO> list = noticeProc.list_by_search_paging(map);
        mav.addObject("list", list);
        
        // �˻��� ���ڵ� ����
        int search_count = noticeProc.search_count(map);
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
        String paging = noticeProc.pagingBox("list_by_search_paging.do", search_count, nowPage, word);
        mav.addObject("paging", paging);
      
        mav.addObject("nowPage", nowPage);
        
        return mav;
      }    
/**
 * ���յ� ī�װ� �׷캰 ī�װ� ���
 * http://localhost:9090/ojt/cate/list_index_left.do
 * @param request
 * @return
 */
/*@RequestMapping(value="/notice/list_index_left.do", method=RequestMethod.GET)
public ModelAndView list_index_left(HttpServletRequest request){
  // System.out.println("--> list_index() GET called.");
  ModelAndView mav = new ModelAndView();
  mav.setViewName("/notice/list_index_left"); // webapp/notice/list_index_left.jsp
*/  
  /*List<CategrpVO> categrp_list = categrpProc.list_seqno_asc(); // ī�װ� �׷� ���
  
  // Categrp: name, Cate: title ���� ���
  ArrayList<String> name_title_list = new ArrayList<String>();   
  
  StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

  // ī�װ� �׷� ������ŭ ��ȯ
  for (int index = 0; index < categrp_list.size(); index++) {
    CategrpVO categrpVO = categrp_list.get(index);

    name_title_list.add("<LI class='categrp_name'>"+ categrpVO.getName() + "</LI>");

    // ī�װ� �׷캰 ī�װ� ��� ����
    ArrayList<Categrp_CateVO> cate_list = cateProc.list_by_categrpno(categrpVO.getCategrpno()); 
    
    // ī�װ� ������ŭ ��ȯ
    for (int j=0; j < cate_list.size(); j++) {
      Categrp_CateVO categrp_CateVO = cate_list.get(j);
      String title = categrp_CateVO.getTitle(); // ī�װ� �̸�
      int cnt = categrp_CateVO.getCnt();  // ī�װ��� ��ϵ� �ۼ�
      
      url.append("<LI class='cate_title'>");
      // url.append("  <A href='" + request.getContextPath()+ "/contents/list_by_cateno.do?cateno="+categrp_CateVO.getCateno()+"'>");
      url.append("  <A href='" + request.getContextPath()+ "/contents/list_by_cateno_search_paging.do?cateno="+categrp_CateVO.getCateno()+"'>");
      url.append(title);
      url.append("  </A>");
      url.append("  <span style='font-size: 0.9em; color: #555555;'>("+cnt+")</span>");
      url.append("</LI>");
      name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� ī�װ��� �߰� 
      
      url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����
      
    }
  }*/
/*  
  mav.addObject("name_title_list", name_title_list);
  mav.addObject("total_count", contentsProc.total_count());*/
  
 


}




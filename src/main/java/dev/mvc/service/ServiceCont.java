package dev.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import nation.web.tool.Tool;
import nation.web.tool.Upload;




@Controller
public class ServiceCont {
    @Autowired
    @Qualifier("dev.mvc.service.ServiceProc")
    private ServiceProcInter serviceProc;

    @RequestMapping(value="/service/create.do", method=RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      
      mav.setViewName("/service/create"); // /webapp/service/create.jsp
      
      return mav;
    }
    
    // categrpVO�� Form �±��� ������ �ڵ� �����.
    // http://localhost:9090/team4/service/create.do
    @RequestMapping(value="/service/create.do", method=RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, ServiceVO serviceVO) {
      ModelAndView mav = new ModelAndView();
      // mav.setViewName("/categrp/create_msg"); // /webapp/categrp/create_msg.jsp
      
      // mav.addObject("count", count);
      
      
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      String upDir = Tool.getRealPath(request, "/service/storage");
      // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
      List<MultipartFile> filesMF = serviceVO.getFilesMF(); 
   
      // System.out.println("--> filesMF.get(0).getSize(): " +
      // filesMF.get(0).getSize());
   
      String files = "";        // DBMS �÷��� ������ ���ϸ�
      String files_item = ""; // �ϳ��� ���ϸ�
      String sizes = "";       // DBMS �÷��� ������ ���� ũ��
      long sizes_item = 0;   // �ϳ��� ���� ������
      String thumbs = "";    // DBMS �÷��� ������ Thumb ���ϵ�
      String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
   
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
   
            if (Tool.isImage(files_item)) { // �̹������� �˻�
              thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹��� ����
            }
   
            // 1�� �̻��� ���� ���� ó��
            if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
              // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
              files = files + "/" + files_item;
              // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
              sizes = sizes + "/" + sizes_item;
              // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
              thumbs = thumbs + "/" + thumbs_item;
              
            // ������ ��� ���� ��ü�� 1�� ���������� ũ�� üũ, ������ 1���ΰ��  
            } else if (multipartFile.getSize() > 0) { 
              files = files_item; // file1.jpg
              sizes = "" + sizes_item; // 123456
              thumbs = thumbs_item; // file1_t.jpg
            }
          } // if (multipartFile.getSize() > 0) {  END
        } // END for
      }
      serviceVO.setFiles(files);
      serviceVO.setSizes(sizes);
      serviceVO.setThumbs(thumbs);
      // -------------------------------------------------------------------
      // ���� ���� �ڵ� ����
      // -------------------------------------------------------------------
      count = serviceProc.create(serviceVO);
      
      mav.setViewName("redirect:/service/create_msg.jsp?count=" + count);
      
      return mav;
    }
    
    
 // http://localhost:9090/team4/service/list.do
    @RequestMapping(value="/service/list.do", method=RequestMethod.GET)
    public ModelAndView list() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/service/list"); // /webapp/service/list.jsp
      
      // ArrayList<ServiceVO> list = serviceProc.list();
      ArrayList<ServiceVO> list = serviceProc.list();
      mav.addObject("list", list);
      
      return mav;
    }  
    
 // http://localhost:9090/ojt/contents/list_by_cateno.do?cateno=1
    @RequestMapping(value = "/service/list_by_question_no.do", method = RequestMethod.GET)
    public ModelAndView list_by_cateno(int question_no) {
      ModelAndView mav = new ModelAndView();
   
/*      ServiceVO serviceVO = serviceProc.read_by_join(question_no);
      mav.addObject("serviceVO", serviceVO);*/
   
      List<ServiceVO> list = serviceProc.list_by_question_no(question_no);
      mav.addObject("list", list);
   
      mav.setViewName("/service/list_by_question_no"); // /webapp/contents/list_by_cateno.jsp
   
      return mav;
    }
    
 // JSON
    // http://localhost:9090/team4/service/read.do?categrpno=1
    @RequestMapping(value="/service/read.do", 
                             method=RequestMethod.GET)
    public ServiceVO read(int question_no) {
        ModelAndView mav = new ModelAndView();
      
        ServiceVO serviceVO = serviceProc.read(question_no);
        mav.addObject("serviceVO", serviceVO);

      return serviceVO;
    }
    
    // categrpVO�� Form �±��� ������ �ڵ� �����.
    // http://localhost:9090/team4/service/update.do
    @RequestMapping(value="/service/update.do", method=RequestMethod.POST)
    public ModelAndView update(ServiceVO serviceVO) {
      ModelAndView mav = new ModelAndView();
     
      int count = serviceProc.update(serviceVO);
      mav.setViewName("redirect:/service/update_msg.jsp?count=" + count);
      
      return mav;
    }
    
 // http://localhost:9090/team4/service/update.do?cateno=1
    @RequestMapping(value="/service/update.do", 
                              method=RequestMethod.GET)
    public ModelAndView update(int question_no) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/service/update"); // /webapp/cate/update.jsp
      
      ServiceVO serviceVO = serviceProc.read(question_no);
      mav.addObject("serviceVO", serviceVO);
      
      return mav;
    }
    
    @RequestMapping(value="/service/delete.do", method=RequestMethod.POST)
    public ModelAndView delete_Proc(int question_no) {
      ModelAndView mav = new ModelAndView();
     
      int count = serviceProc.delete(question_no);
      mav.setViewName("redirect:/service/list.do");  // ������� �ٷ� �̵�
      
      return mav;
    }
    
 // http://localhost:9090/ojt/cate/delete.do?cateno=1
    @RequestMapping(value="/service/delete.do", 
                              method=RequestMethod.GET)
    public ModelAndView delete(int question_no) {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/service/delete"); // /webapp/cate/delete.jsp
      
      ServiceVO serviceVO = serviceProc.read(question_no);
      mav.addObject("serviceVO", serviceVO);
      
      return mav;
    }
    
    
    /**
     * ī�װ��� �˻� ���
     * 
     * @return
     */
    // http://localhost:9090/ojt/service/list_by_cateno_search.do?cateno=1
    @RequestMapping(value = "/service/list_by_search.do", method = RequestMethod.GET)
    public ModelAndView list_by_search(String word) {
      ModelAndView mav = new ModelAndView();
   
      /*Categrp_CateVO categrp_CateVO = cateProc.read_by_join(cateno);
      mav.addObject("categrp_CateVO", categrp_CateVO);*/
   
      HashMap<String, Object> map = new HashMap<String, Object>();

      map.put("word", word);
      
      // �˻��� ���ڵ� ���
      List<ServiceVO> list = serviceProc.list_by_search(map);
      mav.addObject("list", list);
      
      // �˻��� ���ڵ� ����
      int search_count = serviceProc.search_count(map);
      mav.addObject("search_count", search_count);

   
      mav.setViewName("/service/list_by_search"); // /webapp/contents/list_by_cateno_search.jsp
   
      return mav;
    }
    
    
    /**
     * ��� + �˻� + ����¡ ����
     * http://localhost:9090/ojt/contents/list_by_search_paging.do
     * @param categoryno
     * @param word
     * @param nowPage
     * @return
     *//*
    @RequestMapping(value = "/service/list_by_search_paging.do", 
                                         method = RequestMethod.GET)
    public ModelAndView list_by_search_paging(
        @RequestParam(value="cateno", defaultValue="1") int cateno,
        @RequestParam(value="word", defaultValue="") String word,
        @RequestParam(value="nowPage", defaultValue="1") int nowPage
        ) { 
      // System.out.println("--> list_by_category() GET called.");
      System.out.println("--> nowPage: " + nowPage);
      
      ModelAndView mav = new ModelAndView();
      
      // �˻� ��� �߰�,  /webapp/contents/list_by_category_search_paging.jsp
      mav.setViewName("/service/list_by_search_paging");   
      
      // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word);     // #{word}
      map.put("nowPage", nowPage);       
      
      // �˻� ���
      List<ServiceVO> list = serviceProc.list_by_search_paging(map);
      mav.addObject("list", list);
      
      // �˻��� ���ڵ� ����
      int search_count = serviceProc.search_count(map);
      mav.addObject("search_count", search_count);
    
      Categrp_CateVO categrp_CateVO = cateProc.read_by_join(cateno);
      mav.addObject("categrp_CateVO", categrp_CateVO);
      
      // mav.addObject("word", word);
    
      
       * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
       * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
       * 
       * @param listFile ��� ���ϸ� 
       * @param categoryno ī�װ���ȣ 
       * @param search_count �˻�(��ü) ���ڵ�� 
       * @param nowPage     ���� ������
       * @param word �˻���
       * @return ����¡ ���� ���ڿ�
        
      String paging = contentsProc.pagingBox("list_by_cateno_search_paging.do", cateno, search_count, nowPage, word);
      mav.addObject("paging", paging);
    
      mav.addObject("nowPage", nowPage);
      
      return mav;
    }    
    */
    
    
}

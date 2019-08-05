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
    
    // categrpVO는 Form 태그의 값으로 자동 저장됨.
    // http://localhost:9090/team4/service/create.do
    @RequestMapping(value="/service/create.do", method=RequestMethod.POST)
    public ModelAndView create(HttpServletRequest request, ServiceVO serviceVO) {
      ModelAndView mav = new ModelAndView();
      // mav.setViewName("/categrp/create_msg"); // /webapp/categrp/create_msg.jsp
      
      // mav.addObject("count", count);
      
      
      // -------------------------------------------------------------------
      // 파일 전송 코드 시작
      // -------------------------------------------------------------------
      String upDir = Tool.getRealPath(request, "/service/storage");
      // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
      List<MultipartFile> filesMF = serviceVO.getFilesMF(); 
   
      // System.out.println("--> filesMF.get(0).getSize(): " +
      // filesMF.get(0).getSize());
   
      String files = "";        // DBMS 컬럼에 저장할 파일명
      String files_item = ""; // 하나의 파일명
      String sizes = "";       // DBMS 컬럼에 저장할 파일 크기
      long sizes_item = 0;   // 하나의 파일 사이즈
      String thumbs = "";    // DBMS 컬럼에 저장할 Thumb 파일들
      String thumbs_item = ""; // 하나의 Thumb 파일명
   
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
   
            if (Tool.isImage(files_item)) { // 이미지인지 검사
              thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지 생성
            }
   
            // 1개 이상의 다중 파일 처리
            if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
              // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
              files = files + "/" + files_item;
              // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
              sizes = sizes + "/" + sizes_item;
              // 미니 이미지를 조합하여 하나의 컬럼에 저장
              thumbs = thumbs + "/" + thumbs_item;
              
            // 파일이 없어도 파일 객체가 1개 생성됨으로 크기 체크, 파일이 1개인경우  
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
      // 파일 전송 코드 종료
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
    
    // categrpVO는 Form 태그의 값으로 자동 저장됨.
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
      mav.setViewName("redirect:/service/list.do");  // 목록으로 바로 이동
      
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
     * 카테고리별 검색 목록
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
      
      // 검색된 레코드 목록
      List<ServiceVO> list = serviceProc.list_by_search(map);
      mav.addObject("list", list);
      
      // 검색된 레코드 갯수
      int search_count = serviceProc.search_count(map);
      mav.addObject("search_count", search_count);

   
      mav.setViewName("/service/list_by_search"); // /webapp/contents/list_by_cateno_search.jsp
   
      return mav;
    }
    
    
    /**
     * 목록 + 검색 + 페이징 지원
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
      
      // 검색 기능 추가,  /webapp/contents/list_by_category_search_paging.jsp
      mav.setViewName("/service/list_by_search_paging");   
      
      // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
      HashMap<String, Object> map = new HashMap<String, Object>();
      map.put("cateno", cateno); // #{cateno}
      map.put("word", word);     // #{word}
      map.put("nowPage", nowPage);       
      
      // 검색 목록
      List<ServiceVO> list = serviceProc.list_by_search_paging(map);
      mav.addObject("list", list);
      
      // 검색된 레코드 갯수
      int search_count = serviceProc.search_count(map);
      mav.addObject("search_count", search_count);
    
      Categrp_CateVO categrp_CateVO = cateProc.read_by_join(cateno);
      mav.addObject("categrp_CateVO", categrp_CateVO);
      
      // mav.addObject("word", word);
    
      
       * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
       * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
       * 
       * @param listFile 목록 파일명 
       * @param categoryno 카테고리번호 
       * @param search_count 검색(전체) 레코드수 
       * @param nowPage     현재 페이지
       * @param word 검색어
       * @return 페이징 생성 문자열
        
      String paging = contentsProc.pagingBox("list_by_cateno_search_paging.do", cateno, search_count, nowPage, word);
      mav.addObject("paging", paging);
    
      mav.addObject("nowPage", nowPage);
      
      return mav;
    }    
    */
    
    
}

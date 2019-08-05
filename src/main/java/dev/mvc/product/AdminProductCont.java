package dev.mvc.product;

import java.io.File;
import org.json.JSONObject;
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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.prodcate.ProdcateProcInter;
import dev.mvc.prodcate.Prodcategrp_ProdcateVO;
import dev.mvc.prodest.ProdestProcInter;
import dev.mvc.prodest.ProdestVO;
import dev.mvc.prodest.Prodest_totalVO;
import dev.mvc.prodcategrp.ProdcategrpProcInter;
import dev.mvc.prodcategrp.ProdcategrpVO;
import nation.web.tool.Tool;
import nation.web.tool.Upload;

@Controller
public class AdminProductCont {
  @Autowired
  @Qualifier("dev.mvc.prodcategrp.ProdcategrpProc")
  private ProdcategrpProcInter prodcategrpProc;
  
  @Autowired
  @Qualifier("dev.mvc.prodcate.ProdcateProc")
  private ProdcateProcInter prodcateProc = null; 
 
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.prodest.ProdestProc")
  private ProdestProcInter prodestProc = null;
  
  /**
   * 등록 폼 http://localhost:9090/ojt/admin/product/create.do?prodcateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/admin/product/create.do", method = RequestMethod.GET)
  public ModelAndView create(int prodcateno) {
    ModelAndView mav = new ModelAndView();
    // System.out.println("prodcateno: ----" + prodcateno);
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    mav.setViewName("/admin/product/create"); // /webapp/admin/product/create.jsp
 
    return mav;
  }

  /**
   * 등록 처리
   * 
   * 파일 태그의 연결
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ↓
   * private List<MultipartFile> filesMF;
   * 
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/create.do", method = RequestMethod.POST)
  public ModelAndView create(HttpServletRequest request,
                                          RedirectAttributes redirectAttributes, 
                                          ProductVO productVO,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage,
                                        @RequestParam(value="customerno", defaultValue="1") int customerno,
                                        @RequestParam(value="viewno", defaultValue="1") int viewno) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
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
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
 
    count = productProc.create(productVO);
    redirectAttributes.addAttribute("nowPage", nowPage);
    redirectAttributes.addAttribute("viewno", viewno);
    redirectAttributes.addAttribute("customerno", customerno);
    // System.out.println("create count: " + count);
    if (count == 1) {
      prodcateProc.increaseCnt(productVO.getProdcateno()); // 글수 증가
    }
 
    mav.setViewName(
        "redirect:/admin/product/create_msg.jsp?count=" + count + "&prodcateno=" + productVO.getProdcateno()); // /webapp/admin/product/create_msg.jsp
 
    // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno=" + productVO.getProdcateno());
    // mav.setViewName("redirect:/admin/product/list_all_prodcateno.do");
 
    return mav;
  }
  
  /**
   * 등록 폼 http://localhost:9090/team4/admin/product/prodest_create.do
   * 견적테이블 제품 등록처리
   * @return
   */
  @RequestMapping(value = "/admin/product/prodest_create.do", method = RequestMethod.POST)
  public ModelAndView prodest_create(ProdestVO prodestVO, 
      @RequestParam(value="prod_word", defaultValue="") String prod_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      @RequestParam(value="viewno", defaultValue="1") int viewno,
      @RequestParam(value="prodcateno", defaultValue="1") int prodcateno)
      {
    ModelAndView mav = new ModelAndView();
    System.out.println("prodcateno="+prodcateno);
    int count = prodestProc.create(prodestVO);
    System.out.println("count="+count);
    // System.out.println("viewno="+viewno);
    //    ArrayList<Prodest_totalVO> list = prodestProc.list();  // 견적서 리스트 받아오는 메소드
    //    mav.addObject("list", list);
    mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
                    +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word);
    
    //mav.setViewName("/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
    //              +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word);
    return mav;
  }
  
//http://localhost:9090/team4/admin/product/update_cnt_up.do
@RequestMapping(value = "/admin/product/prod_good_up.do", method = RequestMethod.POST)
public ModelAndView prod_good_up(int productno, 
    @RequestParam(value="prod_word", defaultValue="") String prod_word,
    @RequestParam(value="customerno", defaultValue="1") String customerno,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage,
    @RequestParam(value="viewno", defaultValue="1") int viewno,
    @RequestParam(value="prodcateno", defaultValue="1") int prodcateno
    ) {
  ModelAndView mav = new ModelAndView();
 int count = productProc.prod_good_up(productno);

 // mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
 // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do");
 mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
     +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno);
 return mav;
}

//http://localhost:9090/team4/admin/product/update_cnt_up.do
@RequestMapping(value = "/admin/product/prod_good_down.do", method = RequestMethod.POST)
public ModelAndView prod_good_down(int productno, 
  @RequestParam(value="prod_word", defaultValue="") String prod_word,
  @RequestParam(value="customerno", defaultValue="1") String customerno,
  @RequestParam(value="nowPage", defaultValue="1") int nowPage,
  @RequestParam(value="viewno", defaultValue="1") int viewno,
  @RequestParam(value="prodcateno", defaultValue="1") int prodcateno
  ) {
ModelAndView mav = new ModelAndView();

int count = productProc.prod_good_down(productno);

// mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
// mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do");
mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
   +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno);
return mav;
}
  
  
//http://localhost:9090/team4/admin/product/update_cnt_up.do
@RequestMapping(value = "/admin/product/update_cnt_up.do", method = RequestMethod.POST)
public ModelAndView update_cnt_up(int prodestno, 
    @RequestParam(value="prod_word", defaultValue="") String prod_word,
    @RequestParam(value="customerno", defaultValue="1") String customerno,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage,
    @RequestParam(value="viewno", defaultValue="1") int viewno,
    @RequestParam(value="prodcateno", defaultValue="1") int prodcateno
    ) {
  ModelAndView mav = new ModelAndView();

 int count = prodestProc.update_cnt_up(prodestno);

 // mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
 // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do");
 mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
     +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno);
 return mav;
}


//http://localhost:9090/team4/admin/product/update_cnt_up.do
@RequestMapping(value = "/admin/product/update_cnt_down.do", method = RequestMethod.POST)
public ModelAndView update_cnt_down(int prodestno, 
    @RequestParam(value="prod_word", defaultValue="") String prod_word,
    @RequestParam(value="customerno", defaultValue="1") String customerno,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage,
    @RequestParam(value="viewno", defaultValue="1") int viewno,
    @RequestParam(value="prodcateno", defaultValue="1") int prodcateno
    ) {
  ModelAndView mav = new ModelAndView();
  
  Prodest_totalVO prodest_totalVO = prodestProc.read(prodestno);
  int prodest_cnt = prodest_totalVO.getProdest_cnt();
  if(prodest_cnt > 1){
    int count = prodestProc.update_cnt_down(prodestno);
  }else{
    // System.out.println("prodest_cnt= "+ prodest_cnt);
  }


// mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
// mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do");
mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
    +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno);
return mav;
}

//http://localhost:9090/team4/admin/product/update_cnt_up.do
@RequestMapping(value = "/admin/product/prodest_delete.do", method = RequestMethod.POST)
public ModelAndView prodest_delete(int prodestno, 
    @RequestParam(value="prod_word", defaultValue="") String prod_word,
    @RequestParam(value="customerno", defaultValue="1") String customerno,
    @RequestParam(value="nowPage", defaultValue="1") int nowPage,
    @RequestParam(value="viewno", defaultValue="1") int viewno,
    @RequestParam(value="prodcateno", defaultValue="1") int prodcateno
    ) {
  // System.out.println("prodcateno="+prodcateno);
  // System.out.println("viewno="+viewno);
  
  ModelAndView mav = new ModelAndView();
  int count = prodestProc.delete(prodestno);

// mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
//mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do");
mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno="+prodcateno
    +"&viewno="+viewno+"&nowPage="+nowPage+"&prod_word="+prod_word+"&customerno="+customerno);
return mav;
}

  /**
   * 전체 목록
   * 
   * @return
   */
  // http://localhost:9090/ojt/admin/product/list_all_prodcate.do
  @RequestMapping(value = "/admin/product/list_all_prodcate.do", method = RequestMethod.GET)
  public ModelAndView list_all_prodcate() {
    ModelAndView mav = new ModelAndView();
 
    ArrayList<ProductVO> list = productProc.list_all_prodcate();
    mav.addObject("list", list);
    
    int total_count = productProc.total_count();
    mav.addObject("total_count", total_count);
 
    mav.setViewName("/admin/product/list_all_prodcate"); // /webapp/admin/product/list_all_prodcate.jsp
 
    return mav;
  }

  /**
   * 카테고리별 목록
   * 
   * @return
   */
  // http://localhost:9090/ojt/admin/product/list_by_prodcateno.do?prodcateno=1
  @RequestMapping(value = "/admin/product/list_by_prodcateno.do", method = RequestMethod.GET)
  public ModelAndView list_by_prodcateno(int prodcateno) {
    ModelAndView mav = new ModelAndView();
 
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
 
    List<ProductVO> list = productProc.list_by_prodcateno(prodcateno);
    mav.addObject("list", list);
 
    mav.setViewName("/admin/product/list_by_prodcateno"); // /webapp/admin/product/list_by_prodcateno.jsp
 
    return mav;
  }
  
  /**
   * 조회
   * 
   * @param productno
   * @return
   */
  @RequestMapping(value = "/admin/product/read.do", method = RequestMethod.GET)
  public ModelAndView read(int productno) {
    ModelAndView mav = new ModelAndView();
    
    int count = productProc.prod_viewcnt_up(productno);
    System.out.println("prodviewcnt up="+ count);
    mav.setViewName("/admin/product/read"); // /webapp/admin/product/read.jsp

    ProductVO productVO = productProc.read(productno);
    mav.addObject("productVO", productVO);

    // 카테고리 정보 저장
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(productVO.getProdcateno()); 
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);

    ArrayList<FileVO> file_list = productProc.getThumbs(productVO);

    mav.addObject("file_list", file_list);

    return mav;
  }
  
//http://localhost:9090/ojt/prodcate/list.do
 /*@RequestMapping(value="/admin/product/list_by_prodest.do", method=RequestMethod.GET)
 public ModelAndView list_by_prodest() {
   ModelAndView mav = new ModelAndView();
   mav.setViewName("/admin/product/list_by_prodcateno_search_paging"); // /webapp/prodcate/list.jsp
   
   ArrayList<Prodest_totalVO> list = prodestProc.list();
   mav.addObject("list", list);
   
   return mav;
 }*/
  
  @ResponseBody
  @RequestMapping(value = "/admin/product/readp.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String readp(int productno) {
    
    // ProductVO productVO = productProc.read(productno);
    Prodcate_ProductVO prodcate_ProductVO = productProc.read_by_join(productno); 
    JSONObject json = new JSONObject(prodcate_ProductVO);
    System.out.println(json);
    
    return json.toString();
    
  }

  // ZIP 압축 후 파일 다운로드 
  @RequestMapping(value = "/admin/product/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int productno) {
    ModelAndView mav = new ModelAndView();

    ProductVO productVO = productProc.read(productno);
    
    String files = productVO.getFiles();
    String[] files_array = files.split("/");
    
    String dir = "/admin/product/storage";
    String upDir = Tool.getRealPath(request, dir); // 절대 경로 산출
    
    // 다운로드되는 파일, 파일명을 지정하거나 날짜 조합
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // 압축파일이 생성될 폴더 지정
    
    String[] zip_src = new String[files_array.length]; // 파일 갯수만큼 배열 선언
    
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // 절대 경로가 조합된 파일 저장      
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
      
//      if (file.delete() == true) {
//        System.out.println(zip_filename + " 파일을 삭제했습니다.");
//      }

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
   * 수정 폼 http://localhost:9090/ojt/admin/product/update.do?prodcateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/admin/product/update.do", method = RequestMethod.GET)
  public ModelAndView update(int prodcateno, int productno) {
    ModelAndView mav = new ModelAndView();
    
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    ProductVO productVO = productProc.read(productno);
    mav.addObject("productVO", productVO);
    
    ArrayList<FileVO> file_list = productProc.getThumbs(productVO);
    mav.addObject("file_list", file_list);
    
    mav.setViewName("/admin/product/update"); // /webapp/admin/product/update.jsp
 
    return mav;
  }
  
  /**
   * - 글만 수정하는 경우의 구현 
   * - 파일만 수정하는 경우의 구현 
   * - 글과 파일을 동시에 수정하는 경우의 구현
   * 
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/update.do", method = RequestMethod.POST)
  public ModelAndView update(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         ProductVO productVO,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage,
                                         @RequestParam(value="viewno", defaultValue="1") int viewno,
                                         @RequestParam(value="prod_word", defaultValue="") String prod_word,
                                         @RequestParam(value="customerno", defaultValue="customerno") int customerno) {
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring이 File 객체를 저장해둠.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = ""; // 컬럼에 저장할 파일명
    String files_item = ""; // 하나의 파일명
    String sizes = "";
    long sizes_item = 0; // 하나의 파일 사이즈
    String thumbs = ""; // Thumb 파일들
    String thumbs_item = ""; // 하나의 Thumb 파일명
 
    int count = filesMF.size(); // 업로드된 파일 갯수
 
    // 기존의 등록 정보 조회
    ProductVO productVO_old = productProc.read(productVO.getProductno());
    
    if (filesMF.get(0).getSize() > 0) { // 새로운 파일을 등록함으로 기존에 등록된 파일 목록 삭제
      // thumbs 파일 삭제
      String thumbs_old = productVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
      }
 
      // 원본 파일 삭제
      String files_old = productVO_old.getFiles();
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
 
          if (Tool.isImage(files_item)) {
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb 이미지
                                                                    // 생성
          }
 
          if (i != 0 && i < count) { // index가 1 이상이면(두번째 파일 이상이면)
            // 하나의 컬럼에 여러개의 파일명을 조합하여 저장, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // 하나의 컬럼에 여러개의 파일 사이즈를 조합하여 저장, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // 미니 이미지를 조합하여 하나의 컬럼에 저장
            thumbs = thumbs + "/" + thumbs_item;
          } else if (multipartFile.getSize() > 0) { // 파일이 없어도 파일 객체가 1개 생성됨으로
                                                    // 크기 체크
            files = files_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
 
        }
      } // for END
      // --------------------------------------------
      // 새로운 파일의 등록 종료
      // --------------------------------------------
 
    } else { // 글만 수정하는 경우, 기존의 파일 정보 재사용
      files = productVO_old.getFiles();
      sizes = productVO_old.getSizes();
      thumbs = productVO_old.getThumbs();
    }
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
 
    productVO.setAdminno(1); // 회원 개발후 session으로 변경
 
    count = productProc.update(productVO);  // DBMS 수정
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
 
    // redirect시에는 request가 전달이안됨으로 아래의 방법을 이용하여 데이터 전달
    redirectAttributes.addAttribute("productno", productVO.getProductno());
    redirectAttributes.addAttribute("prodcateno", productVO.getProdcateno());
    redirectAttributes.addAttribute("prod_title", productVO.getProd_title());
    redirectAttributes.addAttribute("nowPage", nowPage);
    redirectAttributes.addAttribute("viewno", viewno);
    redirectAttributes.addAttribute("prod_word", prod_word);
    redirectAttributes.addAttribute("customerno", customerno);
 
    mav.setViewName("redirect:/admin/product/update_msg.jsp");
    
 
    return mav;
 
  }

  /**
   * 수정 폼 
   * http://localhost:9090/ojt/admin/product/delete.do?prodcateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/admin/product/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int prodcateno, int productno,
      @RequestParam(value="customerno", defaultValue="1") String customerno) {
    ModelAndView mav = new ModelAndView();
    
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    ProductVO productVO = productProc.read(productno);
    mav.addObject("productVO", productVO);
    
    System.out.println("customerno="+customerno);
    HashMap<String, Object> map = new HashMap();
    
    map.put("productno", productno);
    map.put("customerno", customerno);
    
    int count = productProc.prod_prodest_cnt(map);
    mav.addObject("count", count);
    System.out.println("count="+count);
    if(count == 0){
      mav.setViewName("/admin/product/delete"); // /webapp/prodcate/delete.jsp
    }else{
      // mav.setViewName("redirect:/admin/product/delete_prod_prodest.do?productno="+productno);
      mav.setViewName("/admin/product/delete_prod_prodest");
    }
    
    // ArrayList<FileVO> file_list = productProc.getThumbs(productVO);
    // mav.addObject("file_list", file_list);
    
    //mav.setViewName("/admin/product/delete"); // /webapp/admin/product/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int productno,
                                         @RequestParam(value="prodcateno", defaultValue="1") int prodcateno,
                                         @RequestParam(value="prod_word", defaultValue="") String prod_word,
                                         @RequestParam(value="customerno", defaultValue="1") String customerno,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage,
                                         @RequestParam(value="viewno", defaultValue="1") int viewno) {
    ModelAndView mav = new ModelAndView();
 
    String upDir = Tool.getRealPath(request, "/admin/product/storage");

    // 기존의 등록 정보 조회
    ProductVO productVO_old = productProc.read(productno);
    
    String thumbs_old = productVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
 
    // 원본 파일 삭제
    String files_old = productVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
    
    ProductVO productVO = productProc.read(productno);
    int count = productProc.delete(productno);
    if (count == 1) {
      prodcateProc.decreaseCnt(productVO.getProdcateno()); // 글수 증가
    }
    if (count > 0) {
      
      // -------------------------------------------------------------------------------------
      // 마지막 페이지의 레코드 삭제시의 페이지 번호 -1 처리
      HashMap<String, Object> map = new HashMap();
      map.put("prodcateno", prodcateno);
      map.put("prod_word", prod_word);
      if (productProc.search_count(map) % Product.RECORD_PER_PAGE == 0) {
        nowPage = nowPage - 1;
        if (nowPage < 1) {
          nowPage = 1;
        }
      }
      // -------------------------------------------------------------------------------------
      
    }
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("productno", productno);
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("prod_title", productVO_old.getProd_title());
    redirectAttributes.addAttribute("nowPage", nowPage);
    redirectAttributes.addAttribute("viewno", viewno);
    redirectAttributes.addAttribute("customerno", customerno);
    
    mav.setViewName("redirect:/admin/product/delete_msg.jsp");
    //mav.setViewName("redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno="prodcate);
    //prodcate/list_by_prodcategrpno.do?prodcategrpno=3
 
    return mav;
 
  }
  
  @RequestMapping(value = "/admin/product/delete_product.do", method = RequestMethod.GET)
  public ModelAndView delete_product(int prodcateno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("prodcateno: " + prodcateno);
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO); 
    
    // ArrayList<FileVO> file_list = productProc.getThumbs(productVO);
    // mav.addObject("file_list", file_list);
    
    mav.setViewName("/admin/product/delete_product"); // /webapp/admin/product/delete.jsp
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/delete_product.do", method = RequestMethod.POST)
  public ModelAndView delete_product(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int prodcateno) {
    
    ModelAndView mav = new ModelAndView();
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    int prodcategrpno = prodcategrp_ProdcateVO.getProdcategrpno();
    String upDir = Tool.getRealPath(request, "/admin/product/storage");

    // 검색 목록
    List<ProductVO> list = productProc.list_by_prodcateno(prodcateno);
    System.out.println("리스트: " +list);
    
    
    int i =0;
    for(i=0; i<list.size(); i++){
    ProductVO productVO_old =  list.get(i);
    prodcateProc.decreaseCnt(prodcateno); // 글수 감소
    String thumbs_old = productVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");

    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // 기존에 등록된 thumbs 파일 삭제
    }
 
    // 원본 파일 삭제
    String files_old = productVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // 기존에 등록된 원본 파일 삭제
    }
    }
    int count = productProc.delete_product(prodcateno);
    if (count > 0) {
        // prodcateProc.decreaseCnt(prodcateno); // 글수 감소
    } 
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    System.out.println("count: " + count);
    System.out.println("prodcateno: " + prodcateno);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("prodcategrpno", prodcategrpno);

    mav.setViewName("redirect:/admin/product/delete_product_msg.jsp");

 
    return mav;
  }
  
  /**
   * 수정 폼 
   * http://localhost:9090/ojt/admin/product/delete.do?prodcateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/admin/product/delete_prod_prodest.do", method = RequestMethod.POST)
  public ModelAndView delete_prod_prodest(RedirectAttributes redirectAttributes,
      HttpServletRequest request, 
      @RequestParam(value="prodcateno", defaultValue="1") int prodcateno,
      @RequestParam(value="prod_word", defaultValue="") String prod_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      @RequestParam(value="viewno", defaultValue="1") int viewno,
      @RequestParam(value="customerno", defaultValue="1") int customerno,
      int productno) {
    ModelAndView mav = new ModelAndView();
    
    // ProductVO productVO = productProc.read(productno);
    // mav.addObject("productVO", productVO);
    
    int count = prodestProc.delete_product(productno);
    
    System.out.println("count: " + count);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("productno", productno); // redirect parameter 적용
    redirectAttributes.addAttribute("prodcateno", prodcateno); // redirect parameter 적용
    redirectAttributes.addAttribute("prod_word", prod_word); // redirect parameter 적용
    redirectAttributes.addAttribute("nowPage", nowPage); // redirect parameter 적용
    redirectAttributes.addAttribute("viewno", viewno); // redirect parameter 적용
    redirectAttributes.addAttribute("customerno", customerno); // redirect parameter 적용
    
    mav.setViewName("redirect:/admin/product/delete_prodest_msg.jsp");
    // mav.setViewName("/admin/product/delete_prodest_msg.do");
 
    return mav;
  }
  
  /**
   * 삭제
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/delete_test.do", method = RequestMethod.POST)
  public ModelAndView delete_test(RedirectAttributes redirectAttributes, 
                                         HttpServletRequest request, 
                                         int prodcateno, 
                                         @RequestParam(value="prod_word", defaultValue="") String prod_word,
                                         @RequestParam(value="nowPage", defaultValue="1") int nowPage) {
    ModelAndView mav = new ModelAndView();
    
    int count = productProc.delete_product(prodcateno);
    if (count > 0) {
    }
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    redirectAttributes.addAttribute("count", count); // redirect parameter 적용
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/admin/product/delete_msg.jsp");
    //mav.setViewName("redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno="prodcate);
    //prodcate/list_by_prodcategrpno.do?prodcategrpno=3
 
    return mav;
 
  }
  
  
  
  /**
   * 카테고리별 검색 목록
   * 
   * @return
   */
  // http://localhost:9090/ojt/admin/product/list_by_prodcateno_search.do?prodcateno=1
  @RequestMapping(value = "/admin/product/list_by_prodcateno_search.do", method = RequestMethod.GET)
  public ModelAndView list_by_prodcateno_search(int prodcateno, String prod_word) {
    ModelAndView mav = new ModelAndView();
 
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
 
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("prodcateno", prodcateno);
    map.put("prod_word", prod_word);
    
    // 검색된 레코드 목록
    List<ProductVO> list = productProc.list_by_prodcateno_search(map);
    mav.addObject("list", list);
    
    // 검색된 레코드 갯수
    int search_count = productProc.search_count(map);
    mav.addObject("search_count", search_count);

 
    mav.setViewName("/admin/product/list_by_prodcateno_search"); // /webapp/admin/product/list_by_prodcateno_search.jsp
 
    return mav;
  }
  
  /**
   * 목록 + 검색 + 페이징 지원
   * http://172.16.12.21:9090/team4/admin/product/list_by_prodcateno_search_paging.do?prodcateno=10
   * @param prodcategoryno
   * @param prod_word
   * @param nowPage
   * @return
   */
  @RequestMapping(value = "/admin/product/list_by_prodcateno_search_paging.do", 
                                       method = RequestMethod.GET)
  public ModelAndView list_by_prodcategory_search_paging(
      @RequestParam(value="prodcateno", defaultValue="1") int prodcateno,
      @RequestParam(value="customerno", defaultValue="1") int customerno,
      @RequestParam(value="prod_word", defaultValue="") String prod_word,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage,
      @RequestParam(value="viewno", defaultValue="1") int viewno
      ) { 
    // System.out.println("--> list_by_prodcategory() GET called.");
    // System.out.println("--> nowPage: " + nowPage);
    
    ModelAndView mav = new ModelAndView();
    
    // 검색 기능 추가,  /webapp/admin/product/list_by_prodcategory_search_paging.jsp
    mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
    
    // 숫자와 문자열 타입을 저장해야함으로 Obejct 사용
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("prodcateno", prodcateno); // #{prodcateno}
    map.put("prod_word", prod_word);     // #{prod_word}
    map.put("nowPage", nowPage);
    map.put("viewno", viewno); // 1. 인기순, 2. 신제품순, 3. 낮은 가격순, 4. 높은 가격순
    
    // System.out.println("viewno=" + viewno);
    // 제품 목록
    List<ProductVO> list = productProc.list_by_prodcateno_search_paging(map);
    mav.addObject("list", list);
    
    // 견적서 목록
    ArrayList<Prodest_totalVO> prodest_list = prodestProc.list(customerno);
    System.out.println("prodest_list= "+prodest_list);
    mav.addObject("prodest_list", prodest_list);
    
    System.out.println(list);  // 중요
    // 검색된 레코드 갯수
    int search_count = productProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    ArrayList<ProdcategrpVO> grplist = prodcategrpProc.list_seqno_asc();
    mav.addObject("grplist", grplist);
    
    // mav.addObject("prod_word", prod_word);
  
    /*
     * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
     * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
     * 
     * @param listFile 목록 파일명 
     * @param prodcategoryno 카테고리번호 
     * @param search_count 검색(전체) 레코드수 
     * @param nowPage     현재 페이지
     * @param prod_word 검색어
     * @return 페이징 생성 문자열
     */ 
    String paging = productProc.pagingBox("list_by_prodcateno_search_paging.do", prodcateno, search_count, nowPage, prod_word, viewno, customerno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    

  /**
   * 답변 폼 http://localhost:9090/ojt/admin/product/reply.do?prodcateno=1
   * 
   * @return
   */
  @RequestMapping(value = "/admin/product/reply.do", method = RequestMethod.GET)
  public ModelAndView reply(int prodcateno, int productno) {
    ModelAndView mav = new ModelAndView();
    
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    mav.setViewName("/admin/product/reply"); // /webapp/admin/product/reply.jsp
 
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
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/admin/product/reply.do", method = RequestMethod.POST)
  public ModelAndView reply(HttpServletRequest request, 
                                        ProductVO productVO,
                                        @RequestParam(value="prod_word", defaultValue="") String prod_word,
                                        @RequestParam(value="nowPage", defaultValue="1") int nowPage                                        
                                        ) {
    // System.out.println("--> create() POST executed");
    ModelAndView mav = new ModelAndView();
 
    // -------------------------------------------------------------------
    // 파일 전송 코드 시작
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring이 File 객체를 저장해둠, 개발자는 이용만 함.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
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
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // 파일 전송 코드 종료
    // -------------------------------------------------------------------
    
    // 회원 개발 후 session 으로변경
    // int adminno = (Integer)session.getAttribute("adminno");
    productVO.setAdminno(1);
    
    // --------------------------- 답변 관련 코드 시작 --------------------------
    ProductVO parentVO = productProc.read(productVO.getProductno()); // 부모글 정보 추출
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("prod_grpno", parentVO.getProd_grpno());
    map.put("prod_ansnum",  parentVO.getProd_ansnum());
    productProc.increaseAnsnum(map); // 현재 등록된 답변 뒤로 +1 처리함.

    productVO.setProd_grpno(parentVO.getProd_grpno()); // 부모의 그룹번호 할당
    productVO.setProd_indent(parentVO.getProd_indent() + 1); // 답변 차수 증가
    productVO.setProd_ansnum(parentVO.getProd_ansnum() + 1); // 부모 바로 아래 등록
    // --------------------------- 답변 관련 코드 종료 --------------------------

    count = productProc.reply(productVO);
    if (count == 1) {
      prodcateProc.increaseCnt(productVO.getProdcateno()); // 글수 증가
    }
 
    mav.setViewName(
        "redirect:/admin/product/reply_msg.jsp?count=" + count + "&prodcateno=" + productVO.getProdcateno()+ "&nowPage=" + nowPage); // /webapp/admin/product/reply_msg.jsp
 
    // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno=" + productVO.getProdcateno());
    // mav.setViewName("redirect:/admin/product/list_all_prodcateno.do");
 
    return mav;
  }

  
}







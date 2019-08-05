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
   * ��� �� http://localhost:9090/ojt/admin/product/create.do?prodcateno=1
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
   * ��� ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
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
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
 
    count = productProc.create(productVO);
    redirectAttributes.addAttribute("nowPage", nowPage);
    redirectAttributes.addAttribute("viewno", viewno);
    redirectAttributes.addAttribute("customerno", customerno);
    // System.out.println("create count: " + count);
    if (count == 1) {
      prodcateProc.increaseCnt(productVO.getProdcateno()); // �ۼ� ����
    }
 
    mav.setViewName(
        "redirect:/admin/product/create_msg.jsp?count=" + count + "&prodcateno=" + productVO.getProdcateno()); // /webapp/admin/product/create_msg.jsp
 
    // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno=" + productVO.getProdcateno());
    // mav.setViewName("redirect:/admin/product/list_all_prodcateno.do");
 
    return mav;
  }
  
  /**
   * ��� �� http://localhost:9090/team4/admin/product/prodest_create.do
   * �������̺� ��ǰ ���ó��
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
    //    ArrayList<Prodest_totalVO> list = prodestProc.list();  // ������ ����Ʈ �޾ƿ��� �޼ҵ�
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
   * ��ü ���
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
   * ī�װ��� ���
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
   * ��ȸ
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

    // ī�װ� ���� ����
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

  // ZIP ���� �� ���� �ٿ�ε� 
  @RequestMapping(value = "/admin/product/download.do", method = RequestMethod.GET)
  public ModelAndView download(HttpServletRequest request, int productno) {
    ModelAndView mav = new ModelAndView();

    ProductVO productVO = productProc.read(productno);
    
    String files = productVO.getFiles();
    String[] files_array = files.split("/");
    
    String dir = "/admin/product/storage";
    String upDir = Tool.getRealPath(request, dir); // ���� ��� ����
    
    // �ٿ�ε�Ǵ� ����, ���ϸ��� �����ϰų� ��¥ ����
    String zip = Tool.getDateRand() + ".zip";  // 20190522102114933.zip
    String zip_filename = upDir + zip; // ���������� ������ ���� ����
    
    String[] zip_src = new String[files_array.length]; // ���� ������ŭ �迭 ����
    
    for (int i=0; i < files_array.length; i++) {
      zip_src[i] = upDir + "/" + files_array[i]; // ���� ��ΰ� ���յ� ���� ����      
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
      
//      if (file.delete() == true) {
//        System.out.println(zip_filename + " ������ �����߽��ϴ�.");
//      }

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
   * ���� �� http://localhost:9090/ojt/admin/product/update.do?prodcateno=1
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
   * - �۸� �����ϴ� ����� ���� 
   * - ���ϸ� �����ϴ� ����� ���� 
   * - �۰� ������ ���ÿ� �����ϴ� ����� ����
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring�� File ��ü�� �����ص�.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
    // System.out.println("--> filesMF.get(0).getSize(): " +
    // filesMF.get(0).getSize());
 
    String files = ""; // �÷��� ������ ���ϸ�
    String files_item = ""; // �ϳ��� ���ϸ�
    String sizes = "";
    long sizes_item = 0; // �ϳ��� ���� ������
    String thumbs = ""; // Thumb ���ϵ�
    String thumbs_item = ""; // �ϳ��� Thumb ���ϸ�
 
    int count = filesMF.size(); // ���ε�� ���� ����
 
    // ������ ��� ���� ��ȸ
    ProductVO productVO_old = productProc.read(productVO.getProductno());
    
    if (filesMF.get(0).getSize() > 0) { // ���ο� ������ ��������� ������ ��ϵ� ���� ��� ����
      // thumbs ���� ����
      String thumbs_old = productVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }
 
      // ���� ���� ����
      String files_old = productVO_old.getFiles();
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
 
          if (Tool.isImage(files_item)) {
            thumbs_item = Tool.preview(upDir, files_item, 120, 80); // Thumb �̹���
                                                                    // ����
          }
 
          if (i != 0 && i < count) { // index�� 1 �̻��̸�(�ι�° ���� �̻��̸�)
            // �ϳ��� �÷��� �������� ���ϸ��� �����Ͽ� ����, file1.jpg/file2.jpg/file3.jpg
            files = files + "/" + files_item;
            // �ϳ��� �÷��� �������� ���� ����� �����Ͽ� ����, 12546/78956/42658
            sizes = sizes + "/" + sizes_item;
            // �̴� �̹����� �����Ͽ� �ϳ��� �÷��� ����
            thumbs = thumbs + "/" + thumbs_item;
          } else if (multipartFile.getSize() > 0) { // ������ ��� ���� ��ü�� 1�� ����������
                                                    // ũ�� üũ
            files = files_item; // file1.jpg
            sizes = "" + sizes_item; // 123456
            thumbs = thumbs_item; // file1_t.jpg
          }
 
        }
      } // for END
      // --------------------------------------------
      // ���ο� ������ ��� ����
      // --------------------------------------------
 
    } else { // �۸� �����ϴ� ���, ������ ���� ���� ����
      files = productVO_old.getFiles();
      sizes = productVO_old.getSizes();
      thumbs = productVO_old.getThumbs();
    }
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
 
    productVO.setAdminno(1); // ȸ�� ������ session���� ����
 
    count = productProc.update(productVO);  // DBMS ����
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
 
    // redirect�ÿ��� request�� �����̾ȵ����� �Ʒ��� ����� �̿��Ͽ� ������ ����
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
   * ���� �� 
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
   * ����
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

    // ������ ��� ���� ��ȸ
    ProductVO productVO_old = productProc.read(productno);
    
    String thumbs_old = productVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");
    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
 
    // ���� ���� ����
    String files_old = productVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
    
    ProductVO productVO = productProc.read(productno);
    int count = productProc.delete(productno);
    if (count == 1) {
      prodcateProc.decreaseCnt(productVO.getProdcateno()); // �ۼ� ����
    }
    if (count > 0) {
      
      // -------------------------------------------------------------------------------------
      // ������ �������� ���ڵ� �������� ������ ��ȣ -1 ó��
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
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
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
   * ����
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

    // �˻� ���
    List<ProductVO> list = productProc.list_by_prodcateno(prodcateno);
    System.out.println("����Ʈ: " +list);
    
    
    int i =0;
    for(i=0; i<list.size(); i++){
    ProductVO productVO_old =  list.get(i);
    prodcateProc.decreaseCnt(prodcateno); // �ۼ� ����
    String thumbs_old = productVO_old.getThumbs();
    StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");

    while (thumbs_st.hasMoreTokens()) {
      String fname = upDir + thumbs_st.nextToken();
      Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
    }
 
    // ���� ���� ����
    String files_old = productVO_old.getFiles();
    StringTokenizer files_st = new StringTokenizer(files_old, "/");
    while (files_st.hasMoreTokens()) {
      String fname = upDir + files_st.nextToken();
      Tool.deleteFile(fname);  // ������ ��ϵ� ���� ���� ����
    }
    }
    int count = productProc.delete_product(prodcateno);
    if (count > 0) {
        // prodcateProc.decreaseCnt(prodcateno); // �ۼ� ����
    } 
 
    // mav.setViewName("redirect:/admin/product/update_msg.jsp?count=" + count + "&...);
    System.out.println("count: " + count);
    System.out.println("prodcateno: " + prodcateno);
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("prodcategrpno", prodcategrpno);

    mav.setViewName("redirect:/admin/product/delete_product_msg.jsp");

 
    return mav;
  }
  
  /**
   * ���� �� 
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
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("productno", productno); // redirect parameter ����
    redirectAttributes.addAttribute("prodcateno", prodcateno); // redirect parameter ����
    redirectAttributes.addAttribute("prod_word", prod_word); // redirect parameter ����
    redirectAttributes.addAttribute("nowPage", nowPage); // redirect parameter ����
    redirectAttributes.addAttribute("viewno", viewno); // redirect parameter ����
    redirectAttributes.addAttribute("customerno", customerno); // redirect parameter ����
    
    mav.setViewName("redirect:/admin/product/delete_prodest_msg.jsp");
    // mav.setViewName("/admin/product/delete_prodest_msg.do");
 
    return mav;
  }
  
  /**
   * ����
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
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("nowPage", nowPage);
    
    mav.setViewName("redirect:/admin/product/delete_msg.jsp");
    //mav.setViewName("redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno="prodcate);
    //prodcate/list_by_prodcategrpno.do?prodcategrpno=3
 
    return mav;
 
  }
  
  
  
  /**
   * ī�װ��� �˻� ���
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
    
    // �˻��� ���ڵ� ���
    List<ProductVO> list = productProc.list_by_prodcateno_search(map);
    mav.addObject("list", list);
    
    // �˻��� ���ڵ� ����
    int search_count = productProc.search_count(map);
    mav.addObject("search_count", search_count);

 
    mav.setViewName("/admin/product/list_by_prodcateno_search"); // /webapp/admin/product/list_by_prodcateno_search.jsp
 
    return mav;
  }
  
  /**
   * ��� + �˻� + ����¡ ����
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
    
    // �˻� ��� �߰�,  /webapp/admin/product/list_by_prodcategory_search_paging.jsp
    mav.setViewName("/admin/product/list_by_prodcateno_search_paging");
    
    // ���ڿ� ���ڿ� Ÿ���� �����ؾ������� Obejct ���
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("prodcateno", prodcateno); // #{prodcateno}
    map.put("prod_word", prod_word);     // #{prod_word}
    map.put("nowPage", nowPage);
    map.put("viewno", viewno); // 1. �α��, 2. ����ǰ��, 3. ���� ���ݼ�, 4. ���� ���ݼ�
    
    // System.out.println("viewno=" + viewno);
    // ��ǰ ���
    List<ProductVO> list = productProc.list_by_prodcateno_search_paging(map);
    mav.addObject("list", list);
    
    // ������ ���
    ArrayList<Prodest_totalVO> prodest_list = prodestProc.list(customerno);
    System.out.println("prodest_list= "+prodest_list);
    mav.addObject("prodest_list", prodest_list);
    
    System.out.println(list);  // �߿�
    // �˻��� ���ڵ� ����
    int search_count = productProc.search_count(map);
    mav.addObject("search_count", search_count);
  
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);
    
    ArrayList<ProdcategrpVO> grplist = prodcategrpProc.list_seqno_asc();
    mav.addObject("grplist", grplist);
    
    // mav.addObject("prod_word", prod_word);
  
    /*
     * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
     * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
     * 
     * @param listFile ��� ���ϸ� 
     * @param prodcategoryno ī�װ���ȣ 
     * @param search_count �˻�(��ü) ���ڵ�� 
     * @param nowPage     ���� ������
     * @param prod_word �˻���
     * @return ����¡ ���� ���ڿ�
     */ 
    String paging = productProc.pagingBox("list_by_prodcateno_search_paging.do", prodcateno, search_count, nowPage, prod_word, viewno, customerno);
    mav.addObject("paging", paging);
  
    mav.addObject("nowPage", nowPage);
    
    return mav;
  }    

  /**
   * �亯 �� http://localhost:9090/ojt/admin/product/reply.do?prodcateno=1
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
   * �亯 ó��
   * 
   * ���� �±��� ����
   * <input type="file" name='filesMF' id='filesMF' size='40' multiple="multiple">
   * ��
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
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    String upDir = Tool.getRealPath(request, "/admin/product/storage");
    // Spring�� File ��ü�� �����ص�, �����ڴ� �̿븸 ��.
    List<MultipartFile> filesMF = productVO.getFilesMF(); 
 
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
    productVO.setFiles(files);
    productVO.setSizes(sizes);
    productVO.setThumbs(thumbs);
    // -------------------------------------------------------------------
    // ���� ���� �ڵ� ����
    // -------------------------------------------------------------------
    
    // ȸ�� ���� �� session ���κ���
    // int adminno = (Integer)session.getAttribute("adminno");
    productVO.setAdminno(1);
    
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------
    ProductVO parentVO = productProc.read(productVO.getProductno()); // �θ�� ���� ����
    
    HashMap<String, Object> map = new HashMap<String, Object>();
    map.put("prod_grpno", parentVO.getProd_grpno());
    map.put("prod_ansnum",  parentVO.getProd_ansnum());
    productProc.increaseAnsnum(map); // ���� ��ϵ� �亯 �ڷ� +1 ó����.

    productVO.setProd_grpno(parentVO.getProd_grpno()); // �θ��� �׷��ȣ �Ҵ�
    productVO.setProd_indent(parentVO.getProd_indent() + 1); // �亯 ���� ����
    productVO.setProd_ansnum(parentVO.getProd_ansnum() + 1); // �θ� �ٷ� �Ʒ� ���
    // --------------------------- �亯 ���� �ڵ� ���� --------------------------

    count = productProc.reply(productVO);
    if (count == 1) {
      prodcateProc.increaseCnt(productVO.getProdcateno()); // �ۼ� ����
    }
 
    mav.setViewName(
        "redirect:/admin/product/reply_msg.jsp?count=" + count + "&prodcateno=" + productVO.getProdcateno()+ "&nowPage=" + nowPage); // /webapp/admin/product/reply_msg.jsp
 
    // mav.setViewName("redirect:/admin/product/list_by_prodcateno_search_paging.do?prodcateno=" + productVO.getProdcateno());
    // mav.setViewName("redirect:/admin/product/list_all_prodcateno.do");
 
    return mav;
  }

  
}







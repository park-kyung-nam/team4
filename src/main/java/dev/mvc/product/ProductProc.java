package dev.mvc.product;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.Tool;

@Component("dev.mvc.product.ProductProc")
public class ProductProc implements ProductProcInter {
  @Autowired
  private ProductDAOInter productDAO;
  
  public ProductProc () {
    System.out.println("--> ProductProc created.");
  }
  
  @Override
  public int get_created_no(){
    return this.productDAO.get_created_no();
  }
  
  @Override
  public int create(ProductVO productVO) {
    int count = productDAO.create(productVO);
    return count;
  }

  @Override
  public ArrayList<ProductVO> list_all_prodcate() {
    ArrayList<ProductVO> list = productDAO.list_all_prodcate();
    return list;
  }

  @Override
  public int total_count() {
    int count = productDAO.total_count();
    return count;
  }

  /**
   * �̹��� ����߿� ù��° �̹��� ���ϸ��� �����Ͽ� ����
   * @param productVO
   * @return
   */
  public String getThumb(ProductVO productVO) {
    String thumbs = productVO.getThumbs();
    String thumb = "";
    
    if (thumbs != null) {
      String[] thumbs_array = thumbs.split("/");
      int count = thumbs_array.length;
      
      if (count > 0) {
        thumb = thumbs_array[0];    
      }
    }
    // System.out.println("thumb: " + thumb);
    return thumb;
  }
  
  @Override
  public ArrayList<ProductVO> list_by_prodcateno(int prodcateno) {
    ArrayList<ProductVO> list = productDAO.list_by_prodcateno(prodcateno);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ProductVO productVO = list.get(i);
      String thumb = getThumb(productVO); // ��ǥ �̹��� ����
      productVO.setThumb(thumb); 
    }
    
    return list;
  }

  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param productVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ProductVO productVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String thumbs = productVO.getThumbs(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String files = productVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = productVO.getSizes();        // 272558/404087... 
    
    String[] thumbs_array = thumbs.split("/");  // Thumbs
    String[] files_array = files.split("/");   // ���ϸ� ����
    String[] sizes_array = sizes.split("/"); // ���� ������

    int count = sizes_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);

    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(thumbs_array[index], 
                                            files_array[index], 
                                            sizes_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }


  @Override
  public ProductVO read(int productno) {
    return productDAO.read(productno);
  }
  
  @Override
  public Prodcate_ProductVO read_by_join(int productno) {
    Prodcate_ProductVO prodcate_ProductVO = productDAO.read_by_join(productno);
    return prodcate_ProductVO;
  }

  @Override
  public int update(ProductVO productVO) {
    int count = productDAO.update(productVO);
    return count;
  }

  @Override
  public int delete(int productno) {
    int count = productDAO.delete(productno);
    return count;
  }
  
  @Override
  public int delete_product(int prodcateno) {
    int count = productDAO.delete_product(prodcateno);
    return count;
  }

  @Override
  public ArrayList<ProductVO> list_by_prodcateno_search(HashMap map) {
    ArrayList<ProductVO> list = productDAO.list_by_prodcateno_search(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ProductVO productVO = list.get(i);
      String thumb = getThumb(productVO); // ��ǥ �̹��� ����
      productVO.setThumb(thumb); 
    }
    
    return list;
  }

  @Override
  public int search_count(HashMap map) {
    int count = productDAO.search_count(map);
    return count;
  }

  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ� 
   * @param prodcateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int prodcateno, int search_count, int nowPage, String prod_word, int viewno, int customerno){ 
    int totalPage = (int)(Math.ceil((double)search_count/Product.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Product.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Product.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Product.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Product.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����
     
    StringBuffer str = new StringBuffer(); 
     
    str.append("<style type='text/css'>"); 
    str.append("  #paging {text-align: center; margin-top: 5px; font-size: 1em;}"); 
    str.append("  #paging A:link {text-decoration:none; color:black; font-size: 1em;}"); 
    str.append("  #paging A:hover{text-decoration:none; background-color: #FFFFFF; color:black; font-size: 1em;}"); 
    str.append("  #paging A:visited {text-decoration:none;color:black; font-size: 1em;}"); 
    str.append("  .span_box_1{"); 
    str.append("    text-align: center;");    
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("    margin:1px 2px 1px 2px; /*��, ������, �Ʒ�, ����*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("���� ������: " + nowPage + " / " + totalPage + "  "); 

    // ���� 10�� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 2�׷��� ���: (2 - 1) * 10 = 1�׷��� 10
    // ���� 3�׷��� ���: (3 - 1) * 10 = 2�׷��� 20
    int _nowPage = (nowGrp-1) * Product.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&prod_word="+prod_word+"&nowPage="+_nowPage+"&prodcateno="+prodcateno+"&viewno="+viewno+"&customerno="+customerno+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./"+listFile+"?prod_word="+prod_word+"&nowPage="+i+"&prodcateno="+prodcateno+"&viewno="+viewno+"&customerno="+customerno+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Product.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&prod_word="+prod_word+"&nowPage="+_nowPage+"&prodcateno="+prodcateno+"&viewno="+viewno+"&customerno="+customerno+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  
  @Override
  public ArrayList<ProductVO> list_by_prodcateno_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Product.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Product.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<ProductVO> list = productDAO.list_by_prodcateno_search_paging(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ProductVO productVO = list.get(i);
      String thumb = getThumb(productVO); // ��ǥ �̹��� ����
      productVO.setThumb(thumb); 
    }
     
    return list;
  }
  
  @Override
  public ArrayList<ProductVO> list_by_prod_price_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Product.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Product.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<ProductVO> list = productDAO.list_by_prod_price_search_paging(map);
    
    int count = list.size();
    for (int i=0; i < count; i++) {
      ProductVO productVO = list.get(i);
      String thumb = getThumb(productVO); // ��ǥ �̹��� ����
      productVO.setThumb(thumb); 
    }
     
    return list;
  }

  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int count = productDAO.increaseAnsnum(map);
    return count;
  }
  
  @Override
  public int reply(ProductVO productVO) {
    int count = productDAO.reply(productVO);
    return count;
  }

  @Override
  public int prod_good_up(int productno) {
    int count = productDAO.prod_good_up(productno);
    return count;
  }

  @Override
  public int prod_good_down(int productno) {
    int count = productDAO.prod_good_down(productno);
    return count;
  }

  @Override
  public int prod_viewcnt_up(int productno) {
    int count = productDAO.prod_viewcnt_up(productno);
    return count;
  }

  @Override
  public int prod_viewcnt_down(int productno) {
    int count = productDAO.prod_viewcnt_down(productno);
    return count;
  }

  @Override
  public int prod_prodest_cnt(HashMap<String, Object> map) {
    int count = productDAO.prod_prodest_cnt(map);
    return count;
  }
  
}









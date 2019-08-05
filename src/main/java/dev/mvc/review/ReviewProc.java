package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.event.EventVO;
import nation.web.tool.FileVO;
import dev.mvc.notice.Notice;
import dev.mvc.notice.NoticeVO;
import nation.web.tool.Tool;

@Component("dev.mvc.review.ReviewProc")
public class ReviewProc implements ReviewProcInter {
  // �ڵ����� ������ NoticeDAOInter Ÿ���� ���� �Ҵ��
  @Autowired
  private ReviewDAOInter reviewDAO;
  
  public ReviewProc () {
    System.out.println("--> ReviewProc created.");
  }
  
  @Override
  public int create(ReviewVO reviewVO) {
    int count = reviewDAO.create(reviewVO);
    return count;
  
  }

  @Override
  public ArrayList<ReviewVO> list() {
    ArrayList<ReviewVO> list = reviewDAO.list();
    return list;
  }
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getR_thumb1(ReviewVO reviewVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String r_thumb1 = reviewVO.getR_thumb1(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String r_file1 = reviewVO.getR_file1();          // xmas01_2.jpg/xmas02_2.jpg...
    String r_size1 = reviewVO.getR_size1();        // 272558/404087... 
    
    String[] r_thumb1_array = r_thumb1.split("/");  // Thumbs
    String[] r_file1_array = r_file1.split("/");   // ���ϸ� ����
    String[] r_size1_array = r_size1.split("/"); // ���� ������

    int count = r_size1_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);

    if (r_file1.length() > 0) {
      for (int index = 0; index < count; index++) {
        r_size1_array[index] = Tool.unit(new Integer(r_size1_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(r_thumb1_array[index], 
                                              r_file1_array[index], 
                                              r_size1_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }

  @Override
  public ReviewVO read(int reviewno) {
    ReviewVO reviewVO = reviewDAO.read(reviewno);
    return reviewVO;
  }

  @Override
  public int update(ReviewVO reviewVO) {
    int count = reviewDAO.update(reviewVO);
    return count;
  }

  @Override
  public int delete(int reviewno) {
    int count = reviewDAO.delete(reviewno);
    return count;
  }

  @Override
  public int search_count(HashMap map) {
    int count = reviewDAO.search_count(map);
    return count;
  }
  /** 
   * SPAN�±׸� �̿��� �ڽ� ���� ����, 1 ���������� ���� 
   * ���� ������: 11 / 22   [����] 11 12 13 14 15 16 17 18 19 20 [����] 
   *
   * @param listFile ��� ���ϸ� 
   * @param cateno ī�װ���ȣ 
   * @param search_count �˻�(��ü) ���ڵ�� 
   * @param nowPage     ���� ������
   * @param word �˻���
   * @return ����¡ ���� ���ڿ�
   */ 
  @Override
  public String pagingBox(String listFile, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Review.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Review.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Review.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Review.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Review.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    int _nowPage = (nowGrp-1) * Review.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // ���� ������, ���� 
      }else{
        // ���� �������� �ƴ� ������
        str.append("<span class='span_box_1'><A href='./"+listFile+"?word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 

    // 10�� ���� �������� �̵�
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // ���� 1�׷��� ���: (1 * 10) + 1 = 2�׷��� 11
    // ���� 2�׷��� ���: (2 * 10) + 1 = 3�׷��� 21
    _nowPage = (nowGrp * Review.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  
  @Override
  public ArrayList<ReviewVO> list_by_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Notice.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Review.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<ReviewVO> list = reviewDAO.list_by_search_paging(map);
    
   /* int count = list.size();
    for (int i=0; i < count; i++) {
      ReviewVO reviewVO = list.get(i);
      String n_thumb = getR_thumb(reviewVO); // ��ǥ �̹��� ����
      reviewVO.setThumb(thumb); 
    }*/
    
    return list;
  }
  
  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int count = reviewDAO.increaseAnsnum(map);
    return count;
  }
  
  @Override
  public int reply(ReviewVO reviewVO) {
    int count = reviewDAO.reply(reviewVO);
    return count;
  }
  
}  
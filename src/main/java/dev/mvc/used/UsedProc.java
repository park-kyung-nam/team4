package dev.mvc.used;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.FileVO;
import nation.web.tool.Tool;

@Component("dev.mvc.used.UsedProc")
public class UsedProc implements UsedProcInter {
  // �ڵ����� ������ NoticeDAOInter Ÿ���� ���� �Ҵ��
  @Autowired
  private UsedDAOInter usedDAO;
  
  public UsedProc () {
    System.out.println("--> UsedProc created.");
  }
  
  @Override
  public int create(UsedVO usedVO) {
    int count = usedDAO.create(usedVO);
    return count;
  
  }

  @Override
  public ArrayList<UsedVO> list() {
    ArrayList<UsedVO> list = usedDAO.list();
    return list;
  }
  /**
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getU_thumb1(UsedVO usedVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String u_thumb1 = usedVO.getU_thumb1(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String u_file1 = usedVO.getU_file1();          // xmas01_2.jpg/xmas02_2.jpg...
    String u_size1 = usedVO.getU_size1();        // 272558/404087... 
    
    String[] u_thumb1_array = u_thumb1.split("/");  // Thumbs
    String[] u_file1_array = u_file1.split("/");   // ���ϸ� ����
    String[] u_size1_array = u_size1.split("/"); // ���� ������

    int count = u_size1_array.length;
    // System.out.println("sizes_array.length: " + sizes_array.length);
    // System.out.println("sizes: " + sizes);
    // System.out.println("files: " + files);

    if (u_file1.length() > 0) {
      for (int index = 0; index < count; index++) {
        u_size1_array[index] = Tool.unit(new Integer(u_size1_array[index]));  // 1024 -> 1KB
      
        FileVO fileVO = new FileVO(u_thumb1_array[index], 
                                              u_file1_array[index], 
                                              u_size1_array[index]);
        file_list.add(fileVO);
      }
    } 

    return file_list;
  }

  @Override
  public UsedVO read(int usedno) {
    UsedVO usedVO = usedDAO.read(usedno);
    return usedVO;
  }

  @Override
  public int update(UsedVO usedVO) {
    int count = usedDAO.update(usedVO);
    return count;
  }

  @Override
  public int delete(int usedno) {
    int count = usedDAO.delete(usedno);
    return count;
  }

  @Override
  public int search_count(HashMap map) {
    int count = usedDAO.search_count(map);
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
    int totalPage = (int)(Math.ceil((double)search_count/Used.RECORD_PER_PAGE)); // ��ü ������  
    int totalGrp = (int)(Math.ceil((double)totalPage/Used.PAGE_PER_BLOCK));// ��ü �׷� 
    int nowGrp = (int)(Math.ceil((double)nowPage/Used.PAGE_PER_BLOCK));    // ���� �׷� 
    int startPage = ((nowGrp - 1) * Used.PAGE_PER_BLOCK) + 1; // Ư�� �׷��� ������ ��� ����  
    int endPage = (nowGrp * Used.PAGE_PER_BLOCK);             // Ư�� �׷��� ������ ��� ����   
     
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
    int _nowPage = (nowGrp-1) * Used.PAGE_PER_BLOCK;  
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
    _nowPage = (nowGrp * Used.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"'>����</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  
  @Override
  public ArrayList<UsedVO> list_by_search_paging(HashMap<String, Object> map) {
    /* 
    ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
    1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
    2 ������: nowPage = 2, (2 - 1) * 10 --> 10
    3 ������: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Used.RECORD_PER_PAGE;
   
    // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
   int startNum = beginOfPage + 1; 
   //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
   int endNum = beginOfPage + Used.RECORD_PER_PAGE;   
   /*
    1 ������: WHERE r >= 1 AND r <= 10
    2 ������: WHERE r >= 11 AND r <= 20
    3 ������: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<UsedVO> list = usedDAO.list_by_search_paging(map);
    
   /* int count = list.size();
    for (int i=0; i < count; i++) {
      UsedVO usedVO = list.get(i);
      String u_thumb = getU_thumb(usedVO); // ��ǥ �̹��� ����
      usedVO.setThumb(thumb); 
    }*/
    
    return list;
  }
  
  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    int count = usedDAO.increaseAnsnum(map);
    return count;
  }
  
  @Override
  public int reply(UsedVO usedVO) {
    int count = usedDAO.reply(usedVO);
    return count;
  }
  
}  
package dev.mvc.used;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import nation.web.tool.FileVO;
import nation.web.tool.Tool;

@Component("dev.mvc.used.UsedProc")
public class UsedProc implements UsedProcInter {
  // 자동으로 생성된 NoticeDAOInter 타입의 빈이 할당됨
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
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getU_thumb1(UsedVO usedVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String u_thumb1 = usedVO.getU_thumb1(); // xmas01_2_t.jpg/xmas02_2_t.jpg...
    String u_file1 = usedVO.getU_file1();          // xmas01_2.jpg/xmas02_2.jpg...
    String u_size1 = usedVO.getU_size1();        // 272558/404087... 
    
    String[] u_thumb1_array = u_thumb1.split("/");  // Thumbs
    String[] u_file1_array = u_file1.split("/");   // 파일명 추출
    String[] u_size1_array = u_size1.split("/"); // 파일 사이즈

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
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param listFile 목록 파일명 
   * @param cateno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(String listFile, int search_count, int nowPage, String word){ 
    int totalPage = (int)(Math.ceil((double)search_count/Used.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/Used.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/Used.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * Used.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * Used.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
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
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("  .span_box_2{"); 
    str.append("    text-align: center;");    
    str.append("    background-color: #668db4;"); 
    str.append("    color: #FFFFFF;"); 
    str.append("    font-size: 1em;"); 
    str.append("    border: 1px;"); 
    str.append("    border-style: solid;"); 
    str.append("    border-color: #cccccc;"); 
    str.append("    padding:1px 6px 1px 6px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("    margin:1px 2px 1px 2px; /*위, 오른쪽, 아래, 왼쪽*/"); 
    str.append("  }"); 
    str.append("</style>"); 
    str.append("<DIV id='paging'>"); 
//    str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 

    // 이전 10개 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
    // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
    int _nowPage = (nowGrp-1) * Used.PAGE_PER_BLOCK;  
    if (nowGrp >= 2){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"'>이전</A></span>"); 
    } 

    for(int i=startPage; i<=endPage; i++){ 
      if (i > totalPage){ 
        break; 
      } 
  
      if (nowPage == i){ 
        str.append("<span class='span_box_2'>"+i+"</span>"); // 현재 페이지, 강조 
      }else{
        // 현재 페이지가 아닌 페이지
        str.append("<span class='span_box_1'><A href='./"+listFile+"?word="+word+"&nowPage="+i+"'>"+i+"</A></span>");   
      } 
    } 

    // 10개 다음 페이지로 이동
    // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
    // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
    // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
    _nowPage = (nowGrp * Used.PAGE_PER_BLOCK)+1;  
    if (nowGrp < totalGrp){ 
      str.append("<span class='span_box_1'><A href='./"+listFile+"?&word="+word+"&nowPage="+_nowPage+"'>다음</A></span>"); 
    } 
    str.append("</DIV>"); 
     
    return str.toString(); 
  }
 
  
  @Override
  public ArrayList<UsedVO> list_by_search_paging(HashMap<String, Object> map) {
    /* 
    페이지에서 출력할 시작 레코드 번호 계산 기준값, nowPage는 1부터 시작
    1 페이지: nowPage = 1, (1 - 1) * 10 --> 0 
    2 페이지: nowPage = 2, (2 - 1) * 10 --> 10
    3 페이지: nowPage = 3, (3 - 1) * 10 --> 20
    */
   int beginOfPage = ((Integer)map.get("nowPage") - 1) * Used.RECORD_PER_PAGE;
   
    // 시작 rownum, 1 페이지: 1 / 2 페이지: 11 / 3 페이지: 21 
   int startNum = beginOfPage + 1; 
   //  종료 rownum, 1 페이지: 10 / 2 페이지: 20 / 3 페이지: 30
   int endNum = beginOfPage + Used.RECORD_PER_PAGE;   
   /*
    1 페이지: WHERE r >= 1 AND r <= 10
    2 페이지: WHERE r >= 11 AND r <= 20
    3 페이지: WHERE r >= 21 AND r <= 30
    */
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<UsedVO> list = usedDAO.list_by_search_paging(map);
    
   /* int count = list.size();
    for (int i=0; i < count; i++) {
      UsedVO usedVO = list.get(i);
      String u_thumb = getU_thumb(usedVO); // 대표 이미지 추출
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
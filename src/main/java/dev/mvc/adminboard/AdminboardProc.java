package dev.mvc.adminboard;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.admin.AdminDAOInter;
import nation.web.tool.FileVO;
import nation.web.tool.Tool;

@Component("dev.mvc.adminboard.AdminboardProc")
public class AdminboardProc implements AdminboardProcInter{
  @Autowired
  private AdminDAOInter adminDAO;
  @Autowired
  private AdminboardDAOInter adminboardDAO;
  

  @Override
  public int post(AdminboardVO adminboardVO) {
    return this.adminboardDAO.post(adminboardVO);
  }
  
  @Override
  public int get_created_no(){
    return this.adminboardDAO.get_created_no();
  }

  @Override
  public ArrayList<AdminboardVO> boardlist() {
    return this.adminboardDAO.boardlist();
  }

  @Override
  public ArrayList<AdminboardInclVO> boardlist_incl() {
    return this.adminboardDAO.boardlist_incl();
  }
  
  @Override
  public int search_count(HashMap<String, Object> map) {
    return this.adminboardDAO.search_count(map);
  }

  @Override
  public ArrayList<AdminboardInclVO> boardlist_incl_spg(HashMap<String, Object> map) {

   int beginOfPage = ((Integer)map.get("nowPage") - 1) * ADMINBOARD.RECORD_PER_PAGE;
   
   int startNum = beginOfPage + 1; 
   int endNum = beginOfPage + ADMINBOARD.RECORD_PER_PAGE;   
   map.put("startNum", startNum);
   map.put("endNum", endNum);
   
    ArrayList<AdminboardInclVO> list = adminboardDAO.boardlist_incl_spg(map);
    
    return list;
    
  }
  

  /** 
   * SPAN태그를 이용한 박스 모델의 지원, 1 페이지부터 시작 
   * 현재 페이지: 11 / 22   [이전] 11 12 13 14 15 16 17 18 19 20 [다음] 
   *
   * @param catno 카테고리번호 
   * @param search_count 검색(전체) 레코드수 
   * @param nowPage     현재 페이지
   * @param word 검색어
   * @return 페이징 생성 문자열
   */ 
  @Override
  public String pagingBox(int search_count, int nowPage, String word, String name, String content, String id){ 
    int totalPage = (int)(Math.ceil((double)search_count/ADMINBOARD.RECORD_PER_PAGE)); // 전체 페이지  
    int totalGrp = (int)(Math.ceil((double)totalPage/ADMINBOARD.PAGE_PER_BLOCK));// 전체 그룹 
    int nowGrp = (int)(Math.ceil((double)nowPage/ADMINBOARD.PAGE_PER_BLOCK));    // 현재 그룹 
    int startPage = ((nowGrp - 1) * ADMINBOARD.PAGE_PER_BLOCK) + 1; // 특정 그룹의 페이지 목록 시작  
    int endPage = (nowGrp * ADMINBOARD.PAGE_PER_BLOCK);             // 특정 그룹의 페이지 목록 종료   
     
    StringBuffer str = new StringBuffer(); 
    
   str.append("<ul class='pagination my-0'>"); 
//   str.append("현재 페이지: " + nowPage + " / " + totalPage + "  "); 
   
   if(startPage < 1){
     startPage = 1;
   }
   if(endPage > totalPage){
     endPage = totalPage;
   }

   // 이전 10개 페이지로 이동
   // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
   // 현재 2그룹일 경우: (2 - 1) * 10 = 1그룹의 10
   // 현재 3그룹일 경우: (3 - 1) * 10 = 2그룹의 20
   int _nowPage = (nowPage-1);  
   if (nowPage >= 2){ 
     str.append("<li class='page-item'><A class='page-link' href='./list.do?&content="+content+"&nowPage="+_nowPage+"&name="+name+"'><span aria-hidden='true'>&laquo;</span> 이전</A></li>"); 
   } 

   for(int i=startPage; i<=endPage; i++){ 
     if (i > totalPage){ 
       break; 
     } 
 
     if (nowPage == i){ 
       str.append("<li class='page-item active'><A class='page-link' href=''>"+i+"</a></li>"); // 현재 페이지, 강조 
     }else{
       // 현재 페이지가 아닌 페이지
       str.append("<li class='page-item'><A class='page-link' href='./list.do?content="+content+"&nowPage="+i+"&name="+name+"'>"+i+"</A></li>");   
     } 
   } 

   // 10개 다음 페이지로 이동
   // nowGrp: 1 (1 ~ 10 page),  nowGrp: 2 (11 ~ 20 page),  nowGrp: 3 (21 ~ 30 page) 
   // 현재 1그룹일 경우: (1 * 10) + 1 = 2그룹의 11
   // 현재 2그룹일 경우: (2 * 10) + 1 = 3그룹의 21
   _nowPage = (nowPage+1);  
   if (nowPage < totalPage){ 
     str.append("<li class='page-item'><A class='page-link' href='./list.do?&content="+content+"&nowPage="+_nowPage+"&name="+name+"'>다음 <span aria-hidden='true'>&raquo;</span></A></li>"); 
   } 
   str.append("</ul>"); 

   return str.toString(); 
  }

  @Override
  public AdminboardVO read(int adminboardno) {
    return this.adminboardDAO.read(adminboardno);
  }

  @Override
  public AdminboardInclVO read_incl(int adminboardno) {
    return this.adminboardDAO.read_incl(adminboardno);
  }

  @Override
  public ArrayList<FileVO> getFiles(AdminboardInclVO adminboardVO) {
    ArrayList<FileVO> file_list = new ArrayList<FileVO>();
    
    String files = adminboardVO.getFiles();          // xmas01_2.jpg/xmas02_2.jpg...
    String sizes = adminboardVO.getSizes();        // 272558/404087... 
    
    String[] files_array = files.split("/");   // 파일명 추출
    String[] sizes_array = sizes.split("/"); // 파일 사이즈

    int count = sizes_array.length;
     //System.out.println("thumbs_array.length: " + thumbs_array.length);
     //System.out.println("files_array.length: " + files_array.length);
     //System.out.println("sizes_array.length: " + sizes_array.length);
     //System.out.println("thumbs: " + thumbs);
     //System.out.println("sizes: " + sizes);
     //System.out.println("files: " + files);

     //System.out.println("thumbs_array: " + thumbs_array.toString());
     //System.out.println("files_array: " + files_array.toString());
     //System.out.println("sizes_array: " + sizes_array.toString());


    if (files.length() > 0) {
      for (int index = 0; index < count; index++) {
        sizes_array[index] = Tool.unit(new Integer(sizes_array[index]));  // 1024 -> 1KB

        //System.out.println("thumbs_array[index] : " + thumbs_array[index]);
        //System.out.println("files_array[index] : " + files_array[index]);
        //System.out.println("sizes_array[index] : " + sizes_array[index]);
        
        /*FileVO fileVO = new FileVO(thumbs_array[index], 
                                            files_array[index], 
                                            sizes_array[index]);*/
        file_list.add(new FileVO("",files_array[index],sizes_array[index]));
      }
    } 

    return file_list;
  }

  @Override
  public int update(AdminboardVO adminboardVO) {
    return this.adminboardDAO.update(adminboardVO);
  }

  @Override
  public int delete(int adminboardno) {
    return this.adminboardDAO.delete(adminboardno);
  }

  @Override
  public int discard(int adminno) {
    return this.adminboardDAO.discard(adminno);
  }

}

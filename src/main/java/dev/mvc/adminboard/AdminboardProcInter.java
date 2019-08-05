package dev.mvc.adminboard;

import java.util.ArrayList;
import java.util.HashMap;

import nation.web.tool.FileVO;

public interface AdminboardProcInter {
  
  public int post(AdminboardVO adminboardVO);

  public int get_created_no();
  
  public ArrayList<AdminboardVO> boardlist();
  
  public ArrayList<AdminboardInclVO> boardlist_incl();

  public int search_count(HashMap<String, Object> map);
  
  public ArrayList<AdminboardInclVO> boardlist_incl_spg(HashMap<String, Object> map);
  
  public AdminboardVO read(int adminboardno);
  
  public AdminboardInclVO read_incl(int adminboardno);
  
  public int update(AdminboardVO adminboardVO);
  
  public int delete(int adminboardno);
  
  public int discard(int adminno);

  public ArrayList<FileVO> getFiles(AdminboardInclVO adminboardInclVO);

  String pagingBox(int search_count, int nowPage, String word, String name, String content, String id);

}

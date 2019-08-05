package dev.mvc.adminboard;

import java.util.ArrayList;
import java.util.HashMap;

public interface CommentsProcInter {
  
  public int create(CommentsVO commentsVO);
  
  public ArrayList<CommentsInclVO> comments(int adminboardno);
  
  public CommentsInclVO read(int admincommentno);
  
  public int update(CommentsVO commentsVO);
  
  public int delete(int admincommentno);
  
  public int search_count(int adminboardno);
  
  public int reply(CommentsVO commentsVO);
  
  public int increaseAnsnum(HashMap<String, Object> map);

}

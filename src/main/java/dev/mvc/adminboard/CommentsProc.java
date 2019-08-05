package dev.mvc.adminboard;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.adminboard.CommentsProc")
public class CommentsProc implements CommentsProcInter {
  
  @Autowired
  private CommentsDAOInter commentsDAO;

  @Override
  public int create(CommentsVO commentsVO) {
    return this.commentsDAO.create(commentsVO);
  }

  @Override
  public ArrayList<CommentsInclVO> comments(int adminboardno) {
    return this.commentsDAO.comments(adminboardno);
  }

  @Override
  public CommentsInclVO read(int admincommentno) {
    return this.commentsDAO.read(admincommentno);
  }

  @Override
  public int update(CommentsVO commentsVO) {
    return this.commentsDAO.update(commentsVO);
  }

  @Override
  public int delete(int admincommentno) {
    return this.commentsDAO.delete(admincommentno);
  }

  @Override
  public int search_count(int adminboardno) {
    return this.commentsDAO.search_count(adminboardno);
  }

  @Override
  public int reply(CommentsVO commentsVO) {
    return this.commentsDAO.reply(commentsVO);
  }

  @Override
  public int increaseAnsnum(HashMap<String, Object> map) {
    return this.commentsDAO.increaseAnsnum(map);
  }

}

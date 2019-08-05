package dev.mvc.reply;

import java.util.ArrayList;

  

public interface ReplyDAOInter {

    /**
     *    <insert id="create" parameterType="ReplyVO">
     */
    public int create(ReplyVO ReplyVO);
    
    public ReplyVO read(int question_no);
}

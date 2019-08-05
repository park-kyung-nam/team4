package dev.mvc.reply;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


@Component("dev.mvc.reply.ReplyProc")
public class ReplyProc implements ReplyProcInter {
    @Autowired
    private ReplyDAOInter replyDAO;
    
    
    @Override
    public int create(ReplyVO ReplyVO) {
       int create = replyDAO.create(ReplyVO);
        return create;
    }


    @Override
    public ReplyVO read(int question_no) {
        ReplyVO read = replyDAO.read(question_no);
        return read;
    }

    

 

}

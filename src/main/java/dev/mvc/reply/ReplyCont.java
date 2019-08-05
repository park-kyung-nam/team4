package dev.mvc.reply;

import java.util.ArrayList;
import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.service.ServiceVO;





@Controller
public class ReplyCont {
 
    @Autowired
    @Qualifier("dev.mvc.reply.ReplyProc")
    private ReplyProcInter replyProc;

    @RequestMapping(value="/reply/create.do", method=RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/reply/create"); // /webapp/service/create.jsp
      
      
      
      return mav;
    }
    
    
 // categrpVO는 Form 태그의 값으로 자동 저장됨.
    // http://localhost:9090/team4/service/create.do
    @RequestMapping(value="/reply/create.do", method=RequestMethod.POST)
    public ModelAndView create(ReplyVO replyVO) {
      ModelAndView mav = new ModelAndView();
      // mav.setViewName("/categrp/create_msg"); // /webapp/categrp/create_msg.jsp
      
      int count = replyProc.create(replyVO);
      
      int question_no = replyVO.getReply_no();
      replyVO = replyProc.read(question_no); 
      mav.addObject("replyVO", replyVO);
      // mav.addObject("count", count);
      mav.setViewName("redirect:/reply/create_msg.jsp?count=" + count);
      
      return mav;
    }
    
}

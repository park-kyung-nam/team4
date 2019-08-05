package dev.mvc.delivery;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;




@Controller
public class DeliveryCont{
    @Autowired
    @Qualifier("dev.mvc.delivery.DeliveryProc")
    private DeliveryProcInter deliveryProc;
    
    
 // http://localhost:9090/ojt/delivery/create.do
    @RequestMapping(value="/delivery/create.do", method=RequestMethod.GET)
    public ModelAndView create() {
      ModelAndView mav = new ModelAndView();
      mav.setViewName("/delivery/create"); // /webapp/categrp/create.jsp
      
      return mav;
    }
    
    
    // categrpVO는 Form 태그의 값으로 자동 저장됨.
    // http://localhost:9090/ojt/delivery/create.do
    @RequestMapping(value="/delivery/create.do", method=RequestMethod.POST)
    public ModelAndView create(DeliveryVO deliveryVO) {
      ModelAndView mav = new ModelAndView();
      // mav.setViewName("/delivery/create_msg"); // /webapp/delivery/create_msg.jsp
      
      int count = deliveryProc.create(deliveryVO);
      // mav.addObject("count", count);
      mav.setViewName("redirect:/delivery/create_msg.jsp?count=" + count);
      
      return mav;
    }
}
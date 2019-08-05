package dev.mvc.order;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
   
@Controller
public class orderCont {
	@Autowired 
	@Qualifier("dev.mvc.order.orderProc")
	private orderProcInter orderProc = null;
	
	  public orderCont(){
		    System.out.println("--> orderCont created.");
		  }
		  
	  
	  /**
	   * 주문 등록
	   */
	 // http://localhost:9090/team4/order/order.do 
	 @RequestMapping(value="/order/order.do", method=RequestMethod.GET)
	 public ModelAndView order() {
	   ModelAndView mav = new ModelAndView();
	   mav.setViewName("/order/order"); // /webapp/order/order.jsp
	     
	   return mav;
	 }
	  
	 // http://localhost:9090/team4/order/order.do 
	@RequestMapping(value="/order/order.do",  
	                          method=RequestMethod.POST)
	public ModelAndView order(HttpServletRequest request,
	    @RequestParam(value="customerno", defaultValue="1") int customerno,
	    @RequestParam(value="productno", defaultValue="1") int productno,
	    orderVO orderVO) {
	  // System.out.println("order called."); 
	  ModelAndView mav = new ModelAndView();
	 
	  int count = orderProc.order(orderVO); 
	  mav.setViewName("redirect:/order/order_msg.jsp?count=" + count +
	      "&orderno=" + orderVO.getOrderno()+"&productno="+productno+"&customerno="+customerno);
	   
	  return mav;
	}  
	
	 /**
	  * 주문 조회
	  * @param orderVO
	  * @return
	  */
	    //  http://localhost:9090/team4/order/read_order.do?orderno=11
	 
	 @RequestMapping(value="/order/read_order.do", method=RequestMethod.GET)
	 public ModelAndView read_order(int orderno){
	   // System.out.println("--> read_order(int customerno) GET called.");
	   ModelAndView mav = new ModelAndView(); 
	   mav.setViewName("/order/read_order"); // webapp/order/read_order.jsp
	     
     Order_ProductVO  order_productVO = orderProc.read_order(orderno);
     mav.addObject("order_productVO", order_productVO);
	   
	   return mav; 
	 }   
	 
	 /**
	  * 주문 수정 GET
	  * @param orderVO
	  * @return
	  */
	  @RequestMapping(value="/order/update_order.do", 
	                            method=RequestMethod.GET)
	  public ModelAndView update_order(int orderno) {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/order/update_order");  
	    
	     Order_ProductVO  order_productVO = orderProc.read_order(orderno);
	      mav.addObject("order_productVO", order_productVO);
	    
	    return mav;
	  }
	 
		 /**
		  * 주문 수정 POST
		  * @param orderVO 
		  * @return
		  */
	//  http://localhost:9090/team4/order/update_order.do
	 @RequestMapping(value="/order/update_order.do", method=RequestMethod.POST)
	  public ModelAndView update(orderVO orderVO) {
	    ModelAndView mav = new ModelAndView();
	    
	    int count = orderProc.update_order(orderVO);
	    mav.setViewName("redirect:/order/update_order_msg.jsp?count=" + count + "&customerno="+orderVO.getCustomerno());
	    mav.addObject("orderVO", orderVO); 
	      
	    return mav; 
	  }
	 
	 
	 /**
	  * 회원의 주문 목록
	  * @param orderVO
	  * @return
	  */
	  // http://localhost:9090/team4/order/list_order.do?customerno=1
	  @RequestMapping(value="/order/list_order.do", method=RequestMethod.GET)
	  public ModelAndView list_order(int customerno) {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("/order/list_order"); // /webapp/order/list_order.jsp
	    
	    System.out.println(customerno);
	    ArrayList<Order_ProductVO> list = orderProc.list_order(customerno);
	    mav.addObject("list", list);
	    
	    Order_ProductVO  order_productVO = orderProc.read_order(customerno);
      mav.addObject("order_productVO", order_productVO);
	    
	    return mav;
	  }  
	 
	 /**
	  * 주문 삭제(delete)
	  */
	  @RequestMapping(value = "/order/delete_order.do", method = RequestMethod.GET)
	  public ModelAndView delete(int orderno) {
	    ModelAndView mav = new ModelAndView();
	    
	    Order_ProductVO  order_productVO = orderProc.read_order(orderno);
      mav.addObject("order_productVO", order_productVO);
	    
	    mav.setViewName("/order/delete_order"); // /webapp/order/delete_order.jsp
	 
	    return mav;
	  }
	  
	  /**
	   * 삭제
	   * @param request
	   * @param orderVO
	   * @return
	   */
	  @RequestMapping(value="/order/delete_order.do", 
	                            method=RequestMethod.POST)
	  public ModelAndView delete_proc(int orderno) {
	    ModelAndView mav = new ModelAndView();
	   
	    // orderVO orderVO = orderProc.read_order(orderno);
	    
	    int count = orderProc.delete_order(orderno);

	    mav.setViewName("redirect:/order/delete_order_msg.jsp?count=" + count+"&orderno=" + orderno);
	    
	    return mav;
	  }  
 
	
}
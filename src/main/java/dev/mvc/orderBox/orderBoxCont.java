package dev.mvc.orderBox;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

 
@Controller
public class orderBoxCont {
	@Autowired  
	@Qualifier("dev.mvc.orderBox.orderBoxProc")
	private orderBoxProcInter orderBoxProc = null;
	
	  public orderBoxCont(){
		    System.out.println("--> orderBoxCont created.");
		  }

	  /*********************************************************************************/
	 /** 장바구니 관련 **/
	 /*********************************************************************************/
	  
	  /**
	   * 제품 상세보기
	   */
	  @RequestMapping(value="/orderBox/detail_product.do", method=RequestMethod.GET)
		 public ModelAndView read_order(int productno){
		   
		   ModelAndView mav = new ModelAndView(); 
		   mav.setViewName("/orderBox/detail_product"); // webapp/orderBox/detail_product.jsp
		     
		   orderBoxVO orderBoxVO = orderBoxProc.detail_product(productno); 
		   mav.addObject("orderBoxVO", orderBoxVO);
		   
		   return mav; 
		 }   
	  
	  /**
	   * 장바구니 등록 
	 * @param productno 
	   */
	 // http://localhost:9090/team4/orderBox/orderBox.do?productno=1 
	 @RequestMapping(value="/orderBox/orderBox.do", method=RequestMethod.GET)
	 public ModelAndView orderBox(HttpServletRequest request,
	     @RequestParam(value="productno", defaultValue="1") int productno,
	     orderBoxVO orderBoxVO) {
		 
	   ModelAndView mav = new ModelAndView();      
	   
	   System.out.println("productno"+productno);
	      
	    int count = orderBoxProc.orderBox(productno); 
	    
	    mav.setViewName("redirect:/orderBox/orderBox_msg.jsp?count=" + count +"&productno="+productno);
	    
	     return mav;
	 }  

	/**
	 *  장바구니 목록(사용자번호)
	 */
	  // http://localhost:9090/team4/orderBox/list_orderBox.do?customerno=1
	  @RequestMapping(value="/orderBox/list_orderBox.do", method=RequestMethod.GET)
	  public ModelAndView list_orderBox(int customerno) {
		   
		Map<String, Object> map =new HashMap<String, Object>();
		ArrayList<orderBoxVO> list = orderBoxProc.list_orderBox(customerno);
		ModelAndView mav = new ModelAndView();
		
		map.put("list", list);

	    mav.setViewName("/orderBox/list_orderBox"); // /webapp/orderBox/list_orderBox.jsp
	    
	    mav.addObject("map", map);
	      
	  //  orderBoxVO orderBoxVO = orderBoxProc.list_orderBox(customerno); 
	  //  mav.addObject("orderBoxVO", orderBoxVO); 
	     
	    return mav;
	  }  
	  
	  /***************************************테스트 ***
	     
	      /**
		  * 장바구니 삭제(delete)
		  */
		  @RequestMapping(value = "/orderBox/delete_orderBox.do", method = RequestMethod.GET)
		  public ModelAndView delete_orderBox(int orderBoxno) {
		    ModelAndView mav = new ModelAndView();
		     
		    int count = orderBoxProc.delete_orderBox(orderBoxno);
		    
		    mav.setViewName("redirect:/orderBox/delete_orderBox_msg.jsp?count=" + count); // /webapp/orderBox/list_orderBox.jsp
		 
		    return mav;     
		  } 
		   
		  
			 /**
			  * 장바구니 수량 수정 GET
			  * @param orderBoxVO
			  * @return
			  */
			  @RequestMapping(value="/orderBox/update_orderBox.do", 
			                            method=RequestMethod.GET)
			  public ModelAndView update_order(int orderBoxno) {
				  
			    ModelAndView mav = new ModelAndView(); 
			    
			    mav.setViewName("/orderBox/update_orderBox");  
			    
			    orderBoxVO orderBoxVO = orderBoxProc.read_orderBox(orderBoxno);
			    
			    mav.addObject("orderBoxVO", orderBoxVO);
			     
			    return mav;
			  }
			 
				 /**
				  * 장바구니 수량 수정 POST
				  * @param orderBoxVO 
				  * @return
				  */
			 @RequestMapping(value="/orderBox/update_orderBox.do", method=RequestMethod.POST)
			  public ModelAndView update(orderBoxVO orderBoxVO) {
				 
			    ModelAndView mav = new ModelAndView();
			   
				int count = orderBoxProc.update_orderBox(orderBoxVO); 
			    
			    mav.setViewName("redirect:/orderBox/update_orderBox_msg.jsp?count=" + count+"&orderBoxno=" + orderBoxVO.getOrderBoxno());
			    
			    mav.addObject("orderBoxVO", orderBoxVO);  
			        
			    return mav; 
			  }
	
	
	}
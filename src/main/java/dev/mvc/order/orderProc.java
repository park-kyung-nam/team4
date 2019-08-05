package dev.mvc.order;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


 

@Component("dev.mvc.order.orderProc")
public class orderProc implements orderProcInter {

	@Autowired
	private orderDAOInter orderDAO; 
	
	  public orderProc(){
		    System.out.println("--> orderProc created.");
		  }
	
	  /**
	   * 주문등록(create) 
	   */
	@Override
	public int order(orderVO orderVO) {
		int count = orderDAO.order(orderVO); 
		return count;
	}



	/** 
	 * 주문조회(read)
	 */
	@Override
	public Order_ProductVO read_order(int orderno) {
	  Order_ProductVO order_productVO = orderDAO.read_order(orderno);
		return order_productVO;
	}

	/**
	 * 주문수정(update)
	 */
	@Override
	public int update_order(orderVO orderVO) {
		int count = orderDAO.update_order(orderVO);
		return count; 
	}

	/**
	  * 회원의 주문 목록 
	  * @param orderVO
	  * @return
	  */  
	@Override
	public ArrayList<Order_ProductVO> list_order(int customerno) { 
		ArrayList<Order_ProductVO> list = orderDAO.list_order(customerno);
		return list;
	}

	/**
	 * 주문 삭제(delete)
	 */
	@Override
	public int delete_order(int orderno) {
		int count = orderDAO.delete_order(orderno);
		return count;
	}
 

	
	
} 
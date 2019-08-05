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
	   * �ֹ����(create) 
	   */
	@Override
	public int order(orderVO orderVO) {
		int count = orderDAO.order(orderVO); 
		return count;
	}



	/** 
	 * �ֹ���ȸ(read)
	 */
	@Override
	public Order_ProductVO read_order(int orderno) {
	  Order_ProductVO order_productVO = orderDAO.read_order(orderno);
		return order_productVO;
	}

	/**
	 * �ֹ�����(update)
	 */
	@Override
	public int update_order(orderVO orderVO) {
		int count = orderDAO.update_order(orderVO);
		return count; 
	}

	/**
	  * ȸ���� �ֹ� ��� 
	  * @param orderVO
	  * @return
	  */  
	@Override
	public ArrayList<Order_ProductVO> list_order(int customerno) { 
		ArrayList<Order_ProductVO> list = orderDAO.list_order(customerno);
		return list;
	}

	/**
	 * �ֹ� ����(delete)
	 */
	@Override
	public int delete_order(int orderno) {
		int count = orderDAO.delete_order(orderno);
		return count;
	}
 

	
	
} 
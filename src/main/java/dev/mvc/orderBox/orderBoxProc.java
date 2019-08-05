package dev.mvc.orderBox;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;


 

@Component("dev.mvc.orderBox.orderBoxProc")
public class orderBoxProc implements orderBoxProcInter {

	@Autowired
	private orderBoxDAOInter orderBoxDAO; 
	 
	  public orderBoxProc(){ 
		    System.out.println("--> orderBoxProc created.");
		  } 
	  
	  
	  /**
	   * ��ǰ ������
	   */
	  @Override
	  public orderBoxVO detail_product(int productno){
		  orderBoxVO  orderBoxVO= orderBoxDAO.detail_product(productno);
		  return orderBoxVO;  
	  }
	  	   
	  
	  /**
	   * ��ٱ��� ���(insert)
	   */
	  @Override 
	  public int orderBox(int productno){
		int count = orderBoxDAO.orderBox(productno);
			return count;   
	  }


	  /**
	   * ȸ���� ��ٱ��� ���(list)
	   */
	@Override
	public ArrayList<orderBoxVO> list_orderBox(int customerno) {
		ArrayList<orderBoxVO> list = orderBoxDAO.list_orderBox(customerno);
		return list; 
	}

	/**
	 * ��ٱ��� �ݾ� �հ�
	 */
	@Override  
	public int SumAllPrice(int customerno) {
		int SumAllPrice = orderBoxDAO.SumAllPrice(customerno);
		return SumAllPrice; 
	}

	/**
	 * ��ٱ��� ����
	 */
	@Override
	public int delete_orderBox(int orderBoxno) {
		int count = orderBoxDAO.delete_orderBox(orderBoxno);
		return count;
	}


	/** 
	 * ��ٱ��� ��ȸ
	 */
	@Override
	public orderBoxVO read_orderBox(int orderBoxno) {
		orderBoxVO orderBoxVO = orderBoxDAO.read_orderBox(orderBoxno);
		return orderBoxVO;
	}

	/**
	 * ��ٱ��� ��ǰ ���� ����(update)
	 */ 
	@Override
	public int update_orderBox(orderBoxVO orderBoxVO) {
		int count = orderBoxDAO.update_orderBox(orderBoxVO);
		return count;
	}

/**
 * ��ٱ��� ���� ��ǰ �˻�
 
		@Override
	public int count_orderBox(int productno, int customerno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productno", productno);
		map.put("customerno", customerno); 
		
		int count = sqlSession.selectOne("count_orderBox", map);
		return count;  
	}   
  
  */



 
	  
	
	
	
	
}
	  
	  
	
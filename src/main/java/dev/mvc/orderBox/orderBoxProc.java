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
	   * 상품 상세정보
	   */
	  @Override
	  public orderBoxVO detail_product(int productno){
		  orderBoxVO  orderBoxVO= orderBoxDAO.detail_product(productno);
		  return orderBoxVO;  
	  }
	  	   
	  
	  /**
	   * 장바구니 등록(insert)
	   */
	  @Override 
	  public int orderBox(int productno){
		int count = orderBoxDAO.orderBox(productno);
			return count;   
	  }


	  /**
	   * 회원의 장바구니 목록(list)
	   */
	@Override
	public ArrayList<orderBoxVO> list_orderBox(int customerno) {
		ArrayList<orderBoxVO> list = orderBoxDAO.list_orderBox(customerno);
		return list; 
	}

	/**
	 * 장바구니 금액 합계
	 */
	@Override  
	public int SumAllPrice(int customerno) {
		int SumAllPrice = orderBoxDAO.SumAllPrice(customerno);
		return SumAllPrice; 
	}

	/**
	 * 장바구니 삭제
	 */
	@Override
	public int delete_orderBox(int orderBoxno) {
		int count = orderBoxDAO.delete_orderBox(orderBoxno);
		return count;
	}


	/** 
	 * 장바구니 조회
	 */
	@Override
	public orderBoxVO read_orderBox(int orderBoxno) {
		orderBoxVO orderBoxVO = orderBoxDAO.read_orderBox(orderBoxno);
		return orderBoxVO;
	}

	/**
	 * 장바구니 상품 수량 변경(update)
	 */ 
	@Override
	public int update_orderBox(orderBoxVO orderBoxVO) {
		int count = orderBoxDAO.update_orderBox(orderBoxVO);
		return count;
	}

/**
 * 장바구니 동일 상품 검사
 
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
	  
	  
	
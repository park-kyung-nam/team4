package dev.mvc.order;

import java.util.ArrayList;

public interface orderDAOInter{
	
	/**
	 * 주문 등록
	 */ 
	public int order(orderVO orderVO);

	/**
	 * 주문 조회
	 */
	public Order_ProductVO read_order(int orderno); 
	
	/**
	 * 주문 수정(update)
	 * <XMP>
	 *  <update id="update_order" parameterType="orderVO">
	 *</XMP>
	 */ 
	public int update_order(orderVO orderVO);	
	
	/**
	 * 주문 삭제(delete)
	 * <XMP>
	 * <delete id="delete_order" parameterType="int">
	 *</XMP>
	 */
	public int delete_order(int orderno);
	
	/**
	  * 회원의 주문 목록 
	  * @param orderVO
	  * @return
	  */ 
	  public ArrayList<Order_ProductVO> list_order(int customerno);
	  
	  

	
}
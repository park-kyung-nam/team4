package dev.mvc.order;

import java.util.ArrayList;

public interface orderDAOInter{
	
	/**
	 * �ֹ� ���
	 */ 
	public int order(orderVO orderVO);

	/**
	 * �ֹ� ��ȸ
	 */
	public Order_ProductVO read_order(int orderno); 
	
	/**
	 * �ֹ� ����(update)
	 * <XMP>
	 *  <update id="update_order" parameterType="orderVO">
	 *</XMP>
	 */ 
	public int update_order(orderVO orderVO);	
	
	/**
	 * �ֹ� ����(delete)
	 * <XMP>
	 * <delete id="delete_order" parameterType="int">
	 *</XMP>
	 */
	public int delete_order(int orderno);
	
	/**
	  * ȸ���� �ֹ� ��� 
	  * @param orderVO
	  * @return
	  */ 
	  public ArrayList<Order_ProductVO> list_order(int customerno);
	  
	  

	
}
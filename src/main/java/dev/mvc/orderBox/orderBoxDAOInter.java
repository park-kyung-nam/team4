package dev.mvc.orderBox;

import java.util.ArrayList;

import dev.mvc.orderBox.orderBoxVO;

public interface orderBoxDAOInter{
	
/**
 * ��ǰ �󼼺���
 */ 
public orderBoxVO detail_product(int productno);
	 
	/**
 * ��ٱ��� ��� 
 * @param orderBoxVO
 * @return
 */
public int orderBox(int productno);


/**
 * ��ٱ��� ���(list)
 * @param customerno
 * @return
 */
public ArrayList<orderBoxVO> list_orderBox(int customerno);

/**
 * ��ٱ��� �ݾ� �հ�
 */
public int SumAllPrice(int customerno);	 

/**
 * ��ٱ��� ����
 */
public int delete_orderBox(int orderBoxno);

/**
 * ��ٱ��� ��ȸ
 */
public orderBoxVO read_orderBox(int orderBoxno);

/**
 * ��ٱ��� ��ǰ ���� ����(update)
 */
public int update_orderBox(orderBoxVO orderBoxVO);

/**
 * ������ ��ǰ �˻�

public int count_orderBox(int productno, int customerno);

*/










}
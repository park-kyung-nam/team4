package dev.mvc.orderBox;

import java.util.ArrayList;

import dev.mvc.orderBox.orderBoxVO;

public interface orderBoxDAOInter{
	
/**
 * 제품 상세보기
 */ 
public orderBoxVO detail_product(int productno);
	 
	/**
 * 장바구니 등록 
 * @param orderBoxVO
 * @return
 */
public int orderBox(int productno);


/**
 * 장바구니 목록(list)
 * @param customerno
 * @return
 */
public ArrayList<orderBoxVO> list_orderBox(int customerno);

/**
 * 장바구니 금액 합계
 */
public int SumAllPrice(int customerno);	 

/**
 * 장바구니 삭제
 */
public int delete_orderBox(int orderBoxno);

/**
 * 장바구니 조회
 */
public orderBoxVO read_orderBox(int orderBoxno);

/**
 * 장바구니 상품 수량 변경(update)
 */
public int update_orderBox(orderBoxVO orderBoxVO);

/**
 * 동일한 상품 검사

public int count_orderBox(int productno, int customerno);

*/










}
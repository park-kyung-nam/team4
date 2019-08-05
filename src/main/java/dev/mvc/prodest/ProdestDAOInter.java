package dev.mvc.prodest;

import java.util.ArrayList;

import dev.mvc.prodcate.Prodcategrp_ProdcateVO;
import dev.mvc.prodest.ProdestVO;
import dev.mvc.prodest.Prodest_totalVO;

public interface ProdestDAOInter {
  
  /**
   * <xmp>
   * ���� ���
   * <insert id="create" parameterType="ProdestVO">
   * </xmp>
   * @param prodestVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(ProdestVO prodestVO);
  
  /**
   * <xmp>
   * ��� ī�װ� join(����) ���
   * <select id="list" resultType="Prodcategrp_ProdcateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Prodest_totalVO> list(int customerno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return �Ѱ��� ī�װ�
   */
  public Prodest_totalVO read(int prodestno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read_by_join" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return �Ѱ��� ī�װ�
   */
  public Prodest_totalVO read_by_join(int prodestno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="update_cnt_up" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int update_cnt_up(int prodestno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="update_cnt_up" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int update_cnt_down(int prodestno);
  
  public int delete(int prodestno);
  
  
  /**
   * <xmp> 
   * ��ǰ��ȣ�� ��ġ�ϴ� ���� ���̺��� �ڷ� ����
   * <delete id="delete_product" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int delete_product(int productno);

}

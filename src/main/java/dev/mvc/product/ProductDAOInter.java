package dev.mvc.product;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.prodcate.Prodcategrp_ProdcateVO;

public interface ProductDAOInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="ProductVO">
   * </xmp>
   * @param productVO
   * @return
   */
  public int create(ProductVO productVO);
  
  /**
   * ���� �ֱٿ� ������� ��ǰ��ȣ�� �ҷ���
   * @return productno
   */
  public int get_created_no();
  
  /**
   * ��ü ���
   * @return
   */
  public ArrayList<ProductVO> list_all_prodcate();
  
  /**
   * ��ϵ� ��ü �ۼ�
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * ī�װ��� ���
   * <select id="list_by_prodcateno" resultType="ProductVO" parameterType="int">
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno(int prodcateno);
  
  /**
   * ��ȸ
   * @param productno
   * @return
   */
  public ProductVO read(int productno);
  
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read_by_join" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return �Ѱ��� ī�װ�
   */
  public Prodcate_ProductVO read_by_join(int prodcateno);
 
  /**
   * �ۼ���
   * <update id="update" parameterType="ProductVO">
   * @param productVO
   * @return
   */
  public int update(ProductVO productVO);
  
  /**
   * ��õ�� ����
   * <update id="prod_good_up">
   * @param productno
   * @return
   */
  public int prod_good_up(int productno);
  
  /**
   * ��õ�� ����
   * <update id="prod_good_down">
   * @param productno
   * @return
   */
  public int prod_good_down(int productno);
  
  /**
   * ��ȸ�� ����
   * <update id="prod_viewcnt_up">
   * @param productno
   * @return
   */
  public int prod_viewcnt_up(int productno);
  
  /**
   * ��ȸ�� ����
   * <update id="prod_viewcnt_down">
   * @param productno
   * @return
   */
  public int prod_viewcnt_down(int productno);
  
  /**
   * <xmp>
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param productno
   * @return
   */
  public int delete(int productno);
  
  /**
   * <xmp>
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param productno
   * @return
   */
  public int delete_product(int prodcateno);

  /**
   * �˻� ���
   * <select id="list_by_prodcateno_search" resultType="ProductVO" parameterType="HashMap">
   * @param prodcateno
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno_search(HashMap map);

  /**
   * prodcate�� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_prodcateno_search_paging" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno_search_paging(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_prod_price_search_paging" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ProductVO> list_by_prod_price_search_paging(HashMap<String, Object> map);

  /**
   * �亯 ���� ����
   * <update id="increaseAnsnum" parameterType="HashMap"> 
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
   
  /**
   * <xmp>
   * �亯
   * <insert id="reply" parameterType="ProductVO">
   * </xmp>
   * @param productVO
   * @return
   */
  public int reply(ProductVO productVO);
  
  /**
   * <xmp>
   * �����ȿ� ���Ե� ��ǰ ����
   * <insert id="prod_prodest_cnt">
   * </xmp>
   * @param productno
   * @return
   */
  public int prod_prodest_cnt(HashMap<String, Object> map);
  
}








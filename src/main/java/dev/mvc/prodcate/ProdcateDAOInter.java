package dev.mvc.prodcate;

import java.util.ArrayList;

public interface ProdcateDAOInter {

  /**
   * <xmp>
   * ī�װ� ���
   * <insert id="create" parameterType="ProdcateVO">
   * </xmp>
   * @param prodcateVO
   * @return ��ϵ� ���ڵ� ����
   */
  public int create(ProdcateVO prodcateVO);
  
  /**
   * <xmp>
   * ��� ī�װ� join(����) ���
   * <select id="list" resultType="Prodcategrp_ProdcateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Prodcategrp_ProdcateVO> list();

  /**
   * <xmp>
   * ī�װ� �׷� ��ȣ�� ���� ī�װ� ���
   * <select id="list_by_prodcategrpno" resultType="Prodcategrp_ProdcateVO"  parameterType="int">
   * </xmp>
   * @return
   */
  public ArrayList<Prodcategrp_ProdcateVO> list_by_prodcategrpno(int prodcategrpno);
 
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read" resultType="ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return �Ѱ��� ī�װ�
   */
  public ProdcateVO read(int prodcateno);
  
  /**
   * <xmp> 
   * ��ȸ
   * <select id="read_by_join" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return �Ѱ��� ī�װ�
   */
  public Prodcategrp_ProdcateVO read_by_join(int prodcateno);
  
  
  /**
   * <xmp> 
   * ī�װ� ����
   * <update id="update" parameterType="ProdcateVO"> 
   * </xmp> 
   * @param prodcateVO
   * @return ������ ���ڵ� ����
   */
  public int update(ProdcateVO prodcateVO);
  
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param prodcateno
   * @return ������ ���ڵ� ����
   */
  public int delete(int prodcateno);
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param prodcategrpno
   * @return ������ ���ڵ� ����
   */
  public int delete_cascade(int prodcategrpno);
   
  /**
   * �� �� ����
   * <update id="increaseCnt" parameterType="int">
   * @param prodcateno
   * @return
   */
  public int increaseCnt(int prodcateno);
  
  /**
   * �� �� ����
   * <update id="decreaseCnt" parameterType="int">
   * @param prodcateno
   * @return
   */
  public int decreaseCnt(int prodcateno);
  
  /**
   * ��� ���� ���� <xmp> <update id="update_seqno_up" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_up(int prodcateno);

  /**
   * ��� ���� ���� <xmp> <update id="update_seqno_down" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_down(int prodcateno);

  /**
   * ��� N -> Y <xmp> <update id="visible" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return ó���� ���ڵ� ����
   */
  public int visible(int prodcateno);

  /**
   * ��� Y -> N <xmp> <update id="nonvisible" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return ó���� ���ڵ� ����
   */
  public int nonvisible(int prodcateno);
  
}


















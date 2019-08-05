package dev.mvc.prodcategrp;

import java.util.ArrayList;

// MyBATIS�� <mapper namespace="dev.mvc.prodcategrp.ProdcategrpDAOInter">�� ����
// �������� �ڵ����� ����
public interface ProdcategrpDAOInter {
  /**
   * <Xmp> ī�װ� �׷� ��� <insert id="create" parameterType="ProdcategrpVO"> </Xmp>
   * 
   * @param prodcategrpVO
   * @return ó���� ���ڵ� ����
   */
  public int create(ProdcategrpVO prodcategrpVO);

  /**
   * <xmp> prodcategrpno �������� ���
   * <select id="list_prodcategrpno_asc" resultType="ProdcategrpVO" > </xmp>
   * 
   * @return ArrayList<ProdcategrpVO>
   */
  public ArrayList<ProdcategrpVO> list_prodcategrpno_asc();

  /**
   * <xmp> seqno �������� ���
   * <select id="list_seqno_asc" resultType="ProdcategrpVO" > </xmp>
   * 
   * @return ArrayList<ProdcategrpVO>
   */
  public ArrayList<ProdcategrpVO> list_seqno_asc();

  /**
   * ��ȸ <xmp> <select id="read" resultType="ProdcategrpVO" parameterType="int">
   * </xmp>
   * 
   * @param prodcategrpno
   * @return
   */
  public ProdcategrpVO read(int prodcategrpno);

  /**
   * ���� ó�� <xmp> <update id="update" parameterType="ProdcategrpVO"> </xmp>
   * 
   * @param prodcategrpVO
   * @return ó���� ���ڵ� ����
   */
  public int update(ProdcategrpVO prodcategrpVO);

  /**
   * ���� ó�� <xmp> <delete id="delete" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int delete(int prodcategrpno);

  /**
   * ��� ���� ���� <xmp> <update id="update_seqno_up" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_up(int prodcategrpno);

  /**
   * ��� ���� ���� <xmp> <update id="update_seqno_down" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int update_seqno_down(int prodcategrpno);

  /**
   * ��� N -> Y <xmp> <update id="visible" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int visible(int prodcategrpno);

  /**
   * ��� Y -> N <xmp> <update id="nonvisible" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return ó���� ���ڵ� ����
   */
  public int nonvisible(int prodcategrpno);

  /**
   * ��ϵ� �ۼ� ���� <xmp> <update id="increase_cnt" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @param cnt
   * @return ó���� ���ڵ� ����
   */
  public int increaseCnt(int prodcategrpno);

  /**
   * ��ϵ� �ۼ� ���� <xmp> <update id="increase_cnt" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @param cnt
   * @return ó���� ���ڵ� ����
   */
  public int decreaseCnt(int prodcategrpno);

}

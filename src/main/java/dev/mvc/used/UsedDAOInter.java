package dev.mvc.used;

import java.util.ArrayList;

import java.util.HashMap;

public interface UsedDAOInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="UsedVO">
   * </xmp>
   * @param usedVO
   * @return
   */
  public int create(UsedVO usedVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="UsedVO">
   *</xmp>
   */
  public ArrayList<UsedVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="UsedVO" parameterType="int">
   * </xmp>
   * @param usedno
   * @return 
   */
  public UsedVO read(int usedno);
   
  /**
   * <xmp> 
   *  ����
   * <update id="update" parameterType="UsedVO"> 
   * </xmp> 
   * @param usedVO
   * @return ������ ���ڵ� ����
   */
  public int update(UsedVO usedVO);
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param usedno
   * @return ������ ���ڵ� ����
   */
  public int delete(int usedno);

  /**
   * �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_cateno_search_paging" resultType="UsedVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<UsedVO> list_by_search_paging(HashMap<String, Object> map);

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
   * <insert id="reply" parameterType="ReviewVO">
   * </xmp>
   * @param reviewVO
   * @return
   */
  public int reply(UsedVO reviewVO);
  
}




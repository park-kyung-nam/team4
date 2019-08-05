package dev.mvc.review;

import java.util.ArrayList;

import java.util.HashMap;

public interface ReviewDAOInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return
   */
  public int create(ReviewVO reviewVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="NoticeVO">
   *</xmp>
   */
  public ArrayList<ReviewVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return 
   */
  public ReviewVO read(int reviewno);
   
  /**
   * <xmp> 
   *  ����
   * <update id="update" parameterType="NoticeVO"> 
   * </xmp> 
   * @param noticeVO
   * @return ������ ���ڵ� ����
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return ������ ���ڵ� ����
   */
  public int delete(int reviewno);

  /**
   * �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_cateno_search_paging" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ReviewVO> list_by_search_paging(HashMap<String, Object> map);

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
  public int reply(ReviewVO reviewVO);
  
}




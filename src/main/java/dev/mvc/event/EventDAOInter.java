package dev.mvc.event;

import java.util.ArrayList;

import java.util.HashMap;

import dev.mvc.review.ReviewVO;


public interface EventDAOInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return
   */
  public int create(EventVO eventVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="EventVO">
   *</xmp>
   */
  public ArrayList<EventVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="EventVO" parameterType="int">
   * </xmp>
   * @param eventno
   * @return 
   */
  public EventVO read(int eventno);
   
  /**
   * <xmp> 
   *  ����
   * <update id="update" parameterType="EventVO"> 
   * </xmp> 
   * @param eventVO
   * @return ������ ���ڵ� ����
   */
  public int update(EventVO eventVO);
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param eventno
   * @return ������ ���ڵ� ����
   */
  public int delete(int eventno);


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
  public ArrayList<EventVO> list_by_search_paging(HashMap<String, Object> map);

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
   * <insert id="reply" parameterType="EventVO">
   * </xmp>
   * @param eventVO
   * @return
   */
  public int reply(EventVO eventVO);
}





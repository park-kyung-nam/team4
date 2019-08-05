package dev.mvc.event;

import java.util.ArrayList;

import java.util.HashMap;

import dev.mvc.review.ReviewVO;


public interface EventDAOInter {
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return
   */
  public int create(EventVO eventVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="EventVO">
   *</xmp>
   */
  public ArrayList<EventVO> list();
  
  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="EventVO" parameterType="int">
   * </xmp>
   * @param eventno
   * @return 
   */
  public EventVO read(int eventno);
   
  /**
   * <xmp> 
   *  수정
   * <update id="update" parameterType="EventVO"> 
   * </xmp> 
   * @param eventVO
   * @return 수정된 레코드 갯수
   */
  public int update(EventVO eventVO);
  
  /**
   * <xmp> 
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param eventno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int eventno);


  /**
   * 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_cateno_search_paging" resultType="ContentsVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<EventVO> list_by_search_paging(HashMap<String, Object> map);

  /**
   * 답변 순서 증가
   * <update id="increaseAnsnum" parameterType="HashMap"> 
   * @param map
   * @return
   */
  public int increaseAnsnum(HashMap<String, Object> map);
   
  /**
   * <xmp>
   * 답변
   * <insert id="reply" parameterType="EventVO">
   * </xmp>
   * @param eventVO
   * @return
   */
  public int reply(EventVO eventVO);
}





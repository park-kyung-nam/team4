package dev.mvc.used;

import java.util.ArrayList;

import java.util.HashMap;

public interface UsedDAOInter {
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="UsedVO">
   * </xmp>
   * @param usedVO
   * @return
   */
  public int create(UsedVO usedVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="UsedVO">
   *</xmp>
   */
  public ArrayList<UsedVO> list();
  
  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="UsedVO" parameterType="int">
   * </xmp>
   * @param usedno
   * @return 
   */
  public UsedVO read(int usedno);
   
  /**
   * <xmp> 
   *  수정
   * <update id="update" parameterType="UsedVO"> 
   * </xmp> 
   * @param usedVO
   * @return 수정된 레코드 갯수
   */
  public int update(UsedVO usedVO);
  
  /**
   * <xmp> 
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param usedno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int usedno);

  /**
   * 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_cateno_search_paging" resultType="UsedVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<UsedVO> list_by_search_paging(HashMap<String, Object> map);

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
   * <insert id="reply" parameterType="ReviewVO">
   * </xmp>
   * @param reviewVO
   * @return
   */
  public int reply(UsedVO reviewVO);
  
}




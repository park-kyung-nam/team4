package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.notice.NoticeVO;
import dev.mvc.review.ReviewVO;
import nation.web.tool.FileVO;


public interface EventProcInter {
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
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param eventVO
   * @return
   */
  public ArrayList<FileVO> getE_thumb1(EventVO eventVO);
  
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



public int search_count(HashMap map);
/**
 * 페이지 목록 문자열 생성
 * @param listFile 목록 파일명 
 * @param noticeno
 * @param search_count 검색 갯수
 * @param nowPage 현재 페이지, nowPage는 1부터 시작
 * @param word 검색어
 * @return
 */
public String pagingBox(String listFile, int search_count, int nowPage, String word);

/**
 * <xmp>
 * 검색 + 페이징 목록
 * <select id="list_by_search_paging" resultType="ContentsVO" parameterType="HashMap">
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



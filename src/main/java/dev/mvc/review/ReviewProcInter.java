package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import nation.web.tool.FileVO;
import dev.mvc.notice.NoticeVO;

public interface ReviewProcInter {
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return
   */
  public int create(ReviewVO reviewVO);
  
  /**
   * <xmp>
   * 목록
   * <select id="list" resultType="NoticeVO">
   *</xmp>
   */
  public ArrayList<ReviewVO> list();
  
  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getR_thumb1(ReviewVO reviewVO);

  /**
   * <xmp>
   * 조회
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return 
   */

  public ReviewVO read(int reviewno);
   
  /**
   * <xmp> 
   *  수정
   * <update id="update" parameterType="NoticeVO"> 
   * </xmp> 
   * @param noticeVO
   * @return 수정된 레코드 갯수
   */
  public int update(ReviewVO reviewVO);
  
  /**
   * <xmp> 
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int reviewno);

 
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
  public ArrayList<ReviewVO> list_by_search_paging(HashMap<String, Object> map);

  
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
  public int reply(ReviewVO reviewVO);
  
}




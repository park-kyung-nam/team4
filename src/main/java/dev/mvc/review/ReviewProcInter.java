package dev.mvc.review;

import java.util.ArrayList;
import java.util.HashMap;

import nation.web.tool.FileVO;
import dev.mvc.notice.NoticeVO;

public interface ReviewProcInter {
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
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getR_thumb1(ReviewVO reviewVO);

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

 
  public int search_count(HashMap map);
  /**
   * ������ ��� ���ڿ� ����
   * @param listFile ��� ���ϸ� 
   * @param noticeno
   * @param search_count �˻� ����
   * @param nowPage ���� ������, nowPage�� 1���� ����
   * @param word �˻���
   * @return
   */
  public String pagingBox(String listFile, int search_count, int nowPage, String word);

  /**
   * <xmp>
   * �˻� + ����¡ ���
   * <select id="list_by_search_paging" resultType="ContentsVO" parameterType="HashMap">
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




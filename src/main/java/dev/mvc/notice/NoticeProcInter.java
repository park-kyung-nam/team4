package dev.mvc.notice;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.notice.NoticeVO;

public interface NoticeProcInter {
  /**
   * <xmp>
   * ���
   * <insert id="create" parameterType="NoticeVO">
   * </xmp>
   * @param noticeVO
   * @return
   */
  public int create(NoticeVO noticeVO);
  
  /**
   * <xmp>
   * ���
   * <select id="list" resultType="NoticeVO">
   *</xmp>
   */
  public ArrayList<NoticeVO> list();
  
  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="NoticeVO" parameterType="int">
   * </xmp>
   * @param noticeno
   * @return 
   */
  public NoticeVO read(int noticeno);
   
  /**
   * <xmp> 
   *  ����
   * <update id="update" parameterType="NoticeVO"> 
   * </xmp> 
   * @param noticeVO
   * @return ������ ���ڵ� ����
   */
  public int update(NoticeVO noticeVO);
  
  /**
   * <xmp> 
   * ����
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param noticeno
   * @return ������ ���ڵ� ����
   */
  public int delete(int noticeno);

  
  /**
   * cate�� �˻��� ���ڵ� ����
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
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
  public ArrayList<NoticeVO> list_by_search_paging(HashMap<String, Object> map);
  
}




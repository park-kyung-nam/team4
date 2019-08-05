package dev.mvc.used;

import java.util.ArrayList;
import nation.web.tool.FileVO;
import java.util.HashMap;

import dev.mvc.notice.NoticeVO;

public interface UsedProcInter {
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
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param reviewVO
   * @return
   */
  public ArrayList<FileVO> getU_thumb1(UsedVO usedVO);

  /**
   * <xmp>
   * ��ȸ
   * <select id="read" resultType="NoticeVO" parameterType="int">
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
   * @param UsedVO
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
   * <insert id="reply" parameterType="UsedVO">
   * </xmp>
   * @param usedVO
   * @return
   */
  public int reply(UsedVO usedVO);
  
}




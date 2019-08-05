package dev.mvc.event;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.notice.NoticeVO;
import dev.mvc.review.ReviewVO;
import nation.web.tool.FileVO;


public interface EventProcInter {
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
   * ���ϸ��� ������ŭ FileVO ��ü�� ����� ����
   * @param eventVO
   * @return
   */
  public ArrayList<FileVO> getE_thumb1(EventVO eventVO);
  
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



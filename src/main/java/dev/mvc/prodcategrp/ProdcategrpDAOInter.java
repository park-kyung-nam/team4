package dev.mvc.prodcategrp;

import java.util.ArrayList;

// MyBATIS의 <mapper namespace="dev.mvc.prodcategrp.ProdcategrpDAOInter">에 선언
// 스프링이 자동으로 구현
public interface ProdcategrpDAOInter {
  /**
   * <Xmp> 카테고리 그룹 등록 <insert id="create" parameterType="ProdcategrpVO"> </Xmp>
   * 
   * @param prodcategrpVO
   * @return 처리된 레코드 갯수
   */
  public int create(ProdcategrpVO prodcategrpVO);

  /**
   * <xmp> prodcategrpno 오름차순 목록
   * <select id="list_prodcategrpno_asc" resultType="ProdcategrpVO" > </xmp>
   * 
   * @return ArrayList<ProdcategrpVO>
   */
  public ArrayList<ProdcategrpVO> list_prodcategrpno_asc();

  /**
   * <xmp> seqno 오름차순 목록
   * <select id="list_seqno_asc" resultType="ProdcategrpVO" > </xmp>
   * 
   * @return ArrayList<ProdcategrpVO>
   */
  public ArrayList<ProdcategrpVO> list_seqno_asc();

  /**
   * 조회 <xmp> <select id="read" resultType="ProdcategrpVO" parameterType="int">
   * </xmp>
   * 
   * @param prodcategrpno
   * @return
   */
  public ProdcategrpVO read(int prodcategrpno);

  /**
   * 수정 처리 <xmp> <update id="update" parameterType="ProdcategrpVO"> </xmp>
   * 
   * @param prodcategrpVO
   * @return 처리된 레코드 갯수
   */
  public int update(ProdcategrpVO prodcategrpVO);

  /**
   * 삭제 처리 <xmp> <delete id="delete" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int delete(int prodcategrpno);

  /**
   * 출력 순서 상향 <xmp> <update id="update_seqno_up" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int prodcategrpno);

  /**
   * 출력 순서 하향 <xmp> <update id="update_seqno_down" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int prodcategrpno);

  /**
   * 출력 N -> Y <xmp> <update id="visible" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int visible(int prodcategrpno);

  /**
   * 출력 Y -> N <xmp> <update id="nonvisible" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int nonvisible(int prodcategrpno);

  /**
   * 등록된 글수 증가 <xmp> <update id="increase_cnt" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @param cnt
   * @return 처리된 레코드 갯수
   */
  public int increaseCnt(int prodcategrpno);

  /**
   * 등록된 글수 감소 <xmp> <update id="increase_cnt" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @param cnt
   * @return 처리된 레코드 갯수
   */
  public int decreaseCnt(int prodcategrpno);

}

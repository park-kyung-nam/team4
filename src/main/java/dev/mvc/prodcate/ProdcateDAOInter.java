package dev.mvc.prodcate;

import java.util.ArrayList;

public interface ProdcateDAOInter {

  /**
   * <xmp>
   * 카테고리 등록
   * <insert id="create" parameterType="ProdcateVO">
   * </xmp>
   * @param prodcateVO
   * @return 등록된 레코드 갯수
   */
  public int create(ProdcateVO prodcateVO);
  
  /**
   * <xmp>
   * 모든 카테고리 join(결합) 목록
   * <select id="list" resultType="Prodcategrp_ProdcateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Prodcategrp_ProdcateVO> list();

  /**
   * <xmp>
   * 카테고리 그룹 번호에 의한 카테고리 목록
   * <select id="list_by_prodcategrpno" resultType="Prodcategrp_ProdcateVO"  parameterType="int">
   * </xmp>
   * @return
   */
  public ArrayList<Prodcategrp_ProdcateVO> list_by_prodcategrpno(int prodcategrpno);
 
  /**
   * <xmp> 
   * 조회
   * <select id="read" resultType="ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return 한건의 카테고리
   */
  public ProdcateVO read(int prodcateno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="read_by_join" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return 한건의 카테고리
   */
  public Prodcategrp_ProdcateVO read_by_join(int prodcateno);
  
  
  /**
   * <xmp> 
   * 카테고리 수정
   * <update id="update" parameterType="ProdcateVO"> 
   * </xmp> 
   * @param prodcateVO
   * @return 수정된 레코드 갯수
   */
  public int update(ProdcateVO prodcateVO);
  
  
  /**
   * <xmp> 
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param prodcateno
   * @return 삭제된 레코드 갯수
   */
  public int delete(int prodcateno);
  
  /**
   * <xmp> 
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param prodcategrpno
   * @return 삭제된 레코드 갯수
   */
  public int delete_cascade(int prodcategrpno);
   
  /**
   * 글 수 증가
   * <update id="increaseCnt" parameterType="int">
   * @param prodcateno
   * @return
   */
  public int increaseCnt(int prodcateno);
  
  /**
   * 글 수 감소
   * <update id="decreaseCnt" parameterType="int">
   * @param prodcateno
   * @return
   */
  public int decreaseCnt(int prodcateno);
  
  /**
   * 출력 순서 상향 <xmp> <update id="update_seqno_up" parameterType="int"> </xmp>
   * 
   * @param prodcategrpno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_up(int prodcateno);

  /**
   * 출력 순서 하향 <xmp> <update id="update_seqno_down" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return 처리된 레코드 갯수
   */
  public int update_seqno_down(int prodcateno);

  /**
   * 출력 N -> Y <xmp> <update id="visible" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return 처리된 레코드 갯수
   */
  public int visible(int prodcateno);

  /**
   * 출력 Y -> N <xmp> <update id="nonvisible" parameterType="int"> </xmp>
   * 
   * @param prodcateno
   * @return 처리된 레코드 갯수
   */
  public int nonvisible(int prodcateno);
  
}


















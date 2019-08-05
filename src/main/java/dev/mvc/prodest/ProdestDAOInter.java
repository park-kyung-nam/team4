package dev.mvc.prodest;

import java.util.ArrayList;

import dev.mvc.prodcate.Prodcategrp_ProdcateVO;
import dev.mvc.prodest.ProdestVO;
import dev.mvc.prodest.Prodest_totalVO;

public interface ProdestDAOInter {
  
  /**
   * <xmp>
   * 견적 등록
   * <insert id="create" parameterType="ProdestVO">
   * </xmp>
   * @param prodestVO
   * @return 등록된 레코드 갯수
   */
  public int create(ProdestVO prodestVO);
  
  /**
   * <xmp>
   * 모든 카테고리 join(결합) 목록
   * <select id="list" resultType="Prodcategrp_ProdcateVO" >
   * </xmp> 
   * @return
   */
  public ArrayList<Prodest_totalVO> list(int customerno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="read" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return 한건의 카테고리
   */
  public Prodest_totalVO read(int prodestno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="read_by_join" resultType="Prodcategrp_ProdcateVO" parameterType="int">
   * </xmp>
   * @param prodcateno
   * @return 한건의 카테고리
   */
  public Prodest_totalVO read_by_join(int prodestno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="update_cnt_up" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int update_cnt_up(int prodestno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="update_cnt_up" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int update_cnt_down(int prodestno);
  
  public int delete(int prodestno);
  
  
  /**
   * <xmp> 
   * 제품번호와 일치하는 견적 테이블의 자료 삭제
   * <delete id="delete_product" parameterType="int">
   * </xmp>
   * @param prodestno
   * @return count
   */
  public int delete_product(int productno);

}

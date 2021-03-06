package dev.mvc.product;

import java.util.ArrayList;
import java.util.HashMap;

import dev.mvc.prodcate.Prodcategrp_ProdcateVO;

public interface ProductProcInter {
  /**
   * <xmp>
   * 등록
   * <insert id="create" parameterType="ProductVO">
   * </xmp>
   * @param productVO
   * @return
   */
  public int create(ProductVO productVO);
  
  /**
   * 가장 최근에 만들어진 제품번호를 불러옴
   * @return productno
   */
  public int get_created_no();
  
  /**
   * 전체 목록
   * @return
   */
  public ArrayList<ProductVO> list_all_prodcate();
  
  /**
   * 등록된 전체 글수
   * <select id="total_count" resultType="int" > 
   */
  public int total_count();
  
  /**
   * 카테고리별 목록
   * <select id="list_by_prodcateno" resultType="ProductVO" parameterType="int">
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno(int prodcateno);

  /**
   * 파일명의 갯수만큼 FileVO 객체를 만들어 리턴
   * @param productVO
   * @return
   */
  public ArrayList<FileVO> getThumbs(ProductVO productVO);

  /**
   * 조회
   * @param productno
   * @return
   */
  public ProductVO read(int productno);
  
  /**
   * <xmp> 
   * 조회
   * <select id="read_by_join" resultType="Prodcate_ProductVO" parameterType="int">
   * </xmp>
   * @param productno
   * @return 한건의 카테고리와 제품
   */
  public Prodcate_ProductVO read_by_join(int productno);
  
  /**
   * 글수정
   * <update id="update" parameterType="ProductVO">
   * @param productVO
   * @return
   */
  public int update(ProductVO productVO);
  
  /**
   * 추천수 증가
   * <update id="prod_good_up">
   * @param productno
   * @return
   */
  public int prod_good_up(int productno);
  
  /**
   * 추천수 감소
   * <update id="prod_good_down">
   * @param productno
   * @return
   */
  public int prod_good_down(int productno);
  
  /**
   * 조회수 증가
   * <update id="prod_viewcnt_up">
   * @param productno
   * @return
   */
  public int prod_viewcnt_up(int productno);
  
  /**
   * 조회수 감소
   * <update id="prod_viewcnt_down">
   * @param productno
   * @return
   */
  public int prod_viewcnt_down(int productno);

  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param productno
   * @return
   */
  public int delete(int productno);
  
  /**
   * <xmp>
   * 삭제
   * <delete id="delete" parameterType="int">
   * </xmp> 
   * @param productno
   * @return
   */
  public int delete_product(int prodcateno);
  
  /**
   * 검색 목록
   * <select id="list_by_prodcateno_search" resultType="ProductVO" parameterType="HashMap">
   * @param prodcateno
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno_search(HashMap map);

  /**
   * prodcate별 검색된 레코드 갯수
   * <select id="search_count" resultType="int" parameterType="HashMap">
   * @return
   */
  public int search_count(HashMap map);

  /**
   * 페이지 목록 문자열 생성
   * @param listFile 목록 파일명 
   * @param prodcateno 커테고리번호
   * @param search_count 검색 갯수
   * @param nowPage 현재 페이지, nowPage는 1부터 시작
   * @param word 검색어
   * @return
   */
  public String pagingBox(String listFile, int prodcateno, int search_count, int nowPage, String prod_word, int viewno, int customerno);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_prodcateno_search_paging" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ProductVO> list_by_prodcateno_search_paging(HashMap<String, Object> map);
  
  /**
   * <xmp>
   * 검색 + 페이징 목록
   * <select id="list_by_prodcateno_search_paging" resultType="ProductVO" parameterType="HashMap">
   * </xmp>
   * @param map
   * @return
   */
  public ArrayList<ProductVO> list_by_prod_price_search_paging(HashMap<String, Object> map);
  
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
   * <insert id="reply" parameterType="ProductVO">
   * </xmp>
   * @param productVO
   * @return
   */
  public int reply(ProductVO productVO);
  
  /**
   * <xmp>
   * 견적안에 포함된 제품 갯수
   * <insert id="prod_prodest_cnt">
   * </xmp>
   * @param productno
   * @return
   */
  public int prod_prodest_cnt(HashMap<String, Object> map);
}




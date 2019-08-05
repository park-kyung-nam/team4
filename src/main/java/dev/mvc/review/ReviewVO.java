package dev.mvc.review;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
  /** 글 번호 */
  private int reviewno;
  /** 제목 */
  private String r_title;
  /** 내용 */
  private String r_content;
  /** 업로드 파일 */
  private String r_file1 = "";
  /** 업로드된 파일 크기 */
  private String r_size1 = "";
  /** 업로드 썸네일*/
  private String r_thumb1 = "";
  /** 조회수 */
  private int r_cnt = 0;
  /**답변 갯수*/
  private int replycnt;
  /** 등록일 */
  private String rdate;
  /** 글쓴이*/
  private String rname;
  /** 그룹 번호 */ 
  private int grpno;
  /** 답변 차수 */
  private int indent;
  /** 답변 순서 */
  private int ansnum;
  /**검색어*/
  private String word;
  /** 평점 */
  private int score;
  /** 상품 번호 */ 
  private int productno;
  /** 고객 번호*/
  private int customerno;
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;
  
public ReviewVO() {
  
}

public int getReviewno() {
  return reviewno;
}

public void setReviewno(int reviewno) {
  this.reviewno = reviewno;
}

public String getR_title() {
  return r_title;
}

public void setR_title(String r_title) {
  this.r_title = r_title;
}

public String getR_content() {
  return r_content;
}

public void setR_content(String r_content) {
  this.r_content = r_content;
}

public String getR_file1() {
  return r_file1;
}

public void setR_file1(String r_file1) {
  this.r_file1 = r_file1;
}

public String getR_size1() {
  return r_size1;
}

public void setR_size1(String r_size1) {
  this.r_size1 = r_size1;
}

public String getR_thumb1() {
  return r_thumb1;
}

public void setR_thumb1(String r_thumb1) {
  this.r_thumb1 = r_thumb1;
}

public int getR_cnt() {
  return r_cnt;
}

public void setR_cnt(int r_cnt) {
  this.r_cnt = r_cnt;
}

public int getReplycnt() {
  return replycnt;
}

public void setReplycnt(int replycnt) {
  this.replycnt = replycnt;
}

public String getRdate() {
  return rdate;
}

public void setRdate(String rdate) {
  this.rdate = rdate;
}


public String getRname() {
  return rname;
}

public void setRname(String rname) {
  this.rname = rname;
}

public int getGrpno() {
  return grpno;
}

public void setGrpno(int grpno) {
  this.grpno = grpno;
}

public int getIndent() {
  return indent;
}

public void setIndent(int indent) {
  this.indent = indent;
}

public int getAnsnum() {
  return ansnum;
}

public void setAnsnum(int ansnum) {
  this.ansnum = ansnum;
}

public String getWord() {
  return word;
}

public void setWord(String word) {
  this.word = word;
}

public int getScore() {
  return score;
}

public void setScore(int score) {
  this.score = score;
}

public int getProductno() {
  return productno;
}

public void setProductno(int productno) {
  this.productno = productno;
}

public int getCustomerno() {
  return customerno;
}

public void setCustomerno(int customerno) {
  this.customerno = customerno;
}

/**
 * @return the sizesLabel
 */
public String getSizesLabel() {
  return sizesLabel;
}

/**
 * @param sizesLabel the sizesLabel to set
 */
public void setSizesLabel(String sizesLabel) {
  this.sizesLabel = sizesLabel;
}

/**
 * @return the filesMF
 */
public List<MultipartFile> getFilesMF() {
  return filesMF;
}

/**
 * @param filesMF the filesMF to set
 */
public void setFilesMF(List<MultipartFile> filesMF) {
  this.filesMF = filesMF;
}

}
  
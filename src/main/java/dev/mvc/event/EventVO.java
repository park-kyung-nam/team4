package dev.mvc.event;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class EventVO {

  /** 글 번호 */
  private int eventno;
  /** 제목 */
  private String e_title;
  /** 내용 */
  private String e_content;
  /** 업로드 파일 */
  private String e_file1 = "";
  /** 업로드된 파일 크기 */
  private String e_size1 = "";
  /** 썸네일 파일 크기 */
  private String e_thumb1 = ""; 
  /** 조회수 */
  private int e_cnt = 0;
  /**답변 갯수*/
  private int replycnt;
  /** 등록일 */
  private String rdate;
  /** 답변 차수 */
  private int indent;
  /** 답변 순서 */
  private int ansnum;
  /**검색어*/
  private String word;
  /** 관리자 번호 */ 
  private int adminno;
  /** 상품 번호 */ 
  private int productno; 
  /** 
  Spring Framework에서 자동 주입되는 업로드 파일 객체,
  DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
  여러개의 파일 업로드
  */  
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
  private String sizesLabel;

  
public EventVO() {
} 
  
public int getEventno() {
  return eventno;
}

public void setEventno(int eventno) {
  this.eventno = eventno;
}

public String getE_title() {
  return e_title;
}

public void setE_title(String e_title) {
  this.e_title = e_title;
}

public String getE_content() {
  return e_content;
}

public void setE_content(String e_content) {
  this.e_content = e_content;
}

public String getE_file1() {
  return e_file1;
}

public void setE_file1(String e_file1) {
  this.e_file1 = e_file1;
}

public String getE_size1() {
  return e_size1;
}

public void setE_size1(String e_size1) {
  this.e_size1 = e_size1;
}

public String getE_thumb1() {
  return e_thumb1;
}

public void setE_thumb1(String e_thumb1) {
  this.e_thumb1 = e_thumb1;
}

public int getE_cnt() {
  return e_cnt;
}

public void setE_cnt(int e_cnt) {
  this.e_cnt = e_cnt;
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


public int getAdminno() {
  return adminno;
}

public void setAdminno(int adminno) {
  this.adminno = adminno;
}

public int getProductno() {
  return productno;
}

public void setProductno(int productno) {
  this.productno = productno;
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
  
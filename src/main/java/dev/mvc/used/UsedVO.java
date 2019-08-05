package dev.mvc.used;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class UsedVO {
  /** 글 번호 */
  private int usedno;
  /** 제목 */
  private String u_title;
  /** 내용 */
  private String u_content;
  /** 업로드 파일 */
  private String u_file1 = "";
  /** 업로드된 파일 크기 */
  private String u_size1 = "";
  /** 업로드 썸네일*/
  private String u_thumb1 = "";
  /** 조회수 */
  private int u_cnt = 0;
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
  
public UsedVO() {
  
}

public int getUsedno() {
  return usedno;
}


public void setUsedno(int usedno) {
  this.usedno = usedno;
}


public String getU_title() {
  return u_title;
}


public void setU_title(String u_title) {
  this.u_title = u_title;
}


public String getU_content() {
  return u_content;
}


public void setU_content(String u_content) {
  this.u_content = u_content;
}


public String getU_file1() {
  return u_file1;
}


public void setU_file1(String u_file1) {
  this.u_file1 = u_file1;
}


public String getU_size1() {
  return u_size1;
}


public void setU_size1(String u_size1) {
  this.u_size1 = u_size1;
}


public String getU_thumb1() {
  return u_thumb1;
}


public void setU_thumb1(String u_thumb1) {
  this.u_thumb1 = u_thumb1;
}


public int getU_cnt() {
  return u_cnt;
}


public void setU_cnt(int u_cnt) {
  this.u_cnt = u_cnt;
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
  
package dev.mvc.review;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ReviewVO {
  /** �� ��ȣ */
  private int reviewno;
  /** ���� */
  private String r_title;
  /** ���� */
  private String r_content;
  /** ���ε� ���� */
  private String r_file1 = "";
  /** ���ε�� ���� ũ�� */
  private String r_size1 = "";
  /** ���ε� �����*/
  private String r_thumb1 = "";
  /** ��ȸ�� */
  private int r_cnt = 0;
  /**�亯 ����*/
  private int replycnt;
  /** ����� */
  private String rdate;
  /** �۾���*/
  private String rname;
  /** �׷� ��ȣ */ 
  private int grpno;
  /** �亯 ���� */
  private int indent;
  /** �亯 ���� */
  private int ansnum;
  /**�˻���*/
  private String word;
  /** ���� */
  private int score;
  /** ��ǰ ��ȣ */ 
  private int productno;
  /** �� ��ȣ*/
  private int customerno;
  /** 
  Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü,
  DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
  �������� ���� ���ε�
  */  
  private List<MultipartFile> filesMF;

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
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
  
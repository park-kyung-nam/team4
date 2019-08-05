package dev.mvc.prodcategrp;

public class ProdcategrpVO {
  /** 카테고리 그룹 번호 */
  private int prodcategrpno;
  /**카테고리 그룹 이름*/
  private String prodgrp_title;
  /**출력 순서*/
  private int prodgrp_seqno;
  /** 출력 모드 */
  private String prodgrp_visible;
  /**소유 카테고리 갯수*/
  private int prodgrp_cnt;
  /** 등록일 */
  private String prodgrp_rdate;
  
  public int getProdcategrpno() {
    return prodcategrpno;
  }
  public void setProdcategrpno(int prodcategrpno) {
    this.prodcategrpno = prodcategrpno;
  }
  public String getProdgrp_title() {
    return prodgrp_title;
  }
  public void setProdgrp_title(String prodgrp_title) {
    this.prodgrp_title = prodgrp_title;
  }
  public int getProdgrp_seqno() {
    return prodgrp_seqno;
  }
  public void setProdgrp_seqno(int prodgrp_seqno) {
    this.prodgrp_seqno = prodgrp_seqno;
  }
  public String getProdgrp_visible() {
    return prodgrp_visible;
  }
  public void setProdgrp_visible(String prodgrp_visible) {
    this.prodgrp_visible = prodgrp_visible;
  }
  public int getProdgrp_cnt() {
    return prodgrp_cnt;
  }
  public void setProdgrp_cnt(int prodgrp_cnt) {
    this.prodgrp_cnt = prodgrp_cnt;
  }
  public String getProdgrp_rdate() {
    return prodgrp_rdate;
  }
  public void setProdgrp_rdate(String prodgrp_rdate) {
    this.prodgrp_rdate = prodgrp_rdate;
  }
  

}


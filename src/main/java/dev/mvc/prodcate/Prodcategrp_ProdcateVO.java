package dev.mvc.prodcate;

public class Prodcategrp_ProdcateVO {
  // prodcategrp table
  private String prodgrp_title;
  private int prodcategrpno;
  private int prodgrp_seqno;
  
  // prodcate table
  private int prodcateno;
  private String prodcate_title;
  private int prodcate_seqno; // JOIN 시만 사용, seqno 컬럼과 대응
  private String prodcate_visible;
  private String prodcate_ids;
  private int prodcate_cnt;
  private String prodcate_rdate;
  public String getProdgrp_title() {
    return prodgrp_title;
  }
  public void setProdgrp_title(String prodgrp_title) {
    this.prodgrp_title = prodgrp_title;
  }
  public int getProdcategrpno() {
    return prodcategrpno;
  }
  public void setProdcategrpno(int prodcategrpno) {
    this.prodcategrpno = prodcategrpno;
  }
  public int getProdgrp_seqno() {
    return prodgrp_seqno;
  }
  public void setProdgrp_seqno(int prodgrp_seqno) {
    this.prodgrp_seqno = prodgrp_seqno;
  }
  public int getProdcateno() {
    return prodcateno;
  }
  public void setProdcateno(int prodcateno) {
    this.prodcateno = prodcateno;
  }
  public String getProdcate_title() {
    return prodcate_title;
  }
  public void setProdcate_title(String prodcate_title) {
    this.prodcate_title = prodcate_title;
  }
  public int getProdcate_seqno() {
    return prodcate_seqno;
  }
  public void setProdcate_seqno(int prodcate_seqno) {
    this.prodcate_seqno = prodcate_seqno;
  }
  public String getProdcate_visible() {
    return prodcate_visible;
  }
  public void setProdcate_visible(String prodcate_visible) {
    this.prodcate_visible = prodcate_visible;
  }
  public String getProdcate_ids() {
    return prodcate_ids;
  }
  public void setProdcate_ids(String prodcate_ids) {
    this.prodcate_ids = prodcate_ids;
  }
  public int getProdcate_cnt() {
    return prodcate_cnt;
  }
  public void setProdcate_cnt(int prodcate_cnt) {
    this.prodcate_cnt = prodcate_cnt;
  }
  public String getProdcate_rdate() {
    return prodcate_rdate;
  }
  public void setProdcate_rdate(String prodcate_rdate) {
    this.prodcate_rdate = prodcate_rdate;
  }
 
}


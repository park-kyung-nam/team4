package dev.mvc.prodcate;
/* 
    prodcateno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    prodcategrpno                     NUMBER(10)     NULL ,
    title                             VARCHAR2(50)     NOT NULL,
    seqno                             NUMBER(5)    DEFAULT 0     NOT NULL,
    visible                           CHAR(1)    DEFAULT 'Y'     NOT NULL,
    cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    ids                               VARCHAR2(10)     DEFAULT 'admin'     NOT NULL,
    rdate                             DATE     NOT NULL,
    FOREIGN KEY (prodcategrpno) REFERENCES prodcategrp (prodcategrpno)
 */
public class ProdcateVO {
  private int prodcateno;
  private int prodcategrpno;
  private String prodcate_title;
  private int prodcate_seqno;
  private String prodcate_visible;
  private int prodcate_cnt;
  private String prodcate_ids;
  private String prodcate_rdate;
  public int getProdcateno() {
    return prodcateno;
  }
  public void setProdcateno(int prodcateno) {
    this.prodcateno = prodcateno;
  }
  public int getProdcategrpno() {
    return prodcategrpno;
  }
  public void setProdcategrpno(int prodcategrpno) {
    this.prodcategrpno = prodcategrpno;
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
  public int getProdcate_cnt() {
    return prodcate_cnt;
  }
  public void setProdcate_cnt(int prodcate_cnt) {
    this.prodcate_cnt = prodcate_cnt;
  }
  public String getProdcate_ids() {
    return prodcate_ids;
  }
  public void setProdcate_ids(String prodcate_ids) {
    this.prodcate_ids = prodcate_ids;
  }
  public String getProdcate_rdate() {
    return prodcate_rdate;
  }
  public void setProdcate_rdate(String prodcate_rdate) {
    this.prodcate_rdate = prodcate_rdate;
  }
  
}



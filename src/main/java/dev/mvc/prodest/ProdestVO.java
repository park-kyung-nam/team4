package dev.mvc.prodest;

/*
    prodestno                         NUMBER(10)    NOT NULL    PRIMARY KEY,
    productno                            NUMBER(10)     NULL ,
    customerno                        NUMBER(10)     NULL ,
 */
public class ProdestVO {
  private int prodestno;
  private int productno;
  private int customerno;
  
  public int getProdestno() {
    return prodestno;
  }
  public void setProdestno(int prodestno) {
    this.prodestno = prodestno;
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
  
}

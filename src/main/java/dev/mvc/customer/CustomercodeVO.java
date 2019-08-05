package dev.mvc.customer;

public class CustomercodeVO {

/*
CREATE TABLE customerstatscode(
    customerstatscodeno                 NUMBER(10)     NOT NULL    PRIMARY KEY,
    customerstatschar                   VARCHAR2(30)   unique     NOT NULL,
    customerstatsdesc                   CLOB     NOT NULL
);
*/
  private int customerstatscodeno;
  private String customerstatschar;
  private String customerstatsdesc;
  public int getCustomerstatscodeno() {
    return customerstatscodeno;
  }
  public void setCustomerstatscodeno(int customerstatscodeno) {
    this.customerstatscodeno = customerstatscodeno;
  }
  public String getCustomerstatschar() {
    return customerstatschar;
  }
  public void setCustomerstatschar(String customerstatschar) {
    this.customerstatschar = customerstatschar;
  }
  public String getCustomerstatsdesc() {
    return customerstatsdesc;
  }
  public void setCustomerstatsdesc(String customerstatsdesc) {
    this.customerstatsdesc = customerstatsdesc;
  }
}

package dev.mvc.admin;

public class AdmincodeVO {

/*
CREATE TABLE admincode(
    admincodeno                       NUMBER(10)     NOT NULL    PRIMARY KEY,
    privchar                          VARCHAR2(10)     NOT NULL,
    privdesc                          CLOB     NOT NULL
);
*/
  private int admincodeno;
  private String privchar;
  private String privdesc;
  public int getAdmincodeno() {
    return admincodeno;
  }
  public void setAdmincodeno(int admincodeno) {
    this.admincodeno = admincodeno;
  }
  public String getPrivchar() {
    return privchar;
  }
  public void setPrivchar(String privchar) {
    this.privchar = privchar;
  }
  public String getPrivdesc() {
    return privdesc;
  }
  public void setPrivdesc(String privdesc) {
    this.privdesc = privdesc;
  }
}

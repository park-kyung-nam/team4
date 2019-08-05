package dev.mvc.admin;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AdminVO {
  
/*
CREATE TABLE admin(
    adminno                           NUMBER(10)     NOT NULL    PRIMARY KEY,
    name                              VARCHAR2(90)     NOT NULL,
    id                                VARCHAR2(200)  unique  NOT NULL,
    passwd                            CLOB     NOT NULL,
    admincodeno                       NUMBER(10)  default -2  not NULL ,
    address                           CLOB     NOT NULL,
    phone1                            VARCHAR2(20)     NOT NULL,
    phone2                            VARCHAR2(20)     NULL ,
    email                             VARCHAR2(200)  unique  NOT NULL,
    rdate                             DATE     NOT NULL,
  FOREIGN KEY (admincodeno) REFERENCES admincode (admincodeno)
);
*/
  
  private int adminno;
  private String name;
  private String id;
  private String img;
  private String profileimg;
  private String passwd;
  private int admincodeno;
  private String address;
  private String phone1;
  private String phone2;
  private String email;
  private String rdate;
  private List<MultipartFile> filesMF;
  public int getAdminno() {
    return adminno;
  }
  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
  public String getId() {
    return id;
  }
  public void setId(String id) {
    this.id = id;
  }
  public String getPasswd() {
    return passwd;
  }
  public void setPasswd(String passwd) {
    this.passwd = passwd;
  }
  public int getAdmincodeno() {
    return admincodeno;
  }
  public void setAdmincodeno(int admincodeno) {
    this.admincodeno = admincodeno;
  }
  public String getAddress() {
    return address;
  }
  public void setAddress(String address) {
    this.address = address;
  }
  public String getPhone1() {
    return phone1;
  }
  public void setPhone1(String phone1) {
    this.phone1 = phone1;
  }
  public String getPhone2() {
    return phone2;
  }
  public void setPhone2(String phone2) {
    this.phone2 = phone2;
  }
  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getImg() {
    return img;
  }
  public void setImg(String img) {
    this.img = img;
  }
  public String getProfileimg() {
    return profileimg;
  }
  public void setProfileimg(String profileimg) {
    this.profileimg = profileimg;
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

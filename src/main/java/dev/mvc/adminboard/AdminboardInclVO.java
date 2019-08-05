package dev.mvc.adminboard;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class AdminboardInclVO {
  
  private int adminboardno;
  private String title;
  private String content;
  private String files;
  private String sizes;
  private String rdate;
  private String ddate;
  private String word;
  private int cnt;
  private int adminno;
  

  private int a_adminno;
  private String name;
  private String id;
  private String img;
  private String profileimg;
  private int admincodeno;
  private String phone1;
  private String phone2;
  private String email;
  
  private List<MultipartFile> filesMF;
  public int getAdminboardno() {
    return adminboardno;
  }
  public void setAdminboardno(int adminboardno) {
    this.adminboardno = adminboardno;
  }
  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }
  public String getContent() {
    return content;
  }
  public void setContent(String content) {
    this.content = content;
  }
  /**
   * @return the files
   */
  public String getFiles() {
    if (this.files == null) {
      return "";
    } else{
      return files;
    }
  }
  public void setFiles(String files) {
    this.files = files;
  }
  public String getSizes() {
    if (this.sizes == null) {
      return "";
    } else{
      return sizes;
    }
  }
  public void setSizes(String sizes) {
    this.sizes = sizes;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getDdate() {
    if (this.ddate == null) {
      return "";
    }
    return ddate;
  }
  public void setDdate(String ddate) {
    this.ddate = ddate;
  }
  public String getWord() {
    return word;
  }
  public void setWord(String word) {
    this.word = word;
  }
  public int getCnt() {
    return cnt;
  }
  public void setCnt(int cnt) {
    this.cnt = cnt;
  }
  public int getAdminno() {
    return adminno;
  }
  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }
  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }
  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }
  public int getA_adminno() {
    return a_adminno;
  }
  public void setA_adminno(int a_adminno) {
    this.a_adminno = a_adminno;
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
  public int getAdmincodeno() {
    return admincodeno;
  }
  public void setAdmincodeno(int admincodeno) {
    this.admincodeno = admincodeno;
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
  
  

}

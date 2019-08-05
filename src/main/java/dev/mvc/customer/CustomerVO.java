package dev.mvc.customer;

public class CustomerVO {
  
  private int customerno         ;   
  private String name               ;
  private String id                 ;
  private String passwd             ;
  private String zipcode            ;
  private String address            ;
  private String address2            ;
  private String phone1             ;
  private String phone2             ;
  private String email              ;
  private String notifemail         ;
  private String notifphone         ;
  private String rdate              ;
  private String ddate              ;
  private String bdate              ;
  private int customerstatscodeno;
  public int getCustomerno() {
    return customerno;
  }
  public void setCustomerno(int customerno) {
    this.customerno = customerno;
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
  public String getNotifemail() {
    if (notifemail == "on"){
      notifemail = "Y";
    }
    if (notifemail == null){
      notifemail = "N";
    }
    return notifemail;
  }
  public void setNotifemail(String notifemail) {
    this.notifemail = notifemail;
  }
  public String getNotifphone() {
    if (notifphone == "on"){
      notifphone = "Y";
    }
    if (notifphone == null){
      notifphone = "N";
    }
    return notifphone;
  }
  public void setNotifphone(String notifphone) {
    this.notifphone = notifphone;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getDdate() {
    return ddate;
  }
  public void setDdate(String ddate) {
    this.ddate = ddate;
  }
  public int getCustomerstatscodeno() {
    return customerstatscodeno;
  }
  public void setCustomerstatscodeno(int customerstatscodeno) {
    this.customerstatscodeno = customerstatscodeno;
  }
  public String getZipcode() {
    return zipcode;
  }
  public void setZipcode(String zipcode) {
    this.zipcode = zipcode;
  }
  public String getAddress2() {
    return address2;
  }
  public void setAddress2(String address2) {
    this.address2 = address2;
  }
  public String getBdate() {
    return bdate;
  }
  public void setBdate(String bdate) {
    this.bdate = bdate;
  }   



}

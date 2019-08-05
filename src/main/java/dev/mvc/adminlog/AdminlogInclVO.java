package dev.mvc.adminlog;

public class AdminlogInclVO {
  private int logtype;
  private String typedesc;

  public int logno;
  public int logtype_l;
  public int adminno;
  public String logdate;
  public String ipv4;
  public String ipv6;
  public String logdesc;

  private int adminno_a;
  private String name;
  private String id;
  private int admincodeno;
  
  public int getLogtype() {
    return logtype;
  }
  public void setLogtype(int logtype) {
    this.logtype = logtype;
  }
  public String getTypedesc() {
    return typedesc;
  }
  public void setTypedesc(String typedesc) {
    this.typedesc = typedesc;
  }
  public int getLogno() {
    return logno;
  }
  public void setLogno(int logno) {
    this.logno = logno;
  }
  public int getLogtype_l() {
    return logtype_l;
  }
  public void setLogtype_l(int logtype_l) {
    this.logtype_l = logtype_l;
  }
  public int getAdminno() {
    return adminno;
  }
  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }
  public String getLogdate() {
    return logdate;
  }
  public void setLogdate(String logdate) {
    this.logdate = logdate;
  }
  public String getIpv4() {
    if(ipv4 == null){
      ipv4 = "";
    }
    return ipv4;
  }
  public void setIpv4(String ipv4) {
    this.ipv4 = ipv4;
  }
  public String getIpv6() {
    if(ipv6 == null){
      ipv6 = "";
    }
    return ipv6;
  }
  public void setIpv6(String ipv6) {
    this.ipv6 = ipv6;
  }
  public String getLogdesc() {
    return logdesc;
  }
  public void setLogdesc(String logdesc) {
    this.logdesc = logdesc;
  }
  public int getAdminno_a() {
    return adminno_a;
  }
  public void setAdminno_a(int adminno_a) {
    this.adminno_a = adminno_a;
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
  public int getAdmincodeno() {
    return admincodeno;
  }
  public void setAdmincodeno(int admincodeno) {
    this.admincodeno = admincodeno;
  }
  
  
  
}

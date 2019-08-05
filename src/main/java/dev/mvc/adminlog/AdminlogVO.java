package dev.mvc.adminlog;

public class AdminlogVO {

  public int logno;
  public int logtype;
  public int adminno;
  public String logdate;
  public String ipv4;
  public String ipv6;
  public String logdesc;
  public int getLogno() {
    return logno;
  }
  public void setLogno(int logno) {
    this.logno = logno;
  }
  public int getLogtype() {
    return logtype;
  }
  public void setLogtype(int logtype) {
    this.logtype = logtype;
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
  
  
  
}

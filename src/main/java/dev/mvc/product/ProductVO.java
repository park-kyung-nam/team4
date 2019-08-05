package dev.mvc.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
  
  /** �� ��ȣ */
  private int productno;
  /** �Խ��� �׷� ��ȣ */
  private int prodcateno;
  /** ȸ�� ��ȣ */
  private int adminno;
  /**��ǰ�� */
  private String prod_title;
  /** ���� */
  private String prod_content;
  /** ��õ �� */
  private int prod_good;
  /** Preview ���� �̹��� 200 X 150, �ڵ� ������ */
  private String thumbs = "";

  /** ���� �̹����߿� ù��° Preview �̹��� ����, 200 X 150 */
  private String thumb = "";

  /** ���ε� ���� */
  private String files = "";
  /** ���ε�� ���� ũ�� */
  private String sizes = "";
  /** ��ǰ ���� */
  private int prod_cnt = 0;
  /** �亯 ���� */
  private int replyprod_cnt;
  /** ����� */
  private String prod_rdate;
  /** �׷� ��ȣ */
  private int prod_grpno;
  /** �亯 ���� */
  private int prod_indent;
  /** �亯 ���� */
  private int prod_ansnum;
  /** �˻��� */
  private String prod_word;
  /** ���� */
  private int prod_price;
  /** ���� ���� */
  private int prod_dc;
  /** ������ �ݾ� */
  private int dcprod_price;
  /** ����Ʈ */
  private int prod_point;
  /** �Ⱓ�� ������ */
  private String prod_startdate;
  /** �Ⱓ�� ������ */
  private String prod_enddate;
  /** ��� ���� */
  private String prod_visible;
  /** ��ȸ�� */
  private int prod_viewcnt = 0;
  /** ip */
  private String ip;
  /**������*/
  private String prod_maker;

  /**
   * Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü, DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
   * �ϳ��� ���� ���ε�
   */
  // private MultipartFile filesMF;

  /**
   * Spring Framework���� �ڵ� ���ԵǴ� ���ε� ���� ��ü, DBMS �� ���� �÷��� �������� �ʰ� ���� �ӽ� ���� ����.
   * �������� ���� ���ε�
   */
  private List<MultipartFile> filesMF;

  /** size1�� �ĸ� ���� ��¿� ����, ���� �÷��� �������� ����. */
  private String sizesLabel;

public ProductVO() {

}

  /**
   * @return the files
   */
  public String getFiles() {
    if (this.files == null) {
      return "";
    } else {
      return files;
    }
  }

  /**
   * @param files
   *          the files to set
   */
  public void setFiles(String files) {
    this.files = files;
  }

  public int getProductno() {
    return productno;
  }

  public void setProductno(int productno) {
    this.productno = productno;
  }

  public int getProdcateno() {
    return prodcateno;
  }

  public void setProdcateno(int prodcateno) {
    this.prodcateno = prodcateno;
  }

  public int getAdminno() {
    return adminno;
  }

  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }

  public String getProd_title() {
    return prod_title;
  }

  public void setProd_title(String prod_title) {
    this.prod_title = prod_title;
  }

  public String getProd_content() {
    return prod_content;
  }

  public void setProd_content(String prod_content) {
    this.prod_content = prod_content;
  }

  public int getProd_good() {
    return prod_good;
  }

  public void setProd_good(int prod_good) {
    this.prod_good = prod_good;
  }

  public String getThumbs() {
    return thumbs;
  }

  public void setThumbs(String thumbs) {
    this.thumbs = thumbs;
  }

  public String getThumb() {
    return thumb;
  }

  public void setThumb(String thumb) {
    this.thumb = thumb;
  }

  public String getSizes() {
    return sizes;
  }

  public void setSizes(String sizes) {
    this.sizes = sizes;
  }

  public int getProd_cnt() {
    return prod_cnt;
  }

  public void setProd_cnt(int prod_cnt) {
    this.prod_cnt = prod_cnt;
  }

  public int getReplyprod_cnt() {
    return replyprod_cnt;
  }

  public void setReplyprod_cnt(int replyprod_cnt) {
    this.replyprod_cnt = replyprod_cnt;
  }

  public String getProd_rdate() {
    return prod_rdate;
  }

  public void setProd_rdate(String prod_rdate) {
    this.prod_rdate = prod_rdate;
  }

  public int getProd_grpno() {
    return prod_grpno;
  }

  public void setProd_grpno(int prod_grpno) {
    this.prod_grpno = prod_grpno;
  }

  public int getProd_indent() {
    return prod_indent;
  }

  public void setProd_indent(int prod_indent) {
    this.prod_indent = prod_indent;
  }

  public int getProd_ansnum() {
    return prod_ansnum;
  }

  public void setProd_ansnum(int prod_ansnum) {
    this.prod_ansnum = prod_ansnum;
  }

  public String getProd_word() {
    return prod_word;
  }

  public void setProd_word(String prod_word) {
    this.prod_word = prod_word;
  }

  public int getProd_price() {
    return prod_price;
  }

  public void setProd_price(int prod_price) {
    this.prod_price = prod_price;
  }

  public int getProd_dc() {
    return prod_dc;
  }

  public void setProd_dc(int prod_dc) {
    this.prod_dc = prod_dc;
  }

  public int getDcprod_price() {
    return dcprod_price;
  }

  public void setDcprod_price(int dcprod_price) {
    this.dcprod_price = dcprod_price;
  }

  public int getProd_point() {
    return prod_point;
  }

  public void setProd_point(int prod_point) {
    this.prod_point = prod_point;
  }

  public String getProd_startdate() {
    return prod_startdate;
  }

  public void setProd_startdate(String prod_startdate) {
    this.prod_startdate = prod_startdate;
  }

  public String getProd_enddate() {
    return prod_enddate;
  }

  public void setProd_enddate(String prod_enddate) {
    this.prod_enddate = prod_enddate;
  }

  public String getProd_visible() {
    return prod_visible;
  }

  public void setProd_visible(String prod_visible) {
    this.prod_visible = prod_visible;
  }

  public int getProd_viewcnt() {
    return prod_viewcnt;
  }

  public void setProd_viewcnt(int prod_viewcnt) {
    this.prod_viewcnt = prod_viewcnt;
  }

  public String getIp() {
    return ip;
  }

  public void setIp(String ip) {
    this.ip = ip;
  }

  public List<MultipartFile> getFilesMF() {
    return filesMF;
  }

  public void setFilesMF(List<MultipartFile> filesMF) {
    this.filesMF = filesMF;
  }

  public String getSizesLabel() {
    return sizesLabel;
  }

  public void setSizesLabel(String sizesLabel) {
    this.sizesLabel = sizesLabel;
  }

  public String getProd_maker() {
    if(prod_maker == null){
      return "";
    }else{
      return prod_maker;
    }
  }

  public void setProd_maker(String prod_maker) {
    this.prod_maker = prod_maker;
  }
  
}

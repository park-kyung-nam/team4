package dev.mvc.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ProductVO {
  
  /** 글 번호 */
  private int productno;
  /** 게시판 그룹 번호 */
  private int prodcateno;
  /** 회원 번호 */
  private int adminno;
  /**제품명 */
  private String prod_title;
  /** 내용 */
  private String prod_content;
  /** 추천 수 */
  private int prod_good;
  /** Preview 소형 이미지 200 X 150, 자동 생성됨 */
  private String thumbs = "";

  /** 여러 이미지중에 첫번째 Preview 이미지 저장, 200 X 150 */
  private String thumb = "";

  /** 업로드 파일 */
  private String files = "";
  /** 업로드된 파일 크기 */
  private String sizes = "";
  /** 제품 갯수 */
  private int prod_cnt = 0;
  /** 답변 갯수 */
  private int replyprod_cnt;
  /** 등록일 */
  private String prod_rdate;
  /** 그룹 번호 */
  private int prod_grpno;
  /** 답변 차수 */
  private int prod_indent;
  /** 답변 순서 */
  private int prod_ansnum;
  /** 검색어 */
  private String prod_word;
  /** 가격 */
  private int prod_price;
  /** 할인 가격 */
  private int prod_dc;
  /** 결재할 금액 */
  private int dcprod_price;
  /** 포인트 */
  private int prod_point;
  /** 기간의 시작일 */
  private String prod_startdate;
  /** 기간의 종료일 */
  private String prod_enddate;
  /** 출력 여부 */
  private String prod_visible;
  /** 조회수 */
  private int prod_viewcnt = 0;
  /** ip */
  private String ip;
  /**제조사*/
  private String prod_maker;

  /**
   * Spring Framework에서 자동 주입되는 업로드 파일 객체, DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
   * 하나의 파일 업로드
   */
  // private MultipartFile filesMF;

  /**
   * Spring Framework에서 자동 주입되는 업로드 파일 객체, DBMS 상에 실제 컬럼은 존재하지 않고 파일 임시 저장 목적.
   * 여러개의 파일 업로드
   */
  private List<MultipartFile> filesMF;

  /** size1의 컴마 저장 출력용 변수, 실제 컬럼은 존재하지 않음. */
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

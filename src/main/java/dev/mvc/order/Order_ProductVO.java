package dev.mvc.order;

public class Order_ProductVO {
  
  private int orderno; // �ֹ���ȣ
  private int productno; // ��ǰ��ȣ
  private int customerno; // ȸ����ȣ
  private String orderName; // �ֹ��ڸ�
  private String zipCode; // �����ȣ 
  private String orderAddr1; // �ּ�1
  private String orderAddr2; // �ּ�2
  private String orderDate; // �ֹ���
  private int point; //����Ʈ
   private String phoneno; //��ȭ��ȣ
   private String customerName;
  private String productImg; // ��ǰ �̹���
  private String productName; // ��ǰ �̸�
  private int productPrice;  // ��ǰ ����
  private int orderAmount; //�ֹ�����
  
  private String prod_title;
  private int prod_price;
  
  public int getOrderno() {
    return orderno;
  }
  public void setOrderno(int orderno) {
    this.orderno = orderno;
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
  public String getOrderName() {
    return orderName;
  }
  public void setOrderName(String orderName) {
    this.orderName = orderName;
  }
  public String getZipCode() {
    return zipCode;
  }
  public void setZipCode(String zipCode) {
    this.zipCode = zipCode;
  }
  public String getOrderAddr1() {
    return orderAddr1;
  }
  public void setOrderAddr1(String orderAddr1) {
    this.orderAddr1 = orderAddr1;
  }
  public String getOrderAddr2() {
    return orderAddr2;
  }
  public void setOrderAddr2(String orderAddr2) {
    this.orderAddr2 = orderAddr2;
  }
  public String getOrderDate() {
    return orderDate;
  }
  public void setOrderDate(String orderDate) {
    this.orderDate = orderDate;
  }
  public int getPoint() {
    return point;
  }
  public void setPoint(int point) {
    this.point = point;
  }
  public String getPhoneno() {
    return phoneno;
  }
  public void setPhoneno(String phoneno) {
    this.phoneno = phoneno;
  }
  public String getCustomerName() {
    return customerName;
  }
  public void setCustomerName(String customerName) {
    this.customerName = customerName;
  }
  public String getProductImg() {
    return productImg;
  }
  public void setProductImg(String productImg) {
    this.productImg = productImg;
  }
  public String getProductName() {
    return productName;
  }
  public void setProductName(String productName) {
    this.productName = productName;
  }
  public int getProductPrice() {
    return productPrice;
  }
  public void setProductPrice(int productPrice) {
    this.productPrice = productPrice;
  }
  public int getOrderAmount() {
    return orderAmount;
  }
  public void setOrderAmount(int orderAmount) {
    this.orderAmount = orderAmount;
  }
  public String getProd_title() {
    return prod_title;
  }
  public void setProd_title(String prod_title) {
    this.prod_title = prod_title;
  }
  public int getProd_price() {
    return prod_price;
  }
  public void setProd_price(int prod_price) {
    this.prod_price = prod_price;
  }

}

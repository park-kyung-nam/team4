package dev.mvc.orderBox;

public class orderBoxVO {
	
	private String productImg; // ��ǰ �̹���
	private String productName; // ��ǰ �̸�
	private int productPrice;  // ��ǰ ����
	private int orderAmount; //�ֹ�����
	private int productno; // ��ǰ��ȣ
	private int customerno; // ȸ����ȣ
	private int orderBoxno; // ��ٱ��Ϲ�ȣ
	private int SumAllPrice; // �� �ݾ�
    private String product;
    
	
	  
	
     
    
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	public int getSumAllPrice() {
		return SumAllPrice;
	}
	public void setSumAllPrice(int SumAllPrice) {
		this.SumAllPrice = SumAllPrice;
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
	public int getOrderBoxno() {
		return orderBoxno;
	}
	public void setOrderBoxno(int orderBoxno) {
		this.orderBoxno = orderBoxno;
	}
	
	
	
	
}
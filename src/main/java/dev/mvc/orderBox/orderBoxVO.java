package dev.mvc.orderBox;

public class orderBoxVO {
	
	private String productImg; // 제품 이미지
	private String productName; // 제품 이름
	private int productPrice;  // 제품 가격
	private int orderAmount; //주문수량
	private int productno; // 상품번호
	private int customerno; // 회원번호
	private int orderBoxno; // 장바구니번호
	private int SumAllPrice; // 총 금액
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
package dev.mvc.delivery;


public class DeliveryVO {

    /*CREATE TABLE delivery(
            delivery_no NUMERIC(20) PRIMARY KEY,
            member_no NUMERIC(10),
            recipient VARCHAR(200),
            address VARCHAR(200),
            phone NUMERIC(20),
            requests VARCHAR(500),
            order_no NUMERIC(20),
      FOREIGN KEY (order_no) REFERENCES product (order_no),
      FOREIGN KEY (member_no) REFERENCES member (member_no)
    );*/
    
    private int delivery_no;
    private int member_no;
    private String recipient;
    private String address;
    private int phone;
    private String requests;
    private int order_no;
    
    
    public int getDelivery_no() {
        return delivery_no;
    }
    public void setDelivery_no(int delivery_no) {
        this.delivery_no = delivery_no;
    }
    public int getMember_no() {
        return member_no;
    }
    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }
    public String getRecipient() {
        return recipient;
    }
    public void setRecipient(String recipient) {
        this.recipient = recipient;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public int getPhone() {
        return phone;
    }
    public void setPhone(int phone) {
        this.phone = phone;
    }
    public String getRequests() {
        return requests;
    }
    public void setRequests(String requests) {
        this.requests = requests;
    }
    public int getOrder_no() {
        return order_no;
    }
    public void setOrder_no(int order_no) {
        this.order_no = order_no;
    }
}
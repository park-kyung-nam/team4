CREATE TABLE delivery(
        delivery_no NUMERIC(20) PRIMARY KEY,
        member_no NUMERIC(10),
        recipient VARCHAR(200),
        zipcode   VARCHAR(5)        NULL, -- 우편번호, 12345
        address2 VARCHAR(200),
        address2  VARCHAR(50)       NULL, -- 주소 2
        phone NUMERIC(20),
        requests VARCHAR(500),
        order_no NUMERIC(20),
  FOREIGN KEY (order_no) REFERENCES product (order_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE delivery is '배송';
COMMENT ON COLUMN delivery.delivery_no is '배송번호';
COMMENT ON COLUMN delivery.member_no is '회원번호';
COMMENT ON COLUMN delivery.recipient is '수령인';
COMMENT ON COLUMN delivery.ZIPCODE is '우편번호';
COMMENT ON COLUMN delivery.address1 is '주소';
COMMENT ON COLUMN delivery.address2 is '상세주소';
COMMENT ON COLUMN delivery.phone is '핸드폰';
COMMENT ON COLUMN delivery.email is '이메일';
COMMENT ON COLUMN delivery.requests is '요청사항';
COMMENT ON COLUMN delivery.order_no is '주문번호';


INSERT  INTO delivery(delivery_no, 
							recipient, address, phone, 
							email, requests, order_no)
VALUES ((SELECT NVL(MAX(delivery_no), 0) +1 AS delivery_no FROM delivery),
                 '장재형', '솔데스크', '010-1234-5678',
                  'abcd@naver.com', '없음', 1);
            
SELECT delivery_no, buyer, recipient, address, phone, email, requests, order_no
FROM delivery
ORDER BY delivery_no ASC;
            


drop table phonebook;

SELECT * FROM phonebook;
            
            
            
            
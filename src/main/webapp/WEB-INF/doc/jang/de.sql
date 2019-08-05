CREATE TABLE delivery(
        delivery_no NUMERIC(20) PRIMARY KEY,
        member_no NUMERIC(10),
        recipient VARCHAR(200),
        zipcode   VARCHAR(5)        NULL, -- �����ȣ, 12345
        address2 VARCHAR(200),
        address2  VARCHAR(50)       NULL, -- �ּ� 2
        phone NUMERIC(20),
        requests VARCHAR(500),
        order_no NUMERIC(20),
  FOREIGN KEY (order_no) REFERENCES product (order_no),
  FOREIGN KEY (member_no) REFERENCES member (member_no)
);

COMMENT ON TABLE delivery is '���';
COMMENT ON COLUMN delivery.delivery_no is '��۹�ȣ';
COMMENT ON COLUMN delivery.member_no is 'ȸ����ȣ';
COMMENT ON COLUMN delivery.recipient is '������';
COMMENT ON COLUMN delivery.ZIPCODE is '�����ȣ';
COMMENT ON COLUMN delivery.address1 is '�ּ�';
COMMENT ON COLUMN delivery.address2 is '���ּ�';
COMMENT ON COLUMN delivery.phone is '�ڵ���';
COMMENT ON COLUMN delivery.email is '�̸���';
COMMENT ON COLUMN delivery.requests is '��û����';
COMMENT ON COLUMN delivery.order_no is '�ֹ���ȣ';


INSERT  INTO delivery(delivery_no, 
							recipient, address, phone, 
							email, requests, order_no)
VALUES ((SELECT NVL(MAX(delivery_no), 0) +1 AS delivery_no FROM delivery),
                 '������', '�ֵ���ũ', '010-1234-5678',
                  'abcd@naver.com', '����', 1);
            
SELECT delivery_no, buyer, recipient, address, phone, email, requests, order_no
FROM delivery
ORDER BY delivery_no ASC;
            


drop table phonebook;

SELECT * FROM phonebook;
            
            
            
            
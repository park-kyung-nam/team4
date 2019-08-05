package dev.mvc.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class NoticeVO {
/*
    noticeno                        NUMBER(10)     NOT NULL    PRIMARY KEY,
    n_title                             VARCHAR2(100)    NOT NULL,
    n_content                        VARCHAR2(1000)    NOT NULL,
    n_file1                             VARCHAR2(200)    NULL ,
    n_size1                             NUMBER(10)     DEFAULT 0     NULL ,
    n_cnt                               NUMBER(10)     DEFAULT 0     NOT NULL,
    rdate                           DATE     NOT NULL,
    adminno                       NUMBER(10)     NULL ,
    
COMMENT ON TABLE notice is '��������';
COMMENT ON COLUMN notice.noticeno is '�� ��ȣ';
COMMENT ON COLUMN notice.n_title is '����';
COMMENT ON COLUMN notice.n_content is '����';
COMMENT ON COLUMN notice.n_file1 is '����';
COMMENT ON COLUMN notice.n_size1 is '���� ũ��';
COMMENT ON COLUMN notice.n_cnt is '��ȸ��';
COMMENT ON COLUMN notice.rdate is '��¥';
COMMENT ON COLUMN notice.adminno is '������ ��ȣ';
*/
  /** �� ��ȣ */
  private int noticeno;
  /** ���� */
  private String n_title;
  /** ���� */
  private String n_content;
  /** ���ε� ���� */
  private String n_file1 = "";
  /** ���ε�� ���� ũ�� */
  private String n_size1 = "";
  /** ��ȸ�� */
  private int n_cnt = 0;
  /** ����� */
  private String rdate;
  /** �˻��� */
  private String word;
  /** ������ ��ȣ */ 
  private int adminno;
  
public NoticeVO() {
  
}

  public int getNoticeno() {
    return noticeno;
  }
  public void setNoticeno(int noticeno) {
    this.noticeno = noticeno;
  }
  public String getN_title() {
    return n_title;
  }
  public void setN_title(String n_title) {
    this.n_title = n_title;
  }
  public String getN_content() {
    return n_content;
  }

  public void setN_content(String n_content) {
    this.n_content = n_content;
  }
  public String getN_file1() {
    return n_file1;
  }
  public void setN_file1(String n_file1) {
    this.n_file1 = n_file1;
  }
  public String getN_size1() {
    return n_size1;
  }
  public void setN_size1(String n_size1) {
    this.n_size1 = n_size1;
  }
  public int getN_cnt() {
    return n_cnt;
  }
  public void setN_cnt(int n_cnt) {
    this.n_cnt = n_cnt;
  }
  public String getRdate() {
    return rdate;
  }
  public void setRdate(String rdate) {
    this.rdate = rdate;
  }
  public String getWord() {
    return word;
  }

  public void setWord(String word) {
    this.word = word;
  }
  public int getAdminno() {
    return adminno;
  }
  public void setAdminno(int adminno) {
    this.adminno = adminno;
  }

 
}
  
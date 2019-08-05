package dev.mvc.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class ServiceVO {
    
    
/*    question_no NUMERIC(10) PRIMARY KEY,
    member_no NUMERIC(10),
    title VARCHAR(10),
    contents VARCHAR(10),
    visible VARCHAR(1),
    seqno NUMERIC(10),
    cnt NUMERIC(10),
    rdate DATE,*/
    
    private int question_no;
    

    private int member_no;
    private String title;
    private String contents;
    private String visible;
    private int seqno;
    private int cnt;
    private String rdate;
    private String thumbs;
    private String files;
    private String sizes;
    private List<MultipartFile> filesMF;
    
    
    public String getThumbs() {
        return thumbs;
    }
    public void setThumbs(String thumbs) {
        this.thumbs = thumbs;
    }
    public String getFiles() {
        return files;
    }
    public void setFiles(String files) {
        this.files = files;
    }
    public String getVisible() {
        return visible;
    }
    public void setVisible(String visible) {
        this.visible = visible;
    }
    public int getQuestion_no() {
        return question_no;
    }
    public void setQuestion_no(int question_no) {
        this.question_no = question_no;
    }
    public int getMember_no() {
        return member_no;
    }
    public void setMember_no(int member_no) {
        this.member_no = member_no;
    }
    public String getTitle() {
        return title;
    }
    public void setTitle(String title) {
        this.title = title;
    }
    public String getContents() {
        return contents;
    }
    public void setContents(String contents) {
        this.contents = contents;
    }
    public int getSeqno() {
        return seqno;
    }
    public void setSeqno(int seqno) {
        this.seqno = seqno;
    }
    public int getCnt() {
        return cnt;
    }
    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
    public String getRdate() {
        return rdate;
    }
    public void setRdate(String rdate) {
        this.rdate = rdate;
    }
    
    /**
     * @return the filesMF
     */
    public List<MultipartFile> getFilesMF() {
      return filesMF;
    }
    
    public void setFilesMF(List<MultipartFile> filesMF) {
        this.filesMF = filesMF;
    }
    public String getSizes() {
        return sizes;
    }
    public void setSizes(String sizes) {
        this.sizes = sizes;
    }
    
    
}

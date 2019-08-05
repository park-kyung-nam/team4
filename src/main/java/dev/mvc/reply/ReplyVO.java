package dev.mvc.reply;

public class ReplyVO {
    
    
/*    CREATE TABLE ServiceCenter_reply(
        reply_no NUMERIC(10) PRIMARY KEY,
        reply_content VARCHAR(4000),
        reply_rdate DATE,
        question_no NUMERIC(10),
  FOREIGN KEY (question_no) REFERENCES ServiceCenter (question_no)
);
*/
    private int reply_no;
    private String reply_content;
    private String reply_rdate;
    private int question_no;
    public int getReply_no() {
        return reply_no;
    }
    public void setReply_no(int reply_no) {
        this.reply_no = reply_no;
    }
    public String getReply_content() {
        return reply_content;
    }
    public void setReply_content(String reply_content) {
        this.reply_content = reply_content;
    }
    public String getReply_rdate() {
        return reply_rdate;
    }
    public void setReply_rdate(String reply_rdate) {
        this.reply_rdate = reply_rdate;
    }
    public int getQuestion_no() {
        return question_no;
    }
    public void setQuestion_no(int question_no) {
        this.question_no = question_no;
    }
  
    
}

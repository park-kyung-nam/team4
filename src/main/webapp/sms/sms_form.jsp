<%@ page contentType="text/html; charset=UTF-8"%>
 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>sms - jsp</title>
</head>
 
<body>
  <form method="post" name="smsForm" action="./sms_proc.jsp">
    <input type="hidden" name="action" value="go"> 
    <input type="hidden" name="smsType" value="S"> <!-- 발송 타입 -->
    <input type="hidden" name="subject" value=""> <!-- 장문(LMS)인 경우(한글30자이내) -->
    <input type="hidden" name="returnurl" maxlength="64" value="./sms_proc_next.jsp" size="80">
 
    전송메세지
    <textarea name="msg" cols="30" rows="2" style="width: 455px;">2016</textarea><br>
    단문(SMS) : 최대 90byte까지 전송할 수 있습니다.
    <br>
    <br>받는 번호 <input type="text" name="rphone" value="010-1111-2222"> 예) 011-0112-1112 , '-' 포함해서 입력. <br>
    보내는 번호 
    <input type="hidden" name="sphone1" value="010"> <!-- 전화번호 첫째자리 -->
    <input type="hidden" name="sphone2" value="1111"> <!-- 전화번호 둘째자리 -->
    <input type="hidden" name="sphone3" value="2222"> <!-- 전화번호 셋째자리 -->
    <br>
    <input type="submit" value="전송">이통사 정책에 따라 발신번호와 수신번호가 같은 경우
    발송되지 않습니다.
  </form>
</body>
 
</html>
package dev.mvc.customer;
 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import nation.web.tool.Tool;
 
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
 
public class CustomerInterceptor extends HandlerInterceptorAdapter {
 
  // ��û �ּ� ��� �������� �۵���
  @Override
  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    HttpSession session = request.getSession(true);
    System.out.println("session.getAttribute(\"usertype\"): " + session.getAttribute("usertype"));
    System.out.println("preHandle executed.");
    System.out.println("URL: " + request.getContextPath());
    
    // ������ �α��ν� "grade" ���� ���� ����
    String usertype = Tool.checkNull((String)session.getAttribute("usertype"));
    
    if (usertype.equals("C") == true ){ // ���� ����, ��û ������ ó��
      return true; // ��û �������� ��� ����
    } else{
      // ���� ��¶Ǵ� �α��� �������� �̵�
      response.sendRedirect(request.getContextPath() + "/login");
      return false;
    }
  }
 
  // ��û �ּ� ��� ������ �۵���
  @Override
  public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
      ModelAndView modelAndView) throws Exception {
    System.out.println("postHandle executed.");
    //modelAndView.addObject("admin", "������ ���� ����� ����մϴ�.");
 
  }
 
  // JSP�� View ������ ������� �۵���.
  @Override
  public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
      throws Exception {
    System.out.println("afterCompletion executed.");
 
  }
  
}
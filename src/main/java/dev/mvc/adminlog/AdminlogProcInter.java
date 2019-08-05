package dev.mvc.adminlog;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

public interface AdminlogProcInter {
  
  /**
   * �α� ���
   * @param adminlogVO
   * @return ��� Ȯ�� (1= ����)
   */
  public int record_log(AdminlogVO adminlogVO);

  /**
   * �ܺο���
   * @param adminlogVO
   * @return ��� Ȯ�� (1= ����)
   */
  public int record_log(HttpServletRequest request,int logtype, int adminno, String logdesc);
  
  /**
   * �α� ��� �з�
   * @param adminlogtypeVO
   * @return �з� ����Ʈ
   */
  public ArrayList<AdminlogtypeVO> view_codes_list();

  /**
   * �����ͺ��̽��� �α� ����Ʈ
   * ���� �������� �󿡼��� ������� ����
   * @return ����Ʈ
   */
  public ArrayList<AdminlogVO> log_list();
  
  /**
   * �����ͺ��̽��� �α� ����Ʈ
   * ���� �������� �󿡼��� ������� ����
   * @return ����Ʈ
   */
  public ArrayList<AdminlogInclVO> log_list_full(HashMap<String, Object> map);

  
  /**
   * �����ͺ��̽��� �α� ����Ʈ
   * ���� �������� �󿡼��� ������� ����
   * @return ����Ʈ
   */
  public int search_count(HashMap<String, Object> map);
  
  /**
   * �����ͺ��̽��� ���� �α� Ȯ��
   * ���� �������� �󿡼��� ������� ����
   * @param logno
   * @return �α� �׸�
   */
  public AdminlogVO log_check(int logno);
  
  /**
   * �α� ����
   * @param adminlogVO
   * @return ���� Ȯ�� (1= ����)
   */
  public int log_update(AdminlogVO adminlogVO);

  /**
   * ������ ���� �� �α� �ϰ� ����
   * �����ڰ� ������ ��� ������ ��ȣ�� -1�� ����Ǿ�
   * ��� ������ �󿡼��� 'Ż���� ȸ��'���� ǥ�õ�
   * @param adminno
   * @return ���� Ȯ�� (1= ����)
   */
  public int log_update_for_delete_admin(int adminno);
  
  /**
   * �α� ����
   * @param �α� ��ȣ
   * @return ���� Ȯ�� (1= ����)
   */
  public int log_delete(int logno);

  public String pagingBox(int search_count, int nowPage, String name, int logtype);
  
}

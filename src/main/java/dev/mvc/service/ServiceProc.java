package dev.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;




@Component("dev.mvc.service.ServiceProc")
public class ServiceProc implements ServiceProcInter {

    @Autowired
    private ServiceDAOInter serviceDAO;
    
    @Override
    public int create(ServiceVO serviceVO) {
        int count = serviceDAO.create(serviceVO);
        return count;
    }

    @Override
    public ArrayList<ServiceVO> list() {
        // TODO Auto-generated method stub
        ArrayList<ServiceVO> list = serviceDAO.list();
        return list;
    }

    @Override
    public ServiceVO read(int question_no) {
        ServiceVO read = serviceDAO.read(question_no);
        return read;
    }

    @Override
    public int update(ServiceVO serviceVO) {
        int update = serviceDAO.update(serviceVO);
        return update;
    }

    @Override
    public int delete(int question_no) {
        int delete = serviceDAO.delete(question_no);
        return delete;
    }

    @Override
    public ArrayList<ServiceVO> list_by_question_no(int question_no) {
        ArrayList<ServiceVO> list = serviceDAO.list_by_question_no(question_no);
        return list;
    }

    @Override
    public ArrayList<ServiceVO> list_by_search(HashMap map) {
        ArrayList<ServiceVO> list = serviceDAO.list_by_search(map);
        return list;
    }
    
    @Override
    public int search_count(HashMap map) {
      int count = serviceDAO.search_count(map);
      return count;
    }

    @Override
    public ArrayList<ServiceVO> list_by_search_paging(HashMap<String, Object> map) {
        /* 
        ���������� ����� ���� ���ڵ� ��ȣ ��� ���ذ�, nowPage�� 1���� ����
        1 ������: nowPage = 1, (1 - 1) * 10 --> 0 
        2 ������: nowPage = 2, (2 - 1) * 10 --> 10
        3 ������: nowPage = 3, (3 - 1) * 10 --> 20
        */
       int beginOfPage = ((Integer)map.get("nowPage") - 1) * Contents.RECORD_PER_PAGE;
       
        // ���� rownum, 1 ������: 1 / 2 ������: 11 / 3 ������: 21 
       int startNum = beginOfPage + 1; 
       //  ���� rownum, 1 ������: 10 / 2 ������: 20 / 3 ������: 30
       int endNum = beginOfPage + Contents.RECORD_PER_PAGE;   
       /*
        1 ������: WHERE r >= 1 AND r <= 10
        2 ������: WHERE r >= 11 AND r <= 20
        3 ������: WHERE r >= 21 AND r <= 30
        */
       map.put("startNum", startNum);
       map.put("endNum", endNum);
       
        ArrayList<ServiceVO> list = serviceDAO.list_by_search_paging(map);
        
        int count = list.size();

        
        return list;
    }

    



}

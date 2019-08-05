package dev.mvc.service;

import java.util.ArrayList;
import java.util.HashMap;

public interface ServiceProcInter {
    /**
     * <xmp>
     * 등록
     * <insert id="create" parameterType="serviceVO">
     * </xmp>
     * @param serviceVO
     * @return
     */
    public int create(ServiceVO serviceVO);
    
    public ArrayList<ServiceVO> list();
    
    public ServiceVO read(int question_no);
    
    public ArrayList<ServiceVO> list_by_question_no(int question_no);
    
    public int update(ServiceVO serviceVO);
    
    public int delete(int question_no);
    
    public ArrayList<ServiceVO> list_by_search(HashMap map);
    
    public int search_count(HashMap map);
    

    
    /**
     * <xmp>
     * 검색 + 페이징 목록
     * <select id="list_by_search_paging" resultType="ServiceVO" parameterType="HashMap">
     * </xmp>
     * @param map
     * @return
     */
    public ArrayList<ServiceVO> list_by_search_paging(HashMap<String, Object> map);
}

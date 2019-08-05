package dev.mvc.prodcategrp;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

// @Component: �ڵ����� ���� ����
// �����Ǵ� ���� �̸�: dev.mvc.prodcategrp.ProdcategrpProc
@Component("dev.mvc.prodcategrp.ProdcategrpProc")
public class ProdcategrpProc implements ProdcategrpProcInter {
  // �ڵ����� ������ ProdcategrpDAOInter Ÿ���� ���� �Ҵ��
  @Autowired
  private ProdcategrpDAOInter prodcategrpDAO;
  
  public ProdcategrpProc () {
    System.out.println("--> ProdcategrpProc created.");
  }
  
  @Override
  public int create(ProdcategrpVO prodcategrpVO) {
    // �������� �ڵ����� ������ ���� �����.
    int count = prodcategrpDAO.create(prodcategrpVO);
    return count;
  }

  @Override
  public ArrayList<ProdcategrpVO> list_prodcategrpno_asc() {
    ArrayList<ProdcategrpVO> list = prodcategrpDAO.list_prodcategrpno_asc();
    
    return list;
  }

  @Override
  public ArrayList<ProdcategrpVO> list_seqno_asc() {
    ArrayList<ProdcategrpVO> list = prodcategrpDAO.list_seqno_asc();
    
    return list;
  }

  @Override
  public ProdcategrpVO read(int prodcategrpno) {
    ProdcategrpVO prodcategrpVO = prodcategrpDAO.read(prodcategrpno); 
    return prodcategrpVO;
  }

  @Override
  public int update(ProdcategrpVO prodcategrpVO) {
    int count = prodcategrpDAO.update(prodcategrpVO);
    return count;
  }

  @Override
  public int delete(int prodcategrpno) {
    int count = prodcategrpDAO.delete(prodcategrpno);
    return count;
  }

  @Override
  public int update_seqno_up(int prodcategrpno) {
    int count = prodcategrpDAO.update_seqno_up(prodcategrpno);
    return count;
  }

  @Override
  public int update_seqno_down(int prodcategrpno) {
    int count = prodcategrpDAO.update_seqno_down(prodcategrpno);
    return count;
  }

  @Override
  public int visible(int prodcategrpno) {
    int count = prodcategrpDAO.visible(prodcategrpno);
    return count;
  }
  
  @Override
  public int nonvisible(int prodcategrpno) {
    int count = prodcategrpDAO.nonvisible(prodcategrpno);
    return count;
  }

  @Override
  public int increaseCnt(int prodcategrpno) {
    int count = prodcategrpDAO.increaseCnt(prodcategrpno);
    return count;
  }

  @Override
  public int decreaseCnt(int prodcategrpno) {
    int count = prodcategrpDAO.decreaseCnt(prodcategrpno);
    return 0;
  }

}

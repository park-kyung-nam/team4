package dev.mvc.prodcate;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component("dev.mvc.prodcate.ProdcateProc")
public class ProdcateProc implements ProdcateProcInter {
  @Autowired
  private ProdcateDAOInter prodcateDAO;
  
  public ProdcateProc () {
    System.out.println("--> ProdcateProc created.");
  }
  
  @Override
  public int create(ProdcateVO prodcateVO) {
    int count = prodcateDAO.create(prodcateVO);
    return count;
  }

  @Override
  public ArrayList<Prodcategrp_ProdcateVO> list() {
    ArrayList<Prodcategrp_ProdcateVO> list = prodcateDAO.list();
    return list;
  }

  @Override
  public ArrayList<Prodcategrp_ProdcateVO> list_by_prodcategrpno(int prodcategrpno) {
    ArrayList<Prodcategrp_ProdcateVO> list = prodcateDAO.list_by_prodcategrpno(prodcategrpno);
    return list;
  }

  @Override
  public ProdcateVO read(int prodcateno) {
    ProdcateVO prodcateVO = prodcateDAO.read(prodcateno);
    return prodcateVO;
  }

  @Override
  public Prodcategrp_ProdcateVO read_by_join(int prodcateno) {
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateDAO.read_by_join(prodcateno);
    return prodcategrp_ProdcateVO;
  }
  
  @Override
  public int update(ProdcateVO prodcateVO) {
    int count = prodcateDAO.update(prodcateVO);
    return count;
  }

  @Override
  public int delete(int prodcateno) {
    int count = prodcateDAO.delete(prodcateno);
    return count;
  }
  
  @Override
  public int delete_cascade(int prodcategrpno) {
    int count = prodcateDAO.delete_cascade(prodcategrpno);
    return count;
  }

  @Override
  public int increaseCnt(int prodcateno) {
    int count = prodcateDAO.increaseCnt(prodcateno);
    return count;
  }

  @Override
  public int decreaseCnt(int prodcateno) {
    int count = prodcateDAO.decreaseCnt(prodcateno);
    return count;
  }

  @Override
  public int update_seqno_up(int prodcateno) {
    int count = prodcateDAO.update_seqno_up(prodcateno);
    return count;
  }

  @Override
  public int update_seqno_down(int prodcateno) {
    int count = prodcateDAO.update_seqno_down(prodcateno);
    return  count;
  }

  @Override
  public int visible(int prodcateno) {
    int count = prodcateDAO.visible(prodcateno);
    return count;
  }

  @Override
  public int nonvisible(int prodcateno) {
    int count = prodcateDAO.nonvisible(prodcateno);
    return count;
  }
  
  

}







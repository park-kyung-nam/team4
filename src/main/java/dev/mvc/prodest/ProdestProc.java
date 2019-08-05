package dev.mvc.prodest;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import dev.mvc.prodcate.ProdcateDAOInter;
import dev.mvc.prodcate.ProdcateProcInter;
import dev.mvc.prodcate.Prodcategrp_ProdcateVO;
import dev.mvc.product.Prodcate_ProductVO;

@Component("dev.mvc.prodest.ProdestProc")
public class ProdestProc implements ProdestProcInter {
  @Autowired
  private ProdestDAOInter prodestDAO;
  
  public ProdestProc () {
    System.out.println("--> ProdestProc created.");
  }
  
  @Override
  public int create(ProdestVO prodestVO){
    int count = prodestDAO.create(prodestVO);
    return  count;
  }
  
  @Override
  public ArrayList<Prodest_totalVO> list(int customerno) {
    ArrayList<Prodest_totalVO> list = prodestDAO.list(customerno);
    return list;
  }
  
  @Override
  public Prodest_totalVO read_by_join(int prodestno){
    Prodest_totalVO prodest_totalVO = prodestDAO.read_by_join(prodestno);
    return prodest_totalVO;
  }

  @Override
  public int update_cnt_up(int prodestno) {
    int count = prodestDAO.update_cnt_up(prodestno);
    return count;
  }

  @Override
  public int update_cnt_down(int prodestno) {
    int count = prodestDAO.update_cnt_down(prodestno);
    return count;
  }

  @Override
  public int delete(int prodestno) {
    int count = prodestDAO.delete(prodestno);
    return count;
  }

  @Override
  public Prodest_totalVO read(int prodestno) {
    Prodest_totalVO prodest_totalVO = prodestDAO.read(prodestno);
    return prodest_totalVO;
  }

  @Override
  public int delete_product(int productno) {
    int count = prodestDAO.delete_product(productno);
    return count;
  }
  
}

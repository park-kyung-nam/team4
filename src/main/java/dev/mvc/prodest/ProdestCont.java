package dev.mvc.prodest;

import java.util.ArrayList;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import dev.mvc.prodcate.ProdcateProcInter;
import dev.mvc.prodcategrp.ProdcategrpProcInter;
import dev.mvc.product.ProductProcInter;

@Controller
public class ProdestCont {
  //ProdcategrpProcInter 를 구현한 ProdcategrpProc 객체가 만들어져 할당됨.
  
  @Autowired
  @Qualifier("dev.mvc.prodcate.ProdcateProc")
  private ProdcateProcInter prodcateProc;
  
  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc = null;
  
  @Autowired
  @Qualifier("dev.mvc.prodest.ProdestProc")
  private ProdestProcInter prodestProc;

 public ProdestCont() {
   System.out.println("--> ProdestCont created.");
 }
  
}

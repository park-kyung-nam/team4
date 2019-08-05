package dev.mvc.prodcategrp;

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

@Controller
public class ProdcategrpCont {
  // ProdcategrpProcInter 를 구현한 ProdcategrpProc 객체가 만들어져 할당됨.
  @Autowired
  @Qualifier("dev.mvc.prodcategrp.ProdcategrpProc")
  private ProdcategrpProcInter prodcategrpProc;

  public ProdcategrpCont() {
    System.out.println("--> ProdcategrpCont created.");
  }

  // http://localhost:9090/ojt/prodcategrp/create.do
  @RequestMapping(value = "/prodcategrp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcategrp/create"); // /webapp/prodcategrp/create.jsp

    return mav;
  }

  // prodcategrpVO는 Form 태그의 값으로 자동 저장됨.
  // http://localhost:9090/ojt/prodcategrp/create.do
  @RequestMapping(value = "/prodcategrp/create.do", method = RequestMethod.POST)
  public ModelAndView create(ProdcategrpVO prodcategrpVO) {
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/prodcategrp/create_msg"); //
    // /webapp/prodcategrp/create_msg.jsp

    int count = prodcategrpProc.create(prodcategrpVO);
    // mav.addObject("count", count);
    mav.setViewName("redirect:/prodcategrp/create_msg.jsp?count=" + count);

    return mav;
  }

  // http://localhost:9090/ojt/prodcategrp/list.do
  @RequestMapping(value = "/prodcategrp/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcategrp/list"); // /webapp/prodcategrp/list.jsp

    // ArrayList<ProdcategrpVO> list = prodcategrpProc.list_prodcategrpno_asc();
    ArrayList<ProdcategrpVO> list = prodcategrpProc.list_seqno_asc();
    System.out.println("aa"+list);
    mav.addObject("list", list);

    return mav;
  }

  // JSON
  // http://localhost:9090/team4/prodcategrp/read.do?prodcategrpno=1
  @ResponseBody
  @RequestMapping(value = "/prodcategrp/read.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String read(int prodcategrpno) {
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    ProdcategrpVO prodcategrpVO = prodcategrpProc.read(prodcategrpno);
    JSONObject json = new JSONObject(prodcategrpVO);

    return json.toString();
  }

  // prodcategrpVO는 Form 태그의 값으로 자동 저장됨.
  // http://localhost:9090/ojt/prodcategrp/update.do
  @RequestMapping(value = "/prodcategrp/update.do", method = RequestMethod.POST)
  public ModelAndView update(ProdcategrpVO prodcategrpVO) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update(prodcategrpVO);
    mav.setViewName("redirect:/prodcategrp/update_msg.jsp?count=" + count);

    return mav;
  }

  /**
   * 한건의 그룹 삭제
   * 
   * @param prodcategrpno
   * @return
   */
  @RequestMapping(value = "/prodcategrp/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("grpno=" + prodcategrpno);
    
    int count = prodcategrpProc.delete(prodcategrpno);
    mav.setViewName("redirect:/prodcategrp/list.do"); // 목록으로 바로 이동

    return mav;
  }

  // http://localhost:9090/ojt/prodcategrp/update_seqno_up.do?prodcategrpno=29
  @RequestMapping(value = "/prodcategrp/update_seqno_up.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update_seqno_up(prodcategrpno);
    mav.setViewName("redirect:/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/prodcategrp/update_seqno_down.do
  @RequestMapping(value = "/prodcategrp/update_seqno_down.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update_seqno_down(prodcategrpno);
    mav.setViewName("redirect:/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/prodcategrp/visible.do
  @RequestMapping(value = "/prodcategrp/visible.do", method = RequestMethod.POST)
  public ModelAndView visible(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.visible(prodcategrpno);
    mav.setViewName("redirect:/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/prodcategrp/nonvisible.do
  @RequestMapping(value = "/prodcategrp/nonvisible.do", method = RequestMethod.POST)
  public ModelAndView nonvisible(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.nonvisible(prodcategrpno);
    mav.setViewName("redirect:/prodcategrp/list.do");

    return mav;
  }
}

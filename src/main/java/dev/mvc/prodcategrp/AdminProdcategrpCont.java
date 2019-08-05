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
public class AdminProdcategrpCont {
  // ProdcategrpProcInter �� ������ ProdcategrpProc ��ü�� ������� �Ҵ��.
  @Autowired
  @Qualifier("dev.mvc.prodcategrp.ProdcategrpProc")
  private ProdcategrpProcInter prodcategrpProc;

  public AdminProdcategrpCont() {
    System.out.println("--> ProdcategrpCont created.");
  }

  // http://localhost:9090/ojt/admin/prodcategrp/create.do
  @RequestMapping(value = "/admin/prodcategrp/create.do", method = RequestMethod.GET)
  public ModelAndView create() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/prodcategrp/create"); // /webapp/admin/prodcategrp/create.jsp

    return mav;
  }

  // prodcategrpVO�� Form �±��� ������ �ڵ� �����.
  // http://localhost:9090/ojt/admin/prodcategrp/create.do
  @RequestMapping(value = "/admin/prodcategrp/create.do", method = RequestMethod.POST)
  public ModelAndView create(ProdcategrpVO prodcategrpVO) {
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/admin/prodcategrp/create_msg"); //
    // /webapp/admin/prodcategrp/create_msg.jsp

    int count = prodcategrpProc.create(prodcategrpVO);
    // mav.addObject("count", count);
    mav.setViewName("redirect:/admin/prodcategrp/create_msg.jsp?count=" + count);

    return mav;
  }

  // http://localhost:9090/ojt/admin/prodcategrp/list.do
  @RequestMapping(value = "/admin/prodcategrp/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/prodcategrp/list"); // /webapp/admin/prodcategrp/list.jsp

    // ArrayList<ProdcategrpVO> list = prodcategrpProc.list_prodcategrpno_asc();
    ArrayList<ProdcategrpVO> list = prodcategrpProc.list_seqno_asc();
    mav.addObject("list", list);

    return mav;
  }

  // JSON
  // http://localhost:9090/team4/admin/prodcategrp/read.do?prodcategrpno=1
  @ResponseBody
  @RequestMapping(value = "/admin/prodcategrp/read.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
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

  // prodcategrpVO�� Form �±��� ������ �ڵ� �����.
  // http://localhost:9090/ojt/admin/prodcategrp/update.do
  @RequestMapping(value = "/admin/prodcategrp/update.do", method = RequestMethod.POST)
  public ModelAndView update(ProdcategrpVO prodcategrpVO) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update(prodcategrpVO);
    mav.setViewName("redirect:/admin/prodcategrp/update_msg.jsp?count=" + count);

    return mav;
  }

  /**
   * �Ѱ��� �׷� ����
   * 
   * @param prodcategrpno
   * @return
   */
  @RequestMapping(value = "/admin/prodcategrp/delete.do", method = RequestMethod.POST)
  public ModelAndView delete(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();
    
    System.out.println("grpno=" + prodcategrpno);
    
    int count = prodcategrpProc.delete(prodcategrpno);
    mav.setViewName("redirect:/admin/prodcategrp/list.do"); // ������� �ٷ� �̵�

    return mav;
  }

  // http://localhost:9090/ojt/admin/prodcategrp/update_seqno_up.do?prodcategrpno=29
  @RequestMapping(value = "/admin/prodcategrp/update_seqno_up.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update_seqno_up(prodcategrpno);
    mav.setViewName("redirect:/admin/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/admin/prodcategrp/update_seqno_down.do
  @RequestMapping(value = "/admin/prodcategrp/update_seqno_down.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.update_seqno_down(prodcategrpno);
    mav.setViewName("redirect:/admin/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/admin/prodcategrp/visible.do
  @RequestMapping(value = "/admin/prodcategrp/visible.do", method = RequestMethod.POST)
  public ModelAndView visible(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.visible(prodcategrpno);
    mav.setViewName("redirect:/admin/prodcategrp/list.do");

    return mav;
  }

  // http://localhost:9090/ojt/admin/prodcategrp/nonvisible.do
  @RequestMapping(value = "/admin/prodcategrp/nonvisible.do", method = RequestMethod.POST)
  public ModelAndView nonvisible(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcategrpProc.nonvisible(prodcategrpno);
    mav.setViewName("redirect:/admin/prodcategrp/list.do");

    return mav;
  }
}

package dev.mvc.prodcate;

import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.prodcategrp.ProdcategrpProcInter;
import dev.mvc.prodcategrp.ProdcategrpVO;
import dev.mvc.product.ProductProcInter;
import dev.mvc.product.ProductVO;
import nation.web.tool.Tool;

@Controller
public class ProdcateCont {
  @Autowired
  @Qualifier("dev.mvc.prodcategrp.ProdcategrpProc")
  private ProdcategrpProcInter prodcategrpProc;

  @Autowired
  @Qualifier("dev.mvc.prodcate.ProdcateProc")
  private ProdcateProcInter prodcateProc;

  @Autowired
  @Qualifier("dev.mvc.product.ProductProc")
  private ProductProcInter productProc = null;

  public ProdcateCont() {
    System.out.println("--> ProdcateCont created.");
  }

  // http://localhost:9090/ojt/prodcate/create.do
  // http://localhost:9090/ojt/prodcate/create.do?prodcategrpno=1
  @RequestMapping(value = "/prodcate/create.do", method = RequestMethod.GET)
  public ModelAndView create(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();

    ProdcategrpVO prodcategrpVO = prodcategrpProc.read(prodcategrpno);
    mav.addObject("prodcategrpVO", prodcategrpVO);

    mav.setViewName("/prodcate/create"); // /webapp/prodcate/create.jsp

    return mav;
  }

  // prodcateVO�� Form �±��� ������ �ڵ� �����.
  // http://localhost:9090/team4/prodcate/create.do
  @RequestMapping(value = "/prodcate/create.do", method = RequestMethod.POST)
  public ModelAndView create(ProdcateVO prodcateVO) {
    // System.out.println("create called.");
    ModelAndView mav = new ModelAndView();

    int count = prodcateProc.create(prodcateVO);
    if (count > 0) {
      prodcategrpProc.increaseCnt(prodcateVO.getProdcategrpno()); // �ۼ� ����
    }
    mav.setViewName(
        "redirect:/prodcate/create_msg.jsp?count=" + count + "&prodcategrpno=" + prodcateVO.getProdcategrpno());

    return mav;
  }

  // http://localhost:9090/ojt/prodcate/list.do
  @RequestMapping(value = "/prodcate/list.do", method = RequestMethod.GET)
  public ModelAndView list() {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcate/list"); // /webapp/prodcate/list.jsp

    ArrayList<ProdcategrpVO> grplist = prodcategrpProc.list_seqno_asc();
    mav.addObject("grplist", grplist);

    ArrayList<Prodcategrp_ProdcateVO> list = prodcateProc.list();
    mav.addObject("list", list);

    return mav;
  }

  // http://localhost:9090/ojt/prodcate/list_by_prodcategrpno.do?prodcategrpno=1
  @RequestMapping(value = "/prodcate/list_by_prodcategrpno.do", method = RequestMethod.GET)
  public ModelAndView list_by_prodcategrpno(int prodcategrpno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcate/list_by_prodcategrpno"); // /webapp/prodcate/list_by_prodcategrpno.jsp

    ArrayList<Prodcategrp_ProdcateVO> list = prodcateProc.list_by_prodcategrpno(prodcategrpno);
    mav.addObject("list", list);

    ProdcategrpVO prodcategrpVO = prodcategrpProc.read(prodcategrpno);
    mav.addObject("prodcategrpVO", prodcategrpVO);

    return mav;
  }

  // JSON
  // http://localhost:9090/team4/prodcate/read.do?prodcateno=1
  @ResponseBody
  @RequestMapping(value = "/prodcate/read.do", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
  public String read(int prodcateno) {
    try {
      Thread.sleep(1000);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    JSONObject json = new JSONObject(prodcategrp_ProdcateVO);

    return json.toString();
  }

  // http://localhost:9090/ojt/prodcate/update.do?prodcateno=1
  @RequestMapping(value = "/prodcate/update.do", method = RequestMethod.GET)
  public ModelAndView update(int prodcateno) {
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcate/update"); // /webapp/prodcate/update.jsp

    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);

    return mav;
  }

  // prodcateVO�� Form �±��� ������ �ڵ� �����.
  // http://localhost:9090/ojt/prodcate/update.do
  @RequestMapping(value = "/prodcate/update.do", method = RequestMethod.POST)
  public ModelAndView update(ProdcateVO prodcateVO, int viewno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcateProc.update(prodcateVO);
    System.out.println("viewno" + viewno);
    // Spring controller > JSP View EL
    String prodcate_title = Tool.spring_param_encoding(prodcateVO.getProdcate_title());

    // mav.setViewName("redirect:/prodcate/update_msg.jsp?count=" +
    // count+"&prodcate_title=" + prodcate_title +
    // "&prodcategrpno="+prodcateVO.getProdcategrpno());

    if (viewno == 1) {
      mav.setViewName("redirect:/prodcate/update_msg.jsp?count=" + count + "&prodcate_title=" + prodcate_title
          + "&prodcategrpno=" + prodcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }
    return mav;
  }

  // http://localhost:9090/ojt/prodcate/delete.do?prodcateno=1
  @RequestMapping(value = "/prodcate/delete.do", method = RequestMethod.GET)
  public ModelAndView delete(int prodcateno) {
    ModelAndView mav = new ModelAndView();
    // mav.setViewName("/prodcate/delete"); // /webapp/prodcate/delete.jsp

    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    if (prodcategrp_ProdcateVO.getProdcate_cnt() == 0) {
      mav.setViewName("/prodcate/delete"); // /webapp/prodcate/delete.jsp
    } else {
      mav.setViewName("redirect:/product/delete_product.do?" + "prodcategrpno="
          + prodcategrp_ProdcateVO.getProdcategrpno() + "&prodcateno=" + prodcategrp_ProdcateVO.getProdcateno()); // /webapp/product/delete_product.jsp
    }
    mav.addObject("prodcategrp_ProdcateVO", prodcategrp_ProdcateVO);

    return mav;
  }

  // prodcateVO�� Form �±��� ������ �ڵ� �����.
  // http://localhost:9090/ojt/prodcate/delete.do
  @RequestMapping(value = "/prodcate/delete.do", method = RequestMethod.POST)
  public ModelAndView delete_proc(int prodcateno, int viewno) {
    ModelAndView mav = new ModelAndView();

    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);

    // Spring controller > JSP View EL
    String prodgrp_title = Tool.spring_param_encoding(prodcategrp_ProdcateVO.getProdgrp_title());
    String prodcate_title = Tool.spring_param_encoding(prodcategrp_ProdcateVO.getProdcate_title());

    int count = prodcateProc.delete(prodcateno);

    if (count > 0) {
      prodcategrpProc.decreaseCnt(prodcategrp_ProdcateVO.getProdcategrpno()); // �ۼ�
                                                                              // ����
    }
    if (viewno == 1) {
      mav.setViewName("redirect:/prodcate/delete_msg.jsp?count=" + count + "&prodgrp_title=" + prodgrp_title
          + "&prodcate_title=" + prodcate_title + "&prodcategrpno=" + prodcategrp_ProdcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }

    return mav;
  }

  /**
   * ����
   * 
   * @param request
   * @param productVO
   * @return
   */
  @RequestMapping(value = "/prodcate/delete_product.do", method = RequestMethod.POST)
  public ModelAndView delete_product(RedirectAttributes redirectAttributes, HttpServletRequest request,
      int prodcateno) {

    ModelAndView mav = new ModelAndView();
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    int prodcategrpno = prodcategrp_ProdcateVO.getProdcategrpno();
    String upDir = Tool.getRealPath(request, "/product/storage");

    // �˻� ���
    List<ProductVO> list = productProc.list_by_prodcateno(prodcateno);
    System.out.println("����Ʈ: " + list);

    int i = 0;
    for (i = 0; i < list.size(); i++) {
      ProductVO productVO_old = list.get(i);
      prodcateProc.decreaseCnt(prodcateno); // �ۼ� ����
      String thumbs_old = productVO_old.getThumbs();
      StringTokenizer thumbs_st = new StringTokenizer(thumbs_old, "/");

      while (thumbs_st.hasMoreTokens()) {
        String fname = upDir + thumbs_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� thumbs ���� ����
      }

      // ���� ���� ����
      String files_old = productVO_old.getFiles();
      StringTokenizer files_st = new StringTokenizer(files_old, "/");
      while (files_st.hasMoreTokens()) {
        String fname = upDir + files_st.nextToken();
        Tool.deleteFile(fname); // ������ ��ϵ� ���� ���� ����
      }
    }
    int count = productProc.delete_product(prodcateno);
    System.out.println("���� count: " + count);
    if (count > 0) {
      // prodcateProc.decreaseCnt(prodcateno); // �ۼ� ����
    }

    // mav.setViewName("redirect:/product/update_msg.jsp?count=" + count +
    // "&...);
    System.out.println("count: " + count);
    System.out.println("prodcateno: " + prodcateno);
    redirectAttributes.addAttribute("count", count); // redirect parameter ����
    redirectAttributes.addAttribute("prodcateno", prodcateno);
    redirectAttributes.addAttribute("prodcategrpno", prodcategrpno);

    mav.setViewName("redirect:/prodcate/list.do");

    return mav;
  }

  /**
   * ���յ� ī�װ� �׷캰 ī�װ� ��� http://localhost:9090/ojt/prodcate/list_index_left.do
   * 
   * @param request
   * @return
   */
  @RequestMapping(value = "/prodcate/list_index_left.do", method = RequestMethod.GET)
  public ModelAndView list_index_left(HttpServletRequest request) {
    // System.out.println("--> list_index() GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/prodcate/list_index_left"); // webapp/prodcate/list_index_left.jsp

    List<ProdcategrpVO> prodcategrp_list = prodcategrpProc.list_seqno_asc(); // ī�װ�
                                                                             // �׷�
                                                                             // ���

    // Prodcategrp: name, Prodcate: title ���� ���
    ArrayList<String> name_title_list = new ArrayList<String>();

    StringBuffer url = new StringBuffer(); // ī�װ� ���� ��ũ ����

    // ī�װ� �׷� ������ŭ ��ȯ
    for (int index = 0; index < prodcategrp_list.size(); index++) {
      ProdcategrpVO prodcategrpVO = prodcategrp_list.get(index);

      name_title_list.add("<LI class='prodcategrp_name'>" + prodcategrpVO.getProdgrp_title() + "</LI>");

      // ī�װ� �׷캰 ī�װ� ��� ����
      ArrayList<Prodcategrp_ProdcateVO> prodcate_list = prodcateProc
          .list_by_prodcategrpno(prodcategrpVO.getProdcategrpno());

      // ī�װ� ������ŭ ��ȯ
      for (int j = 0; j < prodcate_list.size(); j++) {
        Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcate_list.get(j);
        String title = prodcategrp_ProdcateVO.getProdcate_title(); // ī�װ� �̸�
        int cnt = prodcategrp_ProdcateVO.getProdcate_cnt(); // ī�װ��� ��ϵ� �ۼ�

        url.append("<LI class='prodcate_title'>");
        // url.append(" <A href='" + request.getContextPath()+
        // "/product/list_by_prodcateno.do?prodcateno="+prodcategrp_ProdcateVO.getProdcateno()+"'>");
        url.append("  <A href='" + request.getContextPath() + "/product/list_by_prodcateno_search_paging.do?prodcateno="
            + prodcategrp_ProdcateVO.getProdcateno() + "'>");
        url.append(title);
        url.append("  </A>");
        url.append("  <span style='font-size: 0.9em; color: #555555;'>(" + cnt + ")</span>");
        url.append("</LI>");
        name_title_list.add(url.toString()); // ��� ��Ͽ� �ϳ��� ī�װ��� �߰�

        url.delete(0, url.toString().length()); // StringBuffer ���ڿ� ����

      }
    }

    mav.addObject("name_title_list", name_title_list);
    mav.addObject("total_count", productProc.total_count());

    return mav;
  }

  // http://localhost:9090/ojt/prodcate/update_seqno_up.do?prodcateno=29
  @RequestMapping(value = "/prodcate/update_seqno_up.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_up(int prodcateno, int viewno) {
    ModelAndView mav = new ModelAndView();

    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    int count = prodcateProc.update_seqno_up(prodcateno);
    if (viewno == 1) {
      mav.setViewName(
          "redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno=" + prodcategrp_ProdcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }
    // mav.setViewName("redirect:/prodcate/list.do"); // ��ü ���
    // ProdcateVO prodcateVO = prodcateProc.read(prodcateno); // ���� ���� grp
    // mav.setViewName("redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno="+prodcateVO.getProdcategrpno());
    // // ���� ���� grp

    return mav;
  }

  // http://localhost:9090/ojt/prodcate/update_seqno_down.do
  @RequestMapping(value = "/prodcate/update_seqno_down.do", method = RequestMethod.POST)
  public ModelAndView update_seqno_down(int prodcateno, int viewno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcateProc.update_seqno_down(prodcateno);
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    if (viewno == 1) {
      mav.setViewName(
          "redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno=" + prodcategrp_ProdcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }

    return mav;
  }

  // http://localhost:9090/ojt/prodcate/visible.do
  @RequestMapping(value = "/prodcate/visible.do", method = RequestMethod.POST)
  public ModelAndView visible(int prodcateno, int viewno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcateProc.visible(prodcateno);
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    if (viewno == 1) {
      mav.setViewName(
          "redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno=" + prodcategrp_ProdcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }
    return mav;
  }

  // http://localhost:9090/ojt/prodcate/nonvisible.do
  @RequestMapping(value = "/prodcate/nonvisible.do", method = RequestMethod.POST)
  public ModelAndView nonvisible(int prodcateno, int viewno) {
    ModelAndView mav = new ModelAndView();

    int count = prodcateProc.nonvisible(prodcateno);
    Prodcategrp_ProdcateVO prodcategrp_ProdcateVO = prodcateProc.read_by_join(prodcateno);
    if (viewno == 1) {
      mav.setViewName(
          "redirect:/prodcate/list_by_prodcategrpno.do?prodcategrpno=" + prodcategrp_ProdcateVO.getProdcategrpno());
    } else if (viewno == 2) {
      mav.setViewName("redirect:/prodcate/list.do");
    }
    return mav;
  }
  
  
  
  
}

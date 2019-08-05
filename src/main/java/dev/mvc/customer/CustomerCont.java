package dev.mvc.customer;

import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.crypto.BadPaddingException;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import dev.mvc.admin.AdminInclVO;
import dev.mvc.admin.AdminVO;
import dev.mvc.admin.AdmincodeVO;
import nation.web.tool.AES256Util;


@Controller
public class CustomerCont {
  @Autowired
  @Qualifier("dev.mvc.customer.CustomerProc")
  CustomerProcInter customerProc;
  AES256Util k;

  public CustomerCont() throws UnsupportedEncodingException{
    k = new AES256Util();
  }
  

  
  @RequestMapping(value="/customer/bio", method=RequestMethod.GET)
  public ModelAndView bio(int customerno){
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/customer/bio");
    /*
    ArrayList<CatgroupVO> groups = catgroupProc.list();
    mav.addObject("groups", groups);
    */
    CustomerInclVO customerInclVO = customerProc.select_customer_withcodes(customerno);
    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("customerInclVO", customerInclVO);
    
    return mav;
    
  }
  

  @RequestMapping(value="/customer/update.do", method=RequestMethod.GET)
  public ModelAndView update_customer_foradmin(int customerno){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.setViewName("/admin/customer/update"); // webapp/member/read.jsp

    CustomerInclVO customerInclVO = customerProc.select_customer_withcodes(customerno);
    ArrayList<CustomercodeVO> codes = customerProc.view_codes_list();
    mav.addObject("codes", codes);
    mav.addObject("customerVO", customerInclVO);
    
    return mav;
  }  

  @RequestMapping(value="/customer/update.do", method=RequestMethod.POST)
  public ModelAndView update_customer_foradmin(CustomerVO customerVO,
      @RequestParam(value="name", defaultValue="") String name,
      @RequestParam(value="nowPage", defaultValue="1") int nowPage){
    // System.out.println("--> read(int mno) GET called.");
    ModelAndView mav = new ModelAndView();
    mav.addObject("name", customerVO.getName());

    int count = customerProc.update_customer_profile(customerVO);

    mav.addObject("result",1);
    if(count == 1){
      mav.addObject("al_class","alert-success");
      mav.addObject("msg", " 회원 데이터를 수정하였습니다.");
    }else{
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 회원 데이터 수정에 실패하였습니다. 다시 시도해 주세요.");
    }
    
    return mav;
  }  
  

  @ResponseBody
  @RequestMapping(value="/customer/customer.scan", 
                           method=RequestMethod.GET,
                           produces="text/plain;charset=UTF-8")
  public String read_json(int customerno) {
    try {
      Thread.sleep(100);
    } catch (InterruptedException e) {
      e.printStackTrace();
    }

    CustomerVO customerVO = customerProc.select_customer(customerno);
    //System.out.println(adminVO.getName());
    JSONObject json = new JSONObject(customerVO);
    
    return json.toString();
  }
  
  

  @RequestMapping(value="/customer/dereg.do", method=RequestMethod.POST)
  public ModelAndView dereg_admin(RedirectAttributes redirectAttributes,
                                        HttpServletRequest request,
                                        HttpSession session,
                                        int customerno){
    ModelAndView mav = new ModelAndView();
    
    
    //System.out.println("profileimg = "+adminVO.getProfileimg());
    int count = customerProc.update_customer_priv(customerno, 5);
    //int count = 0;

    CustomerVO customerVO = customerProc.select_customer(customerno);
    mav.addObject("name", customerVO.getName());
    mav.addObject("result",1);
    if(count == 1){
      mav.addObject("al_class","alert-success");
      mav.addObject("msg", " 회원 이용을 제한하였습니다.");
      mav.setViewName("/customer/dereg_comp");
    }else{
      mav.addObject("al_class","alert-danger");
      mav.addObject("msg", " 회원 이용 제한 처리에 실패하였습니다. 다시 시도해 주세요.");
      mav.setViewName("/customer/dereg");
    }
    return mav;
  }
  

  
  
}

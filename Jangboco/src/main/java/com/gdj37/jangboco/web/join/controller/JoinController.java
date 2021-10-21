package com.gdj37.jangboco.web.join.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.web.join.service.IJoinService;

@Controller
public class JoinController {
	
    @Autowired
    public IJoinService iJoinService;
	
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping(value = "/joinMain")
	public ModelAndView join(ModelAndView mav) {
		mav.setViewName("jangboco/join/main");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernl")
	public ModelAndView joinPernl(ModelAndView mav) {
		mav.setViewName("jangboco/join/joinPernl");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernlForm")
	public ModelAndView joinPernlForm(ModelAndView mav) {
		mav.setViewName("jangboco/join/joinPernlForm");
		return mav;
	}
	
	@RequestMapping(value = "/joinMarketForm")
	public ModelAndView joinMarketForm(ModelAndView mav) {
		mav.setViewName("jangboco/join/joinMarketForm");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernlSocial")
	public ModelAndView joinPernlSocial(ModelAndView mav) {
		mav.setViewName("janboco/join/joinPernlSocial");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
    public String mailCheck(String email) throws Exception{
        
        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;
        
        String subject = "test 메일";
        String content = 
        		"홈페이지를 방문해주셔서 감사합니다"+
        		"<br><br>" +
        		"인증번호는"+checkNum+"입니다" +
        		"<br>"+
        		"해당 인증번호를 인증번호 확인란에 기입하여 주세요";
        		;
        String from = "rambn1993@naver.com";
        String to = email;
        
        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            // true는 멀티파트 메세지를 사용하겠다는 의미
            
            /*
             * 단순한 텍스트 메세지만 사용시엔 아래의 코드도 사용 가능 
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */
            
            mailHelper.setFrom(from);
            // 빈에 아이디 설정한 것은 단순히 smtp 인증을 받기 위해 사용 따라서 보내는이(setFrom())반드시 필요
            // 보내는이와 메일주소를 수신하는이가 볼때 모두 표기 되게 원하신다면 아래의 코드를 사용하시면 됩니다.
            //mailHelper.setFrom("보내는이 이름 <보내는이 아이디@도메인주소>");
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            // true는 html을 사용하겠다는 의미입니다.
            
            /*
             * 단순한 텍스트만 사용하신다면 다음의 코드를 사용하셔도 됩니다. mailHelper.setText(content);
             */
            
            mailSender.send(mail);
           
        } catch(Exception e) {
            e.printStackTrace();
        }
        String num = Integer.toString(checkNum);
        System.out.println("************************************"+num);
        return num;
    }
	
	@RequestMapping(value = "/joinSuccess", method=RequestMethod.POST)
	public ModelAndView joinPernlSuccess (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
		System.out.println(params);
		params.put("member_type", "1");
		int cnt = iJoinService.addMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/joinMarketSuccess", method=RequestMethod.POST)
	public ModelAndView joinMarketSuccess (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
		System.out.println(params);
		int cnt = iJoinService.addMarketMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/validEmail", method= RequestMethod.POST,
			produces = "text/json;charset=UTF-8")
	public String validEmail(@RequestParam HashMap<String,String> params) throws Throwable{
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iJoinService.validEmail(params.get("email"));
		System.out.println(cnt);
		if(cnt==0) {
			modelMap.put("result","true");
			
		} else {
			modelMap.put("result", "false");
		}
		
		return mapper.writeValueAsString(modelMap);
	}
	
	@RequestMapping(value="/agrnt")
	public ModelAndView agrnt(ModelAndView mav) throws Throwable {
		mav.setViewName("jangboco/join/agrnt");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/getDisctAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String getDisctAjax() throws Exception {
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list = iJoinService.getDisct();
		modelMap.put("list",list);
		return mapper.writeValueAsString(modelMap);
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/searchMarketAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String searchMarketAjax(@RequestParam HashMap<String,String> params) throws Exception {
		System.out.println(params);
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list = iJoinService.getMarkets(params);
		modelMap.put("list",list);
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/searchBranchAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String searchBranchAjax(@RequestParam HashMap<String,String> params) throws Exception {
		System.out.println(params);
		ObjectMapper mapper =  new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		List<HashMap<String,String>> list = iJoinService.getBranches(params);
		modelMap.put("list",list);
		return mapper.writeValueAsString(modelMap);
		
	}
	
	@ResponseBody
	@RequestMapping(value="/checkRegnum", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String checkRegnum(@RequestParam HashMap<String, String> params) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iJoinService.checkRegnum(params);
		modelMap.put("result", cnt);
		return mapper.writeValueAsString(modelMap);
	}
	
	@ResponseBody
	@RequestMapping(value="/checkAddMarket", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String checkAddMarket(@RequestParam HashMap<String, String> params) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String,String> counts= iJoinService.checkAddMarket(params);
		System.out.println(counts);
		modelMap.put("result", counts);
		return mapper.writeValueAsString(modelMap);
	}
	
	@ResponseBody
	@RequestMapping(value="/checkBranchName", method=RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String checkBranchName(@RequestParam HashMap<String, String> params) throws Exception {
		System.out.println("tttttttttttttteeeeeeeeeeeeeeesssssssssssssssssssss");
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt= iJoinService.checkBranchName(params);
		modelMap.put("result", cnt);
		return mapper.writeValueAsString(modelMap);
	}

}

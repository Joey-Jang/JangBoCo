package com.gdj37.jangboco.web.join.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigInteger;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.security.SecureRandom;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gdj37.jangboco.util.Utils;
import com.gdj37.jangboco.web.join.service.IJoinService;

@Controller
public class JoinController {
	
    @Autowired
    public IJoinService iJoinService;
	
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping(value = "/joinMain")
	public ModelAndView join(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/main");
		return mav;
	}
	
	@RequestMapping(value = "/loginMain")
	public ModelAndView loginMain(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/loginMain");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernl")
	public ModelAndView joinPernl(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/joinPernl");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernlForm")
	public ModelAndView joinPernlForm(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/joinPernlForm");
		return mav;
	}
	
	@RequestMapping(value = "/joinMarketForm")
	public ModelAndView joinMarketForm(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/joinMarketForm");
		return mav;
	}
	
	@RequestMapping(value = "/joinPernlSocial")
	public ModelAndView joinPernlSocial(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/joinPernlSocial");
		return mav;
	}
	
	@RequestMapping(value = "/findPw")
	public ModelAndView findPw(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/findPw");
		return mav;
	}
	
	@RequestMapping(value = "/findPwSet")
	public ModelAndView findPwSet(ModelAndView mav) {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/findPwSet");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value = "/mailCheck", method = RequestMethod.GET)
    public String mailCheck(String email) throws Exception{

        Random random = new Random();
        int checkNum = random.nextInt(888888) + 111111;

        String subject = "????????? ?????????????????????";
        String content =
        		"??????????????? ?????????????????? ???????????????"+
        		"<br><br>" +
        		"???????????????"+checkNum+"?????????" +
        		"<br>"+
        		"?????? ??????????????? ???????????? ???????????? ???????????? ?????????";
        		;
        String from = "rambn1993@naver.com";
        String to = email;

        try {
            MimeMessage mail = mailSender.createMimeMessage();
            MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true,"UTF-8");
            // true??? ???????????? ???????????? ?????????????????? ??????

            /*
             * ????????? ????????? ???????????? ???????????? ????????? ????????? ?????? ??????
             * MimeMessageHelper mailHelper = new MimeMessageHelper(mail,"UTF-8");
             */

            mailHelper.setFrom(from);
            // ?????? ????????? ????????? ?????? ????????? smtp ????????? ?????? ?????? ?????? ????????? ????????????(setFrom())????????? ??????
            // ??????????????? ??????????????? ?????????????????? ?????? ?????? ?????? ?????? ??????????????? ????????? ????????? ??????????????? ?????????.
            //mailHelper.setFrom("???????????? ?????? <???????????? ?????????@???????????????>");
            mailHelper.setTo(to);
            mailHelper.setSubject(subject);
            mailHelper.setText(content, true);
            // true??? html??? ?????????????????? ???????????????.

            /*
             * ????????? ???????????? ?????????????????? ????????? ????????? ??????????????? ?????????. mailHelper.setText(content);
             */

            mailSender.send(mail);

        } catch(Exception e) {
            e.printStackTrace();
        }
        String num = Integer.toString(checkNum);
        System.out.println("************************************"+num);
        return num;
    }
	
	@RequestMapping(value = "/joinPernlMember", method=RequestMethod.POST)
	public ModelAndView joinPernlMember(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		System.out.println(params);
		params.put("member_type", "1");
		params.put("social_type", "1");
		params.put("pw",Utils.encryptAES128(params.get("pw")));
		int cnt = iJoinService.addMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/joinSocialMember", method=RequestMethod.POST)
	public ModelAndView joinSocialMember (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		//social type 1 ?????? 2????????? 3?????????
		params.put("member_type", "1");
		params.put("social_type", "2");
		params.put("pw","");
		int cnt = iJoinService.addMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/joinMarketMember", method=RequestMethod.POST)
	public ModelAndView joinMarketMember (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		System.out.println(params);
		params.put("pw",Utils.encryptAES128(params.get("pw")));
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
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
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
	
	//????????? ??????????????? callback url????????????
	@RequestMapping(value = "/naverLoginAjax", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String naverLoginAjax(
			@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("tttteeeeeesssssss"+params.get("type"));
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//?????????????????? ??????????????? ????????????";
	    String redirectURI = URLEncoder.encode("http://localhost:8090/Jangboco/naverCallback", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    apiURL += "&type="+params.get("type");
	    session.setAttribute("state", state);
		modelMap.put("url", apiURL);
		
		return mapper.writeValueAsString(modelMap);
	}
	
	//????????? ??????????????? callback url????????????
	@RequestMapping(value = "/naverLoginAjax2", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String naverLoginAjax2(
			@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("tttteeeeeesssssss"+params.get("type"));
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//?????????????????? ??????????????? ????????????";
	    String redirectURI = URLEncoder.encode("http://localhost:8090/Jangboco/naverCallback2", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    apiURL += "&type="+params.get("type");
	    session.setAttribute("state", state);
		modelMap.put("url", apiURL);
		
		return mapper.writeValueAsString(modelMap);
	}

	//?????? ????????????
	//TODO: ?????? ?????? ???????????? ?????????
	//????????? ?????? callback??????
	@RequestMapping(value = {"/naverCallback"})
	public ModelAndView naverCallback(ModelAndView mav, HttpServletRequest httpRequest, HttpServletResponse response) throws Exception {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//?????????????????? ??????????????? ????????????";
	    String clientSecret = "PQJLkkvB6N";//?????????????????? ??????????????? ????????????";
	    String code = httpRequest.getParameter("code");
	    String state = httpRequest.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:8090/Jangboco/naverCallback", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    
	    String access_token = "";
	    String refresh_token = "";
	    String token_error = "";
	    System.out.println("apiURL="+apiURL);
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      if(responseCode==200) { // ?????? ??????
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // ?????? ??????
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	    	 //????????? ????????? ????????? ??????
	    	 //????????? ????????? ?????????
    		System.out.println("????????? ?????????"+res.toString());
    		JSONParser parsing = new JSONParser();
    		Object obj = parsing.parse(res.toString());
    		JSONObject jsonObj = (JSONObject)obj;
    			        
    		access_token = (String)jsonObj.get("access_token");
    		refresh_token = (String)jsonObj.get("refresh_token");
    		token_error = (String)jsonObj.get("error");
    		if(access_token != null && access_token !="") { // access_token??? ??? ???????????????
    			String email = getMemberEmail(access_token);
    			int cnt = iJoinService.validEmail(email);
    			if(cnt>0) {
    				//????????? ???????????????
    				mav.setViewName("/jangboco/join/joinNotSuccess");
    				return mav;
    			} else {
    				//????????? ?????? ?????? ?????? ???????????? ????????? ????????? 
    				mav.addObject("SocialEmail", email);
    				mav.setViewName("/jangboco/join/joinSocialForm");
    				return mav;
    			}
    		}
    		if(token_error !=null&& token_error!="") {
    			System.out.println("error");
    			mav.setViewName("redirect:/");
    			return mav;
    		}
	      } else {
	    	  mav.setViewName("redirect:/");
			    return mav;
	      }
	    } catch (Exception e) {
	      System.out.println(e);
	    }
	    mav.setViewName("redirect:/jangboco/join/joinSuccess");
	    return mav;
	}

	
	//???????????????
	//????????? ?????? callback??????
	//???????????? ????????? ?????????????????????
	//TODO: ?????? ?????? ???????????? ?????????
	@RequestMapping(value = {"/naverCallback2"})
	public ModelAndView naverCallback2(ModelAndView mav, HttpSession session, HttpServletRequest httpRequest, HttpServletResponse response) throws Exception {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
	    System.out.println("ttttttttttttteeeeeeeeeeeeeeeeeeeeeeelogin");
		String clientId = "jlJuEKFjyjO5XiGwl5eX";//?????????????????? ??????????????? ????????????";
	    String clientSecret = "PQJLkkvB6N";//?????????????????? ??????????????? ????????????";
	    String code = httpRequest.getParameter("code");
	    String state = httpRequest.getParameter("state");
	    String redirectURI = URLEncoder.encode("http://localhost:8090/Jangboco/naverCallback2", "UTF-8");
	    String apiURL;
	    apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code&";
	    apiURL += "client_id=" + clientId;
	    apiURL += "&client_secret=" + clientSecret;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&code=" + code;
	    apiURL += "&state=" + state;
	    
	    String access_token = "";
	    String refresh_token = "";
	    String token_error = "";
	    System.out.println("apiURL="+apiURL);
	    try {
	      URL url = new URL(apiURL);
	      HttpURLConnection con = (HttpURLConnection)url.openConnection();
	      con.setRequestMethod("GET");
	      int responseCode = con.getResponseCode();
	      BufferedReader br;
	      System.out.print("responseCode="+responseCode);
	      if(responseCode==200) { // ?????? ??????
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // ?????? ??????
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	    	 //????????? ????????? ????????? ??????
	    	 //????????? ????????? ?????????
    		System.out.println("????????? ?????????"+res.toString());
    		JSONParser parsing = new JSONParser();
    		Object obj = parsing.parse(res.toString());
    		JSONObject jsonObj = (JSONObject)obj;
    		access_token = (String)jsonObj.get("access_token");
    		refresh_token = (String)jsonObj.get("refresh_token");
    		token_error = (String)jsonObj.get("error");
    		if(access_token != null && access_token !="") { // access_token??? ??? ???????????????
    			String email = getMemberEmail(access_token);
    			int cnt = iJoinService.validEmail(email);
    			if(cnt>0) {
    				//????????? ???????????????
    				//????????? ?????? ????????? ??????
    				session.setAttribute("memberType", "1");
    				session.setAttribute("email", email);
    				HashMap<String, Object> member_info = iJoinService.getMemberInfo(email);
    				session.setAttribute("sMNo", member_info.get("MEMBER_NO"));
    				session.setAttribute("sNicnm", member_info.get("NICNM"));
    				mav.setViewName("redirect:/home");
    				return mav;
    			} else {
    				//????????? ?????? ???????????? ?????????????????? ???
    				mav.addObject("SocialEmail", email);
    				mav.setViewName("/jangboco/join/joinSocialForm");
    				return mav;
    			}
    		}
    		if(token_error !=null&& token_error!="") {
    			System.out.println("error");
    			mav.setViewName("redirect:/home");
    			return mav;
    		}
	      } else {
	    	  mav.setViewName("redirect:/home");
			    return mav;
	      }
	    } catch (Exception e) {
	      System.out.println(e);
	    }
	    mav.setViewName("redirect:/home");
	    return mav;
	}
	
	
	//????????? ????????? ?????? ???????????? 
	public String getMemberEmail(String access_token) {
        //String token = "YOUR_ACCESS_TOKEN";// ????????? ?????? ?????? ???";
		String email = "";
        String header = "Bearer " + access_token; // Bearer ????????? ?????? ??????
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // ?????? ??????
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // ?????? ??????
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            System.out.println(response.toString());
            JSONParser parsing = new JSONParser();
    		Object obj = parsing.parse(response.toString());
    		JSONObject jsonObj = (JSONObject)obj;
    		JSONObject responseObj = (JSONObject)jsonObj.get("response");
    		email = (String)responseObj.get("email");
    		System.out.println(email);
    		//email?????? ????????? ????????? ????????? ???????????? 
    		//????????? ????????? ?????? ??????????????? 
    		//????????? ?????? ??????????????? ???????????? (???????????????)
        } catch (Exception e) {
            System.out.println(e);
        }
		return email;
	}
	
	
	@RequestMapping(value="/loginPernl")
	public ModelAndView loginPernl(ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/loginPernl");
		return mav;
	}
	
	@RequestMapping(value="/loginForm")
	public ModelAndView loginForm(ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		mav.setViewName("jangboco/join/loginForm");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping(value="/loginCheck", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String loginCheck(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		HashMap<String,Object> hm = new HashMap<String, Object>();
		params.put("pw",Utils.encryptAES128(params.get("pw")));
		hm = iJoinService.loginPernlCheck(params);
		if(hm!=null) {
			modelMap.put("cnt", hm.get("CNT"));
			modelMap.put("member_type", hm.get("MEMBER_TYPE"));
		}
		return mapper.writeValueAsString(modelMap);
	}
	@ResponseBody
	@RequestMapping(value="/loginMember")
	public ModelAndView loginMember(@RequestParam HashMap<String,String> params, 
			HttpSession session,
			ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		System.out.println(params);
		String memberType = params.get("member_type");
//		String pageUrl = "jangboco/join/";
		if(memberType.equals("0")) {
			//?????????
			session.setAttribute("memberType", memberType);
			session.setAttribute("email", params.get("email"));
		} else if (memberType.equals("1")) {
			//??????
			System.out.println("?????? ???????????????");
//			pageUrl += "pernlPage";
			session.setAttribute("memberType", memberType);
			session.setAttribute("email", params.get("email"));
		} else if (memberType.equals("2")){
			//??????
			System.out.println("?????? ???????????????");
//			pageUrl += "marketPage";
			session.setAttribute("memberType", memberType);
			session.setAttribute("email", params.get("email"));
		}
		HashMap<String, Object> member_info = iJoinService.getMemberInfo(params.get("email"));
		session.setAttribute("sMNo", member_info.get("MEMBER_NO"));
		session.setAttribute("sNicnm", member_info.get("NICNM"));
//		mav.setViewName(pageUrl);
		mav.setViewName("redirect:home");
		return mav;
	}
	
	//?????? ???????????? ????????? ????????? ??????
	@ResponseBody
	@RequestMapping(value="/findPwAjax", method = RequestMethod.POST,
			produces = "text/json; charset=UTF-8")
	public String findPwAjax(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		System.out.println(params);
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		int cnt = iJoinService.findPw(params.get("email"));
		modelMap.put("cnt", cnt);
		return mapper.writeValueAsString(modelMap);
	}

	@RequestMapping(value="/findMember")
	public ModelAndView findMember(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		System.out.println(params);
		mav.addObject("email",params.get("email"));
		mav.setViewName("jangboco/join/findPwSet");
		return mav;
	}
	
	@RequestMapping(value="/setNewPw")
	public ModelAndView setNewPw(@RequestParam HashMap<String,Object> params, ModelAndView mav) throws Throwable {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
		System.out.println(params);
		params.put("pw",Utils.encryptAES128((String) params.get("pw")));
		int cnt = iJoinService.setNewPw(params);
		mav.setViewName("jangboco/join/setNewPwSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/logout")
	public ModelAndView logout(HttpSession session, ModelAndView mav) throws Throwable {
		session.invalidate();
		
		mav.setViewName("redirect:home");
		
		return mav;
	}
	
}

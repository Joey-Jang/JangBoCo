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
        
        String subject = "장보코 인증메일입니다";
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
		
		//social type 1 일반 2네이버 3카카오
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
	
	//네이버 소셜로그인 callback url가져오기
	@RequestMapping(value = "/naverLoginAjax", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String naverLoginAjax(
			@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("tttteeeeeesssssss"+params.get("type"));
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
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
	
	//네이버 소셜로그인 callback url가져오기
	@RequestMapping(value = "/naverLoginAjax2", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String naverLoginAjax2(
			@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		System.out.println("tttteeeeeesssssss"+params.get("type"));
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
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

	//소셜 회원가입
	//TODO: 소셜 공통 함수처리 합시다
	//네이버 소셜 callback처리
	@RequestMapping(value = {"/naverCallback"})
	public ModelAndView naverCallback(ModelAndView mav, HttpServletRequest httpRequest, HttpServletResponse response) throws Exception {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "PQJLkkvB6N";//애플리케이션 클라이언트 시크릿값";
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
	      if(responseCode==200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	    	 //로그인 취소시 여기서 터짐
	    	 //로그인 에러가 아닐시
    		System.out.println("여기서 터지나"+res.toString());
    		JSONParser parsing = new JSONParser();
    		Object obj = parsing.parse(res.toString());
    		JSONObject jsonObj = (JSONObject)obj;
    			        
    		access_token = (String)jsonObj.get("access_token");
    		refresh_token = (String)jsonObj.get("refresh_token");
    		token_error = (String)jsonObj.get("error");
    		if(access_token != null && access_token !="") { // access_token을 잘 받아왔다면
    			String email = getMemberEmail(access_token);
    			int cnt = iJoinService.validEmail(email);
    			if(cnt>0) {
    				//가입한 사람이있음
    				mav.setViewName("/jangboco/join/joinNotSuccess");
    				return mav;
    			} else {
    				//가입한 사람 없음 가입 진행하고 파람에 담아둠 
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

	
	//소셜로그인
	//네이버 소셜 callback처리
	//아이디가 있으면 세션처리하는곳
	//TODO: 소셜 공통 함수처리 합시다
	@RequestMapping(value = {"/naverCallback2"})
	public ModelAndView naverCallback2(ModelAndView mav, HttpSession session, HttpServletRequest httpRequest, HttpServletResponse response) throws Exception {
		mav.addObject("homeFlag", 1);
		mav.addObject("menuIdx", 0);
		mav.addObject("subMenuIdx", 0);
		
	    System.out.println("ttttttttttttteeeeeeeeeeeeeeeeeeeeeeelogin");
		String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
	    String clientSecret = "PQJLkkvB6N";//애플리케이션 클라이언트 시크릿값";
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
	      if(responseCode==200) { // 정상 호출
	        br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	      } else {  // 에러 발생
	        br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	      }
	      String inputLine;
	      StringBuffer res = new StringBuffer();
	      while ((inputLine = br.readLine()) != null) {
	        res.append(inputLine);
	      }
	      br.close();
	      if(responseCode==200) {
	    	 //로그인 취소시 여기서 터짐
	    	 //로그인 에러가 아닐시
    		System.out.println("여기서 터지나"+res.toString());
    		JSONParser parsing = new JSONParser();
    		Object obj = parsing.parse(res.toString());
    		JSONObject jsonObj = (JSONObject)obj;
    		access_token = (String)jsonObj.get("access_token");
    		refresh_token = (String)jsonObj.get("refresh_token");
    		token_error = (String)jsonObj.get("error");
    		if(access_token != null && access_token !="") { // access_token을 잘 받아왔다면
    			String email = getMemberEmail(access_token);
    			int cnt = iJoinService.validEmail(email);
    			if(cnt>0) {
    				//가입한 사람이있음
    				//세션에 담고 홈으로 이동
    				session.setAttribute("memberType", "1");
    				session.setAttribute("email", email);
    				System.out.println(session.getAttribute("email"));
    				mav.setViewName("redirect:/home");
    				return mav;
    			} else {
    				//가입한 사람 없으니까 가입진행바로 함
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
	
	
	//이용자 데이터 정보 받아오기 
	public String getMemberEmail(String access_token) {
        //String token = "YOUR_ACCESS_TOKEN";// 네아로 접근 토큰 값";
		String email = "";
        String header = "Bearer " + access_token; // Bearer 다음에 공백 추가
        try {
            String apiURL = "https://openapi.naver.com/v1/nid/me";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("GET");
            con.setRequestProperty("Authorization", header);
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
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
    		//email쿼리 날려서 있는지 없는지 확인하기 
    		//없으면 세션에 담고 가입할준비 
    		//있으면 바로 메인창으로 넘어가기 (로그인처리)
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
			//관리자
			session.setAttribute("memberType", memberType);
			session.setAttribute("email", params.get("email"));
		} else if (memberType.equals("1")) {
			//일반
			System.out.println("일반 로그인성공");
//			pageUrl += "pernlPage";
			session.setAttribute("memberType", memberType);
			session.setAttribute("email", params.get("email"));
		} else if (memberType.equals("2")){
			//마켓
			System.out.println("마켓 로그인성공");
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
	
	//해당 아이디가 있는지 없는지 확인
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

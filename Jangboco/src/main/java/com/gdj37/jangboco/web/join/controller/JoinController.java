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
	
	@RequestMapping(value = "/loginMain")
	public ModelAndView loginMain(ModelAndView mav) {
		mav.setViewName("jangboco/join/loginMain");
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
		mav.setViewName("jangboco/join/joinPernlSocial");
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
	
	@RequestMapping(value = "/joinPernlMember", method=RequestMethod.POST)
	public ModelAndView joinPernlMember(@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
		System.out.println(params);
		params.put("member_type", "1");
		params.put("social_type", "1");
		int cnt = iJoinService.addMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/joinSocialMember", method=RequestMethod.POST)
	public ModelAndView joinSocialMember (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
		//social type 1 일반 2네이버 3카카오
		params.put("member_type", "1");
		params.put("social_type", "2");
		params.put("pw","");
		int cnt = iJoinService.addMember(params);
		mav.setViewName("jangboco/join/joinSuccess");
		return mav;
	}
	
	@RequestMapping(value = "/joinMarketMember", method=RequestMethod.POST)
	public ModelAndView joinMarketMember (@RequestParam HashMap<String,String> params, ModelAndView mav) throws Exception {
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
	
	//네이버 소셜로그인 callback url가져오기
	@RequestMapping(value = "/naverLoginAjax", method = RequestMethod.POST, 
			produces = "text/json;charset=UTF-8")
	@ResponseBody
	public String naverLoginAjax(
			@RequestParam HashMap<String, String> params, HttpSession session) throws Throwable {
		ObjectMapper mapper = new ObjectMapper();
		Map<String, Object> modelMap = new HashMap<String, Object>();
		
	    String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
	    String redirectURI = URLEncoder.encode("http://localhost:8181/Jangboco/naverCallback", "UTF-8");
	    SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code";
	    apiURL += "&client_id=" + clientId;
	    apiURL += "&redirect_uri=" + redirectURI;
	    apiURL += "&state=" + state;
	    session.setAttribute("state", state);
		modelMap.put("url", apiURL);
		
		return mapper.writeValueAsString(modelMap);
	}

	//네이버 소셜 callback처리
	@RequestMapping(value = {"/naverCallback"})
	public ModelAndView naverCallback(ModelAndView mav, HttpServletRequest httpRequest, HttpServletResponse response) throws Exception {
		   String clientId = "jlJuEKFjyjO5XiGwl5eX";//애플리케이션 클라이언트 아이디값";
		    String clientSecret = "PQJLkkvB6N";//애플리케이션 클라이언트 시크릿값";
		    String code = httpRequest.getParameter("code");
		    String state = httpRequest.getParameter("state");
		    System.out.println("tttttttttttttttttttttt"+httpRequest.getParameter("type"));
		    String redirectURI = URLEncoder.encode("http://localhost:8181/Jangboco/naverCallback", "UTF-8");
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
	
	//일반로그인폼 리턴
	
	//일반 로그인가능 기능
	
	//
}

package com.defaultcompany.login;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonReader;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.util.StringUtils;
import org.uengine.kernel.GlobalContext;
import org.uengine.util.dao.DefaultConnectionFactory;

public class LoginServiceNew extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
//	private static final long serialVersionUID = -3242857670591254311L;
	public final static String COOKIE_SAVE_ID = "uEngine.Standalone.loggedUserId";
	public final static String COOKIE_AUTO_LOGIN = "uEngine.Standalone.AutoLogin";
	
	/**
	 * Login By Cookie
	 * @param request
	 * @return authenticationCondition
	 */
	public String loginForCookie(HttpServletRequest request){	
		String authenticationCondition = "Fail" ;	
		Cookie[] cookies = request.getCookies();
		
		if(cookies!=null && cookies.length > 0){

			String	userId = "";
			String	autoLogin = "";
			
			for(Cookie cookie : cookies){
				if(COOKIE_SAVE_ID.equals(cookie.getName())){
					userId = cookie.getValue();
				}else if(COOKIE_AUTO_LOGIN.equals(cookie.getName())){
					autoLogin = cookie.getValue();
				}
			}
			
			if(StringUtils.hasText(userId) && StringUtils.hasText(autoLogin) && "true".equals(autoLogin)){
				
				LoginDAO loginDAO = new LoginDAO(((DefaultConnectionFactory) DefaultConnectionFactory.create()).getDataSource());
				Login loginUserInfo = loginDAO.getUserInfo(userId);
				
			
				if (loginUserInfo != null/* && loginUserInfo.getPassword().equals(passWd)*/) {
					HttpSession session = request.getSession(false);
					
					loginUserInfo.setPermission(loginDAO.getPermission(userId));					
					
					/* *****************************************************************************
					 * Check ProcessManager Permission ( Y :isEdition(true), N : isEdition(false) )
					 * ****************************************************************************/
					if("4".equals(loginUserInfo.getPermission())){
						session.setAttribute("loggedUserIsEdition", true);
					}
					
					session.setAttribute("loggedUserId", 		userId);
					session.setAttribute("loggedUserFullName", 	loginUserInfo.getEmpname());
					session.setAttribute("loggedUserIsAdmin",  	loginUserInfo.getIsadmin());
					session.setAttribute("loggedUserJikName",  	loginUserInfo.getJikname());
					session.setAttribute("loggedUserEmail",    	loginUserInfo.getEmail());
					session.setAttribute("loggedUserPartCode", 	loginUserInfo.getPartcode());
					session.setAttribute("loggedUserPartName", 	loginUserInfo.getPartname());
					session.setAttribute("loggedUserGlobalCom", loginUserInfo.getGlobalcom());
					session.setAttribute("loggedUserComName", 	loginUserInfo.getComname());
					session.setAttribute("loggedUserLocale", 	loginUserInfo.getLocale());
					session.setAttribute("loggedUserNateonId", 	loginUserInfo.getNateon());
					session.setAttribute("loggedUserMsnId", 	loginUserInfo.getMsn());

					authenticationCondition = "Success";
				}
			}
		}
		
		return authenticationCondition;
	}
	
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");        
        login(request);       
  
    }
	
	
	/**
	 * Login By Request 
	 * @param request
	 * @return JSON message
	 * @throws IOException 
	 */
	public String login(HttpServletRequest request) throws IOException {

		String authenticationCondition = "Fail" ;
		String authenticationConditionMsg = "TEST A";
		/* ************************************************
		 * loginFrom.jsp : requerst param userId, passWd 
		 **************************************************/
		String userId = request.getParameter("userId") == null ? "" : request.getParameter("userId");
		String passWd = request.getParameter("passWd") == null ? "" : request.getParameter("passWd");
//		//String userId ="test";		
		//String passWd ="test";
		String logOut = "request =[" +userId+ "] -- [" + passWd+"]" ;
	
		if (StringUtils.hasText(userId) && StringUtils.hasText(passWd)) {
		
			try{
				LoginDAO loginDAO = new LoginDAO(((DefaultConnectionFactory) DefaultConnectionFactory.create()).getDataSource());
				Login loginUserInfo = loginDAO.getUserInfo(userId);
				String log = "loginName1 =[" + loginUserInfo.getEmpname() + "], passwd = [" + loginUserInfo.getPassword() +"]";
			
				authenticationConditionMsg = GlobalContext.getMessageForWeb(log, GlobalContext.DEFAULT_LOCALE);
				if (loginUserInfo != null && loginUserInfo.getPassword().equals(passWd)) {
					HttpSession session = request.getSession(false);
					
					loginUserInfo.setPermission(loginDAO.getPermission(userId));
					
					/* *****************************************************************************
					 * Check ProcessManager Permission ( Y :isEdition(true), N : isEdition(false) )
					 * ****************************************************************************/
					if("4".equals(loginUserInfo.getPermission())){
						session.setAttribute("loggedUserIsEdition", true);
					}
					
					session.setAttribute("loggedUserId", 		userId);
					session.setAttribute("loggedUserFullName", 	loginUserInfo.getEmpname());
					session.setAttribute("loggedUserIsAdmin",  	loginUserInfo.getIsadmin());
					session.setAttribute("loggedUserJikName",  	loginUserInfo.getJikname());
					session.setAttribute("loggedUserEmail",    	loginUserInfo.getEmail());
					session.setAttribute("loggedUserPartCode", 	loginUserInfo.getPartcode());
					session.setAttribute("loggedUserPartName", 	loginUserInfo.getPartname());
					session.setAttribute("loggedUserGlobalCom", loginUserInfo.getGlobalcom());
					session.setAttribute("loggedUserComName", 	loginUserInfo.getComname());
					session.setAttribute("loggedUserLocale", 	loginUserInfo.getLocale());
					session.setAttribute("loggedUserNateonId", 	loginUserInfo.getNateon());
					session.setAttribute("loggedUserMsnId", 	loginUserInfo.getMsn());

					authenticationCondition = "Success";
					
				} else {
					authenticationConditionMsg = GlobalContext.getMessageForWeb( log,GlobalContext.DEFAULT_LOCALE);
	
				}
			
			}catch(Exception e){
				authenticationConditionMsg = GlobalContext.getMessageForWeb( logOut,GlobalContext.DEFAULT_LOCALE);
				System.err.println(e.getMessage());

			}
			
		}else{
			authenticationConditionMsg = GlobalContext.getMessageForWeb(logOut,GlobalContext.DEFAULT_LOCALE);

			
		}
		
		return toJSON(authenticationCondition,authenticationConditionMsg);
	}
	
	/**
	 * String values to JSON String 
	 * @param authenticationCondition
	 * @param authenticationConditionMsg
	 * @return
	 */
	private String toJSON(String authenticationCondition , String authenticationConditionMsg){
		StringBuilder json = new StringBuilder();
		
		json.append("{");
		if(StringUtils.hasText(authenticationCondition)){
			json.append("'condition':'");
			json.append(authenticationCondition);
			json.append("'");
		}
		
		if(StringUtils.hasText(authenticationConditionMsg)){
			json.append(StringUtils.hasText(authenticationCondition)?",":"");
			
			json.append("'msg':'");
			json.append(authenticationConditionMsg);
			json.append("'");
		}
		json.append("}");
		
		return json.toString();
	}
}

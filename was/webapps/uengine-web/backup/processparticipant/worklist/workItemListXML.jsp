<%@page import="java.io.OutputStream"%><%@page import="java.beans.XMLEncoder"%><%@page import="java.net.URLEncoder"%><%@page import="java.util.Date"%><%@page import="java.util.List"%><%@page import="java.util.ArrayList"%><%@page import="java.util.Hashtable"%><%@page import="java.sql.ResultSet"%><%@page import="org.uengine.util.dao.DefaultConnectionFactory"%><%@page import="java.sql.PreparedStatement"%><%@page import="java.sql.Connection"%><%@page import="org.springframework.web.bind.ServletRequestUtils"%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%
	String endpoint = ServletRequestUtils.getStringParameter(request, "endpoint", null);
	StringBuffer sql = new StringBuffer("");
	sql.append(" select DISTINCT INST.NAME as procinstnm, INST.initrsnm, INST.INFO, WL.* FROM BPM_PROCINST INST, BPM_WORKLIST WL "); 
	sql.append(" INNER JOIN BPM_ROLEMAPPING ROLE ON WL.ROLENAME=ROLE.ROLENAME OR WL.ENDPOINT='").append(endpoint).append("' ");
	sql.append(" where (wl.status = 'NEW' or wl.status = 'CONFIRMED' or wl.status = 'DRAFT') ");
	sql.append(" and inst.isdeleted=0 AND WL.INSTID=INST.INSTID AND WL.INSTID=ROLE.INSTID AND INST.ISDELETED=0 ");
	sql.append(" AND ROLE.ENDPOINT='").append(endpoint).append("' order by wl.startdate desc ");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	List<Hashtable<String, Object>> worklists = new ArrayList<Hashtable<String, Object>>();
	XMLEncoder xmlEncoder = new XMLEncoder(response.getOutputStream());
	try {
		conn = DefaultConnectionFactory.create().getConnection();
		pstmt = conn.prepareStatement(sql.toString());
		rs = pstmt.executeQuery();
		
		StringBuffer sb = new StringBuffer("");
		
		while (rs.next()) {
			Hashtable<String, Object> ht = new Hashtable<String, Object>();
			
			ht.put("TASKID", URLEncoder.encode(rs.getString("TASKID"), "UTF-8"));
			ht.put("PROCINSTNM", URLEncoder.encode(rs.getString("PROCINSTNM"), "UTF-8"));
			ht.put("TITLE", URLEncoder.encode(rs.getString("TITLE"), "UTF-8"));
			ht.put("STARTDATE", new Date(rs.getTimestamp("STARTDATE").getTime()));
			
			worklists.add(ht);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if (rs != null) try { rs.close(); } catch(Exception e) {}
		if (pstmt != null) try { pstmt.close(); } catch(Exception e) {}
		if (conn != null) try { conn.close(); } catch(Exception e) {}
	}
	
	xmlEncoder.writeObject(worklists);
	xmlEncoder.close();%>
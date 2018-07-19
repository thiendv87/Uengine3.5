<?xml version="1.0" encoding="UTF-8"?>
<%@page pageEncoding="KSC5601"%>
<%response.setContentType("text/xml; charset=UTF-8");%>
<%@include file="../../../common/no_cache.jsp"%>
<%@include file="../../../common/commons.jsp"%>
<%@page import="hanwha.bpm.BPMConstants"%>
<%
	String filePath = request.getParameter("filePath");
	String mode = request.getParameter("mode");
	String namePrefix = request.getParameter("namePrefix");
	String inFileName = GWUtil.toEncode(request.getParameter("inFileName"));
	String inContents = GWUtil.toEncode(request.getParameter("inContents"));
	String outFileName = GWUtil.toEncode(request.getParameter("outFileName"));
	String outContents = GWUtil.toEncode(request.getParameter("outContents"));
	String mapFileName = GWUtil.toEncode(request.getParameter("mapFileName"));
	String mapContents = GWUtil.toEncode(request.getParameter("mapContents"));
	File baseDir = new File(BPMConstants.FORM_FILE_PATH, filePath);
	File targetFile = new File(baseDir, inFileName);
	GWUtil.saveContents(targetFile, inContents);
	targetFile = new File(baseDir, outFileName);
	GWUtil.saveContents(targetFile, outContents);
	targetFile = new File(baseDir, mapFileName);
	GWUtil.saveContents(targetFile, mapContents);
	targetFile = new File(baseDir, namePrefix+"-"+mode+"map.xml");
	GWUtil.saveContents(targetFile, mapContents);
%>
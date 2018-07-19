<%@page import="org.uengine.ui.list.util.FileUploadUtil"%>
<%@page import="org.uengine.kernel.ProcessDefinitionFactory"%>
<%@page import="org.uengine.kernel.FormActivity"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUpload"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.File"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.uengine.util.UEngineUtil"%>
<%@page import="com.sun.xml.internal.ws.util.UtilException"%>
<%@page import="org.uengine.ui.taglibs.input.InputConstants"%>
<%@page import="org.uengine.contexts.FileContext"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="org.apache.log4j.Logger"%>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%@ page pageEncoding="UTF-8" language="java"
	contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding(GlobalContext.ENCODING);
	Logger logger = Logger.getLogger(this.getClass());

	if (FileUpload.isMultipartContent(request)) {
		String fileSystemDir = FormActivity.FILE_SYSTEM_DIR;
		File f = new File("temp");
		f.mkdirs();

		DiskFileItemFactory diskFileItemFactory = new DiskFileItemFactory(100 * 100, f); //100KB cache
		ServletFileUpload upload = new ServletFileUpload(diskFileItemFactory);
		upload.setFileSizeMax(10 * 1024 * 1024);	//10MB
		upload.setHeaderEncoding(GlobalContext.ENCODING);

		try {
			FileContext fc = null;
			String fileTagName = "";
			String fileClass = "";
			int viewMode = InputConstants.WRITE;
			List fileItemsList = upload.parseRequest(request);
			Iterator itor = fileItemsList.iterator();

			while (itor.hasNext()) {

				FileItem fileItem = (FileItem) itor.next();

				if (fileItem.isFormField()) {
					if ("fileClass".equals(fileItem.getFieldName())) {
						fileClass = fileItem.getString(GlobalContext.ENCODING);
						continue;
					}

					if ("viewMode".equals(fileItem.getFieldName())) {
						try {
							viewMode = Integer.parseInt(fileItem.getString(GlobalContext.ENCODING));
						} catch (NumberFormatException e) {
						}
						continue;
					}
				} else {
					String fileNameOnly = fileItem.getName();
					if (!UEngineUtil.isNotEmpty(fileItem.getName()))
						continue;

					int lastIndexOfSeparator = fileNameOnly.lastIndexOf("\\");
					if (lastIndexOfSeparator == -1) {
						lastIndexOfSeparator = fileNameOnly.lastIndexOf("/");
					}
					if (lastIndexOfSeparator > -1)
						fileNameOnly = fileNameOnly.substring(lastIndexOfSeparator + 1);

					String uniqueFName = java.util.Calendar.getInstance().getTimeInMillis()	+ "_" + fileNameOnly;
					uniqueFName = uniqueFName.replaceAll(" ", "_");
					String dirPath = UEngineUtil.getCalendarDir();
					File dirFile = new File(fileSystemDir + "/"	+ dirPath);
					dirFile.mkdirs();
					File savedFile = new File(dirFile, uniqueFName);
					fileItem.write(savedFile);

					fc = new FileContext();
					fc.setPath(dirPath + "/" + uniqueFName);
					fileTagName = fileItem.getFieldName();
				}
			}

			String tag = FileUploadUtil.getFileUploadTag(fileTagName, fc, fileClass, viewMode);
			out.print(tag);
		} catch (Exception e) {
			if (e instanceof org.apache.commons.fileupload.FileUploadException) {
				logger.error(e.getMessage());
			} else {
				throw e;
			}
		}
	}
%>
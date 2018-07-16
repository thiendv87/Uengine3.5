<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	request.setCharacterEncoding(GlobalContext.ENCODING);
	
	if(FileUpload.isMultipartContent(request)){
		String tempDir= request.getRealPath("images/portrait/");
		
		DiskFileUpload fileUpload = new DiskFileUpload();
		fileUpload.setRepositoryPath(tempDir);
		fileUpload.setSizeMax(1024*1024*2); // 2MB
		fileUpload.setSizeThreshold(1024*100);
		
		if(request.getContentLength()<fileUpload.getSizeMax()){
			
			List fileItemList = fileUpload.parseRequest(request);
			int Size = fileItemList.size();
			
			String empCode = "";
			for(int i=0; i<Size; i++){
				FileItem fileItem = (FileItem)fileItemList.get(i);
				
				if(fileItem.isFormField()){
					if(fileItem.getFieldName().equals("emp"))
						empCode = fileItem.getString(GlobalContext.ENCODING);
				}else{
					
					//save file
					/*
					if(fileItem.isInMemory()){
						out.print("메모리에 저장<br/>");
					}else{
						out.print("디스크에 저장<br/>");
					}
					*/
					
					if(fileItem.getSize()>0){
						String fileName = URLDecoder.decode(fileItem.getName(), GlobalContext.ENCODING) ;
						int exp = fileName.lastIndexOf("."); 
						String fileExp = fileName.substring(exp).toLowerCase();
						
						if (!".gif".equals(fileExp)) {
							fileExp = ".gif";
						}
						
						File uploadedFile = new File(tempDir, empCode+fileExp);
						if(uploadedFile.exists()) {
							uploadedFile.delete();
						}
						fileItem.write(uploadedFile);
					}//end if
				}//end if
			}//end for
			%>
			<script>
				alert("upload success");
				self.close();
			</script>
			<%
		}else{
			int overSize = (request.getContentLength()/1000000);
			out.print("파일의 크기는 2MB까지 입니다. 올리신 파일용량은 ");
			out.print(overSize);
			out.print("MB입니다.");
		}
	}else{
		out.print("인코딩 타입이 multipart/form-data가 아닙니다.");
	}
%>
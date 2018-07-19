<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@page import="org.uengine.kernel.GlobalContext"%>
<%
	if(FileUpload.isMultipartContent(request)){
		String tempDir= request.getRealPath("images/portrait/groups/");
		
		DiskFileUpload fileUpload = new DiskFileUpload();
		fileUpload.setRepositoryPath(tempDir);
		fileUpload.setSizeMax(1024*1024*2); // 2MB
		fileUpload.setSizeThreshold(1024*100);
		
		if(request.getContentLength()<fileUpload.getSizeMax()){
			
			List fileItemList = fileUpload.parseRequest(request);
			int Size = fileItemList.size();
			
			String groupCode = "";
			for(int i=0; i<Size; i++)
			{
				FileItem fileItem = (FileItem)fileItemList.get(i);
				
				if(fileItem.isFormField())
				{
					if(fileItem.getFieldName().equals("inputGroupCode"))
					{
						groupCode = fileItem.getString("UTF-8");
					}
				}
				else
				{	
					//save file
					if(fileItem.isInMemory())
					{
						out.print("메모리에 저장<br/>");
					}
					else
					{
						out.print("디스크에 저장<br/>");
					}
					
					if(fileItem.getSize()>0)
					{
				
						int exp = fileItem.getName().lastIndexOf(".");
						String fileExp = fileItem.getName().substring(exp).toLowerCase();
						
						if (!".gif".equals(fileExp))
						{
							fileExp = ".gif";
						}
						
						try
						{
							File uploadedFile = new File(tempDir, groupCode + "_logo" + fileExp);
							
							if(uploadedFile.exists())
							{
								uploadedFile.delete();
							}
							
							fileItem.write(uploadedFile);
						}
						catch(IOException e)
						{
							System.out.println(e);
						}
					}//end if
				}//end if
			}//end for
			%>
			<script>
				alert("upload success");
				self.close();
			</script>
			<%
		}
		else
		{
			int overSize = (request.getContentLength()/1000000);
			out.print("파일의 크기는 2MB까지 입니다. 올리신 파일용량은 ");
			out.print(overSize);
			out.print("MB입니다.");
		}
	}
	else
	{
		out.print("인코딩 타입이 multipart/form-data가 아닙니다.");
	}
%>
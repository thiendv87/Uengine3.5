package wih.documentHandler; 

import sun.net.ftp.*; 
import sun.net.*; 
import java.io.*; 

public class Uploader extends FtpClient{ 
	public Uploader(){
		super();
	}
	
	public void connect(String server, String user, String pass) throws Exception{
      openServer(server, 21);
			
		login(user, pass); 
	}	
	
	public void uploadFile(String fileName, String directory) throws Exception{
		uploadFile(new File(fileName), directory);
	}
	
	public void uploadFile(File file, String directory) throws Exception{
		uploadFile(new FileInputStream(file), directory);
	}

	public void uploadFile(FileInputStream is, String directory) throws Exception{
		binary();

		byte[] bytes = new byte[1024]; 
		int c; 
		int total_bytes=0; 
			
		TelnetOutputStream tos = put(directory); 
			
		while((c=is.read(bytes)) !=-1) 
		{ 
				total_bytes +=c; 
				tos.write(bytes,0,c); 
		} 
			
		tos.close(); 
		is.close();
	} 
	
	public static void main(String args[]) throws Exception{ 
		Uploader uploader = new Uploader();
		
		uploader.connect("156.147.135.67", "ips_pdm", "manager");
		
		uploader.uploadFile("\\\\wmpdm3\\root\\disk3\\iman_vol\\iman_vol1\\infodba\\4322180_dwg_dwg_366f1623.dwg", "CCZ/drawing/test.put"); 
		uploader.uploadFile("\\\\wmpdm3\\root\\disk3\\iman_vol\\iman_vol1\\infodba\\4322180_dwg_dwg_366f1623.dwg", "DFZ/drawing/test.put"); 
	} 
} 


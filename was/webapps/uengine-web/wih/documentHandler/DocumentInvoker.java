package wih.documentHandler; 

import java.io.*;
import java.net.*;
import javax.swing.*;
import java.awt.event.*;

public class DocumentInvoker
{
	static int BUF_SIZE = 65535;
	byte[] buffer = new byte[BUF_SIZE];
	
	String uploadFTPaddress, uploadDirectory, id, pw, fName, localFilePath;
	
	public void init(String[] args)
	{
		
		try{		
			URL u = new URL(args[0]);
			
			uploadFTPaddress = args[1];
			uploadDirectory = args[2];
			id = args[3];
			pw = args[4];
						
			try{
				(new File("uengine_temp")).mkdir();
			}catch(Exception e){}
			fName = args[0].substring(args[0].lastIndexOf("/") + 1, args[0].length());			
			localFilePath = "uengine_temp"+ System.getProperty("file.separator") +  fName;
						
			BufferedInputStream is = new BufferedInputStream(u.openStream());
			FileOutputStream fo = new FileOutputStream(localFilePath);
			BufferedOutputStream fos = new BufferedOutputStream(fo);

			int iRead, iPos=0;
			while((iRead = is.read(buffer, 0, BUF_SIZE)) > 0){
				fos.write(buffer, 0, iRead);
				iPos += iRead;
			}
						
			fos.close();
			fo.close();
			is.close();	
			
			//String absPath = (new File(fNameOnly)).getAbsolutePath();
	
			systemCall("cmd /c"+ localFilePath);
		}catch(Exception e){reportError(e);}
	}

	public void systemCall(String args) throws Exception{
	
System.out.println(args);
		Process proc = 	(Runtime.getRuntime()).exec(args);
		
		if(proc==null) return;
		
		final InputStream stream = proc.getErrorStream();
		final InputStream stream2 = proc.getInputStream();
		
		final BufferedReader reader = new BufferedReader(new InputStreamReader(stream));
		final BufferedReader reader2 = new BufferedReader(new InputStreamReader(stream2));

		new Thread(){
			public void run(){
				try{
					String line;
					do{
						String message = (line = reader.readLine())+"\n";
						System.out.println(">"+ message);
					}while(line != null);
				
					reader.close();
					
					onCallTerminated();
					
				}catch(Exception e){
					reportError(e);
				}
				
			}
			
		}.start();
		
		new Thread(){
			public void run(){
				try{
					String line;
					do{
						String message = (line = reader2.readLine())+"\n";
						System.out.println(">"+ message);
					}while(line != null);
					
					reader2.close();

					onCallTerminated();
				}catch(Exception e){
					reportError(e);
				}
				
			}
		}.start();			
			
	}
	
	int callTerminatedSeq=0;
	public void onCallTerminated(){
		callTerminatedSeq ++;		
		if(callTerminatedSeq==2){
			try{			
				Uploader uploader = new Uploader();
							
				uploader.connect(uploadFTPaddress, id, pw);
				uploader.uploadFile(localFilePath, uploadDirectory + "/" + fName); 
				
				System.exit(0);
			}catch(Exception e){
				reportError(e);
			}
		}
	}
	
	public void reportError(Exception e){
		JFrame errFrm = new JFrame("u|Engine document handler : error");
		ByteArrayOutputStream bao = new ByteArrayOutputStream();
		e.printStackTrace(new PrintStream(bao));
		
		JTextArea ta = new JTextArea();
		ta.setText(bao.toString());
		errFrm.getContentPane().add(new JScrollPane(ta));
		
		errFrm.setSize(200,150);
		errFrm.show();
		
		errFrm.addWindowListener (		
			new WindowAdapter() {
				public void windowClosing(WindowEvent e) {
					System.exit(0);
				}
			}
		);

	}
	
	public static void main(String[] args){
		(new DocumentInvoker()).init(args);
	}	
}		

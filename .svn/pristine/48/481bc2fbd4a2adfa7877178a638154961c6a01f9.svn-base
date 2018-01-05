package com.hcicloud.sap.service.task;

import java.io.BufferedReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;

public class OutputStreamTask extends Thread{

	InputStream is;  
	String type;
	String transfromLogDir;
	Boolean flagLog;
	Boolean flagStdout;

	public OutputStreamTask(InputStream is, String type, 
			String transfromLogDir, Boolean flagLog, Boolean flagStdout) {  
		this.is = is;  
		this.type = type;  
		this.transfromLogDir = transfromLogDir;
		this.flagLog = flagLog;
		this.flagStdout = flagStdout;
	}  

	@Override  
	public void run() {
		InputStreamReader isr = null;
		BufferedReader br = null;
		PrintWriter pw = null;
		try {
			isr = new InputStreamReader(is);

			br = new BufferedReader(isr);
			StringBuffer sbf = new StringBuffer();
			String line = null;
			while ((line = br.readLine()) != null) {
				sbf.append(line).append("\n");
			}

			if (flagLog) {
				pw = new PrintWriter(new FileWriter(transfromLogDir, true));
				pw.println(type + ":" + sbf.toString());
				pw.flush();
			}

			if(flagStdout) {
				System.out.println(type + ":" + sbf.toString());
			}
		} catch (IOException ioe) {  
			ioe.printStackTrace();  
		} finally {
			if(isr != null) {
				try {
					isr.close();
				} catch (IOException e) {
					System.out.println("关闭InputStreamReader失败,错误信息：" + e.getMessage());
				}
			}
			if(br != null) {
				try {
					br.close();
				} catch (IOException e) {
					System.out.println("关闭BufferedReader失败,错误信息：" + e.getMessage());
				}
			}
			if(pw != null) {
				pw.close();
			}
		}
	}
}

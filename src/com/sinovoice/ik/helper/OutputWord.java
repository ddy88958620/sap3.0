/**
 * 
 */
package com.sinovoice.ik.helper;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

/**
 * @author liuweiquan
 *
 */
public class OutputWord {

	public void doOutput(String dicFilePathStr, HttpServletResponse response) {
		//中文不能输出乱码：
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		File dicFile = new File(dicFilePathStr); // 创建文件对象
		if (dicFile.exists() && dicFile.isFile() && dicFile.canRead()) {
			// 字典文件如果存在，就返回2个特定的header:
			response.addHeader("Last-Modified",	String.valueOf(dicFile.lastModified()));
			response.addHeader("ETag", String.valueOf(dicFile.length()));
			//输出词典词条：
			ServletOutputStream out;
			try {
				out = response.getOutputStream();
			    //打开文本文件，读一行写一行：
				BufferedReader br = new BufferedReader(new InputStreamReader(  
		                new FileInputStream(dicFile), "GBK"));  
				
				String w = br.readLine();
				while( w!= null ){//一次读入一行，直到读入null为文件结束;
					 w += "\n";
					 out.write(w.getBytes("utf-8"));
					 w = br.readLine();
				}
				br.close();		
			} catch (FileNotFoundException e) {
				//读不成功，不做任何事
				e.printStackTrace();
			} catch (IOException e) {
				//读不成功，不做任何事
				e.printStackTrace();
			}  
		}
		// else 文件如果不存在，就不返回任何内容
		return;
	}

}

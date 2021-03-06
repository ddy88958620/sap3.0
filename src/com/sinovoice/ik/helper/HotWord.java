/**
 * 
 */
package com.sinovoice.ik.helper;

import javax.servlet.ServletConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author liuweiquan
 *
 */
public class HotWord extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5700020987974046243L;
	private String dicFilePathStr;

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		OutputWord worker = new OutputWord();
		worker.doOutput(dicFilePathStr, response);
		return;
	}

	public void init(ServletConfig config) {//获得servlet自己的初始化参数：词典路径
		dicFilePathStr = config.getServletContext().getRealPath("/")
				+ config.getInitParameter("hotWordPath");

	}

}

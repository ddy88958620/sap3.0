package com.hcicloud.sap.common.utils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hcicloud.sap.dao.ThreadDaoI;
import com.hcicloud.sap.dao.impl.ThreadDaoImpl;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.service.task.TaskSessionFactory;

public class SystemParamUtil {
	
	/**
	 * 根据系统参数名称获取系统参数值
	 * 
	 * @param name
	 *            系统参数名称
	 * @return
	 */
	public static String getValueByName(String name) {
		ThreadDaoI<SystemParam> systemParamDao = null;
		try {
			systemParamDao = new ThreadDaoImpl<SystemParam>(TaskSessionFactory.getSessionFactory());
			if (name != null && StringUtil.trimC(name).length() != 0) {
				String hql = "from SystemParam sp where sp.name = :name ";
				
				Map<String,Object> paramMap = new HashMap<String,Object>();
				paramMap.put("name", StringUtil.trimC(name));
				List<SystemParam> systemParamList = systemParamDao.find(hql, paramMap);
				if(systemParamList != null && systemParamList.size()>0){
					return systemParamList.get(0).getValue();
				}
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			systemParamDao.closeSession();
		}
		return null;
	}
}

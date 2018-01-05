package com.hcicloud.sap.service.task;

import java.io.File;
import java.util.Calendar;
import java.util.Date;

import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.common.utils.StringUtil;

@Service
public class InitIndex {

    /**
     * 初始化索引
     */
    public static void init(){
        PropertiesLoader pLoader = new PropertiesLoader("system.properties");
        Boolean indexInit = pLoader.getBoolean("index_init");
        //如果没索引
        if(!indexInit){
            createIndex(new Date());
            //标记为已映射
            pLoader.setValue("index_init", true);
        }
    }
    
    /**
     * 创建下一个月的索引
     */
    public void createNextIndex(){
        Calendar cl = Calendar.getInstance();
        cl.setTime(new Date());
        cl.add(Calendar.MONTH, 1);
        createIndex(cl.getTime());
    }
    
    /**
     * 创建新的索引
     * @param date
     */
    public static void createIndex(Date date){
    	String classPath = CommonMethod.getPath();
    	if(!classPath.endsWith(File.separator)){
    		classPath += File.separator;
    	}
    	classPath += "WEB-INF"+File.separator+"classes"+File.separator+"index.mapping";
    	//拿到映射内容
    	String mapContent = CommonMethod.getFileContent(classPath);
    	if(mapContent!=null&&mapContent.length()>0){
    		ESMethod.map(StringUtil.dateToString(date, "yyyy-MM"), mapContent);
    	}
    }
}

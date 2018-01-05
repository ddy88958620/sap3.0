package com.hcicloud.sap.service.base;

import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.service.task.EsManagerTask;
import com.hcicloud.sap.service.task.InitIndex;

@Service // 注入spring容器
public class SpringManager implements ApplicationListener<ContextRefreshedEvent> {
    private static ApplicationContext applicationContext = null;
    
    @Override
    public void onApplicationEvent(ContextRefreshedEvent event) {
    	//event.getApplicationContext().getDisplayName().equals("Root WebApplicationContext");
        if(event.getApplicationContext().getParent() == null){
            applicationContext = event.getApplicationContext();
            InitIndex.init();
            EsManagerTask.createIndex();
        }
    }
    
    public static ApplicationContext getApplicationContext() {
        return applicationContext;
    }
}
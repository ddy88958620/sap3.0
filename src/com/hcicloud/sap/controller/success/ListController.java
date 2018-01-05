package com.hcicloud.sap.controller.success;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.Iterator;

/**
 * Created by songxueyan on 2016/12/9.
 */
@Controller
public class ListController {

    @RequestMapping("/successReport")
    public String successReport(){
        return "task/successReport";
    }

    @RequestMapping("/successExport")
    public String successExport(){
        return "task/successExport";
    }
    

    @RequestMapping("/harassReport")
    public String harassReport(){
        return "task/harassReport";
    }

    @RequestMapping("/successData")
    @ResponseBody
    public Grid successGrid(PageFilter ph){
        return null;
    }

    @RequestMapping("/harassExport")
    public String toSuccessTaskExp(){
        return "task/harassExport";
    }

    @RequestMapping("/success/upload")
    public String toUpload(){
        return "task/upload";
    }

    @RequestMapping("/handleFile")
    public String handleFile(HttpServletRequest request){
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        if(multipartResolver.isMultipart(request)){
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            Iterator iterator = multipartRequest.getFileNames();
            while (iterator.hasNext()){
                MultipartFile file = multipartRequest.getFile(iterator.next().toString());
                if(file!=null){
                    String path = "E:/upload/"+file.getOriginalFilename();
                    try {
                        file.transferTo(new File(path));
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
        return "succcess";
    }
    
    //录音调听页-lsh
    @RequestMapping("/successRecord")
    public String successRecord(){
        return "task/successRecord";
    }
    
    //声音flash---lsh
/*    @RequestMapping({ "/flashWidget" })
    public String flash(String uuid,  String width,Model model) {
        try {
        	uuid = new String(uuid.getBytes("ISO-8859-1"),"UTF-8");
        } catch (Exception e) {
        }
    	model.addAttribute("uuid", uuid);
    	model.addAttribute("time", System.currentTimeMillis());
    	model.addAttribute("width", width);
    	model.addAttribute("height",Integer.parseInt(width)*148/860);
        return "/search/flashWidget";
    }*/
    
    
    @RequestMapping({ "/flashWidget" })
    public String flash(String voices,Model model,int select) {
    	   try {
               //id = URLDecoder.decode(id,"utf-8");
               voices = new String(voices.getBytes("ISO-8859-1"),"utf-8");
           } catch (UnsupportedEncodingException e1) {
               e1.printStackTrace();
           }
    	//处理接受的字符串
    	  String[] reData = voices.split(",");
    	  String voiceIds ="";
    	  String  platForm="";
    	  for(int i=0;i<reData.length;i++){
    		  if(i<reData.length-1){
    			  voiceIds +=reData[i]+",";
    		  }else {
    			  platForm=reData[i];
			}
    	  }
    		if(voiceIds.endsWith(",")){
    			voiceIds = voiceIds.substring(0, voiceIds.length()-1);		
    		}
    	
    	model.addAttribute("voiceIds", voiceIds);
    	model.addAttribute("platForm", platForm);
    	model.addAttribute("select",select);
    	model.addAttribute("time", System.currentTimeMillis());
        return "/search/flashWidget";
    }

}


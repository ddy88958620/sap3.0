package com.hcicloud.sap.controller.success;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.success.ContentGridData;
import com.hcicloud.sap.pagemodel.success.SuccessModal;
import com.hcicloud.sap.pagemodel.success.SuccessReportModel;
import com.hcicloud.sap.service.success.SuccessOrderService;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jplus.hyberbin.excel.language.ILanguage;
import org.jplus.hyberbin.excel.service.SimpleExportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;


@Controller
@RequestMapping("/success")
public class SuccessController {

    @Autowired
    private SuccessOrderService successOrderService;

    @RequestMapping("/dataGrid")
    @ResponseBody
    public Grid successDataGrid(SuccessModal model, PageFilter pf) {
    	Grid grid = new Grid();
		try {
			grid = successOrderService.dataGrid(model, pf);
			
		} catch (Exception e) {
			grid.setMessage(e.getMessage());
		}
		return grid;
    }

    @RequestMapping("/report")
    @ResponseBody
    public Grid successReport(SuccessReportModel model) {
        Grid grid = successOrderService.reportGrid(model);
        return grid;
    }
    
    @RequestMapping("/getContent")
    @ResponseBody
    public List<ContentGridData> getContent(String orderId) {
    	List<ContentGridData> list = successOrderService.getContentListByVoiceId(orderId);
        return list;
    }
    
    @RequestMapping("/downZipFile")
    public String downZip(@RequestParam MultipartFile uploadFile,String uploadFileType,HttpServletResponse response,ModelMap map,HttpServletRequest request) {
		try {
			String originalFilename = uploadFile.getOriginalFilename();
			if(!originalFilename.endsWith(".txt")){
				throw new RuntimeException("请上传txt格式的文件！");
			}
			InputStream inputStream = uploadFile.getInputStream();
			File file = successOrderService.getFiles(inputStream,uploadFileType);
			this.downloadFile(file, response, true,request);
			return null;
		} catch (Exception e) {
			e.printStackTrace();
			if(e.getMessage()!=null && e.getMessage()!=""){
				map.addAttribute("errorMessage", e.getMessage());
			}else{
				map.addAttribute("errorMessage", "未知系统错误！");
			}
			return "task/upload";
		}
    }
    
    @RequestMapping("/downloadText")
    public String downloadtText(SuccessModal model,HttpServletResponse response,HttpServletRequest request) {
    	try {
    		File file = successOrderService.getFileTest(model);
    		this.downloadFile(file, response, true,request);
    	} catch (Exception e) {
    		e.printStackTrace();
    		return "task/successExport";
    	}
    	return null;
    }
    
    @RequestMapping("/downTranceText")
    public String downTranceText(SuccessModal model,HttpServletResponse response,HttpServletRequest request) {
    	try {
    		File file = successOrderService.getSuccessFile(model);
    		this.downloadFile(file, response, true,request);
    	} catch (Exception e) {
    		e.printStackTrace();
    		return "task/successExport";
    	}
    	return null;
    }
    
    
    
    
    
    
    public void downloadFile(File file,HttpServletResponse response,boolean isDelete,HttpServletRequest request) {
        try {
            // 以流的形式下载文件。
            BufferedInputStream fis = new BufferedInputStream(new FileInputStream(file.getPath()));
            byte[] buffer = new byte[fis.available()];
            fis.read(buffer);
            fis.close();
            // 清空response
            response.reset();
            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
            
            //更改下载文件名编码格式
            String filename = file.getName();
            if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
                filename = URLEncoder.encode(filename, "UTF-8");  
            } else {  
                filename = new String(filename.getBytes("UTF-8"), "ISO8859-1");  
            }  
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment;filename=" + filename);
            toClient.write(buffer);
            toClient.flush();
            toClient.close();
            if(isDelete)
            {
                file.delete();        //是否将生成的服务器端文件删除
            }
         } 
         catch (IOException ex) {
            ex.printStackTrace();
        }
    } 

    @RequestMapping("/download")
    public void downloadResource(SuccessModal model,HttpServletResponse response,HttpServletRequest request) {
        Workbook workbook = new HSSFWorkbook();
        Sheet sheet = workbook.createSheet("成功单");
        Grid grid = successOrderService.dataGrid(model, new PageFilter(0,10000));
        
        List<SuccessModal> aaData = grid.getAaData();
        List<SuccessModal> voiceSuccessModals = new ArrayList<SuccessModal>();
        for (SuccessModal successModal : aaData) {
        	String orderId = successModal.getOrderId();
			String voiceId = successModal.getVoiceId();
			String platForm = successModal.getPlatForm();
			String callLength = successModal.getCallLength();
			String qualityName = successModal.getQualityName();
			String qualityDetail = successModal.getQualityDetail();
			String createTime = successModal.getCreateTime();
			if(StringUtils.isNotBlank(voiceId)){
				String[] split = voiceId.split(",");
				for (String voice : split) {
					SuccessModal modal = new SuccessModal();
					
					modal.setOrderId(orderId);
					modal.setVoiceId(voice);
					modal.setPlatForm(platForm);
					modal.setCallLength(callLength);
					modal.setQualityName(qualityName);
					modal.setQualityDetail(qualityDetail);
					modal.setCreateTime(createTime);
					
					voiceSuccessModals.add(modal);
				}
			}
		}
        
        
        SimpleExportService service = new SimpleExportService(sheet, voiceSuccessModals,
                new String[]{"orderId", "voiceId","callPhone","callTime", "platForm","callLength","qualityName","qualityDetail","createTime"},
                "成功单数据列表");
        service.setLanguage(new ILanguage() {
            @Override
            public String translate(Object key, Object... objects) {
                String name = map.get(key.toString());
                if(name==null){
                    name = key+"";
                }
                return name;
            }
        });
        service.doExport();
        response.setContentType("application/pdf");
        
        String startTime = model.getStartTime();
        String endTime = model.getEndTime();
        
        String fileName = "成功单数据"; 
        if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)){
        	fileName += startTime + "至" + endTime;
        }
        
        fileName += ".xls";
        try {
	        if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
	        	fileName = URLEncoder.encode(fileName, "UTF-8");  
	        } else {  
	        	fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");  
	        }
            response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
    
    @RequestMapping("/downloadNew")
    public void downloadRe(SuccessModal model,HttpServletResponse response,HttpServletRequest request) {
        Workbook workbook = new HSSFWorkbook();
       
        Grid  suGrid = successOrderService.dataGrid(model, new PageFilter(0,10));
       long total =  suGrid.getiTotalDisplayRecords();
       int sheetNum =(int)total/10000+1;
       System.out.println(sheetNum+"导出条数");
       System.out.println("开始执行for循环");
        for (int i=0;i<sheetNum;i++){
        	System.out.println("第"+i+"次");
        	
        	 Sheet sheet = workbook.createSheet("成功单列表"+(i+1));
        	 System.out.println("成功单列表"+(i+1));
        	 Grid grid = successOrderService.dataGrid(model, new PageFilter(i*10000,10000));
        	 System.out.println("查询success");
             List<SuccessModal> aaData = grid.getAaData();
             List<SuccessModal> voiceSuccessModals = new ArrayList<SuccessModal>();
             for (SuccessModal successModal : aaData) {
             	String orderId = successModal.getOrderId();
     			String voiceId = successModal.getVoiceId();
     			String platForm = successModal.getPlatForm();
     			String callLength = successModal.getCallLength();
     			String qualityName = successModal.getQualityName();
     			String qualityDetail = successModal.getQualityDetail();
     			String createTime = successModal.getCreateTime();
     			if(StringUtils.isNotBlank(voiceId)){
     				
     				String[] split = voiceId.split(",");
    				for (String voice : split) {
    					SuccessModal modal = new SuccessModal();
    					
    					modal.setOrderId(orderId);
    					modal.setVoiceId(voice);
    					modal.setPlatForm(platForm);
    					modal.setCallLength(callLength);
    					modal.setQualityName(qualityName);
    					modal.setQualityDetail(qualityDetail);
    					modal.setCreateTime(createTime);
    					
    					//增加两项为空的列
    					model.setCallPhone("");
    					model.setCallTime("");
    					
    					voiceSuccessModals.add(modal);
    				}
    			}
    		}
             System.out.println("查询结束开始输出excle");
             SimpleExportService service = new SimpleExportService(sheet, voiceSuccessModals,
                     new String[]{"orderId", "voiceId","callPhone","callTime", "platForm","callLength","qualityName","qualityDetail","createTime"},
                     "成功单数据列表");
             service.setLanguage(new ILanguage() {
                 @Override
                 public String translate(Object key, Object... objects) {
                     String name = map.get(key.toString());
                     if(name==null){
                         name = key+"";
                     }
                     return name;
                 }
             });
             
             
             service.doExport();
             
        }
       
		System.out.println("循环结束，开始导出");
       
        response.setContentType("application/pdf");
        
        String startTime = model.getStartTime();
        String endTime = model.getEndTime();
        
        String fileName = "成功单数据"; 
        if(StringUtils.isNotBlank(startTime) && StringUtils.isNotBlank(endTime)){
        	fileName += startTime + "至" + endTime;
        }
        fileName += ".xls";
        try {
	        if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {  
	        	fileName = URLEncoder.encode(fileName, "UTF-8");  
	        } else {  
	        	fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");  
	        }
            response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
            workbook.write(response.getOutputStream());
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
        
        

    private static HashMap<String,String> map = new  HashMap();
    static {
        //"ORDER_ID", "VOICE_ID", "PLAT_FORM","USER_PHONE","CALL_LENGTH","QUALITY_NAME","QUALITY_DETAIL","CREATE_TIME"
    	
        map.put("orderId","工单号");
        map.put("voiceId","录音流水号");
        map.put("platForm","平台编号");
        map.put("callLength","通话时长");
        map.put("qualityName","质检点名称");
        map.put("qualityDetail","检出明细");
        map.put("createTime","上报时间");
        //增加两列空白
        map.put("callPhone", "客户电话");
        map.put("callTime", "通话时间");
    }
}

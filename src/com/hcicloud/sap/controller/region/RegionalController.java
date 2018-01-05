package com.hcicloud.sap.controller.region;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jplus.hyberbin.excel.language.ILanguage;
import org.jplus.hyberbin.excel.service.SimpleExportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.model.region.AgentInfo;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.pagemodel.region.RegionModel;
import com.hcicloud.sap.service.region.RegionService;


@Controller
@RequestMapping({ "/regional" })
public class RegionalController {
	@Autowired 
	private RegionService regionService;	
	
	 private static HashMap<String, String> excelHeadMap = new HashMap();

	  static {
		  excelHeadMap.put("voiceId", "录音流水号");
		  excelHeadMap.put("staffId", "坐席工号");
		  excelHeadMap.put("callPhone", "呼叫电话");
		  excelHeadMap.put("voicePath", "录音路径");
		  excelHeadMap.put("platForm", "平台编号");
		  excelHeadMap.put("productType", "产品类型");
		  excelHeadMap.put("productWord", "命中关键词");
		  excelHeadMap.put("callStartTime", "呼叫起始时间");
		  excelHeadMap.put("callEndTime", "呼叫结束时间");
		  excelHeadMap.put("createTime", "创建时间");
	  }
	
	
	/**
	 * 区拓列表页面访问
	 * @param request
	 * @return
	 */

	@RequestMapping({ "/regionalList" })
	public String manager(HttpServletRequest request) {
		return "/regional/regionalList";
	}
	/**
	 * 区拓报表页面访问
	 * @param request
	 * @return
	 */
	@RequestMapping({ "/regionalReport" })
	public String regionalReport(HttpServletRequest request) {
		return "/regional/regionalReport";
	}
	
	/**
	 * 区拓业务列表
	 * @param regionModel
	 * @param ph
	 * @return
	 */
	 @RequestMapping({"/dataGrid"})
	  @ResponseBody
	  public Grid getGridData(RegionModel regionModel, PageFilter ph)
	  {
	    Grid grid = new Grid();
	    try {
	      grid = this.regionService.dataGrid(regionModel, ph);
	    }
	    catch (Exception e)
	    {
	      grid.setMessage(e.getMessage());
	      e.printStackTrace();
	    }
	    return grid;
	  }
	 
	 /**
	  * 
	  */
	 @RequestMapping({ "/getProductType" })
	 @ResponseBody
		public Json getPlaytForms(){
			Json json = new Json();
			try {
				json =this.regionService.getProductType();
			} catch (Exception e) {
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.DB_ERROR);
			}
			return json;
		}
	 
	 
	
	/**
	 * 导出excel报表
	 * @param regionModel
	 * @param response
	 * @param request
	 */
	  @RequestMapping({"/download"})
	  @ResponseBody
	  public void download(RegionModel regionModel, HttpServletResponse response, HttpServletRequest request)
	  {
	    try
	    { 
	    	
	      regionModel.setProductType(new String(regionModel.getProductType().getBytes("iso8859-1"), "utf-8"));
	      regionModel.setProductWord(new String(regionModel.getProductWord().getBytes("iso8859-1"), "utf-8"));
	    	

	      Grid totalGrid = this.regionService.dataGrid(regionModel, new PageFilter(0, 10));
	      long total = totalGrid.getiTotalDisplayRecords();

	      int sheetNum = (int)total / 10000 + 1;
	      System.out.println(sheetNum + "导出条数");
	      System.out.println("开始执行for循环");

	      Workbook workbook = new HSSFWorkbook();
	      for (int i = 0; i < sheetNum; ++i) {
	        System.out.println("第" + i + "循环");
	        Grid grid = this.regionService.dataGrid(regionModel, new PageFilter(i * 10000, 10000));
	        Sheet sheet = workbook.createSheet("区拓产品数据单" + (i + 1));

	        SimpleExportService service = new SimpleExportService(sheet, grid.getAaData(), 
	          new String[] { "voiceId", "staffId", "callPhone", "voicePath", "platForm", "productType", "productWord", "callStartTime", "createTime" }, 
	          "区拓产品数据列表");

	        service.setLanguage(new ILanguage() {
	            @Override
	            public String translate(Object key, Object... objects) {
	                String name = excelHeadMap.get(key.toString());
	                if(name==null){
	                    name = key+"";
	                }
	                return name;
	            }
	        });

	        service.doExport();
	      }

	      response.setContentType("application/pdf");
	      String fileName = "区拓产品数据" + new Date().getTime() + ".xls";

	      if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0)
	        fileName = URLEncoder.encode(fileName, "UTF-8");
	      else {
	        fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
	      }
	      response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
	      workbook.write(response.getOutputStream());
	    }
	    catch (Exception e)
	    {
	      e.printStackTrace();
	    }
	  }
	  
	  /**
	   * 区拓业务报表统计展示
	   * @param regionModel
	   * @return
	   */
	
	@RequestMapping({"/report"})
	@ResponseBody
	public Grid report(RegionModel regionModel){
		
		try {
			Grid grid = this.regionService.reportGrid(regionModel);
			return grid;
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return null;
	}
	
	
	  
	  
	  
	
}

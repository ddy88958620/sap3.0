package com.hcicloud.sap.controller.upload;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.AntZipUtil;
import com.hcicloud.sap.common.utils.DateConversion;
import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.SystemParam;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.Json;
import com.hcicloud.sap.service.admin.SystemParamServiceI;
import com.hcicloud.sap.service.voice.batchTransServiceI;
import com.hcicloud.sap.vo.BatchTransVo;
import com.sun.istack.internal.logging.Logger;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jplus.hyberbin.excel.language.ILanguage;
import org.jplus.hyberbin.excel.service.SimpleExportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/** 
 * 批量上传流水号文件转写服务
 * @Title batchTransController.java
 * @Package com.hcicloud.sap.controller.upload
 * @author lishihuan
 * @date 2017年08月04日 上午10:40:29
 */
@Controller
@RequestMapping({ "/batchTrans" })
public class batchTransController extends BaseController{
	
	private static Logger logger = Logger.getLogger(batchTransController.class);
	@Autowired
	private SystemParamServiceI systemParamService;
	@Autowired
	private batchTransServiceI batchTransServiceI;

	@Autowired
	private BaseDaoI<SystemParam> systemParamDao;
	/**
	 * 批量转写页面
	 * @return
	 */
	@RequestMapping({ "/manager" })
	public String batchTransPage(){
		return "/upload/batchTrans";
	}
	/**
	 * 上传txt
	 * @param uploadFile
	 * @param uploadFileType
	 * @param response
	 * @param map
	 * @param request
	 * @return
	 */
	@RequestMapping("/uploadFile")
/*	@ResponseBody*/
    public String uploadFile(@RequestParam("myfile") MultipartFile uploadFile,HttpServletResponse response,ModelMap map,HttpServletRequest request) {
		
		try {
			String originalFilename = uploadFile.getOriginalFilename();
			//判断是否为txt格式
			if(!originalFilename.endsWith(".txt")){
				map.put("message", "请上传txt格式的文件！");
				return "/upload/batchTrans";
			}
			
			InputStream inputStream = uploadFile.getInputStream();
			//判断文件是否为空
			int  byteSize = inputStream.available();
			if (byteSize==0) {
				map.put("message", "上传文件为空！");
				return "/upload/batchTrans";
			}
			//读文本
			InputStreamReader reader = new InputStreamReader(inputStream);
			BufferedReader br = new BufferedReader(reader);
			String txtContent ="";
			List<JSONObject> sendList = new ArrayList<JSONObject>();
			//以时间精确到秒为上传目录名称
			Date date=new Date();
			String time =DateConversion.getTimeString(date, "yyyyMMddHHmmss");
			//上传到平台服务器目录
		/*	String voiceLoadPath="/home/lsh/voice/"+time;*/
			//统一数据库参数获取
			String voiceParamName = "voiceLoadPath";
			String voiceLoadPath = systemParamService.getParamSystemByName(voiceParamName);
			if (voiceLoadPath!=null) {
				voiceLoadPath+=time;
			}else {
				map.put("message", "数据库异常");
				return "/upload/batchTrans";
			}

			while((txtContent=br.readLine())!=null){		
				String[] contentAray =  txtContent.split("\\|");
				//格式要求：XQD-CCOD|录音流水号
				if (!"XQD-CCOD".equals(contentAray[0])&&!"XQD-ZX".equals(contentAray[0])&&!"XQD-HW".equals(contentAray[0])&&!"XQD-SHW".equals(contentAray[0])&&!"XQD-ZHW".equals(contentAray[0])) {
					map.put("message", "请检查文本内容格式");
					return "/upload/batchTrans";	
				}
				//拼接下发的格式，录音流水号,录音上传路径{"callIds":"","voiceLoadPath":""}
				JSONObject sendJsonObject = new JSONObject();
				String platForm=contentAray[0];
				String callIds ="";
				for (int i = 1; i < contentAray.length; i++) {
					callIds+=contentAray[i]+",";
				}
				if (callIds.endsWith(",")) {
					callIds=callIds.substring(0, callIds.length()-1);
				}
				sendJsonObject.put("platForm",platForm);
				sendJsonObject.put("callIds", callIds);
				sendJsonObject.put("voiceLoadPath", voiceLoadPath);
				sendList.add(sendJsonObject);
			}
			br.close();
			String resultMeg="";
			String connectMeg="";
			//下发数据到平台
			for (JSONObject jsonObject : sendList) {
				String platForm = jsonObject.getString("platForm");
				
				String sysPlaytFormName = "platFormUrl";
				// 从数据库获取playForm地址集合
				String platFormString = systemParamService.getParamSystemByName(sysPlaytFormName);
				JSONObject platFormJsonObject = JSON.parseObject(platFormString);
				String url =platFormJsonObject.getString(platForm);
				try {
					url = url + "/uploadVoice/receive";

					/*url="http://192.168.5.12:9080/pingan_openAPI/uploadVoice/receive";*/
					System.out.println("下发url :"+url);
					System.out.println("下发url :"+jsonObject.toJSONString());
					
					String result = HTTPMethod.doPostQuery(url,jsonObject.toJSONString(),10000);
					System.out.println("下发返回结果:"+result);
					if(result!=null){
						JSONObject json = JSONObject.parseObject(result);
						if(json!=null&&"0".equals(json.getString("ret"))){
							map.put("message", "上传成功");
							//将信息写入ES供查询显示
							List<String> addList = new ArrayList<String>();
							String[] callIdSplit = jsonObject.getString("callIds").split(",");
							for (String callId : callIdSplit) {
								JSONObject addData =  new JSONObject();
								addData.put("PLAT_FORM", platForm);
								addData.put("UPLOAD_TIME", DateConversion.getTimeString(date, "yyyy-MM-dd HH:mm:ss"));
								addData.put("VOICE_ID",callId);
								addData.put("TRANS_STATE", "转写中");
								addData.put("TRANS_CONTENT", "");
								addList.add(addData.toJSONString());
							}
							//批量插入
							ESMethod.addIndexBatch(EsUtil.getUploadUrl()+"/", addList);

						}else {
							resultMeg+=json.getString("message");
						}
					}
				} catch (Exception e) {
					connectMeg+=platForm+"连接异常";
					e.printStackTrace();
					logger.info("下发异常"+e);
					
				}
			}
			//平台返回异常消息
			if (!"".equals(resultMeg)) {
				map.put("message", resultMeg);
			}
			//平台是否可连接异常消息
			if (!"".equals(connectMeg)) {
				map.put("message", connectMeg);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return "/upload/batchTrans";
    }
	


	@RequestMapping("/dataGrid")
    @ResponseBody
    public Grid getSuccessList(PageFilter pf,BatchTransVo batchTransVo) {
    	Grid grid = new Grid();
		try {
	        grid = batchTransServiceI.dataGrid(batchTransVo,pf);
		} catch (Exception e) {
			grid.setMessage(e.getMessage());
		}
		return grid;
    }
	
	/**
	 * 处理各平台转写上报结果
	 * @param jsonObj
	 * @return
	 */
	@RequestMapping(value = "/receiveUploadNoifyResult",method = {RequestMethod.POST })
	@ResponseBody
	public JSONObject receiveFsrnoifyResult(@RequestBody JSONObject jsonObj){
		System.out.println("录音转写上报结果"+jsonObj);
		long time = System.currentTimeMillis();
		JSONObject retJsonObject=new JSONObject();
		try{
			boolean isSucc = batchTransServiceI.receiveUploadNoifyResult(jsonObj);
			if(isSucc==true){
				retJsonObject.put("result", 0);
			}else{
				retJsonObject.put("result", 1);
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.info("receiveFsrnoifyResult结果接收异常:"+e);
		}
		long time1 = System.currentTimeMillis();
		long times = time1-time;
		System.out.println(time+"receiveUploadNoifyResult耗时"+times);
		return retJsonObject;
	}



	/**
	 * TODO 待改写
	 * 刷新列表操作，调用扫描转写结果任务，将已完成转写的录音放到新目录下，删除原有的录音文件，更新redis里的状态
	 * @return
	 */
//	@RequestMapping({" /refresh "})
//	public String refresh(PageFilter page){
//		ScanTransResult.scan();
//		dataGrid(page);
//		return "/upload/upload";
//	}

	@RequestMapping({ "deleteFromES" })
	@ResponseBody
	public Json deleteFromES(String voiceId){
		Json json = new Json();
		try{
			boolean isSucc = batchTransServiceI.delectBulk(voiceId);
			if(isSucc==true){
				json.setSuccess(true);
				json.setMsg(ErrorReturnMsg.DELETED_SUCCESSFULLY);
			}else{
				json.setSuccess(false);
				json.setMsg(ErrorReturnMsg.DELETED_FAILED);
			}
		}catch(Exception e){
			e.printStackTrace();
			logger.info("deleteFromES批量删除数据失败:"+e);
		}
		return json;
	}

	/**
	 * 导出转译文本
	 * @param model  这里取录音流水号，平台
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping("/downTranceText")
	public String downTranceText(BatchTransVo model, HttpServletResponse response, HttpServletRequest request) {
		try {
			File file = batchTransServiceI.getSuccessFile(model);
			//这里是调用公共的方法
			AntZipUtil.downloadFile(file, response, true,request);
		} catch (Exception e) {
			e.printStackTrace();
			return "task/successExport";
		}
		return null;
	}

	/**
	 * Execle下载
	 * @param model
	 * @param response
	 * @param request
	 * 2017年9月7日 20:34:58
	 */
	@RequestMapping("/download")
	@ResponseBody
	public void download(BatchTransVo model, HttpServletResponse response, HttpServletRequest request){

		try {
			//解决get乱码
//			annoyModel.setAnnoyType(new String(annoyModel.getAnnoyType().getBytes("iso8859-1"),"utf-8"));
//			annoyModel.setSeatAttitude(new String(annoyModel.getSeatAttitude().getBytes("iso8859-1"),"utf-8"));
			//规定一个excle内最多10000条数据
			Grid  totalGrid = batchTransServiceI.dataGrid(model, new PageFilter(0,10));
			long total =  totalGrid.getiTotalDisplayRecords();

			int sheetNum =(int)total/10000+1;
			System.out.println(sheetNum+"转译文本导出条数");
			System.out.println("开始执行for循环");

			Workbook workbook = new HSSFWorkbook();
			for (int i = 0; i < sheetNum; i++) {
				System.out.println("第"+i+"循环");
				Grid grid  = batchTransServiceI.dataGrid(model,  new PageFilter(i*10000,10000));
				Sheet sheet = workbook.createSheet("转译文本数据单"+(i+1));
				//将String[]内对应名称的列取出并按顺序排序
				SimpleExportService service = new SimpleExportService(sheet, grid.getAaData(),
						new String[]{"voiceId","platForm","transState","uploadTime","voicePath"},
						"转译文本数据列表");
				//将对应列的列头改为相应的文字描述
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
			response.setContentType("application/pdf");
			String fileName = "转译文本数据"+new Date().getTime()+".xls";
			//解决文件名乱码,判断是否识IE7-10浏览器
			if (request.getHeader("User-Agent").toUpperCase().indexOf("MSIE") > 0) {
				fileName = URLEncoder.encode(fileName, "UTF-8");
			} else {
				fileName = new String(fileName.getBytes("UTF-8"), "ISO8859-1");
			}
			response.addHeader("Content-Disposition", "attachment; filename=" + fileName);
			workbook.write(response.getOutputStream());
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//文件下载对应参数
	private static HashMap<String,String> map = new  HashMap<String,String>();
	static {
		//"voiceId","platForm","transState","uploadTime","voicePath"
		map.put("voiceId","录音流水号");
		map.put("platForm","平台编号");
		map.put("transState", "录音状态");
		map.put("uploadTime","上传时间");
		map.put("voicePath","录音路径");
	}



}

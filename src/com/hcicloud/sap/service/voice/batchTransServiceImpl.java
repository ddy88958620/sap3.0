package com.hcicloud.sap.service.voice;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.network.EsUtil;
import com.hcicloud.sap.common.network.HTTPMethod;
import com.hcicloud.sap.common.utils.AntZipUtil;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.PropertiesLoader;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.vo.BatchTransVo;
import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.tools.zip.ZipOutputStream;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class batchTransServiceImpl implements batchTransServiceI {

	private Logger logger = Logger.getLogger(batchTransServiceImpl.class);

	private static String txtDir = new PropertiesLoader("system.properties").getProperty("txtDir");
	private static String zipDir = new PropertiesLoader("system.properties").getProperty("zipDir");

	@Override
	public Grid dataGrid(PageFilter pf) {

		//录音没有上传,转写完成,转写中

		StringBuffer bufQuery = new StringBuffer();
		bufQuery.append("{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [");
		bufQuery.append("]}}]}},\"sort\": {\"UPLOAD_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}},"
				+ "\"from\": "
				+ pf.getiDisplayStart()
				+ ",\"size\": "
				+ pf.getiDisplayLength() + "}");
		long total = 0l;
		List<JSONObject> list = new ArrayList<JSONObject>();
		
		
		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getUploadUrl()
					+ "/_search", bufQuery.toString(), 30000);

			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			total = (Integer) hitsObject.get("total");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");
			for (Object v : hitsArray) {
				JSONObject jsonObject = ((JSONObject) v).getJSONObject("_source");
				//构建展示对象
				JSONObject showObject = new JSONObject();
				showObject.put("voiceId", jsonObject.getString("VOICE_ID"));
				showObject.put("transState", jsonObject.getString("TRANS_STATE"));
				showObject.put("platForm", jsonObject.getString("PLAT_FORM"));
				showObject.put("uploadTime", jsonObject.getString("UPLOAD_TIME"));
				showObject.put("voicePath", jsonObject.getString("VOICE_PATH"));

				list.add(showObject);
			
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		Grid grid = new Grid();
		grid.setAaData(list);
		grid.setiTotalDisplayRecords(total);
		grid.setiTotalRecords(list.size());
		return grid;
	}

	
	@Override
	public boolean receiveUploadNoifyResult(JSONObject jsonObj) {
		try {
		   String voiceId = jsonObj.getString("voiceId");
		   String indexName = EsUtil.getUploadUrl()+"/"+voiceId+"/";
		   //修改的字段 
		   StringBuffer sb = new StringBuffer();
		   sb.append("{");
		   sb.append("\"doc\":");
		   
		   JSONObject  docObject= new JSONObject();
		   
		   String  callTime =  jsonObj.getString("callTime");
		   if ("".equals(callTime)) {
			 docObject.put("CALL_START_TIME", null);
		   }else {
			   docObject.put("CALL_START_TIME", callTime);
		   }
		   docObject.put("TRANS_CONTENT", jsonObj.getString("content")); 
		   docObject.put("TRANS_STATE", jsonObj.getString("transState"));
		   docObject.put("VOICE_PATH", jsonObj.getString("voicePath"));
		   sb.append(docObject.toString());
		   sb.append("}");
		   System.out.println("indexName"+indexName);
		   System.out.println("更新es拼接语句"+sb.toString());
	
		   boolean isSuccess=   ESMethod.updateIndex(indexName, sb.toString());
		   System.out.println(isSuccess);
		   return isSuccess;
		 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	@Override
	public boolean delectBulk(String idSArray) {
		try {
			String indexName = EsUtil.getUploadUrl();
			boolean isSuccess = ESMethod.deleteIndexBatch(indexName, idSArray);
			return isSuccess;

		} catch (Exception e) {
		    // TODO: handle exception
		    e.printStackTrace();
		    System.out.println("批量转写，批量删除失败");
		}
		return false;
	}

	@Override
	public Grid dataGrid(BatchTransVo model, PageFilter pf) {
		StringBuffer bufQuery = new StringBuffer();
		bufQuery.append("{\"query\": {\"filtered\": {\"filter\": [{\"bool\": {\"must\": [");

		//条件查询的字符串
		String tempString = "";
		if (StringUtils.isNoneBlank(model.getStartTime())
				&& StringUtils.isNoneBlank(model.getEndTime())) {
			tempString += "{\"range\":{\"UPLOAD_TIME\":{\"gte\":\""
					+ model.getStartTime() + "\",\"lte\":\""
					+ model.getEndTime() + "\"}}},";
		}
		if (StringUtils.isNoneBlank(model.getVoiceId())) {
			tempString += "{\"wildcard\":{\"VOICE_ID\": \"*" + model.getVoiceId() + "*\"}},";
		}
		if (StringUtils.isNoneBlank(model.getTransState())) {
			tempString += "{\"wildcard\":{\"TRANS_STATE\": \"*" + model.getTransState() + "*\"}},";
		}
		if (StringUtils.isNoneBlank(model.getPlatForm())) {
			tempString += "{\"term\":{\"PLAT_FORM\": \"" + model.getPlatForm() + "\"}},";
		}

		if (tempString.endsWith(",")) {
			bufQuery.append(tempString.substring(0, tempString.length() - 1));
		}

		bufQuery.append("]}}]}},\"sort\": {\"UPLOAD_TIME\": {\"order\": \"desc\",\"ignore_unmapped\":true}},"
				+ "\"from\": "
				+ pf.getiDisplayStart()
				+ ",\"size\": "
				+ pf.getiDisplayLength() + "}");
		long total = 0l;
		List<BatchTransVo> list = new ArrayList<BatchTransVo>();

		try {
			String result = HTTPMethod.doPostQuery(EsUtil.getUploadUrl()
					+ "/_search", bufQuery.toString(), 30000);
			System.out.println("查看批量转写的es的url： "+ EsUtil.getUploadUrl() + "/_search");
			System.out.println("查看批量转写的es语句： "+ bufQuery.toString());
			JSONObject resultObject = JSON.parseObject(result);
			if (resultObject != null) {
				JSONObject hitsObject = resultObject.getJSONObject("hits");
				total = (Integer) hitsObject.get("total");
				JSONArray hitsArray = hitsObject.getJSONArray("hits");
				for (Object v : hitsArray) {
					JSONObject jsonObject = ((JSONObject) v).getJSONObject("_source");
					//构建展示对象
					BatchTransVo batchTransVo = new BatchTransVo();
					batchTransVo.setVoiceId(jsonObject.getString("VOICE_ID"));
					batchTransVo.setTransState(jsonObject.getString("TRANS_STATE"));
					batchTransVo.setPlatForm(jsonObject.getString("PLAT_FORM"));
					batchTransVo.setUploadTime(jsonObject.getString("UPLOAD_TIME"));
					batchTransVo.setVoicePath(jsonObject.getString("VOICE_PATH"));
					list.add(batchTransVo);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		Grid grid = new Grid();
		grid.setAaData(list);
		grid.setiTotalDisplayRecords(total);
		grid.setiTotalRecords(list.size());
		return grid;
	}

	@Override
	public File getSuccessFile(BatchTransVo model) {
		Grid dataGrid = this.dataGrid(model, new PageFilter(0, 10000));

		List<File> list = new ArrayList<File>();
		List<BatchTransVo> aaData = dataGrid.getAaData();
		for (BatchTransVo batchTransVo : aaData) {
			// TODO 这里之后改成多线程，执行就很快了
			if (!StringUtils.isEmpty(batchTransVo.getVoiceId())) {
				List<File> fileByVoiceId = getFileByOrderId(batchTransVo.getVoiceId(),batchTransVo.getPlatForm());
				for (int i = 0; i < fileByVoiceId.size(); i++) {
					list.add(fileByVoiceId.get(i));
				}
			}
		}

		File zip = new File(zipDir);
		if (!zip.exists()) {
			zip.mkdirs();
		}

		File fileZip = new File(zipDir + "批量转写文本导出.zip");
		// 文件输出流
		FileOutputStream outStream;
		try {
			outStream = new FileOutputStream(fileZip);

			// 压缩流
			ZipOutputStream toClient = new ZipOutputStream(outStream);
			toClient.setEncoding("gbk");
			AntZipUtil.zipFile(list, toClient);
			toClient.close();
			outStream.close();
			File dirFile = new File(txtDir);
			dirFile.delete();
		} catch (Exception e) {
			System.out.println("batchTransServiceImpl输出压缩流失败");
			logger.info("batchTransServiceImpl输出压缩流失败");
			e.printStackTrace();
		}
		return fileZip;
	}

	private List<File> getFileByOrderId(String voiceId,String platFrom) {
		String searchString = "{\"query\": {\"bool\": {\"must\": [{\"term\":{\"VOICE_ID\":\""+ voiceId + "\"}},{\"term\":{\"PLAT_FORM\":\""+ platFrom +"\"}}]}},\"sort\":{\"UPLOAD_TIME\":{\"order\":\"desc\"}},\"size\":1000}";
		System.out.println(searchString);

		String result = HTTPMethod.doPostQuery(EsUtil.getUploadUrl() + "/_search", searchString, 30000);

		List<File> fileList = new ArrayList<File>();


		try {

			JSONObject resultObject = JSON.parseObject(result);
			JSONObject hitsObject = resultObject.getJSONObject("hits");
			JSONArray hitsArray = hitsObject.getJSONArray("hits");

			File dirFile = new File(txtDir);
			if (!dirFile.exists()) {
				dirFile.mkdirs();
			}

			if (hitsArray == null || hitsArray.size() == 0) {
				System.out.println(voiceId + "_" +platFrom+"无对应文本");
				File file = new File(txtDir + voiceId + "_" +platFrom  + ".txt");
				if (!file.exists()) {
					file.createNewFile();
				}
				fileList.add(file);
				return fileList;
			} else {
				for (Object object : hitsArray) {

					String transContent = null;
					try {
						try {
							JSONObject jsonObject = ((JSONObject) object).getJSONObject("_source");
							transContent = jsonObject.getString("TRANS_CONTENT");
							//transContent = "[{\"content\":\"喂喂你好呃因为是您现在说话方便了你说;time=750 6500\",\"timestamp\":1500963570459,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"现在跟您做一个客户维护好就您之前在公司不是买了一份意外保单嘛去年十一月份买的九百八十八呢呃每个月缴费扣款的短消息都能收到吗;time=7350 16220\",\"timestamp\":1500963570460,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"嗯做的是吧;time=16790 17720\",\"timestamp\":1500963570461,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"呃行然后每年都好也会有个账单给您配送过去您这个地址还在杨浦区真力度吧;time=17890 23300\",\"timestamp\":1500963570462,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"是的;time=24090 24600\",\"timestamp\":1500963570463,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"哎行那后期如果说信息资料有需要变更的钱给我打电话就可以了咱有个钱现在事情呢需要跟您确认一下哈就上个月我们总公司呢有安排客户专员好玩就会给您打过电话;time=24950 34700\",\"timestamp\":1500963570464,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"这边原先呢投保信用度良好的优质客户呢给您开通权限跟您之前还每个月在公司交了这个九八八的保费呢您今年年底哈给您开通权限在你都能够取能够用了;time=35270 45960\",\"timestamp\":1500963570465,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"不用说呢;time=46250 46920\",\"timestamp\":1500963570466,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"二十年之后呢就是帮您考核成活钱就第一;time=47030 50320\",\"timestamp\":1500963570467,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"那第二呢因为您原先在公司呢跑的都是这个人身意外伤害保险嘛比方说像天灾人祸交通事故之类的但是呢唯独生病医疗您是没有的嘛所以公司呢也是在您原有保单基础上把您自身呢关乎一个月这块的保险保障呢给您补充完善进来了但是我们今天上午整理资料的时候呢就发现上你的名字是单独飘红跳台的你们晚上进来所以我想问一下这个通知电话里面接到一女士;time=50870 76700\",\"timestamp\":1500963570468,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"哦可能没接到吧;time=77650 79080\",\"timestamp\":1500963570469,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"行那您看这样子哈这个服务呢不管说您参参加我们肯定是要通知到您的毕竟的话已经支持认可平安那么久呢我最后呢就把您以前那个保费怎么取怎么用这个补充完善重大疾病的了解内容给您讲一下;time=79470 92040\",\"timestamp\":1500963570470,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"长话短说有听不懂的地方您直接问我啊;time=92290 95040\",\"timestamp\":1500963570471,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"我这边有点事情您回头再打电话给我吧好吧;time=95230 98440\",\"timestamp\":1500963570472,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"呃你大概几点钟方便;time=99150 100560\",\"timestamp\":1500963570473,\"talkertype\":\"2\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"我长话短说好;time=101410 102380\",\"timestamp\":1500963570474,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"},{\"content\":\"我这边嗯有点事嗯好好有点事情你回头再打电话吧啊好好好好行那您先忙好再见哈嗯;time=103130 112720\",\"timestamp\":1500963570475,\"talkertype\":\"1\",\"id\":\"123\",\"time\":\"14:19:30\",\"userphone\":\"01012345678\",\"cmd\":\"\",\"channelId\":\"02726752d94d11e5\",\"answer\":\"\",\"answerType\":\"3\"}]";
						} catch (Exception e) {
							e.printStackTrace();
						}

						File file = new File(txtDir + voiceId +"_"+platFrom + ".txt");
						if (!file.exists()) {
							file.createNewFile();
						}
						fileList.add(file);

						if(StringUtils.isEmpty(transContent)){
							continue;
						}
						//解析转写完成的文本
						JSONArray contaArray = JSONObject.parseArray(transContent);
						StringBuffer contentBuffer = new StringBuffer();
						for (int j = 0; j < contaArray.size(); j++) {
							JSONObject jsonObject = contaArray.getJSONObject(j);

							String content = jsonObject.getString("content");
							String talkertype=jsonObject.getString("talkertype");
							if(content!=null&&!"".equals(content)){
								String speakContent = content.substring(0,content.indexOf(";"));
								String timeStamp = content.substring(content.indexOf(";time=")+6,content.length());
								String timeStampArray[] = timeStamp.split(" ");
								timeStamp ="["+CommonMethod.secToTime((int)(Long.parseLong(timeStampArray[0])/1000))+"]";
								if (!"".equals(speakContent)&&speakContent!=null) {
									if ("1".equals(talkertype)) {
										speakContent=timeStamp+"[客服]"+speakContent+"\n";
									}else if("2".equals(talkertype)){
										speakContent=timeStamp+"[用户]"+speakContent+"\n";
									}
									contentBuffer.append(speakContent);
								}
							}
						}
						FileOutputStream fos = null;
						fos = new FileOutputStream(file);
						fos.write(contentBuffer.toString().getBytes());
						fos.flush();
						try {
							fos.close();
						} catch (IOException e) {
							logger.info("batchTransServiceImpl文件流关闭失败");
							System.out.println("batchTransServiceImpl文件流关闭失败");
						}
					} catch (Exception e) {
						e.printStackTrace();
						System.out.println("batchTransServiceImpl创建文件失败");
						logger.info("batchTransServiceImpl创建文件失败");
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fileList;
	}
}

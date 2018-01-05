package com.hcicloud.sap.service.task;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import redis.clients.jedis.Jedis;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.network.ESMethod;
import com.hcicloud.sap.common.utils.RedisUtil;
import com.hcicloud.sap.common.utils.StringUtil;

public class CreateIndexTask implements TaskInterface{

	private String fromKey;
	private String toKey;
	public CreateIndexTask(String fromKey, String toKey) {
        super();
        this.fromKey = fromKey;
        this.toKey = toKey;
    }

    /**
	 * 
	 */
	@Override
	public void run() {
		Jedis jedis = null;
		List<String> batch = new ArrayList<String>();
		String data = null;
		int i = 0;
		
		while(true) {
			try {
				//System.out.println("开始取数据");
				jedis = RedisUtil.getJedis();
				
				if(jedis == null) {
					System.out.println("获取Jedis失败");
					Thread.sleep(5000);
					continue;
				}
				
				if(jedis.llen(fromKey) <= 0) {
					Thread.sleep(5000);
					continue;
				} /*else {
					Thread.sleep(3000);
				}*/
				
				i = 0;
				while(i<500) {
					data = jedis.lpop(fromKey);
					if(data == null || "".equals(data)) {
						break;
					}
					/** 关联添加用户组id */
					/*Map<String,String> userInfoMap = getUserGroupId(data);
					String userGroupId = null;
					String userId = null;
					if (userInfoMap != null) {
						userGroupId = userInfoMap.get("userGroupId");
						userId = userInfoMap.get("userId");
					}
					//String userGroupId = getUserGroupId(data);
					System.out.println("userGroupId = " + userGroupId +"++++++++++++++++"+"userId = " + userId);
					if(userGroupId!=null&&!"".equals(userGroupId)){
						JSONObject dataJsonObj = JSONObject.parseObject(data);
						dataJsonObj.put("userGroupId", userGroupId);
						data = dataJsonObj.toString();
					}else{
						//默认为管理员组
						JSONObject dataJsonObj = JSONObject.parseObject(data);
						dataJsonObj.put("userGroupId", "0");
						data = dataJsonObj.toString();
					}
					if(userId!=null&&!"".equals(userId)){
						JSONObject dataJsonObj = JSONObject.parseObject(data);
						dataJsonObj.put("userGroupId", userGroupId);
						data = dataJsonObj.toString();
					}*/
					JSONObject dataJsonObj = JSONObject.parseObject(data);
					String userGroupId = dataJsonObj.getString("userGroupId");
					if(userGroupId==null||"".equals(userGroupId)){
						dataJsonObj.put("userGroupId", "0");
						data = dataJsonObj.toString();
					}
					
					jedis.rpush(toKey, data);
					
					System.out.println(data);
						batch.add(data);
					i++;
				}
				System.out.println("==========================>batch"+batch.size());

				ESMethod.indexBatch(StringUtil.dateToString(new Date(), "yyyy-MM"), batch);
			} catch(Exception ex) {
				ex.printStackTrace();
			} finally {
				batch.clear();
				
				if(jedis != null) {
					RedisUtil.returnResource(jedis);
				}
			}
		}
	}

	private Map<String,String> getUserGroupId(String data) {
		String uuid = JSON.parseObject(data).getString("UUID");
		Jedis jedis = null;
		JSONObject jsonObject = new JSONObject();
		try{
			jedis = RedisUtil.getJedis();
			List<String> list = jedis.lrange("pcmInfo", 0, -1);
			for(int i=0;i<list.size();i++){
				jsonObject = JSONObject.parseObject(list.get(i));
				String name = jsonObject.getString("name");
				String uuidStr = name.substring(0, name.indexOf(".")).replace(",", "|");
				System.out.println("uuid1:"+uuid+"uuid2:"+uuidStr);
				if(uuid.equals(uuidStr)){
					Map<String,String> userInfo = new HashMap<String, String>();
					userInfo.put("userGroupId", jsonObject.getString("userGroupId"));
					userInfo.put("userId", jsonObject.getString("userId"));
					return userInfo;
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RedisUtil.returnResource(jedis);
		}
		return null ;
	}
}

package com.hcicloud.sap.service.admin;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hcicloud.sap.common.utils.ErrorReturnMsg;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.TxtUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.model.admin.Hotword;
import com.hcicloud.sap.pagemodel.admin.HotwordModel;
import com.hcicloud.sap.pagemodel.base.Json;

@Service
public class HotwordImpl implements HotwordI {
	
	@Autowired
	BaseDaoI<Hotword> hotwordDao;
	@Autowired
	BaseDaoI<User> userDao;

	/**
	 * 获取关键词集合
	 * @param HotwordModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public List<HotwordModel> dataGrid(HotwordModel hotwordModel, PageFilter pageFilter) {
		List<HotwordModel> modelList = new ArrayList<HotwordModel>();
		String hql = "from Hotword s where 1=1";
		Map<String,Object> paramMap = new HashMap<String,Object>();
		if(hotwordModel.getContent() != null && !"".equals(hotwordModel.getContent())) {
			hql += " and s.content like :content";
			paramMap.put("content",  "%"+hotwordModel.getContent()+"%");
		}
		List<Hotword> hotwordList = hotwordDao.find(hql, paramMap, pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());
		copy(modelList, hotwordList);
		return modelList;
	}
	
	/**
	 * 对象实体列表转换为分页模型列表
	 * @param modelList
	 * @param dataList
	 */
	private void copy(List<HotwordModel> modelList,
			List<Hotword> dataList) {
		HotwordModel autoRolesModel = null;
		
		for(Hotword hotword : dataList) {
			autoRolesModel = new HotwordModel();
			transform(hotword, autoRolesModel);
			modelList.add(autoRolesModel);
		}
		
	}
	
	/**
	 * 将实体对象转换为分页模型
	 * @param Hotword
	 * @param HotwordModel
	 */
	private void transform(Hotword hotword, HotwordModel hotwordModel) {
		/**-- 拷贝bean内容 --**/
		BeanUtils.copyProperties(hotword, hotwordModel);
		if(hotword.getUpdateUser()!= null) {
			hotwordModel.setUpdateById(hotword.getUpdateUser().getUuid());
			hotwordModel.setUpdateByName(hotword.getUpdateUser().getName());
		}
	}
	
	/**
	 * 获取数量
	 * @param HotwordModel
	 * @param pageFilter
	 * @return
	 */
	@Override
	public long count(HotwordModel hotwordModel,
			PageFilter pageFilter) {
		String hql = "select count(*) from Hotword s where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql += hqlJoin(hotwordModel, params);
		Long count = this.hotwordDao.count(hql, params);
		return count;
	}
	
	/**
	 * hql语句拼接
	 * @param rulesTypeModel
	 * @param params
	 * @return
	 */
	private String hqlJoin(HotwordModel hotwordModel, Map<String, Object> params) {
		String hql = "";
		if(hotwordModel.getContent() != null && !"".equals(hotwordModel.getContent())) {
			hql += " and s.content like :content";
			params.put("content", hotwordModel.getContent() + "%");
		}
		
		return hql;
	}
	
	/**
	 * 通过ID获取关键词实例
	 * @param uuid
	 * @return
	 */
	@Override
	public HotwordModel get(String uuid) {
		Hotword hotword = this.hotwordDao.get(Hotword.class, uuid);

		HotwordModel hotwordModel = new HotwordModel();
		BeanUtils.copyProperties(hotword, hotwordModel);
		if (hotword.getUpdateUser()!= null) {
			hotwordModel.setUpdateById(hotword.getUpdateUser().getUuid());
			hotwordModel.setUpdateByName(hotword.getUpdateUser().getName());
		}
		return hotwordModel;
	}
	
	/**
	 *关键词重复判断
	 * @param name
	 * @return
	 */
	@Override
	public Boolean isRepeat(String content, String uuid, Boolean flag) {
		String hql = "select count(*) from Hotword s where s.content=:content";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("content", content);
		
		if(flag) {
			hql += " and s.uuid!=:uuid";
			params.put("uuid", uuid);
		}
		
		Long count = this.hotwordDao.count(hql, params);
		if(count <= 0) {
			return false;
		} else {
			return true;
		}
	}
	
	/**
	 * 新增关键词
	 * @param hotwordModel
	 */
	@Override
	public void add(HotwordModel hotwordModel) {
		Hotword hotword = new Hotword();

		BeanUtils.copyProperties(hotwordModel, hotword);
		hotword.setUpdateTime(new Date());
		hotword.setUpdateUser(this.userDao.get(User.class, hotwordModel.getUpdateById()));
		this.hotwordDao.save(hotword);
	}
	
	/**
	 * 更新关键词
	 * @param HotwordModel
	 */
	@Override
	public void update(HotwordModel hotwordModel) {
		Hotword hotword = new Hotword();

		BeanUtils.copyProperties(hotwordModel, hotword);
		hotword.setUpdateTime(new Date());
		hotword.setUpdateUser(this.userDao.get(User.class, hotwordModel.getUpdateById()));
		this.hotwordDao.update(hotword);
	}

	/**
	 * 删除关键词
	 * @param uuid
	 * @throws Exception
	 */
	@Override
	public void delete(String uuid) throws Exception {
		String hql = "delete from Hotword s where s.uuid=:uuid";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("uuid", uuid);
		this.hotwordDao.executeHql(hql, params);
	}
	
	/**
	 * 同步关键词
	 */
	@Override
	public Json syncHotword() throws Exception {
		Json json = new Json();
		String hql = "from Hotword s where s.state=1";
		List<Hotword> hotwordList = this.hotwordDao.find(hql);
		if(hotwordList == null || hotwordList.size() == 0) {
			json.setSuccess(false);
			json.setMsg(ErrorReturnMsg.HAVE_NONE_HOTWORD);
			return json;
		}
		String path = this.getClass().getResource("/").getFile().toString()+"../../resources/hotword.gbk";
		//先删除文件
		/*if(!TxtUtil.deleteFile(path)) {
			json.setSuccess(false);
			json.setMsg("清除原文件失败！");
			return json;
		}*/
		/*try {  
            PrintWriter out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path,true),"gbk")));
            for(Hotword hotword : hotwordList) {
            	if(hotword.getContent() != null && !"".equals(hotword.getContent())) 
	            	out.println(hotword.getContent());
            }
            out.close();
            json.setSuccess(true);
			json.setMsg("同步成功！");
			return json;
        } catch (Exception e) {  
            throw e;
	    }
	      */
		try{
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(path), Charset.forName("GBK")));
			for(Hotword hotword : hotwordList) {
	        	if(hotword.getContent() != null && !"".equals(hotword.getContent())) 
	        		bw.write(hotword.getContent());
	        		bw.newLine();
	        }
			bw.flush();
			bw.close();
			json.setSuccess(true);
			json.setMsg(ErrorReturnMsg.SYNC_SUCCESSFULLY);
			return json;
		} catch (Exception e) {
			throw e;
		}
	}
}
 
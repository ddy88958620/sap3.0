package com.hcicloud.sap.service.admin;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.OperationLog;
import com.hcicloud.sap.pagemodel.admin.OperationLogModel;
import com.hcicloud.sap.pagemodel.base.SessionInfo;

@Service
public class OperationLogServiceImpl implements OperationLogServiceI{

    @Autowired
    BaseDaoI<OperationLog> logDao;
    @Autowired
    BaseDaoI<Object> objectDao;
    @Autowired(required=false)  
    private HttpSession session;
    
    @Override
    public void add(String annotion, String type, Object dataObject,String ip) {
        OperationLog log = new OperationLog();
        log.setOperationTime(new Date());
        //进行类型转换
        log.setOperationMenu(GlobalConstant.actionTypeList.get(annotion));
        log.setOperationType(GlobalConstant.logTypeList.get(type));
        SessionInfo sessionInfo = (SessionInfo)session.getAttribute(GlobalConstant.SESSION_INFO);
        JSONObject jsonObject = null;
        String name = null;
        try {
            jsonObject = JSONObject.parseObject(JSONObject.toJSONString(dataObject));
            name = jsonObject.getString("name");
        } catch (Exception e) {
        }
        
        if(name!=null){
            if(name.length()==0&annotion!=null&&annotion.length()>1){
                try {
                    annotion = StringUtil.captureName(annotion.substring(1,annotion.length()));
                    String hql = " from "+ annotion +" where uuid='"+dataObject.toString()+"'";
                    Object object = objectDao.get(hql);
                    if(object!=null){
                        JSONObject dataJsonObject = JSONObject.parseObject(JSONObject.toJSONString(object));
                        name = dataJsonObject.getString("name");
                    }
                } catch (Exception e) {
                }
            }
        }else{
            name = "ip:".concat(ip);
        }
        log.setOperationData(name);
        if (sessionInfo == null) {
            System.out.println("sessionInfo is null!");
            return;
        }
        // get userid from sessioninfo
        log.setUserId(sessionInfo.getUuid());
        log.setUserName(sessionInfo.getName());
        this.logDao.save(log);
        
    }

    @Override
    public List<OperationLogModel> dataGrid(OperationLogModel operationLogModel,
            String startTime, String endTime, PageFilter pageFilter) {
        List<OperationLogModel> logModelList = new ArrayList<OperationLogModel>();
        
        String hql = "from OperationLog log where 1=1 ";
        Map<String, Object> params = new HashMap<String, Object>();
        
        hql = hql.concat(hqlJoin(operationLogModel, startTime, endTime, params));
        hql = hql.concat(" order by operationTime desc"); 
        List<OperationLog> logList = this.logDao.find(hql, params, 
                pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

        copy(logList, logModelList);
        
        return logModelList;
    }

    @Override
    public Long count(OperationLogModel operationLogModel, String startTime,
            String endTime, PageFilter pageFilter) {
        String hql = "select count(*) from OperationLog log where 1=1 ";
        Map<String, Object> params = new HashMap<String, Object>();
        
        hql = hql.concat(hqlJoin(operationLogModel, startTime, endTime, params));
        
        Long count = this.logDao.count(hql, params);
        
        return count;
    }
    
    /**
     * hql语句拼接
     * @param userGroupModel
     * @param params
     * @return
     */
    private String hqlJoin(OperationLogModel operationLogModel, String startTime, String endTime, Map<String, Object> params) {
        String hql = "";
        if(operationLogModel.getUserName() != null && !"".equals(operationLogModel.getUserName())) {
            hql = hql.concat(" and userName like :userName");
            params.put("userName", "%" + operationLogModel.getUserName() + "%");
        }
        if(operationLogModel.getOperationType() != null && !"".equals(operationLogModel.getOperationType())) {
            hql = hql.concat(" and operationType =:operationType");
            params.put("operationType",  operationLogModel.getOperationType());
        }
        if(operationLogModel.getOperationMenu() != null && !"".equals(operationLogModel.getOperationMenu())) {
            hql = hql.concat(" and operationMenu =:operationMenu");
            params.put("operationMenu", operationLogModel.getOperationMenu() );
        }
        if(startTime != null && !"".equals(startTime)) {
            hql = hql.concat(" and operationTime >=:startTime");
            params.put("startTime", StringUtil.stringToNormalDate(startTime.concat(" 00:00:00")));
        }
        if(endTime != null && !"".equals(endTime)) {
            hql = hql.concat(" and operationTime <=:endTime");
            params.put("endTime", StringUtil.stringToNormalDate(endTime.concat(" 23:59:59")));
        }
        
        return hql;
    }

    /**
     * userGroupList转换为userGroupModelList
     * @param userGroupList
     * @param userGroupModelList
     */
    private void copy(List<OperationLog> logList,
            List<OperationLogModel> logModelList) {
        OperationLogModel logModel = null;
        
        
        for(OperationLog log : logList) {
            logModel = new OperationLogModel();
            
            BeanUtils.copyProperties(log, logModel);
            
            logModelList.add(logModel);
        }
    }
}

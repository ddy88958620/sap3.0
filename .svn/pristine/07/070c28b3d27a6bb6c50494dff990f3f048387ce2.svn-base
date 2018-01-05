package com.hcicloud.sap.service.base;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.StringUtil;
import com.hcicloud.sap.dao.BaseDaoI;
import com.hcicloud.sap.model.admin.SystemLog;
import com.hcicloud.sap.pagemodel.base.SystemLogModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class SystemLogServiceImpl implements SystemLogServiceI {

    @Autowired
    private BaseDaoI<SystemLog> systemLogDao;

    @Override
    public List<SystemLog> dataGrid(SystemLogModel systemLogModel, String startTime, String endTime, PageFilter pageFilter) {

        String hql = "from SystemLog s where 1=1 and s.isDelete <> '1' ";
        Map<String, Object> params = new HashMap<String, Object>();

        hql += hqlJoin(systemLogModel, startTime, endTime, params);

        List<SystemLog> systemLogList = this.systemLogDao.find(hql, params,
                pageFilter.getiDisplayStart(), pageFilter.getiDisplayLength());

//        List<SystemLog> systemLogModelList = new ArrayList<SystemLog>();
//        for(SystemLog systemLog : systemLogList) {
//            systemLog = new SystemLog();
//            /* 预留之后对数据的操作 */
//            systemLogModelList.add(systemLog);
//        }

        return systemLogList;

    }

    /**
     * hql语句拼接
     * @param systemLogModel
     * @param params
     * @return
     */
    private String hqlJoin(SystemLogModel systemLogModel, String startTime, String endTime, Map<String, Object> params) {
        String hql = "";

        if(systemLogModel.getCreateBy() != null && !"".equals(systemLogModel.getCreateBy())) {
            hql += " and s.createBy like :createBy";
            params.put("createBy", "%" + systemLogModel.getCreateBy() + "%");
        }
        if(systemLogModel.getUserGroupId() != null && !"".equals(systemLogModel.getUserGroupId())) {
            hql += " and s.userGroupId = :uuid";
            params.put("uuid", systemLogModel.getUserGroupId());
        }
        if(startTime != null && !"".equals(startTime)) {
            hql = hql.concat(" and s.createDate >=:startTime");
            params.put("startTime", StringUtil.stringToNormalDate(startTime));
        }
        if(endTime != null && !"".equals(endTime)) {
            hql = hql.concat(" and s.createDate <=:endTime");
            params.put("endTime", StringUtil.stringToNormalDate(endTime));
        }

        hql+=" order by s.createDate desc";
        return hql;
    }

    @Override
    public void add(SystemLog systemLog) {
        systemLog.setIsDelete(0);
        this.systemLogDao.save(systemLog);

    }

    @Override
    public void update(SystemLogModel systemLogModel) {

    }

    @Override
    public Long count(SystemLogModel systemLogModel, String startTime, String endTime, PageFilter pageFilter) {
        String hql = "select count(*) from SystemLog s where 1=1 and s.isDelete <> '1' ";
        Map<String, Object> params = new HashMap<String, Object>();
        hql += hqlJoin(systemLogModel, startTime, endTime, params);
        Long count = this.systemLogDao.count(hql, params);
        return count;
    }

    @Override
    public List<SystemLog> getSystemLogList(SystemLogModel systemLogModel) {

        String hql = "from SystemLog s where 1=1 and s.isDelete <> '1' ";
        Map<String, Object> params = new HashMap<String, Object>();

        hql = hql.concat(" and s.uuid =:uuid");
        params.put("uuid", systemLogModel.getUuid());
        List<SystemLog> systemLogList = this.systemLogDao.find(hql,params);

        return systemLogList;
    }
}

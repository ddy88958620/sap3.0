package com.hcicloud.sap.service.task;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.model.admin.UserRoleRelation;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.quality.InspectorModel;
import com.hcicloud.sap.pagemodel.voice.VoiceModel;

public interface TaskAssignServiceI{

	Grid dataGrid(String srartTime , String endTime , String status ,VoiceModel v, PageFilter ph,String userGroupId);

	List<InspectorModel> inspectorGrid(UserRoleRelation userRole, PageFilter ph,String userGroupId);

	long count(String userGroupId);

	void denyAssign(String ids);

	void assignTask(String ids, String inspectorInfo);
	
}
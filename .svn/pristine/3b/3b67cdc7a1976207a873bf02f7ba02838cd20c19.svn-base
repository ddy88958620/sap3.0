package com.hcicloud.sap.service.quality;

import java.util.List;

import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.pagemodel.quality.AutoLexiconModel;

public interface AutoLexiconServiceI {

	public abstract List<AutoLexiconModel> dataGrid(AutoLexiconModel AutoLexiconModel, PageFilter page);

	public abstract AutoLexiconModel get(String uuid);
	
	public abstract void add(AutoLexiconModel AutoLexiconModel);

	public abstract void update(AutoLexiconModel AutoLexiconModel);

	public abstract void delete(String uuid) throws Exception;

	Boolean isRepeat(String name, String uuid, Boolean flag);

	long count(AutoLexiconModel AutoLexiconModel, PageFilter pageFilter);
}

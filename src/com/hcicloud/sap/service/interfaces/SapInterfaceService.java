package com.hcicloud.sap.service.interfaces;

import java.util.List;
import java.util.Map;

public interface SapInterfaceService {

	List<Map<String, Object>> getContentById(String callid);

}

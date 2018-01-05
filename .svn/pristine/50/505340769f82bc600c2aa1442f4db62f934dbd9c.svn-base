package com.hcicloud.sap.controller.admin;

import com.hcicloud.sap.common.annotation.SystemLogAnnotation;
import com.hcicloud.sap.common.utils.PageFilter;
import com.hcicloud.sap.common.utils.ReflectUtils;
import com.hcicloud.sap.controller.base.BaseController;
import com.hcicloud.sap.model.admin.SystemLog;
import com.hcicloud.sap.pagemodel.annoy.AnnoyModel;
import com.hcicloud.sap.pagemodel.base.Grid;
import com.hcicloud.sap.pagemodel.base.SystemLogModel;
import com.hcicloud.sap.service.base.SystemLogServiceI;
import com.hcicloud.sap.vo.SystemLogExcelVo;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.jplus.hyberbin.excel.language.ILanguage;
import org.jplus.hyberbin.excel.service.SimpleExportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

/**
 * @author menghaonan
 * @Description 记录用户操作日志
 * 具体的操作，绑定到指定的controller
 * @Date 2017年11月14日 20:43:41
 * @e-mail 707093428@qq.com
 */
@Controller
@RequestMapping({"/systemLog"})
public class SystemLogController extends BaseController {

    @Autowired
    private SystemLogServiceI systemLogService;

    @RequestMapping({"/manager"})
    public String manager(HttpServletRequest request) {
        return "/admin/systemLog";
    }

    //文件下载对应参数
    private static HashMap<String, String> map = new HashMap<String, String>();
    static {
        map.put("voiceId", "录音流水号");
        map.put("orderId", "工单号");
    }

    /**
     * 列表
     *
     * @param systemLogModel
     * @param ph
     * @return
     */
    @RequestMapping({"/dataGrid"})
    @ResponseBody
    @SystemLogAnnotation(operationType = "监控日志的查询", operationName = "操作记录-操作日志")
    public Grid dataGrid(SystemLogModel systemLogModel, String startTime, String endTime, PageFilter ph) {
        Grid grid = new Grid();
        try {
            grid.setAaData(this.systemLogService.dataGrid(systemLogModel, startTime, endTime, ph));
            long total = this.systemLogService.count(systemLogModel, startTime, endTime, ph);
            grid.setiTotalDisplayRecords(total);
            grid.setiTotalRecords(total);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return grid;
    }

    /**
     * Execle下载
     *
     * @param systemLogModel 查询条件
     * @param response
     * @param request
     */


    @RequestMapping("/download")
    @ResponseBody
    public void download(SystemLogModel systemLogModel, HttpServletResponse response, HttpServletRequest request) {

        try {
            List<SystemLog> systemLogList = systemLogService.getSystemLogList(systemLogModel);

            //拼接参数列表
            List<SystemLogExcelVo> excelList = new ArrayList<SystemLogExcelVo>();
            String paramsTwo = "";
            String createByName = "";

            if (systemLogList != null && systemLogList.size() >0) {
                String params = systemLogList.get(0).getParams();
                createByName = systemLogList.get(0).getCreateBy();

                String paramsList[] = params.split(";");

                String paramsOne[] = paramsList[0].substring(1,paramsList[0].length()-1).split(",");
                paramsTwo = paramsList[1].substring(1,paramsList[1].length()-1);

                if ("orderId".equals(paramsTwo)) {
                    for (int i = 0; i < paramsOne.length; i++) {
                        SystemLogExcelVo systemLogExcelVo = new SystemLogExcelVo();
                        systemLogExcelVo.setOrderId(paramsOne[i].substring(1,paramsOne[i].length()-1));
                        excelList.add(systemLogExcelVo);
                    }
                }else{
                    for (int i = 0; i < paramsOne.length; i++) {
                        SystemLogExcelVo systemLogExcelVo = new SystemLogExcelVo();
                        systemLogExcelVo.setVoiceId(paramsOne[i].substring(1,paramsOne[i].length()-1));
                        excelList.add(systemLogExcelVo);
                    }
                }
            }

            Workbook workbook = new HSSFWorkbook();
            Sheet sheet = workbook.createSheet("上传导出的参数列表");
            //将String[]内对应名称的列取出并按顺序排序
            SimpleExportService service = new SimpleExportService(sheet, excelList,
                    new String[]{paramsTwo},
                    "用户成功单上传导出参数值列表");

            //将对应列的列头改为相应的文字描述
            service.setLanguage(new ILanguage() {
                @Override
                public String translate(Object key, Object... objects) {
                    String name = "";
                    if (key != null) {
                        name = map.get(key.toString());
                        if (name == null) {
                            name = key + "";
                        }
                    }
                    return name;
                }
            });
            service.doExport();
            response.setContentType("application/pdf");
            String fileName = createByName + "上传导出参数列表" + new Date().getTime() + ".xls";
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
}

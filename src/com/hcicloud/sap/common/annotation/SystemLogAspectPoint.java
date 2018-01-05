package com.hcicloud.sap.common.annotation;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.hcicloud.sap.common.constant.GlobalConstant;
import com.hcicloud.sap.common.utils.CommonMethod;
import com.hcicloud.sap.model.admin.SystemLog;
import com.hcicloud.sap.model.admin.User;
import com.hcicloud.sap.pagemodel.base.SessionInfo;
import com.hcicloud.sap.service.base.SystemLogServiceI;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author mhn
 * @version 创建时间：2016年11月13日 21:56:22
 * @E-mail: 707093428@qq.com
 * @desc 切点类
 */

@Aspect
public class SystemLogAspectPoint {

    //注入Service用于把日志保存数据库
    @Resource  //这里我用resource注解，一般用的是@Autowired，他们的区别如有时间我会在后面的博客中来写
    private SystemLogServiceI systemLogService;

    private final Logger logger = LoggerFactory.getLogger(SystemLogAspectPoint.class);

    //Controller层切点
    //execution(* com.hcicloud.sap.controller ..*.login(..))
//    @Pointcut("execution (* com.hcicloud.sap.controller..*.dataGrid(..))")
//    public void controllerAspect() {
//    }


//    @Pointcut("execution (* com.hcicloud.sap.controller..*.success*(..))")
//    public void successExportControllerAspect() {
//    }

    @Pointcut("execution (* com.hcicloud.sap.controller..*.downZip(..))")
    public void controllerAspect() {
    }

    /**
     * 前置通知 用于拦截Controller层记录用户的操作
     * @param joinPoint 切点
     */
    @Before("controllerAspect()")
    public void doBefore(JoinPoint joinPoint) {
        System.out.println("==========执行controller前置通知===============");
        if (logger.isInfoEnabled()) {
            logger.info("before " + joinPoint);
        }
    }

    //配置controller环绕通知,使用在方法aspect()上注册的切入点
//    @Around("controllerAspect()")
//    public void around(JoinPoint joinPoint) {
//        System.out.println("==========开始执行controller环绕通知===============");
//        long start = System.currentTimeMillis();
//        try {
//            ((ProceedingJoinPoint) joinPoint).proceed();
//            long end = System.currentTimeMillis();
//            if (logger.isInfoEnabled()) {
//                logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms!");
//            }
//            System.out.println("==========结束执行controller环绕通知===============");
//        } catch (Throwable e) {
//            long end = System.currentTimeMillis();
//            if (logger.isInfoEnabled()) {
//                logger.info("around " + joinPoint + "\tUse time : " + (end - start) + " ms with exception : " + e.getMessage());
//            }
//        }
//    }

    /**
     * 后置通知 用于拦截Controller层记录用户的操作
     *
     * @param joinPoint 切点
     */
    @After("controllerAspect()")
    public void after(JoinPoint joinPoint) {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session = request.getSession();

//        SessionInfo sessionInfo = new SessionInfo();
//        sessionInfo.setUuid(sysuser.getUuid());
//        sessionInfo.setLoginName(sysuser.getLoginName());
//        sessionInfo.setName(sysuser.getName());
//        sessionInfo.setUserGroupId(sysuser.getUserGroupId());
//        sessionInfo.setUserGroupName(sysuser.getUserGroupName());
//        if(sysuser.getLoginName().compareToIgnoreCase("admin") == 0){
//            sessionInfo.setAdmin(true);
//        }
//        sessionInfo.setPrivilegeList(this.userService.getPrivilegeList(sysuser.getUuid()));
//        session.setAttribute(GlobalConstant.SESSION_INFO, sessionInfo);

        //读取session中的用户
        SessionInfo sessionInfo = (SessionInfo) session.getAttribute(GlobalConstant.SESSION_INFO);
        //请求的IP
//        String ip = request.getRemoteAddr();
        String ip = CommonMethod.getIpAddr(request);

//        测试数据
//        User user = new User();
//        user.setUuid("1");
//        user.setName("张三");
//        String ip = "127.0.0.1";
        try {

            String targetName = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            Object[] arguments = joinPoint.getArgs();
            Class targetClass = Class.forName(targetName);
            Method[] methods = targetClass.getMethods();
            String operationType = "";
            String operationName = "";
            for (Method method : methods) {
                if (method.getName().equals(methodName)) {
                    Class[] clazzs = method.getParameterTypes();
                    if (clazzs.length == arguments.length) {
                        operationType = method.getAnnotation(SystemLogAnnotation.class).operationType();
                        operationName = method.getAnnotation(SystemLogAnnotation.class).operationName();
                        break;
                    }
                }
            }
            String params = "";
            String exceptionDetail = "";
            if (arguments != null && arguments.length > 0) {
                for (int i = 0; i < arguments.length; i++) {
                    System.out.println("参数值："+joinPoint.getArgs()[i].toString());
                    System.out.println("参数所属类："+joinPoint.getArgs()[i].getClass());
                    System.out.println("参数所属类名："+joinPoint.getArgs()[i].getClass().getName());
                    if ("org.apache.catalina.connector.RequestFacade".equals(joinPoint.getArgs()[i].getClass().getName())) {
                        continue;
                    }
                    if ("org.apache.catalina.connector.ResponseFacade".equals(joinPoint.getArgs()[i].getClass().getName())) {
                        continue;
                    }
                    if ("org.springframework.web.multipart.support.DefaultMultipartHttpServletRequest".equals(joinPoint.getArgs()[i].getClass().getName())) {
                        continue;
                    }
                    if ("org.springframework.validation.support.BindingAwareModelMap".equals(joinPoint.getArgs()[i].getClass().getName())) {
                        exceptionDetail = (String) JSONObject.parseObject(JSON.toJSONString(joinPoint.getArgs()[i])).get("errorMessage");
                    }
                    if ("org.springframework.web.multipart.commons.CommonsMultipartFile".equals(joinPoint.getArgs()[i].getClass().getName())) {
                        MultipartFile uploadFile = (MultipartFile)joinPoint.getArgs()[i];
                        InputStream inputStream = uploadFile.getInputStream();
                        List<String> idList = new ArrayList<String>();
                        InputStreamReader reader = new InputStreamReader(inputStream);
                        BufferedReader br = new BufferedReader(reader);
                        String input = "";
                        try {
                            while ((input = br.readLine()) != null) {
                                idList.add(input);
                            }
                            params += JSON.toJSONString(idList) + ";";
                            continue;
                        } catch (IOException e) {
                            e.printStackTrace();
                        } finally {
                            try {
                                br.close();
                            } catch (IOException e) {
                                e.printStackTrace();
                            }
                        }
                    }
                    params += JSON.toJSONString(joinPoint.getArgs()[i]) + ";";
                }
            }
            //*========控制台输出=========*//
            System.out.println("=====controller后置通知开始=====");
            System.out.println("请求方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()") + "." + operationType);
            System.out.println("方法描述:" + operationName);
            System.out.println("请求人:" + sessionInfo.getName());
            System.out.println("请求IP:" + ip);
            //*========数据库日志=========*//
            SystemLog log = new SystemLog();
            log.setUuid(UUID.randomUUID().toString());
            log.setDescription(operationName);
            log.setMethod((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()") + "." + operationType);
            log.setLogType((long) 0);
            log.setRequestIp(ip);
            log.setExceptionCode(null);
            log.setExceptionDetail(null);
            log.setParams(params);
            log.setCreateById(sessionInfo.getUuid());
            log.setCreateBy(sessionInfo.getName());
            log.setUserGroupId(sessionInfo.getUserGroupId());
            log.setUserGroupName(sessionInfo.getUserGroupName());
            log.setExceptionDetail(exceptionDetail);
            log.setCreateDate(new Date());
            //保存数据库
            systemLogService.add(log);
            System.out.println("=====controller后置通知结束=====");
        } catch (Exception e) {
            //记录本地异常日志
            logger.error("==后置通知异常==");
            logger.error("异常信息:{}", e.getMessage());
        }
    }

    //配置后置返回通知,使用在方法aspect()上注册的切入点
//    @AfterReturning("controllerAspect()")
//    public void afterReturn(JoinPoint joinPoint) {
//        System.out.println("=====执行controller后置返回通知=====");
//        if (logger.isInfoEnabled()) {
//            logger.info("afterReturn " + joinPoint);
//        }
//    }

    /**
     * 异常通知 用于拦截记录异常日志
     *
     * @param joinPoint
     * @param e
     */
//    @AfterThrowing(pointcut = "controllerAspect()", throwing = "e")
//    public void doAfterThrowing(JoinPoint joinPoint, Throwable e) {
//        /*HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
//        HttpSession session = request.getSession();
//        //读取session中的用户
//        User user = (User) session.getAttribute(WebConstants.CURRENT_USER);
//        //获取请求ip
//        String ip = request.getRemoteAddr(); */
//        //获取用户请求方法的参数并序列化为JSON格式字符串
//
//        User user = new User();
//        user.setUuid("1");
//        user.setName("张三");
//        String ip = "127.0.0.1";
//
//        String params = "";
//        if (joinPoint.getArgs() != null && joinPoint.getArgs().length > 0) {
//            for (int i = 0; i < joinPoint.getArgs().length; i++) {
//                params += JSON.toJSONString(joinPoint.getArgs()[i]) + ";";
//            }
//        }
//        try {
//
//            String targetName = joinPoint.getTarget().getClass().getName();
//            String methodName = joinPoint.getSignature().getName();
//            Object[] arguments = joinPoint.getArgs();
//            Class targetClass = Class.forName(targetName);
//            Method[] methods = targetClass.getMethods();
//            String operationType = "";
//            String operationName = "";
//            for (Method method : methods) {
//                if (method.getName().equals(methodName)) {
//                    Class[] clazzs = method.getParameterTypes();
//                    if (clazzs.length == arguments.length) {
//                        operationType = method.getAnnotation(SystemLogAnnotation.class).operationType();
//                        operationName = method.getAnnotation(SystemLogAnnotation.class).operationName();
//                        break;
//                    }
//                }
//            }
//             /*========控制台输出=========*/
//            System.out.println("=====异常通知开始=====");
//            System.out.println("异常代码:" + e.getClass().getName());
//            System.out.println("异常信息:" + e.getMessage());
//            System.out.println("异常方法:" + (joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()") + "." + operationType);
//            System.out.println("方法描述:" + operationName);
//            System.out.println("请求人:" + user.getName());
//            System.out.println("请求IP:" + ip);
//            System.out.println("请求参数:" + params);
//               /*==========数据库日志=========*/
//            SystemLog log = new SystemLog();
//            log.setUuid(UUID.randomUUID().toString());
//            log.setDescription(operationName);
//            log.setExceptionCode(e.getClass().getName());
//            log.setLogType((long) 1);
//            log.setExceptionDetail(e.getMessage());
//            log.setMethod((joinPoint.getTarget().getClass().getName() + "." + joinPoint.getSignature().getName() + "()"));
//            log.setParams(params);
//            log.setCreateBy(user.getName());
//            log.setCreateDate(new Date());
//            log.setRequestIp(ip);
//            //保存数据库
//            systemLogService.add(log);
//            System.out.println("=====异常通知结束=====");
//        } catch (Exception ex) {
//            //记录本地异常日志
//            logger.error("==异常通知异常==");
//            logger.error("异常信息:{}", ex.getMessage());
//        }
//         /*==========记录本地异常日志==========*/
//        logger.error("异常方法:{}异常代码:{}异常信息:{}参数:{}", joinPoint.getTarget().getClass().getName() + joinPoint.getSignature().getName(), e.getClass().getName(), e.getMessage(), params);
//
//    }
}

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${ctx }/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript">
   function getTrans(){
	   location.href = "${ctx }/speechPlayer?callid="+$("#getTrans").val();
   }
</script>
</head>
<body>
	由id获取转写文本   id:<input type="text" id="getTrans"><input type="button" value="查询" onclick="getTrans()"><br>
</body>
</html>
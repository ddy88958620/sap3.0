<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
${msg}
<script type="text/javascript" charset="utf-8">
	setTimeout("top.location.href='${ctx}/login'",1500);
</script>
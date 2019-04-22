<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/15 0015
  Time: 下午 8:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>

    <script src="${ctx}/js/jquery.min.js"></script>
    <script src="${ctx}/js/ajaxfileupload.js"></script>
    <title>Title</title>
</head>
<body>
    <input type="file" id="file"><br/>
    <input type="button" value="上传" onclick="upload();">
<script type="text/javascript">

    function upload(){
        $.ajaxFileUpload
        (
            {
                url: '${ctx}/fileUpload/singleUpload', //用于文件上传的服务器端请求地址
                secureuri: false, //是否需要安全协议，一般设置为false
                fileElementId: ['file'], //文件上传域的ID
                dataType: 'json', //返回值类型 一般设置为json
                success: function (data, status)  //服务器成功响应处理函数
                {

                },
                error: function (data, status, e)//服务器响应失败处理函数
                {
                    alert(e);
                }
            }
        )
    }
</script>
</body>
</html>

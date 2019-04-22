<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/4/10 0010
  Time: 下午 5:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <title>Title</title>
    <script src="http://code.jquery.com/jquery-1.4.4.min.js"></script>
    <script type="text/javascript">
       /* $.each(json.result, function(i, item) {   

            var score = item.score;

            var name = item.name;

            var baike_info = item.baike_info;

        });*/

       $(document).ready(function() {
           $.ajax({
               url : "/fileUpload/singleUpload",//请求地址
               dataType : 'json',//数据格式
               type : "post",//请求方式
               data :"{'result':[{'score':'0.511398',}]}",
               async : false,//是否异步请求
               success : function(msg) {//如何发送成功
                   var data = eval(msg);//将msg化为数
                   var num = 1;
                   $.each(date, function (num) {
                       /* //alert(data[num].userName);*/
                       alert(data[num].score)

                       var score = data[num].score;//注意要与实体类中的名称相同
                       var name = data[num].name;
                       var baike_info = data[num].baike_info;
                       var value = "<tr><td align='center'><input name='checked' type='checkbox'  value=" + score + "/></td>";
                       value += "<td align='center'>" + score + "</td> <td align='center'>" + name + "</td> <td align='center'>" + baike_info + "</td><tr/>";
                       $("#tb").append(value);//写入到id为tb的html部分
                   });
               },
           })
       })
    </script>

</head>
<body>
<table  id="tb" width="80%" border="1" cellspacing="0" cellpadding="0"  align="center" >
    <tr>
        <%--   <th align="center"><input name="checked" type="checkbox" /></th>--%>
        <th align="center">score</th>
        <th align="center">name</th>
        <th align="center">baike_info</th>
    </tr>
</table>
</body>

</html>

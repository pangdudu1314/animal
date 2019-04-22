<%@ page import="java.net.URLDecoder" %><%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/3/8 0008
  Time: 下午 4:18
  To change this template use File | Settings | File Templates.
--%>

<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";

%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<html>
<head>
    <base href="<%=basePath%>">
    <title>ECharts</title>
    <style type="text/css">
        body{
          /*  background: url("images/beijingtupian.jpg");*/
            background-color: #fafafa;
        }
        #main{
            /*background: url("images/beijingtupian.jpg");*/
            width: 1300px;
            height:400px;
            float:left;
        }
        *{
            margin:0;
            padding:0;
        }
        body{
            /* background: url("images/beijingtupian.jpg") no-repeat 0 0;*/
            background-color: #fafafa;
        }
        #submitView1{
            width:50px;
            height:37px;
            border: solid 1px #4791ff;
            background-color: #3385ff;
            color: #fff;
            font-size: 15px;
            cursor: pointer;
            margin-right: 40px;
        }
        #submitView1:HOVER {
            background-color: #317ef3;/*//鼠标移动过去时，背景颜色发生变化*/
        }
        input{
            float:left;
        }
    </style>

</head>
<body  style="width:1300px;">
<h1 style="color:#0000FF">动物领域多模态知识库的查询系统</h1>
<div id="main" style="width: 800px;height:500px;float:left;"></div>
<script src="js/echarts.js"></script>
<script src="js/jquery.min.js"></script>
<script type="text/javascript">
    // 路径配置
    require.config({
        paths: {
            echarts: 'dist'
        }
    });

    // 使用
    require(
        [
            'echarts',
            'echarts/chart/force' // 使用柱状图就加载bar模块，按需加载
        ],
        function (ec) {
            // 基于准备好的dom，初始化echarts图表
            var myChart = ec.init(document.getElementById('main'));
            option = {
                title : {
                    text: '动物关系：${name}',
                    subtext: '数据来自百度百科',
                    x:'right',
                    y:'bottom'
                },
                tooltip : {
                    trigger: 'item',
                    formatter: '{a} : {b}'
                },
                toolbox: {
                    show : true,
                    feature : {
                        restore : {show: true},
                        magicType: {show: true, type: ['force', 'chord']},
                        saveAsImage : {show: true}
                    }
                },
                legend: {
                    x: 'left',
                    data:['种类']
                },
                series : [
                    {
                        type:'force',
                        name : "动物关系",
                        ribbonType: false,
                        categories : [
                            {
                                name: '动物'
                            },
                            {
                                name: '种类',
                                symbol: 'diamond'
                            },


                        ],
                        shapeType:'ellipse',
                        itemStyle: {
                            normal: {
                                label: {
                                    show: true,
                                    textStyle: {
                                        color: '#333333',
                                        align: 'center',
                                        baseline: 'bottom'
                                    }

                                },
                                nodeStyle : {
                                    brushType : 'both',
                                    borderColor : 'rgba(255,215,0,0.4)',
                                    borderWidth : 1
                                },
                                linkStyle: {
                                    type: 'line',
                                    width: 3.5,
                                    color:"green"
                                }
                            },
                            emphasis: {
                                label: {
                                    show: false,
                                   // textStyle: null      // 默认使用全局文本样式，详见TEXTSTYLE
                                },
                                nodeStyle : {
                                   // r: 30
                                },
                                linkStyle : {}
                            }
                        },
                        useWorker: false,
                        minRadius : 15,
                        maxRadius : 25,
                        gravity: 1.1,
                        scaling: 1.1,
                        roam: 'move',
                       /* roam:'scale',*/
                        nodes:${nodes},
                        links : ${links}
                    }
                ]
            };
            var ecConfig = require('echarts/config');

            function focus(param) {
                var data = param.data;//点击的图片信息
                var links = option.series[0].links;
                var nodes = option.series[0].nodes;




                if ( data.source !== undefined && data.target !== undefined) { //点击的是边
                    var sourceNode = nodes.filter(function (n) {return n.name == data.source})[0];
                    var targetNode = nodes.filter(function (n) {return n.name == data.target})[0];
                    console.log("选中了边 " + sourceNode.name + ' -> ' + targetNode.name + ' (' + data.weight + ')');
                }

                else  {
                    // $.post("http://localhost:8888/tuxiangzhanshi/servlet", {
                    //     username: data.name, sub: "提交"
                    // } ).success(function (data) {
                    //     $(document).find("html").html(data);
                    // });
                    // console.log("选中了" + data.name + '(' + data.value + ')');
                    //跳转到后台指定方法，或者前端页面，都可以这么写
                    window.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+data.name;//取出名称进行查询

                }

            }
          /*  myChart.on(ecConfig.EVENT.CLICK, focus);
            myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
                console.log(myChart.chart.force.getPosition());
            });*/
            //两个参数  ，第一个是监听的事件类别，第二个是实现方法名称
            myChart.on(ecConfig.EVENT.CLICK, focus)

            myChart.on(ecConfig.EVENT.FORCE_LAYOUT_END, function () {
                console.log(myChart.chart.force.getPosition());
            });
            myChart.setOption(option);
        }
    );</script>
<div id="" style="width:400px; float:left;">

    <div <%--style="float: left"--%>>
        <H2 style="color:#4b1cff; display: inline-block;" >${Animal_xiang}:</H2>
        <br/>
        <%--第一层动物--%>

        <div <%--style="float: left"--%>>
            <div style="float: left">
                <img src="${Animal_simi0}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s0() {
                        var s="${Animal_ming0}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s0()">${Animal_ming0}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi1}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s1() {
                        var s="${Animal_ming1}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s1()"  >${Animal_ming1}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi2}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s2() {
                        var s="${Animal_ming2}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s2()"  >${Animal_ming2}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi3}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s3() {
                        var s="${Animal_ming3}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s3()">${Animal_ming3}</a></p>
            </div>
        </div>
        <%--第二层--%>
        <div <%--style="float: left"--%>>
            <div style="float: left">
                <img src="${Animal_simi4}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s4() {
                        var s="${Animal_ming4}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s4()"  >${Animal_ming4}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi5}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s5() {
                        var s="${Animal_ming5}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s5()"  >${Animal_ming5}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi6}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s6() {
                        var s="${Animal_ming6}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s6()"  >${Animal_ming6}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_simi7}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s7() {
                        var s="${Animal_ming7}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s7()"  >${Animal_ming7}</a></p>
            </div>
        </div>
        <H2 style="color:#4b1cff; display: inline-block;" >${Animal_guan}:</H2>
        <br/>
        <%--第三层--%>
        <div <%--style="float: left"--%>>
            <div style="float: left;">
                <img src="${Animal_s0}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s8() {
                        var s="${Animal_domgwu0}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s8()"  >${Animal_domgwu0}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s1}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s9() {
                        var s="${Animal_domgwu1}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s9()"  >${Animal_domgwu1}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s2}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s10() {
                        var s="${Animal_domgwu2}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s10()"  >${Animal_domgwu2}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s3}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s11() {
                        var s="${Animal_domgwu3}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s11()"  >${Animal_domgwu3}</a></p>
            </div>
        </div>
        <%--第四层--%>
        <div <%--style="float: left"--%>>
            <div style="float: left">
                <img src="${Animal_s4}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s12() {
                        var s="${Animal_domgwu4}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s12()"  >${Animal_domgwu4}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s5}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s13() {
                        var s=${Animal_domgwu5}
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s13()" id="S13" >${Animal_domgwu5}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s6}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s14() {
                        var s="${Animal_domgwu6}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s14()"  >${Animal_domgwu6}</a></p>
            </div>
            <div style="float: left;padding-left: 15px">
                <img src="${Animal_s7}" style="width: 80px;height: 80px">
                <script type="text/javascript">
                    function s15() {
                        var s="${Animal_domgwu7}";
                        window.parent.location.href="${pageContext.request.contextPath}/queryClass/selectAdmin?name="+s;
                    }
                </script>
                <p><a href="javascript:;" onclick="s15()">${Animal_domgwu7}</a></p>

            </di>
        </div>
        </div>
    </div>
</div>

<div>
    <div id="foot" style="width: 700px; float:left;">
        <%--   <p id="migcheng" name="${name}"></p>--%>
        <input id="nameid" type="hidden" value="${key}">
        <H2 style="color:#4b1cff; display: inline-block;" >动物简介:</H2>

        <input id="submitView1" onclick="tiaozhuan();" type="button" name="sub" value="编辑" style="display: inline-block;"   />
        <p>
           <%-- <% out.println(request.getAttribute("Animal_info"));%>--%>
            ${Animal_info}
        </p>
    </div>
    <div id="main1" align="right" style="width: 500px;height:250px;float:left;float:top;"></div>
    <script src="js/echarts.js"></script>
    <script type="text/javascript"></script>
    <script type="text/javascript">
        require.config({
            paths: {
                echarts: 'dist'
            }
        });

        // 使用
        require(
            [
                'echarts',
                'echarts/chart/bar' // 使用柱状图就加载bar模块，按需加载
            ],

            function (ec) {
                // 基于准备好的dom，初始化echarts图表
                var myChart = ec.init(document.getElementById('main1'));
                // 指定图表的配置项和数据
                var option = {
                    title: {
                        text: '动物热搜指数'
                    },
                    tooltip: {},
                    legend: {
                        data:['千']
                    },
                    xAxis: {
                        data: ["周一","周二","周3","周四","周五","周六","周日"]
                    },
                    yAxis: {},
                    series: [{
                        name: '千',
                        type: 'bar',
                        data: [Math.floor(Math.random()*10),Math.floor(Math.random()*10),Math.floor(Math.random()*10),Math.floor(Math.random()*10),Math.floor(Math.random()*10),Math.floor(Math.random()*10),Math.floor(Math.random()*10)]
                    }]
                };
                myChart.setOption(option);
            }
        );
    </script>
</div>

<script>
    function tiaozhuan(){
        var name=$("#nameid").val();
        /*收集最后一个字*/
        var  b  = name.substr(name.length-1,1);
       // window.location.href="bianji.jsp";
        if(b=="科"){
            alert("动物的所属科目不能修改");
        }else{

            window.parent.location.href="${pageContext.request.contextPath}/queryClass/bianji?name="+name;
        }
    }
</script>
</body>
</html>

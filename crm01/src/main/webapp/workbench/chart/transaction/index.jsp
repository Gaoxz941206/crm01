<%--
  Created by IntelliJ IDEA.
  User: gaoxz
  Date: 2021-10-11
  Time: 10:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getScheme()+"://"+
                  request.getServerName()+":"+
                  request.getServerPort()+
                  request.getContextPath()+"/";
%>
<html>
<head>
    <title>统计表</title>
    <base href="<%=path%>">
    <%--　引入Echarts　--%>
    <script src="Echarts/echarts.min.js"></script>
    <script src="jquery/jquery-1.11.1-min.js"></script>
    
    <script type="text/javascript">

        $(function () {
            getEcharts();
        });

        function getEcharts() {

            //基于准备好的DOM，初始化echarts示例
            var myChart = echarts.init(document.getElementById("main"));

            // 指定图表的配置项和数据
            var option = {
                title: {
                    text: '交易阶段漏斗统计图'
                },
                tooltip: {
                    trigger: 'item',
                    formatter: '{a} <br/>{b} : {c}%'
                },
                series: [
                    {
                        name: '交易阶段统计图',
                        type: 'funnel',
                        left: '10%',
                        top: 60,
                        bottom: 60,
                        width: '80%',
                        min: 0,
                        max: 100,
                        minSize: '0%',
                        maxSize: '100%',
                        sort: 'descending',
                        gap: 2,
                        label: {
                            show: true,
                            position: 'inside'
                        },
                        labelLine: {
                            length: 10,
                            lineStyle: {
                                width: 1,
                                type: 'solid'
                            }
                        },
                        itemStyle: {
                            borderColor: '#fff',
                            borderWidth: 1
                        },
                        emphasis: {
                            label: {
                                fontSize: 20
                            }
                        },
                        data: [
                            { value: 60, name: 'Visit' },
                            { value: 40, name: 'Inquiry' },
                            { value: 20, name: 'Order' },
                            { value: 80, name: 'Click' },
                            { value: 100, name: 'Show' }
                        ]
                    }
                ]
            };

            // 使用刚指定的配置项和数据显示图表(画图)。
            myChart.setOption(option);
        }
        
    </script>
    
</head>
<body>

    <div>
        <%-- 为Echarts提供一个DOM容器 --%>
        <div id="main" style="width: 600px;height: 400px">

        </div>

    </div>

</body>
</html>

<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度专业招生完成情况</title>

 <link rel="stylesheet" type="text/css" href="${ctxMap_static}/css/main.css">
     <script type="text/javascript" src="${ctxMap_static}/js/echarts.js" charset="UTF-8"></script>
    <script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="${ctxMap_static}/js/citymap.js" charset="UTF-8"></script>

</head>
<body>
	   <div>
         <form action="#">
            招生计划<select>
            <option>2017年招生计划
            </select>
            招生机构<select>
            <option>招生部门
            <option>招生部门
            <option>招生部门
            <option>招生部门
            </select>
             <button>查询</button>
             <button>导出</button>
         </form>
     </div>
     <div>
             <button>图形</button>
             <button>图表</button>
     </div>
     
      <div>
     <div id="main2" style="width: 90%;height:300px;">
    <script type="text/javascript">
        // 基于准备好的dom，初始化echarts实例
        var myChart2 = echarts.init(document.getElementById('main2'));
        // 指定图表的配置项和数据
        var option2 = {
    tooltip : {
        trigger: 'axis',
        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
        }
    },
    legend: {
        data:['部门招生','代理机构招生','网上招生','现场登记']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis : [
        {
            type : 'category',
            data : ['部门招生','代理机构招生','网上招生','现场登记']
        }
    ],
    yAxis : [
        {
            type : 'value'
        }
    ],
    series : [
        {
            name:'部门招生',
            type:'bar',
            data:[320, 332, 301, 334]
        },
        {
            name:'代理机构招生',
            type:'bar',
            data:[120, 132, 101, 134]
        },
        {
            name:'网上找生',
            type:'bar',
            data:[220, 182, 191, 234]
        },
        {
            name:'现场报道',
            type:'bar',
            data:[150, 232, 201, 154]
        }
    ]
};


        // 使用刚指定的配置项和数据显示图表。
        myChart2.setOption(option2);
    </script>
    </div>
     </div>
</body>
</html>
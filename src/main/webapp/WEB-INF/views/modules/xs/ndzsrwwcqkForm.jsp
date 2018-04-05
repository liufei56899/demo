<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>年度招生任务完成情况</title>
<link rel="stylesheet" type="text/css"
	href="${ctxMap_static}/css/main.css">
<script src="${ctxStatic}/jquery/jquery-1.8.3.min.js" type="text/javascript"></script>	
<%@include file="/WEB-INF/views/include/head.jsp"%>
<script type="text/javascript" src="${ctxStatic}/Highcharts/highcharts-3d.js"></script>
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<style type="text/css">
table,tr,td {
	border: 1px solid #ddd;
	text-align: center; 
}

td {
	height: 40px;
	font-size: 14px !important;
}

/* .ZSJH {
	height: 45px;
	line-height: 45px;
	font-size: 16px;
	border: 1px solid #ddd;
} */

.txtb {
	height: 50px;
	line-height: 50px;
	border: 1px solid #ddd;
	padding-left: 50px;
}

.txtb>button {
	width: 80px;
	height: 30px;
	line-height: 30px;
	font-size: 14px;
	border: none;
	border-radius: 4px;
}

#statTable {
	border-color: #ddd;
}
</style>
<script type="text/javascript" src="${ctxMap_static}/js/echarts.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/citymap.js"
	charset="UTF-8"></script>
<script type="text/javascript">
	jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件
		return this.each(function() {
			var that;
			$('tr', this).each(
					function(row) {
						$('td:eq(' + colIdx + ')', this).filter(':visible')
								.each(
										function(col) {
											if (that != null
													&& $(this).attr("id") == $(
															that).attr("id")) {
												rowspan = $(that).attr(
														"rowSpan");
												if (rowspan == undefined) {
													$(that).attr("rowSpan", 1);
													rowspan = $(that).attr(
															"rowSpan");
												}
												rowspan = Number(rowspan) + 1;
												$(that)
														.attr("rowSpan",
																rowspan);
												$(this).hide();
											} else {
												that = this;
											}
										});
					});
		});
	}
	function loadStat(zsnd) {
		//每次加载统计前，将图表和图形两部分节点都重置为显示状态
		//$("#chartStat").show();
		//$("#listStat").show();
		myChart1.showLoading({
			text : '正在努力加载中...'
		}); //数据加载完之前先显示一段简单的loading动画
		myChart2.showLoading({
			text : '正在努力加载中...'
		}); //数据加载完之前先显示一段简单的loading动画
		var names = []; //类别数组（实际用来盛放X轴坐标值）
		var nums = [];//值数组（用来填充数据）
		$.ajax({
			type : "post",
			async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "${ctx}/statistics/statNDZSRWWCQK", //请求发送 url
			data : {
				zsnd : zsnd
			},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (result) {
					for ( var i = 0; i < result.length; i++) {
						names.push(result[i].name); //挨个取出类别并填入类别数组
						nums.push(result[i].num1); //挨个取出值并填入值数组
					}
					myChart1.hideLoading(); //隐藏加载动画
					myChart1.setOption({ //加载数据图表
						title : {
							text : zsnd + '年度招生任务完成情况'
						},
						xAxis : {
							data : names
						},
						series : [ {
							// 根据名字对应到相应的系列
							name : '年度招生任务完成情况',
							data : nums,
							 itemStyle: {
                					normal: {
                					 color: function(params) { /* 设置颜色 */
                       					 var colorList = ['#FA4E4E','#4476CA','#BDDB77' ];
                       					 return colorList[params.dataIndex];
                					}
                					}
                					}
						} ]
					});

					//填充列表统计数据 中 年度总任务情况统计
					var jhNum = result[0].num1;
					var djNum = result[1].num1;
					var wcNum = result[2].num1;
					var wcPercent = result[2].num4;
					$("#allJhStat").replaceWith(
							"<tr id='allJhStat'><td colspan='3'>" + zsnd
									+ "年度招生计划</td><td colspan='3'>" + jhNum
									+ "</td><td colspan='3'>" + djNum
									+ "</td><td colspan='2'>" + wcNum
									+ "</td><td colspan='2'>" + wcPercent
									+ "</td></tr>");

				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myChart1.hideLoading();
			}
		});
		var namess = [];//类别数组（实际用来盛放X轴坐标值）
		var nums1 = [];//值数组（用来填充数据）
		var nums2 = [];//值数组（用来填充数据）
		var nums3 = [];//值数组（用来填充数据）
		var array1 = [];//饼状图展示数据（总任务）
		var array2 = [];//饼状图展示数据（总登记）
		var array3 = [];//饼状图展示数据（总完成）
		var htmlOther = "";//表格展示网上招生和学校招生情况
		$.ajax({
			type : "post",
			async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
			url : "${ctx}/statistics/statNDZSJGZSWCQK", //请求发送 url
			data : {
				zsnd : zsnd
			},
			dataType : "json", //返回数据形式为json
			success : function(result) {
				//请求成功时执行该函数内容，result即为服务器返回的json对象
				if (result) {
					for ( var i = 0; i < result.length; i++) {
						namess.push(result[i].name); //挨个取出类别并填入类别数组
						nums1.push(result[i].num1); //挨个取出值并填入值数组
						nums2.push(result[i].num2); //挨个取出值并填入值数组
						nums3.push(result[i].num3); //挨个取出值并填入值数组
						if (i < 2) {
							array1.push([ result[i].name, result[i].num1 ]);
						} else {
							htmlOther += "<tr id='otherStat'><td colspan='3'>"
									+ result[i].name + "</td>" + "<td></td>"
									+ "<td></td>" + "<td></td>" + "<td></td>"
									+ "<td></td>" + "<td></td>" + "<td>"
									+ result[i].num2 + "</td>" + "<td>"
									+ result[i].num3 + "</td>" + "<td></td>"
									+ "<td>" + result[i].num8 + "</td>"
									+ "</tr>";
						}
						array2.push([ result[i].name, result[i].num2 ]);
						array3.push([ result[i].name, result[i].num3 ]);
					}
					myChart2.hideLoading(); //隐藏加载动画
					myChart2.setOption({ //加载数据图表
						title : {
							text : zsnd + '年招生机构招生完成情况'
						},
						xAxis : {
							data : namess
						},
						series : [ {
							name : '招生任务数',
							data : nums1,
							 itemStyle: { /* 设置颜色 */
                					normal: {
                					 color:'#FA4E4E'
                					}
                					}
						}, {
							name : '招生登记数',
							data : nums2,
							 itemStyle: {
                					normal: {
                					 color:'#4476CA'
                					}
                					}
						}, {
							name : '招生完成数',
							data : nums3,
							 itemStyle: {
                					normal: {
                					 color:'#BDDB77'
                					}
                					}
						} ]

					});

					//加载统计表格 中 网上招生和学校招生
					$("tr").remove("#otherStat");
					$("#subtotal").after(htmlOther);
				}

			},
			error : function(errorMsg) {
				//请求失败时执行该函数
				alert("图表请求数据失败!");
				myChart2.hideLoading();
			}
		})
		$('#main3').highcharts({
			chart : {
				type : 'pie'
			},
			title : {
				text : '招生任务',
				style: {
               		fontWeight: 'bold',
               		fontSize: '18px'
           		}
			},
			tooltip : {
				pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions : {
				pie : {
					allowPointSelect : true,
					cursor : 'pointer',
					depth : 35,
					colors:[ /* 设置颜色 */
					'#ED5198',
					'#D08FE1',
					'#0194E1',
					'#8FE0CF'
					],
					dataLabels : {
						enabled : true,
						format : '{point.name}'
					}
				}
			},
			series : [ {
				type : 'pie',
				name : '招生任务数占比',
				data : array1
			} ]
		});
		$('#main4').highcharts({
			chart : {
				type : 'pie',
				options3d : {
					enabled : true,
					alpha : 45,
					beta : 0
				}
			},
			title : {
				text : '招生登记',
				style: {
               		fontWeight: 'bold',
               		fontSize: '18px'
           		}
			},
			tooltip : {
				pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions : {
				pie : {
					allowPointSelect : true,
					cursor : 'pointer',
					depth : 35,
						colors:[ /* 设置颜色 */
					'#ED5198',
					'#D08FE1',
					'#0194E1',
					'#8FE0CF'
					],
					dataLabels : {
						enabled : true,
						format : '{point.name}'
					}
				}
			},
			series : [ {
				type : 'pie',
				name : '招生登记数占比',
				data : array2
			} ]
		});
		$('#main5').highcharts({
			chart : {
				type : 'pie',
				options3d : {
					enabled : true,
					alpha : 45,
					beta : 0
				}
			},
			title : {
				text : '招生完成',
				style: {
               		fontWeight: 'bold',
               		fontSize: '18px'
           		}
			},
			tooltip : {
				pointFormat : '{series.name}: <b>{point.percentage:.1f}%</b>'
			},
			plotOptions : {
				pie : {
					allowPointSelect : true,
					cursor : 'pointer',
					depth : 35,
						colors:[    /* 设置颜色 */
					'#ED5198',
					'#D08FE1',
					'#0194E1',
					'#8FE0CF'
					],
					dataLabels : {
						enabled : true,
						format : '{point.name}'
					}
				}
			},
			series : [ {
				type : 'pie',
				name : '招生完成数占比',
				data : array3
			} ]
		});
		//加载统计表格
		loadTableStat(zsnd);
		//加载完数据后，显示到图表
		//changChart();
	}

	//查询并填充列表统计数据，年度总任务情况数据在图表填充时填充
	function loadTableStat(zsnd) {
		$.ajax({
					type : "post",
					async : false, //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
					url : "${ctx}/statistics/statNDZSRWWCQKTable", //请求发送 url
					data : {
						zsnd : zsnd
					},
					dataType : "json", //返回数据形式为json
					success : function(result) {
						//请求成功时执行该函数内容，result即为服务器返回的json对象
						if (result) {
							var bmResult = result[1];
							var ryResult = result[0];
							var sumJhNum = 0;
							var sumDjNum = 0;
							var sumWcNum = 0;
							var html = "";
							for ( var i = 0; i < bmResult.length; i++) {
								//填充列表统计数据 中 年度部门任务情况统计
								var bmId = bmResult[i].id;
								var bmName = bmResult[i].name;
								var bmJhNum = bmResult[i].num1;
								var bmDjNum = bmResult[i].num2;
								var bmWcNum = bmResult[i].num3;
								var bmWcPercent = bmResult[i].num4;
								var bmWcInAllPercent = bmResult[i].num8;
								var bmType = bmResult[i].num5;
								sumJhNum += bmJhNum;
								sumDjNum += bmDjNum;
								sumWcNum += bmWcNum;
								for ( var j = 0; j < ryResult.length; j++) {
									var ryId = ryResult[j].id;
									var ryName = ryResult[j].name;
									var ryJhNum = ryResult[j].num1;
									var ryDjNum = ryResult[j].num2;
									var ryWcNum = ryResult[j].num3;
									var ryWcPercent = ryResult[j].num4;
									var ryBmId = ryResult[j].id2;
									var ryBmName = ryResult[j].name2;
									if (bmId == ryBmId) {
										if (bmType == 2) {
											html += "<tr id='fjJhStat'><td id='"+zsnd+"'>"
													+ zsnd
													+ "年度招生计划</td>"
													+ "<td id='"+bmType+"'>学校招生部门</td>"
													+ "<td id='"+bmId+"'>"
													+ bmName
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmJhNum
													+ "</td>"
													+ "<td>"
													+ ryName
													+ "</td>"
													+ "<td>"
													+ ryJhNum
													+ "</td>"
													+ "<td>"
													+ ryDjNum
													+ "</td>"
													+ "<td>"
													+ ryWcNum
													+ "</td>"
													+ "<td>"
													+ ryWcPercent
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmDjNum
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcNum
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcPercent
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcInAllPercent
													+ "</td>" + "</tr>";
										} else {
											html += "<tr id='fjJhStat'><td id='"+zsnd+"'>"
													+ zsnd
													+ "年度招生计划</td>"
													+ "<td id='"+bmType+"'>代理机构</td>"
													+ "<td id='"+bmId+"'>"
													+ bmName
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmJhNum
													+ "</td>"
													+ "<td>"
													+ ryName
													+ "</td>"
													+ "<td>"
													+ ryJhNum
													+ "</td>"
													+ "<td>"
													+ ryDjNum
													+ "</td>"
													+ "<td>"
													+ ryWcNum
													+ "</td>"
													+ "<td>"
													+ ryWcPercent
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmDjNum
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcNum
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcPercent
													+ "</td>"
													+ "<td id='"+bmId+"'>"
													+ bmWcInAllPercent
													+ "</td>" + "</tr>";
										}
									}
								}

							}
							$("tr").remove("#fjJhStat");
							$("#hiddenTable").empty();
							//将数据添加到隐藏table中
							$("#hiddenTable").append(html);
							//合并隐藏table中相同id的单元格
							$("#hiddenTable").rowspan(0);
							$("#hiddenTable").rowspan(1);
							$("#hiddenTable").rowspan(2);
							$("#hiddenTable").rowspan(3);
							$("#hiddenTable").rowspan(9);
							$("#hiddenTable").rowspan(10);
							$("#hiddenTable").rowspan(11);
							$("#hiddenTable").rowspan(12);
							//将合并后的单元格加到原表格相应位置
							$("#fjJhStatHead").after($("tr[id='fjJhStat']"));
							//加载小计行
							$("#subtotal").replaceWith(
									"<tr id='subtotal'><td colspan='3'>小计</td>"
											+ "<td>" + sumJhNum + "</td>"
											+ "<td></td>" + "<td></td>"
											+ "<td></td>" + "<td></td>"
											+ "<td></td>" + "<td>" + sumDjNum
											+ "</td>" + "<td>" + sumWcNum
											+ "</td>" + "<td></td>"
											+ "<td></td>" + "</tr>");

						}

					},
					error : function(errorMsg) {
						//请求失败时执行该函数
						alert("图表请求数据失败!");
					}
				});
	}

	/* function changChart() {
		$("#chartStat").show();
		$("#listStat").hide();
		$("#chartButton").attr("disabled", "disabled");
		$("#tableButton").removeAttr("disabled");
	}
	function changTable() {
		$("#listStat").show();
		$("#chartStat").hide();
		$("#tableButton").attr("disabled", "disabled");
		$("#chartButton").removeAttr("disabled");
	} */
	//页面加载完后调用ajax加载图表
	$(function() {
		var zsnd = $("#zsnd").val();
		loadStat(zsnd);
	});
	//查询按钮点击事件
	function statButton() {
		var zsnd = $("#zsnd").val();
		loadStat(zsnd);
	}
	
	/*统计结果导出excl*/
	function statExport(){
		var zsnd = $("#zsnd").val();
		window.location.href = "${ctx}/statistics/expStatNDZSJGZSWCQK?zsnd="+zsnd;
	}
</script>
</head>
<body>
		<form action="#" class="breadcrumb form-search">
			<div class="cxtj">查询条件</div>
			<table class="ul-form">
				 <tr>
	       			<th style="width:50%;font-size: 14px;">招生年度</th>
	       			<td style="width:50%;text-align: left;" >
					<select id="zsnd" class="input-medium"  style="width:175px; height:28px; margin-bottom:0; ">
					<c:forEach items="${zsndList}" var="zsnd" varStatus="status">
					<c:if test="${status.index}==0">
						<option value="${zsnd.zsnd}" selected="selected">${zsnd.zsnd}</option>
					</c:if>
					<option value="${zsnd.zsnd}">${zsnd.zsnd}</option>
					</c:forEach>
					</select> 
					</td>
				</tr>
				<tr align="center">
					<td class="btns" colspan="2">
						<input type="button"  class="btn btn-primary" onclick="statButton()"
					value="查询" />
					<input type="button" class="btn btn-primary" onclick="statExport()" value="导出" />
					</td>
				</tr>		
			</table>			
	<div class="cxjg">查询结果</div>
	<div class="easyui-tabs" style="">
		<div title="图形" style="padding:20px;min-width:100px;">
			<div id="chartStat">
				<div>
					<div id="main1" style="width: 50%;height:300px;float:left;">
						<script type="text/javascript">
							// 基于准备好的dom，初始化echarts实例
							var myChart1 = echarts.init(document
									.getElementById('main1'));
							// 指定图表的配置项和数据
							var option1 = {
								title : {
									text : '2017年度招生任务完成情况',
									left : 'center'
								},
								tooltip : {},
								legend : {},
								xAxis : {
									data : []
								},
								yAxis : {},
								series : [ {
									name : '年度招生任务完成情况',
									type : 'bar',
									data : []
								} ]
							};

							// 使用刚指定的配置项和数据显示图表。
							myChart1.setOption(option1);
						</script>
					</div>
					<div id="main2" style="width: 50%;height:300px;float:left;">
						<script type="text/javascript">
							// 基于准备好的dom，初始化echarts实例
							var myChart2 = echarts.init(document
									.getElementById('main2'));
							// 指定图表的配置项和数据
							var option2 = {
								title : {
									text : '2017年招生机构招生完成情况',
									left : 'center'
								},
								tooltip : {
									trigger : 'axis',
									axisPointer : { // 坐标轴指示器，坐标轴触发有效
										type : 'shadow' // 默认为直线，可选为：'line' | 'shadow'
									}
								},
								legend : {
									data : [ '招生任务数', '招生登记数', '招生完成数' ],
									top : 'bottom',//图例组件离容器上侧的距离
									left : 'center',//图例组件离容器左侧的距离
									itemWidth : 14
								//图例标记的图形宽度
								},
								grid : {
									bottom : '10%',
									containLabel : true
								},
								xAxis : [ {
									type : 'category',
									data : []
								} ],
								yAxis : [ {
									type : 'value'
								} ],
								series : [ {
									name : '招生任务数',
									type : 'bar',
									data : []
								}, {
									name : '招生登记数',
									type : 'bar',
									data : []
								}, {
									name : '招生完成数',
									type : 'bar',
									data : []
								} ]
							};

							// 使用刚指定的配置项和数据显示图表。
							myChart2.setOption(option2);
						</script>
					</div>
				</div>
				<div>
					<div id="main3" style="width: 33%;height:300px;float:left;"></div>
					<div id="main4" style="width: 33%;height:300px;float:left;"></div>
					<div id="main5" style="width: 33%;height:300px;float:left;"></div>
				</div>
			</div>
		</div>
		<div title="列表" style="overflow:auto;padding:20px;width:100px;">
			<div id="listStat">
				<table id="statTable" cellspacing="0"
					style="width: 100%;height: 100%;margin-bottom: 30px">
					<tr id="allJhStatHead">
						<td colspan="3">年度招生计划</td>
						<td colspan="3">招生总任务数</td>
						<td colspan="3">招生总登记数</td>
						<td colspan="2">招生总完成数</td>
						<td colspan="2">招生总完成率</td>
					</tr>
					<tr id="allJhStat"></tr>
					<tr id="fjJhStatHead">
						<td>年度招生计划</td>
						<td colspan="2">招生机构</td>
						<td>招生机构任务数</td>
						<td>招生人员姓名</td>
						<td>个人招生任务数</td>
						<td>个人招生登记数</td>
						<td>个人招生完成数</td>
						<td>个人招生完成率</td>
						<td>招生机构登记数</td>
						<td>招生机构完成数</td>
						<td>招生机构完成率</td>
						<td>占总招生任务数比率</td>
					</tr>
					<tr id="fjJhStat"></tr>
					<tr id="subtotal"></tr>
					<tr id="otherStat"></tr>
				</table>
			</div>
		</div>
	</div>
	<table id="hiddenTable"></table>
</body>
</html>

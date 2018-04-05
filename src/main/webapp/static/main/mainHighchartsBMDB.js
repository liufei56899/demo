function viewZstjbmDbInfo(data2) {
	$("#content_botton_zszytj_bm .content_db")
			.highcharts(
					{
						chart : {
							type : 'column'
						},
						title : {
							text : ''
						},
						credits : {
							enabled : false
						},
						subtitle : {
							text : "",//部门招生任务完成统计
							useHTML : true
						},
						xAxis : {
							categories : data2.bm
						},
						yAxis : {
							title : {
								text : ''
							}
						},
						tooltip : {
							headerFormat : "<span style='font-size:10px'>{point.key}</span><table>",
							pointFormat : "<tr><td style='color:{series.color};padding:0'>{series.name}: </td>"
									+ "<td style='padding:0'><b>{point.y:.1f} 个 </b></td></tr>",
							footerFormat : "</table>",
							shared : true,
							useHTML : true
						},
						plotOptions : {
							column : {
								pointPadding : 0.2,
								borderWidth : 0,
								pointWidth : 15
							}
						},
						legend : {
							enabled : false
						},
						series : [ {
							name : '计划任务',
							data : data2.dateJh,
							color : '#6495ED',
							dataLabels : {
								enabled : true,
								rotation : 0,
								color : '#000',
								align : 'right',
								style : {
									fontSize : '13px',
								}
							}
						}, {
							name : '招生完成',
							data : data2.dateSj,
							color : '#B22222',
							dataLabels : {
								enabled : true,
								rotation : 0,
								color : '#000',
								align : 'right',
								style : {
									fontSize : '13px',
								}
							}
						} ]
					});
}

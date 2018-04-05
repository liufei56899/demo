
/** ********招生专业统计******************** */
function viewBmZstjInfo(data2) {
	$("#content_botton_zszytj .content")
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
							useHTML : true
						},
						xAxis : {
							categories : data2.dateN
						},
						yAxis : {
							title : {
								text : ''
							}
						},
						tooltip : {
							headerFormat : '<span style="font-size:10px">{point.key}</span><table>',
							pointFormat : '<tr><td style="color:{series.color};padding:0">{series.name}: </td>'
									+ '<td style="padding:0"><b>{point.y:.1f} 个</b></td></tr>',
							footerFormat : '</table>',
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
							name : "招生登记",
							data : data2.num,
							color : '#dd5600',
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


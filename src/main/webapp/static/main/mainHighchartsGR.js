/** ********显示招生统计/个人信息******************** */
function viewZstjInfo(data2) {
	if (data2.length == 0) {
		$("#zstjgr_info").html("<p style='margin-left:15px;margin-top:15px;'>没有招生信息</p>");
	} else {
		$("#zstjgr_info").highcharts({
			title : {
				text : ''
			},
			credits : {
				enabled : false
			},
			plotOptions : {
				pie : {
					allowPointSelect : false,
					cursor : 'pointer',
					dataLabels : {
						enabled : false
					}
				}
			},
			series : [ {
				type : 'pie',
				name : '人数',
				data : data2
			} ]
		});
	}
}
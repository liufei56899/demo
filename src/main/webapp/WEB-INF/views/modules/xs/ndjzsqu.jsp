<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<title>年度间招生区域分布情况</title>
<link rel="stylesheet" type="text/css"
	href="${ctxMap_static}/css/main.css">
<script type="text/javascript" src="${ctxMap_static}/js/echarts.min.js"
	charset="UTF-8"></script>
<script type="text/javascript" src="${ctxMap_static}/js/citymap.js"
	charset="UTF-8"></script>
	<script type="text/javascript" src="${ctxStatic}/js/jquery-ui-jqLoding.js"></script>
	
<style type="text/css">
table,tr,td {
	border: 1px solid #ddd;
	height : 30px;
	font-size :14px;
	text-align: center;
}

.left {
	width: 100%;
	position: absolute;
	margin-left: 0.5%
}
#th td
{
	height : 30px;
	font-size :16px;
}
.right {
/* 	width: 55%; */
	width: 100%;
	position: relative;
	/* margin-left: 61%; */
}

.d_table {
	/* width: 70% */
	width: 100%;
}

textarea {
	width: 60%
}
#tabledq{
width: 100%;
}
a {
	text-decoration: none;
}

.ZSND {
	height: 45px;
	line-height: 45px;
	font-size: 16px;
	border: 1px solid #ddd;
	padding-left: 50px;
}
.select2-choices{
width: 220px;
border-radius:4px;
}
  .select2-search-choice{
	  	border:none !important;
	  	background: none !important;
	  	padding: 0 !important;
	  	line-height: 26px !important;
	  	padding-left: 15px !important;
	  }
	  .form-search .ul-form li{
	  height: 0;
	  }
	  #th>th,.tr_a>td{
	   text-align: center;
	  }
	  
</style>
</head>
<body>

	<div class="left" style="display: none">
		<div id="main" style="width: 60%;height:600px;"></div>
		<script type="text/javascript" src="${ctxMap_static}/js/app.js" charset="UTF-8"></script>


		<div>
			<br>
			<table cellspacing="0" style="width: 60%;height: 20%;">
				<tr id="ztr">
				    <td>年度</td>
					<td>计划任务总数</td>
					<td>计划登记总数</td>
					<td>计划完成总数</td>
					<td>计划完成率</td>
				</tr>
<c:forEach var="zz" items="${zarea}">
				<tr  class="tr_a">
				    <td id="z0">${zz.zsnd }</td>
					<td id="z1">${zz.num5 }</td>
					<td id="z2">${zz.num6 }</td>
					<td id="z3">${zz.num7 }</td>
					<td id="z4">${zz.num8 }</td>
				</tr>
</c:forEach>
			</table>
		</div>


		<div>
			<br>
		<textarea cols="100%" rows="8%" readonly="readonly" style="resize: none;">
				统计指标说明：
				省、直辖市、自治州、特别行政区：中国地域省、直辖市、自治州、特别行政区名称；
				招生任务数：审核通过的计划招生数；
				招生登记数：登记的学生数；
				招生完成数：已缴费的招生登记学生数；
				招生完成率：招生完成数÷招生任务数的百分比
        
        </textarea>
		</div>
	</div>



	
			<form action="#"  method="post" class="breadcrumb form-search">
			<div class="cxtj">查询条件</div>
		<table class="ul-form">
		<tr>
		<th style="width:50%;font-size:14px;font-family: ''微软雅黑 ">招生年度</th>
		<td style="width:50%; text-align: left;">
				<select id="zsnd" multiple="multiple" name="zsnd"
					class="selectpicker show-tick form-control">
					<c:forEach var="jh" items="${jh }">
						<option value="${jh.zsnd}"
							<c:if test="${fn:contains(nd, jh.zsnd)}">
							selected="selected"</c:if>>${jh.zsnd}</option>
					</c:forEach>
				</select> 
				</td>
				</tr>
				<tr>
				<td colspan="4" style="text-align: center;">
					<input type="button" class="btn btn-primary"  
					onclick="seach(1,'china')" value="查询">
				<input type="button" class="btn btn-primary"
				onclick="report()" value="导出" style="margin-left: 5px;">	
				</td>
				</tr>
				</table>
			</form>
		
		
		
	<div class="cxjg">查询结果</div>

	<div class="easyui-tabs" style="">
		
		<!-- 全国省市列表 -->
			<table id="tabledq" cellspacing="0" class="table table-striped table-bordered table-condensed">
			<thead>
				<tr id="th">
					<th>省、直辖市、自治州、特别行政区</th>
					<th>招生年度</th>
					<th>招生任务数</th>
					<th>招生登记数</th>
					<th>招生完成数</th>
					<th>招生完成率</th>
				</tr>
           </thead>
<tbody>
				<c:forEach var="area" items="${area }">
					<tr class="tr_a">
						<td onclick="seach(${area.id },'${area.name }')" id="td_a" width="280px"><a
							href="#">${area.name }</a>
						</td>
						<td>${area.zsnd }</td>
						<td>${area.num1 }</td>
						<td>${area.num2 }</td>
						<td>${area.num3 }</td>
						<td>${area.num4 }</td>

					</tr>
				</c:forEach>
</tbody>
			</table>
	</div>
	
	
	<script type="text/javascript">
	       var ids;
             function seach(id,name){
             ids=id;
               var nd=$("#zsnd").val();
               if(nd.length>1){
               $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/getByAreas?zsnd="+nd,
				        data: {id:id},
				        dataType:'json',
				        async:false,
						success: function(result){
						if(result[0].length>0){
						$("tr").remove(".tr_a");
						var rr=result[0];
						for(var i=0;i<rr.length;i++){
						var r=rr[i];
						$("#th").after(
						'<tr class="tr_a">'+
           '<td onclick="seach('+r.id+',\''+r.name+'\')" id="td_a">'+'<a href="#">'+r.name+'</a>'+'</td>'+
           '<td>'+r.zsnd+'</td>'+
           '<td>'+r.num1+'</td>'+
           '<td>'+r.num2+'</td>'+
           '<td>'+r.num3+'</td>'+
           '<td>'+r.num4+'</td>'+
          ' </tr>');
         
						}
						$("#tabledq").rowspan(0);
						}else{
						renderMap('china',mapdata);//重新返回全国地图
						seach(1);//列表返回到所有省
						}
						
			  }
		});
               }else{
                alert("招生年度至少选择2个年度！");
               }
             }
             
             /* 导出 */
          function report(){
               $.fn.jqLoading({backgroundImage: "${ctxStatic}/js/loading.gif",
               			height: 100, width: 240, text: "正在加载中，请耐心等待...." });
          		var zsnd = $("#zsnd").val();
          		if(ids==undefined||ids==null||ids==""){
          		ids=1;
          		}
				 window.location.href = "${ctx}/statistics/exportRes?zsnd="+zsnd+"&id="+ids;
               zz();
             }
             
             function zz(){
              $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/exportSuccess",
				        dataType:'json',
				        async:true,
						success: function(result){
							if(result=="1"||result==1){
						 		$.fn.jqLoading("destroy");
						}else{
								zz();
						}
						}
						});
             }
  </script>
	<script type="text/javascript">
	 jQuery.fn.rowspan = function(colIdx) { //封装的一个JQuery小插件，合并相同id的td行
	        return this.each(function(){
	            var that;
	            $('tr', this).each(function(row) {
	                $('td:eq('+colIdx+')', this).filter(':visible').each(function(col) {
	                    if (that!=null && $(this).text() == $(that).text()) {
	                        rowspan = $(that).attr("rowSpan");
	                        if (rowspan == undefined) {
	                            $(that).attr("rowSpan",1);
	                            rowspan = $(that).attr("rowSpan"); 
	                        }
	                        rowspan = Number(rowspan)+1;
	                        $(that).attr("rowSpan",rowspan);
	                        $(this).hide();
	                    } else {
	                        that = this;
	                    }
	                });
	            });
	        });
    }
	
		$(document).ready(function() {
					$("#tabledq").rowspan(0);
					  $("#zsnd").select2({
					         	allowClear: true,
						        newYearId: true,
						        maximumSelectionSize:3
						    });
		});
	</script>

	<br>
	<br>
</body>
</html>
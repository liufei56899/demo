<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ include file="/WEB-INF/views/include/head.jsp"%>
<html>
<head>
<title>年度招生区域分布情况</title>
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

#th td
{
	height : 30px;
	font-size :16px;
}

.left {
	width: 100%;
	position: absolute;
	margin-left: 0.5%
}

.right {
	width: 55%;
	position: relative;
	margin-left: 61%;
}

.d_table {
	width: 70%
}

textarea {
	width: 60%
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
  .select2-search-choice{
	  	border:none !important;
	  	background: none !important;
	  	padding: 0 !important;
	  	line-height: 26px !important;
	  	padding-left: 15px !important;
	  }
</style>
</head>
<body>
	<div class="left">
		<div id="main" style="width: 60%;height:600px;"></div>
		<script type="text/javascript" src="${ctxMap_static}/js/app.js" charset="UTF-8"></script>


		<div>
			<br>
			<table cellspacing="0" style="width: 60%;height: 20%;">
				<tr>
					<td>计划任务总数</td>
					<td>计划登记总数</td>
					<td>计划完成总数</td>
					<td>计划完成率</td>
				</tr>

				<tr>
					<td id="z1">${zarea.num5 }</td>
					<td id="z2">${zarea.num6 }</td>
					<td id="z3">${zarea.num7 }</td>
					<td id="z4">${zarea.num8 }</td>
				</tr>

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



	<div class="right">
		<div class="ZSND">
			<form action="#"  method="post">
				<span style="display:inline-block; width: 80px ; text-align: center;">招生年度：</span>
				<select id="zsnd" onchange="seach(1,'china')" 
				style="margin-left:5px;margin-top: 7px;margin-bottom:8px;width: 220px">
					 <c:forEach var="jh" items="${jh }">
						<!--  遍历所有的招生计划 -->
						<c:if test="${status.index}==0">
							<option value="${jh.zsnd}" selected="selected">${jh.zsnd}</option>
						</c:if>
						<option value="${jh.zsnd}">${jh.zsnd }</option>
					</c:forEach> 
				</select>
				<input type="button" class="btn btn-primary"
				onclick="report()" value="导出" style="margin-left: 5px;">	
			</form>
		</div>
		<!-- 全国省市列表 -->
		<div class="d_table">
			<table cellspacing="0">
				<tr id="th">
					<td>省、直辖市、自治州、特别行政区</td>
					<td>招生任务数</td>
					<td>招生登记数</td>
					<td>招生完成数</td>
					<td>招生完成率</td>
				</tr>


				<c:forEach var="area" items="${area }">
					<tr class="tr_a">
						<td onclick="seach(${area.id },'${area.name }')" id="td_a"><a
							href="#">${area.name }</a>
						</td>
						<td>${area.num1 }</td>
						<td>${area.num2 }</td>
						<td>${area.num3 }</td>
						<td>${area.num4 }</td>
					</tr>
				</c:forEach>

			</table>
		</div>
	</div>
	<script type="text/javascript">
	         var ids;
             function seach(id,name){
             	ids=id;
             	if( name in provinces ){
		//如果点击的是34个省、市、自治区，绘制选中地区的二级地图
		$.getJSON('/em/map_static/map/province/'+ id +'.json', function(data){
			echarts.registerMap( name, data);
			var d = [];
			for( var i=0;i<data.features.length;i++ ){
				d.push({
					name:data.features[i].properties.name
				})
			}
			renderMap(name,d);
		});
	}else if( name in cityMap ){
			//显示县级地图
			$.getJSON('/em/map_static/map/city/'+ id +'.json', function(data){
				echarts.registerMap( name, data);
				var d = [];
				for( var i=0;i<data.features.length;i++ ){
					d.push({
						name:data.features[i].properties.name
					})
				}
				renderMap(name,d);
			});	
	}else{
		renderMap('china',mapdata);
	};
	     $("#zsnd").attr("selected",true);
	     var nd=$("#zsnd").val();
               $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/getByArea",
				        data: {id:id,zsnd:nd},
				        dataType:'json',
				        async:false,
						success: function(result){
						if(result.length>0){
						$("tr").remove(".tr_a");
						for(var i=0;i<result.length;i++){
						var r=result[i];
						$("#th").after('<tr class="tr_a">'+
           '<td onclick="seach('+r.id+',\''+r.name+'\')" id="td_a">'+'<a href="#">'+r.name+'</a>'+'</td>'+
           '<td>'+r.num1+'</td>'+
           '<td>'+r.num2+'</td>'+
           '<td>'+r.num3+'</td>'+
           '<td>'+r.num4+'</td>'+
          ' </tr>');
						}
				   			seachZJ(id,nd);
						}else{
							renderMap('china',mapdata);//重新返回全国地图
							seach(1);//列表返回到所有省
				   			seachZJ(1,nd);
						}
					   }
				    });
             }
             
             function seachZJ(id,nd) {
				 $.ajax({
				        type: "POST",
				        url: "${ctx}/statistics/getByZstj",
				        data: {id:id,zsnd:nd},
				        dataType:'json',
				        async:false,
						success: function(result){
						 if(result!=null){
						 $("#z1").text(result.zj.num5);
						 $("#z2").text(result.zj.num6);
						 $("#z3").text(result.zj.num7);
						 $("#z4").text(result.zj.num8);
						 }
					   }
				    });
			}
             
             /* 导出 */
          function report(){
           $("#zsnd").attr("selected",true);
	       var nd=$("#zsnd").val();
            $.fn.jqLoading({backgroundImage: "${ctxStatic}/js/loading.gif",
                			height: 100, width: 240, text: "正在加载中，请耐心等待...." });
				if(ids==undefined||ids==null||ids==""){
          		ids=1;
          		}
				 window.location.href = "${ctx}/statistics/exportRes?zsnd="+nd+"&id="+ids;
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


	<br>
	<br>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域编码查询</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
<script type="text/javascript">
	  function byCS1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#cs1").empty();
			$("#qx1").empty();
			$("#jd1").empty();
			$("#cs1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#qx1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#jd1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#cs1").select2("destroy");
					$("#cs1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
											
				}
											$("#code").text(val);
			}
		});
	}
	function byQX1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
			$("#qx1").empty();
			$("#jd1").empty();
			$("#qx1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
			$("#jd1").append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#qx1").select2("destroy");
					$("#qx1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
				$("#code").text(val);
			}
		});
	}
	function byXZ1(val) {
		$.ajax({
			type : "POST",
			url : "${ctx}/statistics/ByAreas",
			data : {
				id : val
			},
			dataType : 'json',
			async : false,
			success : function(result) {
				$("#jd1").empty();
					$("#jd1")
							.append(
									"<option value='"+"'>" + "请选择"
											+ "</option> ").select2();
				for ( var i = 0; i < result.length; i++) {
					var r = result[i];
					$("#jd1").select2("destroy");
					$("#jd1")
							.append(
									"<option value='"+r.id+"'>" + r.name
											+ "</option> ").select2();
				}
				$("#code").text(val);
			}
		});
	}
	function byJD(val){
		$("#code").text(val);
	}
</script>
</head>
<body>
	<form:form id="sea" modelAttribute="area" action="#" method="post" class="breadcrumb form-search">
		<div class="cxtj"></div>
			<table class="ul-form">
				<tr>
					<td  style="text-align: center;">
					请选择地区：
						<form:select path="id" id="sf1" class="input-xlarge  required" style="width:10%;" onchange="byCS1(this.value)" >
						<form:option value="" label="请选择省"/>
						<form:options items="${fns:findBySF()}" itemLabel="name" itemValue="id" htmlEscape="false"/>
					</form:select>
						<form:select path="id" class="input-xlarge  required"  style="width:10%;" id="cs1" onchange="byQX1(this.value)" >
						<form:option value="" label="请选择市"/>
					</form:select>
					    <form:select path="id" class="input-xlarge  required"  style="width:10%;" id="qx1"  onchange="byXZ1(this.value)" >
						<form:option value="" label="请选择县"/>
					</form:select>
						<form:select path="id" class="input-xlarge  required"   style="width:10%;"  id="jd1" onchange="byJD(this.value)">
						<form:option value="" label="请选择乡"/>
					</form:select>
					</td>
				</tr>
			
			
				<tr>
					<td style="text-align: center;">
					行政区划码：<span id="code"   style="color: red"></span>
					</td>
				</tr>
			</table>
		
	</form:form>
</body>
</html>
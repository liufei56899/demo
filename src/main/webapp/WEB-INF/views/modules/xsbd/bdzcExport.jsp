<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>教师信息管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<style>
		.form-horizontal .control-label{
			text-align: left;
			padding-left:20px;
		}
	</style>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		
		function exportClick()
		{
			var checkType = "";
			$('input[name="checkType1"]:checked').each(function(){ 
				checkType +=$(this).val()+","; 
			});
			if(checkType!=null && checkType!="")
			{
				checkType =  checkType.substring(0, checkType.length-1);
				$("#checkType").val(checkType);
				jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/zsdj/zsdj/exportBdzcByCol",
		        data: $("#searchForm").serialize(),
		        dataType:'json',
		        async:false,
				success: function(data){
						updateFile(data);
				   }
			    });
			}
		}
		
		//下载
	function updateFile(filePath)
	{
		 window.location.href='${ctx}/zsdj/zsdj/updateFile?filePath='+filePath;
		 closeDialog();
	}
		
	//全部选中	
	function selectAll(checkbox) {
        $('input[name="checkType1"]').prop('checked', $(checkbox).prop('checked'));
    }

	</script>

	<br/>
	<form:form id="exportForm" modelAttribute="zsdj" action="${ctx}/zsdj/zsdj/exportBdzcByCol" method="post" class="form-horizontal" enctype="multipart/form-data">
		<div class="control-group">	
		<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" id="all" onclick="selectAll(this);"/>全选
				</label>
		</div>
		</div>
		<div class="control-group">
		<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="1" name="checkType1" />学生姓名
				</label>
			<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="2" name="checkType1" />性别
				</label>
			</div>
		</div>
		
		<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="3" name="checkType1" />身份证件号码
				</label>
			<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="6" name="checkType1" />出生日期
				</label>
			</div>
		</div>
		</div>
		
		<div class="control-group">
		<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="4" name="checkType1" />专业类别
				</label>
			<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="5" name="checkType1" />专业名称
				</label>
			</div>
		</div>
		<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="7" name="checkType1" />家庭住址
				</label>
			<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="8" name="checkType1" />报到状态
				</label>
			</div>
		</div>
		</div>
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="9" name="checkType1" />创建时间
				</label>
				<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="10" name="checkType1" />学生类别
				</label>
			</div>
			</div>
			<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="11" name="checkType1" />毕业学校
				</label>
				<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="12" name="checkType1" />准考证号
				</label>
			</div>	
		</div>
		</div>
		
		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="13" name="checkType1" />招生老师
				</label>
				<div class="lg-form" style="border-right:none;">
				<label class="control-label">
					<input type="checkbox" value="14" name="checkType1" />学制
				</label>
			</div>
			</div>
			<div class="lg-form">
				<label class="control-label">
					<input type="checkbox" value="15" name="checkType1" />备注
				</label>
			</div>
		</div>
		
		
		<div class="form-actions">
		
			<input id="btnSubmit" class="btn btn-primary" type="button" onclick="exportClick();" value="导出"/>&nbsp;
			
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
	
</body>
</html>
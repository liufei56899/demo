<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<meta name="decorator" content="default" />
</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
      $(document).ready(function() {
	   });
	   
	  //导入数据时，计划名称不能为空
	  function importFile()
	  {
	  	jQuery.ajax({
	        type: "POST",
	        url: "${ctx}/xs/xsJbxx/importXjInfo",
	        data: new FormData($('#importForm')[0]),
	        dataType:'json',
	        async:false,
	        processData: false,
    		contentType: false,
			success: function(data){
			 if(data.istrue)
			 {
			 	$("#errorMgs").html("");
			 	alertx("导入成功！");
			 	closeDialog();
			 	$("#urlForm").submit();	
			 }else
			 {
			 	$("#errorMgs").html(data.failureMsg);	
			 }
		   }
		});
	  }
</script>
    <label id="tip" style="color: red;"></label>
	<form:form id="importForm" action="${ctx}/xs/xsJbxx/importXjInfo" method="post"
		       enctype="multipart/form-data" class="form-search" modelAttribute="zsdj"
		       style="padding:20px;"> 
		  <div class="control-group">
			<label class="control-label">选择文件：</label>
			<div class="controls">
				<input id="uploadFile" name="file" type="file" style="width:230px"/><br/><br/>　
			</div>
		</div>
		<div id="errorMgs" style="font-size: 14px;">
			
		
		</div>
		  <div class="option_">
		     <input id="btnImportSubmit" class="btn btn-primary" type="button" onclick="importFile();" value="导 入 " /> 
		     <input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		  </div>     
	</form:form>
	
	<form action="${ctx}/xs/xsJbxx/exportSucessPage" method="post" id="urlForm"></form>

</body>
</html>
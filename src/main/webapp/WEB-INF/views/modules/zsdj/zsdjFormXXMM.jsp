<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>招生登记管理</title>
<meta name="decorator" content="default" />

</head>
<body>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
      $(document).ready(function() {
        /*  $("#tip").text("${tip}");
         $("#btnExport").click(
				  function() {
				    cleanTip(); //清除提示信息
				    top.$.jBox.confirm("确认要导出用户数据吗？", "系统提示", 
				    function(v, h, f) {
					  if (v == "ok") {
						$("#importForm").attr("action","${ctx}/zsdj/zsdj/exportFile");
						$("#importForm").submit();
					  }
					$("#importForm").attr("action","${ctx}/zsdj/zsdj/importfileTest");
		 }, {buttonsFocus : 1});
		 top.$('.jbox-body .jbox-icon').css('top', '55px');}); */
	   });
	   //清除提示信息
	  function cleanTip(){
	     $("#tip").text("");
	  }
	  
	  //导入数据时，计划名称不能为空
	  function importFile(){
	  	var jhmc=$("#jhID").val();
	  	if(jhmc!=null && jhmc!=""){
	  		//	$("#importForm").submit();
	  		jQuery.ajax({
		        type: "POST",
		        url: "${ctx}/zsdj/zsdj/importfileTest",
		        data: new FormData($('#importForm1')[0]),
		        dataType:'json',
		        async:false,
		        processData: false,
	    		contentType: false,
				success: function(data){
				console.log(data);
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
	  	}else{
	  		alertx("导入数据时计划名称不能为空！");
	  	}
	  }
</script>
    <label id="tip" style="color: red;"></label>
	<form:form id="importForm1" action="${ctx}/zsdj/zsdj/importfileTest" method="post"
		       enctype="multipart/form-data" class="form-search" modelAttribute="zsdj"
		       style="padding:20px;"> 
		      <input id="ly " type="hidden" value="${lyxx}" name="ly"/>
		  <table border="1" class="wsbm" style="border-color: #D6D6D6;">
		      <tr>
		         <td style="text-align: center; padding:10px 0"><label>计划名称:</label></td>
		      <td colspan="2">
		        <form:select path="zsjh.id" id="jhID" class="input-medium required">
				   <form:option value="" label="" />
				   <form:options items="${fns:findZsjhListByUserId()}" itemLabel="jhmc"
						      itemValue="id" htmlEscape="false" />
		          </form:select>
		        </td>
		      </tr>
		      <tr>
		         <td style="text-align: center;"><label>导入文件:</label></td>
		         <td colspan="2"><input id="uploadFile" name="file" type="file" style="width:330px" /></td>
		      </tr>
		  </table>
		<div id="errorMgs" style="font-size: 14px;">
		</div>
		  <div class="option_">
		     <input id="btnImportSubmit" class="btn btn-primary" type="button" onclick="importFile();" value="导 入 " />
		     <%-- 
		     <input id="btnExport" class="btn btn-primary" type="button" value="导出" />
		     --%><a href="${ctx}/zsdj/zsdj/import/template/3" onclick="cleanTip()">下载模板</a>
		  </div>     
	</form:form>
	<form id="urlForm"  action="${ctx}/zsdj/zsdj/importSuccess" method="post">
		<input id="ly " type="hidden" value="${lyxx}" name="ly"/>
	</form>

</body>
</html>
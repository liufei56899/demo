<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>招生计划编辑/查看</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp" %>
</head>
<body>
<link rel="Stylesheet" href="${ctxStatic}/jerichotab/css/jquery.jerichotab.css" />
<script type="text/javascript" src="${ctxStatic}/jerichotab/js/jquery.jerichotab.js"></script>
<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
<script type="text/javascript">
	    var rows = 0;
		$(document).ready(function() {
			$("#inputForm1").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
			var jh_id = $("#id").val();
			if(jh_id !=null && jh_id !="" ){
			   var zt = "${zsjh.zt}";
			   if(zt!=null && zt!="" && zt>2){
				 startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInitDisplay");
			   }else{
			     startInit(jh_id,"${ctx}/zsjh/zsjh/findZyJhInit");
			   }
			} else{
			  rows=1;
			}
			
			
			//去掉删除操作 
			 $("#bmTable1").find("tr").each(function(i)
			{
				var tdNum = $(this).find("td").size();
				if(tdNum>4)
				{
					$(this).find("td :last").remove();
				}
			});
			
		});
		
	    function startInit(jh_id,url){
	     /*  $.getJSON(url,{id:jh_id,rows:1,viewmodel:0},function(result){
	              $("#bmTable1").append(result.html);
		     	  var r = document.getElementById("bmTable1") ;
		     	  rows = r.rows.length;
		     	  if(rows>1){
		     	    for(var i=1;i<rows;i++){
		     	       selectAddStyle("zylx"+i);
		       		   selectAddStyle("zy"+i);
		     	    }
		     	  }
		  	   }); */
		  	   
		  jQuery.ajax({
			        type: "POST",
			        url: url,
			        data: {id:jh_id,rows:1,viewmodel:0},
			        dataType:'json',
			        async:false,
					success: function(result){
						 $("#bmTable1").append(result.html);
				     	 // var r = document.getElementById("bmTable1") ;
				     	 // rows = r.rows.length;
				   }
			    });   
		  	
		  	   
	    }
	//修改页面信息状态
	var viewmodel = "${zsjh.viewModel}";
    if (viewmodel == "view") {
		$("#zybiaoti").css("display", "none");
		$("#option").css("display", "none");
		$("#btnSubmitBc").css("display", "none");
	}
</script>
	<div style="margin-left: 50px;height: 29px;">
	<c:if test="${zsjh.zt eq '2'}">
	    <script type="text/javascript">
	    	var jericho = {
					buildTabpanel : function() {
						$.fn.initJerichoTab({
							renderTo : "#divRight1",
							uniqueId : "myJerichoTab",
							contentCss : {"height" : $("#divRight1").height()},
							tabs : []
						});
					}
			};
	        $().ready(function() {
				            $('#divRight1').css({width : 1060, height : 500});
							jericho.buildTabpanel();
							$.fn.jerichoTab.addTab({
							    title : "计划名称",
								closeable : false,
								data : {
									dataType : "formtag",
									dataLink : "#tbNews"
								}
							}).loadData(true);
							var jh_id = $("#id").val();
							//显示历史记录信息
							$.getJSON("${ctx}/zsjh/zsjhrecord/zsjhrecordlist",{rid : jh_id},function(result) {
							            var div = $("#selection_title1");
										var option = "<select id='jhlis' onchange=\"addtab(this.value)\" style='width:200px;'><option value='' ></option>";
										for ( var i = 0; i < result.length; i++) {
												option += "<option value=\""+result[i].id+"-"+result[i].cid+"\">"
																	+ result[i].cid
																	+ "</option>";
										}
										option = option + "</select>";
										div.append(option);
										$("#jhlis").select2();
							});
				});
	         function addtab(value) {
	                if(value==""||value==null){
	                  return;
	                }
					var value1 = value.substr(0, value.indexOf("-"));
					var name = value.substr(value.indexOf("-") + 1,value.length);
					$.fn.jerichoTab.addTab({
								title : name,
								closeable : true,
								data : {
											dataType : "iframe",
											dataLink : "${ctx}/zsjh/zsjhrecord/formshhistory?id="+ value1
									   }
								}).loadData(true);
				}
	    </script>
	    <label class="control-label">招生计划历史记录:</label> 
				<label class="control-label" style="margin-left: 20px;">
					<div id="selection_title1"></div> 
				</label>
	 </c:if>
	 </div>
	 <div id="divRight1" ></div>
	<c:if test="${zsjh.zt eq '2'}">
		<div id="tbNews" style="overflow-y: scroll;height: 500px;">
	</c:if>
	<c:if test="${zsjh.zt eq '0' or zsjh.zt eq '1' or zsjh.zt eq '3'}">
		<div id="tbNews">
	</c:if>
	<form:form id="inputForm1" modelAttribute="zsjh" action="${ctx}/zsjh/zsjh/save" method="post" class="form-horizontal" style="width: 98%;" >
		<form:hidden path="viewModel" id="viewModel"/>
		<form:hidden path="id" id="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag" value="yes"/>
		<form:hidden path="zt" id="zt"/>
		<form:hidden path="bcStatus" id="bcStatus"/>
		<sys:message content="${message}"/>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">计划名称：</label>
		       <div class="controls">
		       		${zsjh.jhmc }
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生年度：</label>
		       <div class="controls">
		       		${zsjh.zsnd}
		       </div>
		   </div>
		</div>
		<div class="control-group">
		   <%-- <div class="lg-form">
		       <label class="control-label">学期：</label>
		        <div class="controls">
		       		${fns:getDictLabel(zsjh.xqId , 'term_type', '')}
		       </div>
		   </div> --%>
		   <div class="lg-form">
		       <label class="control-label">招生人数：</label>
		        <div class="controls">
		       		${zsjh.zsrs }
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">学年：</label>
		       <div class="controls">
		       		${zsjh.nf.xnmc}(${zsjh.nf.xq})
		       </div>
		   </div>
		</div>
		<div class="control-group">
		   <div class="lg-form">
		       <label class="control-label">招生开始时间：</label>
		       <div class="controls">
		       		<fmt:formatDate value="${zsjh.startDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		   <div class="lg-form">
		       <label class="control-label">招生结束时间：</label>
		        <div class="controls">
		       		<fmt:formatDate value="${zsjh.endDate}" pattern="yyyy-MM-dd"/>
		       </div>
		   </div>
		</div>
		<!-- <div style="width: 80%;  margin-bottom: 5px;" id="zybiaoti">
		   <input style="margin-+: 90px;"type="button" onclick="addRow()" value="招生专业 +" />
		</div> -->
		<div class="control-group">
		 <div style="text-align: center; width: 80%;margin-left: 90px; margin-bottom:10px; height:200px; overflow: auto;">
			 <table id="bmTable1" class="table table-striped table-bordered table-condensed" style="height: 100px;">
				<tr>
								<th style="font-size:14px;">专业类别</th>
								<th style="font-size:14px;">专业名称</th>
								<th style="font-size:14px;">招生人数</th>
								<!-- <th style="font-size:14px;">班级数量</th> -->
				</tr>
			</table>
		  </div>
		</div>
		<div class="control-group">
		   <label class="control-label">招生说明：</label>
  		       <div class="controls">
  		       		${zsjh.jhsm }
  		       </div>
		</div>
		<!-- <div style="text-align: center;">
				   <input id="btnCancel" class="btn" type="button" value="关 闭" onclick="closeDialog();"/>
		</div> -->
		
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
		
	</form:form>
	
</body>

</html>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>学生小组信息管理</title>
	<meta name="decorator" content="default"/>
	<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
	
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
		/* 	$("#inputForm").validate({
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
			}); */
		});
	
	
	
	 function selAll(obj)
		{
		    var o=document.getElementsByName("choose");
		    for(var i=0;i<o.length;i++)
		    {
		        if(obj.checked==true)
		            o[i].checked=true;
		        else
		            o[i].checked=false;
		    }
		}
	//判断是否全部被选中，如果选中全选复选框被选中，反之未被选中
		function selFirst(){
		      var o=document.getElementsByName("choose");
		      var count=0;
		      var num=0;
		      for(var i=0;i<o.length-1;i++)
		      {
		        if(o[i+1].checked==true)
		        {
		          count++;
		        }
		        if(o[i+1].checked==false)
		        {
		          num++;
		        }
		      }
		      if(count==o.length-1)
		      {
		        o[0].checked=true;
		      }
		      if(num>0)
		      {
		        if(o[0].checked==true)
		        {
		          o[0].checked=false;
		        }
		      }
		   }
		 
	</script>
</head>
<body>
<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
			<td height="30px">
						<input type="checkbox" id="checkboxAll" name="choose" onclick="selAll(this)">
				    	<input type="hidden" name="ids" value="" />
				    	<input type="hidden" name="name" value="" />
				    	<input type="hidden" name="status" value="" /> 
			</td>
			  <td>小组名称</td>
			  <td>小组学生数</td>
			  <td>小组学生</td>
			  <td>小组教师</td>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${mapList}" var="groupstu">
			<tr>
			<td height="30px">
						<input type="checkbox" id="checkbox" name="choose" value="${groupstu.id}" onclick="selFirst()">
						<input type="hidden" name="ids" value="${groupstu.id}" />
						<input type="hidden" name="name" value="" />
						<input type="hidden" name="status" value="" />
			  </td>
			  <td>${groupstu.groupname}</td>
			  <td>${groupstu.groupnum}</td>
			  <td>${fns:getStudent(groupstu.groupstudent)}</td>
			  <td>${fns:getTeacher(groupstu.groupteacher)}</td>
		
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="btn-div">
		<input id="btnSubmit" type="button" class="btn btn-primary" onclick="javascript:piliangSubmit()" value="保存"/>
	</div>
	<script type="text/javascript">
		  	//批量添加
		function piliangSubmit()
		{
			var isTrue = true;
			var ids ="";
			$("#contentTable").find("input[type='checkbox']").each(function()
			{
				
				if($(this).attr("checked"))
				{
					if($(this).next().val()!=null && $(this).next().val()!="")
					{
						ids += $(this).next().val()+",";
						isTrue = false;
					}
				}
			});
			
				if(ids!=null && ids!="")
				{
				   ids = ids.substring(0,ids.length-1);
				   $.ajax({
				        type: "POST",
				        url: "${ctx}/practicemanagement/informationTable/saveq",
				        data: {ids:ids},
				        dataType:'json',
				        async:false,
						success: function(data){
							if(data=="ok"){
								alertx("添加成功！");
								/* openDialog.close(); */
								closeDialog();
							}
					   }
				    });
				}
				
				if(isTrue)
				{
					alertx("请选择要添加的小组信息！");
				}
		}
		function closeDialog() {
			$(".panel").css("display", "none");
			$(".window-shadow").css("display", "none");
			$(".window-mask").css("display", "none");
		}
	</script>
</body>
</html>
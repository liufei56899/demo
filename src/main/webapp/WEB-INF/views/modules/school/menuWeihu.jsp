<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>角色管理</title>
	<meta name="decorator" content="default"/>
</head>
<body>
	<%@include file="/WEB-INF/views/include/treeview.jsp" %>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#inputForm").validate({
				submitHandler: function(form){
			    	var ids = [], nodes = tree.getCheckedNodes(true);
					for(var i=0; i<nodes.length; i++) 
					{
						if(nodes[i].id !=1)
						{
							var istrue =getMenuIds(nodes[i].id);
							if(istrue)
							{
								ids.push(nodes[i].id);
							}
						}
					}
					$("#menuIds").val(ids);
					
					if(ids.length >0)
					{
						loading('正在提交，请稍等...');
						form.submit();
					}else
					{
						alertx('请选择子节点！');
					}
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
			


			var setting = {
				check:{enable:true,nocheckInherit:true,isParent:true},
				view:{selectedMulti:false},
				data:{simpleData:{enable:true}},
				callback:{
					beforeClick:function(id, node)
					{
						tree.checkNode(node, !node.checked, true, true);
						return false;
					},
					onCheck: zTreeOnCheck
					
				}};
				
			//验证是否选择子节点
			function zTreeOnCheck(event,treeId,treeNode)
			{	
				//获取选中节点的子节点
				var childNodes = tree.transformToArray(treeNode);
			}
			
			// 用户-菜单
			var zNodes=[
					<c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
		            </c:forEach>];
			// 初始化树结构
			var tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			
			
			// 默认选择节点
			/* var ids = "${role.menuIds}".split(",");
			for(var i=0; i<ids.length; i++) {
				var node = tree.getNodeByParam("id", ids[i]);
				try{tree.checkNode(node, true, false);}catch(e){}
			} */
			// 默认展开全部节点
			tree.expandAll(false);
			
			
			// 默认展开全部节点
			/* tree2.expandAll(false);
			// 刷新（显示/隐藏）机构
			refreshOfficeTree();
			$("#dataScope").change(function(){
				refreshOfficeTree();
			}); */
		});
		
		
		
		
		    function getMenuIds(nodeId)
		    {
		    	var count =0;
		    	var istrue = validIsZiJieDian(nodeId);
				return istrue;
		    }
				
			//验证是否有子节点	
			function validIsZiJieDian(nodeId)
			{
				var istrue;
				jQuery.ajax({
					type : 'post',
					url : "${ctx}/sys/role/findMenuByParentId",
					dataType : 'json',
					data : {
						id : nodeId
					},
					async : false,
					success : function(data) {
						istrue= data.isTrue;
					}
				});
				return istrue;
			}
		
		
		
		function refreshOfficeTree(){
			if($("#dataScope").val()==9){
				$("#officeTree").show();
			}else{
				$("#officeTree").hide();
			}
		}
	</script>
	<br/>
	<form:form id="inputForm" modelAttribute="role" action="${ctx}/um/sysUserMenu/saveMenu" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>
		<div class="control-group">
			<label class="control-label">菜单选择:</label>
			<div class="controls">
				<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
				<input type="hidden" id="menuIds" name="menuIds" />
				<div id="officeTree" class="ztree" style="margin-left:100px;margin-top:3px;float:left;"></div>
				<form:hidden path="officeIds"/>
			</div>
		</div>
		<div class="form-actions">
			<%-- <shiro:hasPermission name="sys:role:edit"> --%>
			<input id="btnSubmit" class="btn btn-primary" type="submit" value="保 存"/>&nbsp;<%-- </shiro:hasPermission> --%>
			<input id="btnCancel" class="btn" type="button" value="关闭" onclick="closeDialog();"/>
		</div>
	</form:form>
</body>
</html>
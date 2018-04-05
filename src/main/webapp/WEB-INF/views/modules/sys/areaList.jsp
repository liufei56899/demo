<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>区域管理</title>
	<meta name="decorator" content="default"/>
	<%@include file="/WEB-INF/views/include/treetable.jsp" %>
	<script type="text/javascript">
		$(function(){
            var option = {
                theme:'default',
                expandLevel : 1,
                beforeExpand : function($treeTable, id) {
                    //判断id是否已经有了子节点，如果有了就不再加载，这样就可以起到缓存的作用
                    if ($('.' + id, $treeTable).length) { return; }
                    $.ajax({
				        type: "POST",
				        url: "${ctx}/sys/area/findallbychr",
				        data: {parentId:id},
				        dataType:'json',
				        async:true,
						success: function(result){
							if(result!=null&&result!=""){
								var tpl = $("#treeTableTpl").html().replace(/(\/\/\<!\-\-)|(\/\/\-\->)/g,"");
								for(var i=0;i<result.length;i++){
									var row=result[i];
									if(row.type==5){
										$treeTable.addChilds(Mustache.render(tpl, {
											dict: {
												type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)
											}, pid: id, row: row,hasChild:''
										}));
									}else{
										$treeTable.addChilds(Mustache.render(tpl, {
											dict: {
												type: getDictLabel(${fns:toJson(fns:getDictList('sys_area_type'))}, row.type)
											}, pid: id, row: row,hasChild:'hasChild="true"'
										}));
									}
								}
							  }
					   }
				    });
                },
                onSelect : function($treeTable, id) {
                    window.console && console.log('onSelect:' + id);
                }
            };
            $("#treeTable").treeTable(option);
        });
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/sys/area/">区域列表</a></li>
		<shiro:hasPermission name="sys:area:edit"><li><a href="${ctx}/sys/area/form">区域添加</a></li></shiro:hasPermission>
	</ul>
	<sys:message content="${message}"/>
	<table id="treeTable" class="table table-striped table-bordered table-condensed">
		<thead><tr><th>区域名称</th><th>区域编码</th><th>区域类型</th><th>备注</th><shiro:hasPermission name="sys:area:edit"><th>操作</th></shiro:hasPermission></tr></thead>
		<tbody id="treeTableList">
			<tr id="1" pId="0" hasChild="true">
				<td><a href="${ctx}/sys/area/form?id=1">中国</a></td>
				<td>100000</td>
				<td>国家</td>
				<td></td>
				<shiro:hasPermission name="sys:area:edit"><td>
					<a href="${ctx}/sys/area/form?id=1">修改</a>
					<a href="${ctx}/sys/area/delete?id=1" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
					<a href="${ctx}/sys/area/form?parent.id=1">添加下级区域</a> 
				</td></shiro:hasPermission>
			</tr>
		</tbody>
	</table>
	<script type="text/template" id="treeTableTpl">
		<tr id="{{row.id}}" pId="{{pid}}" {{hasChild}}>
			<td><a href="${ctx}/sys/area/form?id={{row.id}}">{{row.name}}</a></td>
			<td>{{row.code}}</td>
			<td>{{dict.type}}</td>
			<td>{{row.remarks}}</td>
			<shiro:hasPermission name="sys:area:edit"><td>
				<a href="${ctx}/sys/area/form?id={{row.id}}">修改</a>
				<a href="${ctx}/sys/area/delete?id={{row.id}}" onclick="return confirmx('要删除该区域及所有子区域项吗？', this.href)">删除</a>
				<a href="${ctx}/sys/area/form?parent.id={{row.id}}">添加下级区域</a> 
			</td></shiro:hasPermission>
		</tr>
	</script>
</body>
</html>
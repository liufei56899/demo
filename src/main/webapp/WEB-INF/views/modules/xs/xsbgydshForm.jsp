<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>学生信息管理</title>
<meta name="decorator" content="default" />
</head>
<body>
	<style type="text/css">
.tabTreeselect {
	width: 226px;
}

.labWidth {
	width: 230px;
}

.left-control-group,.right-control-group {
	width: 49.9%;
	float: left;
}

.left-control-group {
	border-right: 1px dotted #ddd;
}

.left-form {
	border-bottom: 1px dotted #ddd;
}

.control-label {
	float: none !important;
}
</style>
	<script type="text/javascript" src="${ctxStatic}/common/jeesite.js"></script>
	<script type="text/javascript">
		$(document).ready(
				function() {
					//$("#name").focus();
					yanzhengYdlx();
					$("#inputForm").validate(
							{
								submitHandler : function(form) {
									var isTrue = validateSub();
									if (isTrue) {

										loading('正在提交，请稍等...');
										form.submit();
									}
								},
								errorContainer : "#messageBox",
								errorPlacement : function(error, element) {
									$("#messageBox").text("输入有误，请先更正。");
									if (element.is(":checkbox")
											|| element.is(":radio")
											|| element.parent().is(
													".input-append")) {
										error.appendTo(element.parent()
												.parent());
									} else {
										error.insertAfter(element);
									}
								}
							});
					if ("${xsJbxx.shzt}" == "2") {
						$("#btnSubmitOk").addClass(" hide");
					}

					/* zhaoShengFangShi();
					lianZhaoHeZuoLeiXing();
					chengYuanYiOnBlur();
					chengYuanErOnBlur(); */

				});

		//根据学生信息异动类型去分别显示界面
		function yanzhengYdlx() {
			var bgydlx = $("#bgydlx").val();
			if (bgydlx == "0") {
				$("#tiaoban").show();
			} else if (bgydlx == "1") {
				$("#tiaoZhuanYe").show();
			} else if (bgydlx == "2") {
				$("#tuixue").show();
			}
		}

		//
		function validateSub() {
			var isTrue = validateDh("jhrlxdh");
			if (isTrue) {
				isTrue = validateDh("lxdh");
			}
			//jtdh
			if (isTrue) {
				isTrue = validateDh("jtdh");
			}
			if (isTrue) {
				isTrue = validateDh("cyylxdh");
			}
			if (isTrue) {
				isTrue = validateDh("cyelxdh");
			}
			if (isTrue) {
				var banJiId = $("#banJiId").val();//分班id
				if (banJiId == null || banJiId == "") {
					isTrue = false;
				}
				if (!isTrue) {
					alertx('请选择班级');
				}
			}

			return isTrue;
		}

		//验证电话格式
		function validateDh(id) {
			var value = $("#" + id).val();
			if (value != null && value != "") {
				var isTrue = /^1\d{10}$/i.test(value)
						|| /^((\(\d{2,3}\))|(\d{3}\-))?(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/i
								.test(value);
				if (!isTrue) {
					validTxt(id, "联系电话格式有问题");
					return false;
				}
			}
			return true;
		}

		//选择班级
		function selectBanJi(obj) {
			/* console.log(obj); */
		}

		//确定班级事件
		function saveBanJi() {
			var num = 0;//
			var bjId = "";//班级id
			var rnrs = parseInt(0);//容纳人数
			var xueShengId = "${xsJbxx.id}";//学生id
			var bjmc = "";
			$("#selectBanJi").find("input[type='checkbox']").each(function() {
				if ($(this).attr("checked")) {
					num++;
					bjId = $(this).attr("id");
					rnrs = parseInt($(this).attr("rnrs"));
					bjmc = $(this).val();
				}
			});
			if (num == 0) {
				alertx('请选择班级');
			} else if (num > 1) {
				alertx('只能选择一个班级');
			} else {
				//验证该班级人数已达容纳人数
				$.getJSON("${ctx}/xs/xsJbxx/getBanJiNum", {
					id : xueShengId,
					bjmc : bjId
				}, function(data) {
					if (rnrs < parseInt(data.bjNum)) {
						alertx('此班级人数已达数，请重新选择班级');
					} else {
						$("#banJiId").val(bjId);
						$("#banJiMc").html(bjmc);
					}

				});
			}
		}

		//根据专业类别获取专业
		function zhuanYeOnClick(zylxVal) {
			$.getJSON("${ctx}/zy/zyJbxx/findZysByLxId", {
				id : zylxVal
			}, function(result) {
				$("#zhuaYeId").html(result.html);
				$("#zyid").attr("style", "width:284px;");
				$("#zyid").select2({
					formatResult : format,
					formatSelection : format,
					escapeMarkup : function(m) {
						return m;
					}
				});
			});
		}

		//招生方式
		/**
		  招生方式 为统一招生时 则 准考证号 、 考生号、考试总分则为必填项
		 */
		function zhaoShengFangShi() {
			var zsfs = $("#zsfs").val();
			if (zsfs == "1") {
				addValidate("zkzh");
				addValidate("ksh");
				addValidate("kszf");
			} else {
				emptyValidate("zkzh");
				emptyValidate("ksh");
				emptyValidate("kszf");
			}
		}

		//连招合作类型
		function lianZhaoHeZuoLeiXing() {
			var lzhzlx = $("#lzhzlx").val();
			if (lzhzlx != "1" && lzhzlx != null && lzhzlx != "") {
				addValidate("lzhzbxfs");
				addValidate("lzhzxxdm");
			} else {
				emptyValidate("lzhzbxfs");
				emptyValidate("lzhzxxdm");
			}
		}

		//成员1信息
		/**
		   （成员1和成员2信息可以都不填写）。若填写成员1或成员2信息时蓝色字体的4项信息同时为必填项，黑色字体为选填项
		 **/
		function chengYuanYiOnBlur() {
			var cyyxm = $("#cyyxm").val();//姓名
			var cyygx = $("#cyygx").val();//关系
			var cyysfjhr = $("#cyysfjhr").val();//是否监护人
			var cyylxdh = $("#cyylxdh").val();//联系电话

			if ((cyyxm != null && cyyxm != "")
					|| (cyygx != null && cyygx != "")
					|| (cyysfjhr != null && cyysfjhr != "")
					|| (cyylxdh != null && cyylxdh != "")) {
				addValidate("cyyxm");
				addValidate("cyygx");
				addValidate("cyysfjhr");
				addValidate("cyylxdh");
			} else {
				emptyValidate("cyyxm");
				emptyValidate("cyygx");
				emptyValidate("cyysfjhr");
				emptyValidate("cyylxdh");

			}
		}

		//验证成员2信息
		function chengYuanErOnBlur() {
			var cyexm = $("#cyexm").val();//姓名
			var cyegx = $("#cyegx").val();//关系
			var cyesfjhr = $("#cyesfjhr").val();//是否监护人
			var cyelxdh = $("#cyelxdh").val();//联系电话
			if ((cyexm != null && cyexm != "")
					|| (cyegx != null && cyegx != "")
					|| (cyesfjhr != null && cyesfjhr != "")
					|| (cyelxdh != null && cyelxdh != "")) {
				addValidate("cyexm");
				addValidate("cyegx");
				addValidate("cyesfjhr");
				addValidate("cyelxdh");
			} else {
				emptyValidate("cyexm");
				emptyValidate("cyegx");
				emptyValidate("cyesfjhr");
				emptyValidate("cyelxdh");

			}
		}

		//添加验证
		function addValidate(id) {
			if ($("#" + id).next().attr("class") == "error") {
				$("#" + id).next().next().html("<font color='red'>*</font>");
			} else {
				$("#" + id).next().html("<font color='red'>*</font>");
			}
			//$("#"+id).next().html("<font color='red'>*</font>");
			$("#" + id).addClass("required");
		}

		//清空验证
		function emptyValidate(id) {
			if ($("#" + id).next().attr("class") == "error") {
				$("#" + id).next().remove();
				$("#" + id).next().empty();
			} else {
				$("#" + id).next().empty();
			}
			$("#" + id).removeClass("required");
			$("#" + id).removeClass("error");
		}

		function saveBefferCheck() {
			var shzt = "${xsJbxx.shzt}";
			var ids = "${xsJbxx.id}";
			if (shzt == 1) {
				alert("该信息已经审核，不能重复审核！");
				return false;
			}
			$.ajax({
				type : 'post',
				url : "${ctx}/xs/xsJbxx/updateShzt",
				dataType : 'text',
				data : {
					ids : ids
				},
				success : function(data) {
					location.href = "${ctx}/xs/xsJbxx/xjList/";
				}
			});
			return true;
		}
		
		
		//审核提交
		function ShenHeCheck() {
			var shzt = "${xsJbxx.bgydlxzt}";
			var id = "${xsJbxx.id}";
			if (shzt == 0) {
				alertx("该信息已经审核通过，不能再次审核！");
				return false;
			}
			var spnr = "";
			var selects = document.getElementsByName("shzt");

			for ( var i = 0; i < selects.length; i++) {
				if (selects[i].checked == true) {
					if (selects[i].value == 1) {
						shzt = 1;
						spnr = "";
					}
					if (selects[i].value == 2) {
						shzt = 2;
						spnr = $("#spnr").val();
						if (spnr == null || spnr == "" || spnr.length < 1) {
							alertx('请填写不通过意见！');
							return;
						}
					}
				}
			}

			$.ajax({
				type : 'post',
				url : "${ctx}/xs/xsJbxx/bgydSh",
				dataType : 'text',
				data : {
					id : id,
					shzt : shzt,
					spnr : spnr
				},
				success : function(data) {
					location.href = "${ctx}/xs/xsJbxx/xsbgydlist/";
				}
			});
			return true;
		}
	</script>
	<br />
	<form:form id="inputForm" modelAttribute="xsJbxx"
		action="${ctx}/xs/xsJbxx/bgydSh" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<fieldset>
			<legend>
				学生信息变更异动类型:
				<form:select path="bgydlx" class="input-xlarge" id="bgydlx"
					disabled="true">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('bgydlx')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</legend>
		</fieldset>
		
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">姓名：</label>
				<div class="controls2">${xsJbxx.xm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1 ">姓名拼音：</label>
				<div class="controls2">${xsJbxx.xmpy }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1 ">英文姓名：</label>
				<div class="controls2">${xsJbxx.ywxm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1 ">性别：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.xbm,'sex','')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">身份证件类型：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.sfzjlxm,'sfzjlx', '')}</div>
			</div>
			<div class="lg-form1" style="border-top: 1px dotted #ddd;">
				<label class="control-label1">身份证件号码：</label>
				<div class="controls2">${xsJbxx.sfzjh }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">出生日期：</label>
				<div class="controls2">${fns:getDate(xsJbxx.csrq)}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">民族：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.mzm,'nation','')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">联系电话：</label>
				<div class="controls2">${xsJbxx.lxdh }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">健康状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.jkzkm,'health', '')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">婚姻状况：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.hyzkm,'hyzk', '')}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">国籍/地区：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.gjdqm,'gjdqm', '')}</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">政治面貌：</label>
				<div class="controls2">${fns:getDictLabel(xsJbxx.zzmmm,'zzmm', '')}</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭电话：</label>
				<div class="controls2">${xsJbxx.jtdh }</div>
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1" style="width: 180px;">户口所在地区县以下详细地址：</label>
				<div class="controls2">${xsJbxx.hkszdqxyxxxdz }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">家庭现地址：</label>
				<div class="controls2">${xsJbxx.jtxdz }</div>
			</div>
		</div>
		<div class="control-group">
			<div class="lg-form1">
				<label class="control-label1">家庭邮政编码：</label>
				<div class="controls2">${xsJbxx.jtyzbm }</div>
			</div>
			<div class="lg-form1">
				<label class="control-label1">年级：</label>
				<div class="controls2">${xsJbxx.nj.nf }</div>
			</div>
		</div>
		
		<!-- 调班界面显示 -->
		<div id="tiaoban" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc }</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后班级名称：</font>
					</label>
					<div class="controls2">${xsJbxx.newBjmc.bjmc}</div>
				</div>
			</div>
		</div>

		<!-- 调专业界面 -->
		<div id="tiaoZhuanYe" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原专业类别：</label>
					<div class="controls2">${xsJbxx.zylxId.lxmc}</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后专业类别：</font></label>
					<div class="controls2">${xsJbxx.newZyid.zylx.lxmc}</div>
				</div>
			</div>
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原专业名称：</label>
					<div class="controls2">${xsJbxx.zyId.zymc}(${fns:getDictLabel(xsJbxx.zyId.xz, 'xzdm','')})</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后专业名称：</font></label>
					<div class="controls2">${xsJbxx.newZyid.zymc}(${fns:getDictLabel(xsJbxx.newZyid.xz, 'xzdm','')})</div>
				</div>
			</div>
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">原班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc }</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1"><font color="red">调整后班级名称：</font></label>
					<div class="controls2">${xsJbxx.newBjmc.bjmc}</div>
				</div>
			</div>
		</div>

		<!-- 退学信息审核 -->
		<div id="tuixue" style="display: none;">
			<div class="control-group">
				<div class="lg-form1">
					<label class="control-label1">学制：</label>
					<div class="controls2">${fns:getDictLabel(xsJbxx.xz, 'xzdm','')}</div>
				</div>
				<div class="lg-form1">
					<label class="control-label1">班级名称：</label>
					<div class="controls2">${xsJbxx.bjmc.bjmc }</div>
				</div>
			</div>
		</div>




		<!-- 部门 -->
		<%--<div class="modal fade" style="width:680px;" id="selectBanJi"
			tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">选择班级</h4>
					</div>
					<div class="modal-body">
						<div id="banJiPanel"></div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" onclick="saveBanJi()"
							class="btn btn-primary" data-dismiss="modal">确定</button>
					</div>
				</div>
			</div>
		</div>
		--%><div class="control-group">
			<label class="control-label">审核结果：</label>
			<div class="controls1">
				<form:radiobutton id="shzt" name="shzt" path="shzt" value="1"
					checked="true" />
				通过
				<form:radiobutton id="shzt" name="shzt" path="shzt" value="2" />
				不通过
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">审核意见：</label>
			<div class="controls">
				<form:textarea id="spnr" path="spnr" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " style="width:677px;" />
			</div>
		</div>

		<div class="control-group">
			<div class="lg-form">
				<label class="control-label">审核人：</label>
				<div class="controls1">
					<form:input path="approveBy.name" id="approveBy.name"
						htmlEscape="false" maxlength="11" readonly="true"
						value="${userName }" class="input-xlarge" />
				</div>
			</div>
			<div class="lg-form">
				<label class="control-label">审核时间：</label>
				<div class="controls1">
					<input name="approveDate" type="text" disabled="disabled"
						maxlength="64" class="input-xlarge Wdate required"
						value="<fmt:formatDate value="${approveDate}" pattern="yyyy-MM-dd"/>"
						onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});" />
				</div>
			</div>
		</div>
		</div>
		<div class="form-actions" align="center">
			<%-- <shiro:hasPermission name="xs:xsJbxx:edit">
			<input id="btnSubmit" onclick="return saveBefferCheck()" class="btn btn-primary" type="button" value="审 核"/>&nbsp;</shiro:hasPermission>
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/> --%>
			<input id="btnSubmitOk" onclick="return ShenHeCheck()"
				class="btn btn-primary" type="button" value="确定" />&nbsp; <input
				id="btnCancel" class="btn btn-primary" type="button" value="取消"
				onclick="closeDialog();" />
		</div>
	</form:form>
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>主页</title>
<meta name="decorator" content="default" />
<%@ include file="/WEB-INF/views/include/base_index.jsp"%>
<link rel="Stylesheet" href="${ctxStatic}/main/main.css">
<script type="text/javascript" src="${ctxStatic}/main/main.js"></script>
<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsGR.js"></script>
<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsBMDB.js"></script>
<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsZY.js"></script>
<script type="text/javascript" src="${ctxStatic}/main/mainHighchartsBMCY.js"></script>
<script type="text/javascript" src="${ctxStatic}/main/Marquee-1.0.js"></script>
 <style type="text/css">
        #marquee6 {
            width: 100%;
            height: 150px;
            overflow: hidden;
            overflow: hidden;
            margin: 0px auto;
            margin-top: 10px;
        }
        
        #marquee6 ul li {
            line-height: 30px;
            background: #F9F9F9;
            margin: 5px 0;
            padding-left: 0px;
        }
        #con_two_1{
         margin: 0;
        }
        #con_two_1>li>strong{
        display:inline-block;
        
        width: 25%;
        text-align: center;
        }
        .container-fluid{
            min-width:1366px;
        }
        .body{
        overflow: hidden;
        }
    </style>
<script type="text/javascript">
	var jhID =null;
	$(document).ready(function() {
		 //获取启用的招生计划
		jQuery.ajax({
	        type: "POST",
	        url: "${ctx}/zsjh/zsjh/isUsedZsjh",
	        data: null,
	        dataType:'json',
	        async:false,
			success: function(data){
				 $("#isUsedZsjh").text(data.jhmc);
	             $("#startDate").text(data.kssj);
	             $("#endDate").text(data.jssj);
	             var jhid2 = data.jhid;
	             jhID = jhid2;
	             if(jhid2!=null){
		                $.getJSON("${ctx}/zsjh/zsjh/getTeachNum",{jhid:jhid2}, function(data) {
					         $("#tea_num").text(data);//参与招生老师人数
				       });
	             }
		   }
	    });
		//获取招生登记信息
		$.getJSON("${ctx}/zsdj/zsdj/getZsdjList",{id:jhID}, function(data) {
			if(data.length>0){
			  var t_thead = $("#con_two_1");
			  var content = "";
		for(var i=0;i<data.length;i++){
			    var jsmc = data[i].name;
			    var zymc = "";
			    if(data[i].zymc!=null)
			    {
			    	zymc = data[i].zymc;
			    	if(zymc.length >5)
			    	{
			    		zymc= zymc.substring(0,5)+"...";
			    	}
			    }
			    content = content +"<li><strong>"+jsmc+"</strong><strong>"+data[i].xm+"</strong><strong>"+zymc+"</strong><strong>"+data[i].lxdh+"</strong></li>";
			  }
			  t_thead.append(content);
			  
			  $('#marquee6').kxbdSuperMarquee({
	                isMarquee: true
	                , isEqual: false
	                , scrollDelay: 70
	                , controlBtn: {
	                    up: '#goUM'
	                    , down: '#goDM'
	                }
	                , direction: 'up'
	            });
               $("#marquee6 ul li:odd").css(
			   {
			   "border-bottom":"1px solid #B2E0FF"
			   }
			  );
              $("#marquee6 ul li:even").css(
              {
                "border-bottom":"1px solid #31C3C2"
              }
              );
			}
		});
		$.getJSON("${ctx}/sys/user/getUserDefault",function(data){
	      //设置当前登录用户的信息
	       $("#uername").text(data.username);//当前等于用户的名称
	       $("#user_part").text(data.officename);
	      if(data!=undefined&&data.boo==true){
	           var appname = window.location.protocol + "//" + window.location.host + "/";
		       $("#userPhoto").attr("src",appname+data.photo);
	       } 
	    });
	     $.getJSON("${ctx}/sys/user/findUserByJdId",function(data){
         	if(data.istrue)
         	{
         		$.getJSON("${ctx}/zsjh/zsjh/getShdbsx",function(data1){
         			$("#syNum").text(data1.dbCount+"个");
         		});
         	}else
         	{
         		$("#syNum").text("0个");
         		$(".dbsx_").attr("onclick","");
         	}
	    });   
	    	  //-------------------------------------------------------------------------------------------------
	  var a;
	    $.getJSON("${ctx}/xs/xsJbxx/getGeRenXinXi",{jhid:jhID},function(data){
	      //设置当前登录用户的信息
		    
		      $("#zsl").text(data.zsl+"个");//招生已完成
		      
		     /*  $("#de_num").text(data.rwl+"/"+data.zsl);
		       $("#de_num").text(data.zsl+"/"+data.rwl);
		       var syl =  data.rwl - data.zsl; */
		      /*  $("#syNum").text(syl+"个"); */
		      a=data.zsl;
	    });
	    
	    
	      //当前招生人数
	    $.getJSON("${ctx}/zsjh/zsjh/getZsjhnum",{id:jhID},function(data){
         			$("#de_num").text(data.wcrs+"/"+data.zsrs); 
         			//  $("#rwl").text(data.zsrs+"个");//招生任务数
         		});
	  
	  
	     //当前招生招生任务数
	    $.getJSON("${ctx}/xs/xsJbxx/getGeRen",{id:jhID},function(data){
         			 $("#rwl").text(data.zsrs+"个");//招生任务数
         			 var b=data.zsrs-a ;
         			  $("#syNum").text(b+"个");
         			 
         		});
	  	  //-------------------------------------------------------------------------------------------------
		//获取通知列表信息
		$.getJSON("${ctx}/oa/oaNotify/selfData", function(data) {
			if(data.list!=null)
			{
				var length = data.list.length;
				var content  = "";
				for(var i=0;i<length;i++){
					if(i<6)
					{
						var id = data.list[i].id;
					   var title = data.list[i].title;
					    if(title.length >20)
					   {
					   		title = title.substring(0,20)+"...";
					   }
					   var updateDate = data.list[i].updateDate;
					    updateDate = updateDate.substring(0,10);
		               content +=  "<p>"+"<span style=\" margin-left:10px;\"><a href='javascript:readNotify(\""+id+"\");'>"+title+"</a></span>"+"<span style=\"float:right; margin-right:10px;\" >"+updateDate+"</span>"+"</p>";
					}
				}
				$("#content_top_tzgg .content").html(content);
			}
		});
		//招生统计-各专业
		$.getJSON("${ctx}/xs/xsJbxx/zstjgzy",{jhId:jhID}, function(data) {
			viewBmZstjInfo(data);
		});
		//招生统计-各部门 对比
		$.getJSON("${ctx}/xs/xsJbxx/zstjgbmDb",{jhId:jhID}, function(data) {
			viewZstjbmDbInfo(data);
		});
		$.getJSON("${ctx}//sys/user/getUserDefault", function(data) {
		    $.getJSON("${ctx}/sys/office/treeData",function(data){
		        var first = "";
		        if(data!=null&&data.length>0){
		           var content = "";
		           for(var t=1;t<data.length;t++){
		              first = data[1].id;
		              content = content + "<option value='"+data[t].id+"'>" + data[t].name + "</option>";
		           }
		        }
		        $("#deptmentId").html(content);
		        $("#deptmentId").select2();
		        $("#s2id_deptmentId").children("a").attr("style","background:none;background-color:none;background-image:none;border:none;");
		        $("#s2id_deptmentId").children("a").find("span :eq(1)").attr("style","display:none;");
		        selectDeptment(first);//初始化
		    });
		});
	});
	
	function openTzggDialog(href, title, width, height) {
		$('#dialogDiv').dialog({
			title : title,
			width : width,
			height : height,
			closed : false,
			cache : false,
			href : href,
			modal : true
		});
	
		$(".panel").css("top", "0px");
		$(".window-shadow").css("top", "0px");
	}
	
	function readNotify(id){
    	openTzggDialog("${ctx}/oa/oaNotify/viewNotify?id="+id,"查看通知信息",860,440);
    }
	
	//选择部门查询方法
    function selectDeptment(value){
			//招生统计当前登录用户所在部门的成员招生量
		    $.getJSON("${ctx}/xs/xsJbxx/zstjBmcy",{id:value,jhId:jhID}, function(data) {
				  var nameValue = new Array();
				  var numValue = new Array();
				  if(data!=null&&data.length>=0){
				      for(var t=0;t<data.length;t++){
				        nameValue.push(data[t].name);
				        numValue.push(data[t].num);
				      }
				  }
				  viewZstjbmInfo(nameValue,numValue);
			}); 
    }
</script>
</head>
<body>
	<div id="main">
		<div id='dialogDiv' style='width:820px;'></div>
		<div id="content_top">
		<div class="tzgg_div">
		    <div class="title">
					<p>通知公告</p>
			</div>
			<div id="content_top_tzgg">
				<div class="content">
				</div>
			</div>
		</div>
         <div class="zsqk_div">
			<div class="title">
					<p>招生实况</p>
				</div>
			<div id="content_top_zssk">
				<div class="content">
				<div class="t_title">
				 <dl>
				  <dt>招生老师</dt>
				  <dt>登记学生</dt>
				  <dt>专业名称</dt>
				  <dt>联系电话</dt>
				 </dl>
				</div>
				 <div id="marquee6">
		        	<ul id="con_two_1">
		            </ul>
	            </div>
				</div>
			</div>
         </div>
         		<div class="grzs_div">
					<div class="title">
					<p>个人招生统计</p>
				</div>
			<div id="content_top_grzstj">
				
				<div class="content">
					<div class="left">
						<div id="zstjgr_info">
						 <div class="info-img ls-img">
						    <img id="userPhoto" alt="" src="${ctxStatic}/lg-images/3.jpg">	
						    </div>
						</div>
					</div>
					<div class="right_">
					<div class="right_cont">
							<p title="当前使用的招生计划">
							 <span class="r-icon"><img alt="" src="${ctxStatic}/lg-images/plan.png"></span>
							  <span id="isUsedZsjh"></span>
							</p> 
							<p title="招生开始时间" style="width: 45%; float: left;">
							 <span class="r-icon"><img alt="" src="${ctxStatic}/lg-images/t-b.png"></span>
							  <span id="startDate"></span>
							</p>
							<p title="招生结束时间" style="width: 45%; float: left; padding-left: 0;">
							 <span class="r-icon"><img alt="" src="${ctxStatic}/lg-images/t-e.png"></span>
							  <span id="endDate"></span>
							</p>
							<p title="参与招生老师人数" style="width: 45%; float: left; ">
							 <span class="r-icon"><img alt="" src="${ctxStatic}/lg-images/teacher.png"></span>
							  <span id="tea_num">0</span>
							</p>
							<p title="当前招生人数" style="width: 45%; float: left; padding-left: 0;">
							 <span class="r-icon"><img alt="" src="${ctxStatic}/lg-images/pepole.png"></span>
							  <span id="de_num">0/0</span>
							</p>
						</div>
					</div>
					<div class="zs_div ls-zs">
						    <p class="zswc_" title="招生完成数"><span id="zsl"></span></p>
						     <p class="zsrw_" title="招生任务数"><span id="rwl"></span></p>
						    <p class="syrw_" title="剩余招生任务数"><span id="syNum"></span></p>
						</div>
				</div>
			</div>
		  </div>
		</div>
		<div id="content_botton">
			<div id="content_botton_zszytj">
			    <div class="title">专业名称统计</div>
				<div class="content"></div>
			</div>
			<div id="content_botton_zszytj_bm">
			    <div class="title">部门招生任务完成统计</div>
				<div id="content_db">
					<div class="content_db"></div>
				</div>
				<div id="content_bm">
				    <div style="background-color:#D31517; border-radius:5px; margin: 5px 0; color: #fff; text-align: center; height: 40px; line-height: 40px;">
				      <select id="deptmentId" style="width: 150px;" onchange="selectDeptment(this.value)">
				      </select>
				      任务完成量统计
				    </div>
					<div class="content_bm"></div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
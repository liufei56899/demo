//地图容器
var chart = echarts.init(document.getElementById('main'));
//34个省、市、自治区的名字拼音映射数组
var provinces = {
    //23个省
    "台湾": "710000",
    "河北": "130000",
    "山西": "140000",
    "辽宁": "210000",
    "吉林": "220000",
    "黑龙江": "230000",
    "江苏": "320000",
    "浙江": "330000",
    "安徽": "340000",
    "福建": "350000",
    "江西": "360000",
    "山东": "370000",
    "河南": "410000",
    "湖北": "420000",
    "湖南": "430000",
    "广东": "440000",
    "海南": "460000",
    "四川": "510000",
    "贵州": "520000",
    "云南": "530000",
    "陕西": "610000",
    "甘肃": "620000",
    "青海": "630000",
    //5个自治区
    "新疆": "650000",
    "广西": "450000",
    "内蒙古": "150000",
    "宁夏": "640000",
    "西藏": "540000",
    //4个直辖市
    "北京": "110000",
    "天津": "120000",
    "上海": "310000",
    "重庆": "500000",
    //2个特别行政区
    "香港": "810000",
    "澳门": "820000"
};

//直辖市和特别行政区-只有二级地图，没有三级地图
var special = ["北京","天津","上海","重庆","香港","澳门"];
var mapdata = [];
//绘制全国地图
$.getJSON('/em/map_static/map/china.json', function(data){
	d = [];
	for( var i=0;i<data.features.length;i++ ){
		d.push({
			name:data.features[i].properties.name
		})
	}
	mapdata = d;
	//注册地图
	echarts.registerMap('china', data);
	//绘制地图
	renderMap('china',d);
});

//地图点击事件
chart.on('click', function (params) {
	if( params.name in provinces ){
		//如果点击的是34个省、市、自治区，绘制选中地区的二级地图
		$.getJSON('/em/map_static/map/province/'+ provinces[params.name] +'.json', function(data){
			echarts.registerMap( params.name, data);
			var d = [];
			for( var i=0;i<data.features.length;i++ ){
				d.push({
					name:data.features[i].properties.name
				})
			}
			renderMap(params.name,d);
			seach(provinces[params.name],params.name);
		});
	}else if( params.seriesName in provinces ){
		//如果是【直辖市/特别行政区】只有二级下钻
		if(  special.indexOf( params.seriesName ) >=0  ){
			renderMap('china',mapdata);
		}else{
			//显示县级地图
			
			$.getJSON('/em/map_static/map/city/'+ cityMap[params.name] +'.json', function(data){
				echarts.registerMap( params.name, data);
				var d = [];
				for( var i=0;i<data.features.length;i++ ){
					d.push({
						name:data.features[i].properties.name
					})
				}
				renderMap(params.name,d);
				seach(cityMap[params.name],params.name);
			});	
		}	
	}else{
		renderMap('china',mapdata);
		seach(1,null);
	}
});

//初始化绘制全国地图配置
var option = {
	backgroundColor: '#fff',//更换地图背景颜色
    title : {
        text: '中华人民共和国',//主标题文本，支持使用 \n 换行[ default: '' ]
        subtext: '三级下钻',//副标题文本，支持使用 \n 换行[ default: '' ]
       /* link:'http://www.ldsun.com',//主标题文本超链接[ default: '' ]
*/        left: 'center',//grid 组件离容器左侧的距离[ default: 'auto' ]
        textStyle:{//文本的样式可以设置全局的
            color: '#000',//文字的颜色[ default: "#fff" ]
            fontSize:32,
            fontWeight:'bolder',
            fontFamily:"Microsoft YaHei"
        },
        subtextStyle:{
        	color: '#000',//副标题文字的颜色[ default: '#aaa' ]
            fontSize:24,
            fontWeight:'bold',
            fontFamily:"Microsoft YaHei"
        }
    },
    tooltip: {//鼠标跟随显示数据
    	show:true,
        trigger: 'item',//数据项图形触发类型[ default: 'item' ]
        formatter: '{b}'//字符串模板  {b}（区域名称）
    },
    toolbox: {
        show: false,//是否显示工具栏组件[ default: true ]
        orient: 'vertical',//工具栏 icon 的布局朝向[ default: 'horizontal' ]
        left: 'right',//工具栏组件离容器左侧的距离[ default: 'auto' ]
        top: 'center',//工具栏组件离容器上侧的距离[ default: 'auto' ]
        feature: {//各工具配置项     自定义的工具名字，只能以 my 开头
            dataView: {readOnly: false},//数据视图工具，可以展现当前图表所用的数据，编辑后可以动态更新
            restore: {},//配置项还原
            saveAsImage: {}//保存为图片
        },
        iconStyle:{//公用的 icon 样式设置
        	normal:{//图形的颜色[ default: 自适应 ]
        		color:'#fff'
        	}
        }
    },
    animationDuration:1000,//初始动画的时长，支持回调函数，可以通过每个数据返回不同的 delay 时间实现更戏剧的初始动画效果越往后的数据延迟越大
	animationEasing:'cubicOut',//初始动画的缓动效果
	animationDurationUpdate:1000//数据更新动画的时长
     
};
function renderMap(map,data){
	option.title.subtext = map;
    option.series = [ 
		{
            name: map,//系列名称，用于tooltip的显示
            type: 'map',//[ default: 'line' ]图形种类
            mapType: map,//图形类型
            roam: false,
            scaleLimit:{min:1.0,max:1.5},
            nameMap:{
			    'china':'中国'
			},
			mapLocation: {
                x: 'left',
                y: 'top',
                height: 500//地图高度
            },
            label: {//图形上的文本标签，可用于说明图形的一些数据信息，比如值，名称等
	            normal:{
					show:true,//是否显示标签[ default: false ]
					textStyle:{//标签的字体样式
						color:'#ff3399',
						fontSize:12
					}  
	            },
	            emphasis: {
	                show: false,
	                textStyle:{
						color:'#fff',
						fontSize:13
					}
	            }
	        },
	        itemStyle: {//默认地图显示样式
	            normal: {
	            	color: '#32A7FD',
	                /*areaColor: '#323c48',*/
	                borderColor: 'dodgerblue'//图形的描边颜色。支持的格式同 color[ default: "#000" ]
	            },
	            emphasis: {//图形的颜色也是选中样式
	                areaColor: '#90CCFF'
	            }
	        },
            data:data
        }	
    ];
    //渲染地图
    chart.setOption(option);
}
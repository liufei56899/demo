package com.thinkgem.jeesite.modules.tj.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.UnderlineStyle;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import jxl.write.WriteException;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZytjJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;

@Controller
@RequestMapping(value = "${adminPath}/tj/ndzyzstj")
public class NdzyzstjController extends BaseController  {
	
	@Autowired
	private ZyJbxxService zyJbxxService;
	
	@Autowired
	private ZsjhService zsjhService;
	
	@ModelAttribute
	public ZyJbxx get(@RequestParam(required=false) String id) {
		ZyJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zyJbxxService.get(id);
		}
		if (entity == null){
			entity = new ZyJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZyJbxx zyjbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		//当前年度
		model.addAttribute("nowDate", DateUtils.getYear());
		//查询计划年度
		List<Map> zsndList = zsjhService.findAllZsnd();
		model.addAttribute("zsndList", zsndList);
		return "modules/ndzyzstj/ndzyzstjList";
	}
	
	/**
	 * 专业图形
	 * @param zyjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "ndzytx")
	public String ndjzytx(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		//专业
		/*List<ZytjJbxx> zyList = zyJbxxService.findAllZy(zytjjbxx);
		String zyListJson = JsonMapper.toJsonString(zyList);
		
		//
		if(zytjjbxx.getZsjhId()==null || "".equals(zytjjbxx.getZsjhId()) )
		{
			zytjjbxx.setNewYear(DateUtils.getYear());
		}
		List<ZytjJbxx> zytjList = zyJbxxService.findNdzytjList(zytjjbxx);
		String zytjListJson = JsonMapper.toJsonString(zytjList);
		
		model.addAttribute("zyListJson", zyListJson);
		model.addAttribute("zytjListJson", zytjListJson);*/
		return "modules/ndzyzstj/ndzytxList";
	}
	
	@ResponseBody
	@RequestMapping(value = "zyList")
	public String zyList(ZytjJbxx zytjjbxx)
	{
		//专业
		List<ZytjJbxx> zyList = zyJbxxService.findAllZy(zytjjbxx);
		return JsonMapper.toJsonString(zyList);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "zytjList")
	public String zytjList(ZytjJbxx zytjjbxx)
	{
		String titleStr ="";
		if(zytjjbxx.getNewYear()==null || "".equals(zytjjbxx.getNewYear()))
		{
			zytjjbxx.setNewYear(DateUtils.getYear());
			titleStr = DateUtils.getYear()+"年度";
		}
		titleStr = zytjjbxx.getNewYear()+"年度";
		List<ZytjJbxx> zytjList = zyJbxxService.findNdzytjList(zytjjbxx);
		List<Integer> zsrws = new ArrayList<Integer>();//招生任务数
		List<Integer> zsdjs = new ArrayList<Integer>();//招生登记数
		List<Integer> zswcs = new ArrayList<Integer>();//招生完成数
		List<String> zylist = new ArrayList<String>();
		List<Map<String,Object>> zymapList = new ArrayList<Map<String,Object>>(); 
		String zyid = "";
		for(int i=0;i<zytjList.size();i++)
		{	
			Map<String,Object> map = new HashMap<String, Object>();
			ZytjJbxx entity = zytjList.get(i);
			if(i==0)
			{
				zyid = entity.getId();
				map.put("zyid", entity.getId());
				map.put("zymc", entity.getZymc());
				map.put("zyxzmc", entity.getZyxzmc());
				zymapList.add(map);
			}
			else{
				
				if(zyid.equals(entity.getId()))
				{
					zyid = entity.getId();
				}else{
					zyid = entity.getId();
					map.put("zyid", entity.getId());
					map.put("zymc", entity.getZymc());
					map.put("zyxzmc", entity.getZyxzmc());
					zymapList.add(map);
				}
			}
		}
		
		zyid = "";
		if(zymapList!=null && zymapList.size()>0){
			for(int j=0;j<zymapList.size();j++){
				Map<String,Object> zyMap = zymapList.get(j);
				String id = zyMap.get("zyid").toString();
				int index=0;
				int zstype=0;
				for(int i=0;i<zytjList.size();i++)
				{
					ZytjJbxx entity = zytjList.get(i);
					String zid = entity.getId();
					int type = StringUtils.toInteger(entity.getZstype());
					
					if(id.equals(zid))
					{
						if(index==0)
						{
							if(type==1){
								zsrws.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==2){
								zsrws.add(0);
								zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==3){
								zsrws.add(0);
								zsdjs.add(0);
								zswcs.add(StringUtils.toInteger(entity.getZsrs()));
							}
							
						}else
						{
							if(type==1){
								zsrws.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==2){
								zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==3){
								zswcs.add(StringUtils.toInteger(entity.getZsrs()));
							}
						}
						index++;
						zstype=type;
					}
					
					
				}
				if(index==1)
				{
					if(zstype==1)
					{
						zsdjs.add(0);
						zswcs.add(0);
					}else if(zstype==2)
					{
						zswcs.add(0);
					}
				}else if(index==2)
				{
					if(zstype==1)
					{
						zsdjs.add(0);
						zswcs.add(0);
						
					}else if(zstype==2)
					{
						zswcs.add(0);
					}
					
				}else if(index==3)
				{
					
				}
				String zymc="未知专业";
				if (zyMap.get("zymc")!=null) {
					zymc=zyMap.get("zymc").toString() +"(" +zyMap.get("zyxzmc").toString()+")";
				}
				zylist.add(zymc);
				
				
				
			}
		}
		//专业
//		List<ZytjJbxx> zyList = zyJbxxService.findAllZy(zytjjbxx);
		Map map = new HashMap();
		map.put("zsrws", zsrws);
		map.put("zsdjs", zsdjs);
		map.put("zswcs", zswcs);
		map.put("zy", zylist);
		map.put("titleStr", titleStr);
		return JsonMapper.toJsonString(map);
	}
	
	/***
	 * 专业列表
	 * @param zyjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "ndzylblist")
	public String ndzylblist(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		if(zytjjbxx.getNewYear()==null || "".equals(zytjjbxx.getNewYear()) )
		{
			zytjjbxx.setNewYear(DateUtils.getYear());
		}
		List<ZytjJbxx> zytjList = zyJbxxService.findNdzytjList(zytjjbxx);
		model.addAttribute("zytjList", zytjList);
		return "modules/ndzyzstj/ndzylblist";
	}
	
	/**
	 * 单个专业的招生统计
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "findndzytjByid")
	public String findndzytjByid(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		//
		if(zytjjbxx.getNewYear() ==null || "".equals(zytjjbxx.getNewYear()) )
		{
			zytjjbxx.setNewYear(DateUtils.getYear());
		}
		//统计单个专业等级数
		List<ZytjJbxx> list = zyJbxxService.findNdzytjListByid(zytjjbxx);
		List<String> newList  = new ArrayList<String>(); 
		//去重后的招生部门
		List<Map<String,Object>> jgList = new ArrayList<Map<String,Object>>();
		if(list!=null && list.size()>0){
			for(int i=0; i<list.size(); i++){
				ZytjJbxx entity = list.get(i);
				String zsbm = entity.getZsbm();
				Map map = new HashMap();
				if(!newList.contains(zsbm)){
					newList.add(zsbm);
					map.put("zsbm", zsbm);
					map.put("zsbmmc", entity.getZsbmmc());
					jgList.add(map);
				}
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("jgList", jgList);
		ZyJbxx zyEntity = get(zytjjbxx.getId());
		model.addAttribute("zyEntity", zyEntity);
		//招生机构类型
		List<Dict> zsjglist =DictUtils.getDictList("ly");
		model.addAttribute("zsjglist", zsjglist);
		
		List<ZytjJbxx> zszyrwsMap = zyJbxxService.findNdzytjzysByid(zytjjbxx);
		model.addAttribute("zszyrwsMap", zszyrwsMap.get(0));
		return "modules/ndzyzstj/ndzyForm";
	}
	
	
	/**
	 * 年度专业统计导出
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "expotZytjList")
	public String expotZytjList(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		 WritableWorkbook wwb = null;
         String fileName = "";
         try {
			String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+"年度专业招生统计.xls";
			fileName = savePath;
			 File file = new File(fileName);
			 if (!file.exists())
			 {
			     file.getParentFile().mkdir();
			     file.createNewFile();
			 }
			 wwb = Workbook.createWorkbook(new File(fileName));
				// 创建一个可写入的工作表
				// Workbook的createSheet方法有两个参数，第一个是工作表的名称，第二个是工作表在工作薄中的位置
			 WritableSheet ws = wwb.createSheet("sheet1", 0);
			 /********************样式***************************/
			// 表头 字体样式[]
            WritableFont wf_title = new WritableFont(WritableFont.createFont("黑体"), 13, WritableFont.NO_BOLD, false);
            WritableCellFormat wctitle = new WritableCellFormat(wf_title);
            wctitle.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
            wctitle.setAlignment(Alignment.CENTRE);//横向居中
            wctitle.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//垂直居中
            wctitle.setBackground(Colour.GRAY_25);
            
            //内容样式
            WritableFont w2 = new WritableFont(WritableFont.createFont("宋体"), 11,
        			WritableFont.NO_BOLD, false,
        			UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
        	WritableCellFormat ww2 = new WritableCellFormat(w2);
        	ww2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
        	ww2.setAlignment(Alignment.CENTRE);
        	ww2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//单元格的内容垂直方向居中
        	
        	WritableFont w3 = new WritableFont(WritableFont.createFont("宋体"), 11,
         			WritableFont.NO_BOLD, false,
         			UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
         	WritableCellFormat ww3 = new WritableCellFormat(w3);
         	ww3.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
         	ww3.setAlignment(Alignment.RIGHT);
         	ww3.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//单元格的内容垂直方向居中
			
			/*****************************************************表头创建 begin****************************************/
			
			// 写入表头
            String[] titleName = {"招生专业名称","专业招生任务数","专业招生登记数","专业招生完成数","专业招生完成率"};
            for (int i = 0; i < titleName.length; i++)
            {
            	//行中内容
            	Label titleLab = new Label(i, 0, titleName[i], wctitle);
				ws.addCell(titleLab);
				ws.setColumnView(i, 20);
				ws.setRowView(i+1,320);//高度
            }
            if(zytjjbxx.getNewYear()==null || "".equals(zytjjbxx.getNewYear()) )
    		{
    			zytjjbxx.setNewYear(DateUtils.getYear());
    		}
    		List<ZytjJbxx> zytjList = zyJbxxService.findNdzytjList(zytjjbxx);
    		Map<String,Object> zyMap = this.getNdzytjMap(zytjList);
    		if(zyMap!=null)
    		{
    			List<String> zylist =(List<String>) zyMap.get("zy");
    			List<Integer> zsrws = (List<Integer>) zyMap.get("zsrws");//招生任务数
    			List<Integer> zsdjs = (List<Integer>) zyMap.get("zsdjs");//招生登记数
    			List<Integer> zswcs = (List<Integer>) zyMap.get("zswcs");//招生完成数
    			if(zylist!=null && zylist.size()>0)
    			{
    				for(int i=0;i<zylist.size();i++)
    				{
    					
    					String zymc = zylist.get(i);
    					Integer rws = zsrws.get(i);
    					Integer djs = zsdjs.get(i);
    					Integer wcs = zswcs.get(i);
    					String lv ="0.00%";
    					if(rws!=0 && wcs!=0)
    					{
    						double gl = (double)wcs/rws;
    				        DecimalFormat df = new DecimalFormat("#.00");
    				        lv =df.format(gl*100) +"%";
    						
    					}
    					Label labelC1 = new Label(0, i+1, zymc,ww2);//专业名称
    					ws.addCell(labelC1);
    					
    					Label labelC2 = new Label(1, i+1, rws.toString(),ww3);//招生任务数
    					ws.addCell(labelC2);
    					
    					Label labelC3 = new Label(2, i+1, djs.toString(),ww3);//招生登记哈数
    					ws.addCell(labelC3);
    					
    					Label labelC4 = new Label(3, i+1, wcs.toString(),ww3);//完成数
    					ws.addCell(labelC4);
    					
    					Label labelC5 = new Label(4, i+1,lv,ww3);//完成率
    					ws.addCell(labelC5);
    				}
    			}
    		}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			try {
				// 从内存中写入文件中
				wwb.write();
				// 关闭资源，释放内存
				wwb.close();
			} catch (Exception e) {
				e.printStackTrace();
			} 
		}
        return JsonMapper.toJsonString(fileName);
	}
	
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "updateFile")
	public void updateFile(HttpServletRequest request, HttpServletResponse response,@RequestParam("filePath") String filePath) throws IOException
	{
		//
		String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+"年度专业招生统计.xls";
		if(filePath.equals("2")){
			 savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+"年度间专业招生统计.xls";
		}
		upload(request, response, savePath);
		try {
			com.thinkgem.jeesite.common.utils.FileUtils.deleteFile(savePath);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// 下载web应用下的文件
	private void upload(HttpServletRequest request, HttpServletResponse response,String filePath) 
	{
		try {
	
			String savePath = filePath;
			File outfile = new File(savePath);
			String filename = outfile.getName();// 获取文件名称
			InputStream fis = new BufferedInputStream(new FileInputStream(
					savePath));
			byte[] buffer = new byte[fis.available()];
			fis.read(buffer); // 读取文件流
			fis.close();
			response.reset(); // 重置结果集
			response.addHeader("Content-Disposition", "attachment;filename="
					+ new String(
							filename.replaceAll(" ", "").getBytes("utf-8"),
							"iso8859-1")); // 返回头 文件名
			response.addHeader("Content-Length", "" + outfile.length()); // 返回头
																			// 文件大小
			response.setContentType("application/octet-stream"); // 设置数据种类
			// 获取返回体输出权
			OutputStream os = new BufferedOutputStream(
					response.getOutputStream());
			os.write(buffer); // 输出文件
			os.flush();
			os.close();
			}catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	
	private Map<String,Object> getNdzytjMap(List<ZytjJbxx> zytjList)
	{
		List<Integer> zsrws = new ArrayList<Integer>();//招生任务数
		List<Integer> zsdjs = new ArrayList<Integer>();//招生登记数
		List<Integer> zswcs = new ArrayList<Integer>();//招生完成数
		List<String> zylist = new ArrayList<String>();
		List<Map<String,Object>> zymapList = new ArrayList<Map<String,Object>>(); 
		String zyid = "";
		for(int i=0;i<zytjList.size();i++)
		{	
			Map<String,Object> map = new HashMap<String, Object>();
			ZytjJbxx entity = zytjList.get(i);
			if(i==0)
			{
				zyid = entity.getId();
				map.put("zyid", entity.getId());
				map.put("zymc", entity.getZymc());
				map.put("zyxzmc", entity.getZyxzmc());
				zymapList.add(map);
			}
			else{
				
				if(zyid.equals(entity.getId()))
				{
					zyid = entity.getId();
				}else{
					zyid = entity.getId();
					map.put("zyid", entity.getId());
					map.put("zymc", entity.getZymc());
					map.put("zyxzmc", entity.getZyxzmc());
					zymapList.add(map);
				}
			}
		}
		
		zyid = "";
		if(zymapList!=null && zymapList.size()>0){
			for(int j=0;j<zymapList.size();j++){
				Map<String,Object> zyMap = zymapList.get(j);
				String id = zyMap.get("zyid").toString();
				int index=0;
				int zstype=0;
				for(int i=0;i<zytjList.size();i++)
				{
					ZytjJbxx entity = zytjList.get(i);
					String zid = entity.getId();
					int type = StringUtils.toInteger(entity.getZstype());
					
					if(id.equals(zid))
					{
						if(index==0)
						{
							if(type==1){
								zsrws.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==2){
								zsrws.add(0);
								zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==3){
								zsrws.add(0);
								zsdjs.add(0);
								zswcs.add(StringUtils.toInteger(entity.getZsrs()));
							}
							
						}else
						{
							if(type==1){
								zsrws.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==2){
								zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
							}else if(type==3){
								zswcs.add(StringUtils.toInteger(entity.getZsrs()));
							}
						}
						index++;
						zstype=type;
					}
				}
				if(index==1)
				{
					if(zstype==1)
					{
						zsdjs.add(0);
						zswcs.add(0);
					}else if(zstype==2)
					{
						zswcs.add(0);
					}
				}else if(index==2)
				{
					if(zstype==1)
					{
						zsdjs.add(0);
						zswcs.add(0);
						
					}else if(zstype==2)
					{
						zswcs.add(0);
					}
					
				}
				String zymc="未知专业";
				if (zyMap.get("zymc")!=null) {
					zymc=zyMap.get("zymc").toString() +"("+zyMap.get("zyxzmc").toString()+")";
				}
				zylist.add(zymc);
			}
		}
		Map map = new HashMap();
		map.put("zsrws", zsrws);
		map.put("zsdjs", zsdjs);
		map.put("zswcs", zswcs);
		map.put("zy", zylist);
		return map;
		
	}
	
	
	/****************************年度间专业**********************************************/
	
	
	/**
	 * 初始化年度间专业统计list
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "ndjtjlist")
	public String ndjtjlist(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
	
		//查询计划年度
		List<Map> zsndList = zsjhService.findAllZsnd();
		model.addAttribute("zsndList", zsndList);
		
		//获取当前年和去年
		String nowYear = DateUtils.getYear();
		String oldYear = getYearByNowYear(nowYear);
		model.addAttribute("nowYear",nowYear);
		model.addAttribute("oldYear",oldYear);
		return "modules/ndjzyzstj/ndjtjList";
	}
	
	/**
	 * 年度间专业图形
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "ndjzytxtj")
	public String ndjzytxtj(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		return "modules/ndjzyzstj/ndjzytxtj";
	}
	
	/**\
	 * 年度间专业图表统计
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "ndjzytjJson")
	public String ndjzytjJson(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		List<String> nfList = new ArrayList<String>();
		List<ZytjJbxx> ndzytjList =new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> ndzytjList1 = new ArrayList<ZytjJbxx>();
		List<List<ZytjJbxx>> list = new ArrayList<List<ZytjJbxx>>();
		Map map = new HashMap();
		if(zytjjbxx.getZsnd1() == null || zytjjbxx.getZsnd1().length ==0){
			zytjjbxx.setNewYear(DateUtils.getYear());
			
			nfList.add(zytjjbxx.getNewYear());
			//当前年份统计专业数
			ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
			//上一年
			nfList.add(getYearByNowYear(zytjjbxx.getNewYear()));
			zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
			ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
			list.add(0,ndzytjList);
			list.add(1,ndzytjList1);
//			map = this.getZytjMap(ndzytjList, ndzytjList1);
			map = getDistinctZy(list,nfList);
		}else
		{
			if(zytjjbxx.getZsnd1().length ==1)
			{
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[0]);
				nfList.add(zytjjbxx.getZsnd1()[0]);
				//当前年份统计专业数
				ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
				//上一年
				nfList.add(getYearByNowYear(zytjjbxx.getZsnd1()[0]));
				zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
				ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
				list.add(0,ndzytjList);
				list.add(1,ndzytjList1);
//				map = this.getZytjMap(ndzytjList, ndzytjList1);
				map = getDistinctZy(list,nfList);
			}else
			{
				for(int i=0;i<zytjjbxx.getZsnd1().length;i++){
					zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[i]);
					nfList.add(i,zytjjbxx.getZsnd1()[i]);
					List<ZytjJbxx> tjList = zyJbxxService.findNdzytjList(zytjjbxx);
					list.add(i,tjList);
				}
//				map = this.getZytjMapBynd(list);
				map = getDistinctZy(list,nfList);
			}
		}
		
		map.put("nf", nfList);
		return JsonMapper.toJsonString(map);
	}
	
	
	/**
	 * 年度间专业列表
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "ndjzylbtj")
	public String ndjzylbtj(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		List<List<ZytjJbxx>> list = new ArrayList<List<ZytjJbxx>>();
		Map map = new HashMap();
		List<ZytjJbxx> ndzytjList =new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> ndzytjList1 = new ArrayList<ZytjJbxx>();
		List<String> nfList = new ArrayList<String>();
		if(zytjjbxx.getZsnd1() == null || zytjjbxx.getZsnd1().length ==0){
			zytjjbxx.setNewYear(DateUtils.getYear());
			nfList.add(zytjjbxx.getNewYear());
			//当前年份统计专业数
			ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
			//上一年
			nfList.add(getYearByNowYear(zytjjbxx.getNewYear()));
			zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
			ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
//			map = this.getZytjMap(ndzytjList, ndzytjList1);
			list.add(0, ndzytjList);
			list.add(1, ndzytjList1);
			map = this.getDistinctZy(list,nfList);
		}else{
			if(zytjjbxx.getZsnd1().length ==1)
			{
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[0]);
				nfList.add(zytjjbxx.getZsnd1()[0]);
				//当前年份统计专业数
				ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
				//上一年
				nfList.add(getYearByNowYear(zytjjbxx.getZsnd1()[0]));
				zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
				ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
//				map = this.getZytjMap(ndzytjList, ndzytjList1);
				list.add(0, ndzytjList);
				list.add(1, ndzytjList1);
				map = this.getDistinctZy(list,nfList);
			}else{
				for(int i=0;i<zytjjbxx.getZsnd1().length;i++){
					zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[i]);
					nfList.add(i,zytjjbxx.getZsnd1()[i]);
					List<ZytjJbxx> tjList = zyJbxxService.findNdzytjList(zytjjbxx);
					list.add(i,tjList);
				}
				map = this.getDistinctZy(list,nfList);
//				Map zymap = this.getZytjMapBynd(list);
			}
		}
		
		map.put("nf", nfList);
		model.addAttribute("map", map);
		return "modules/ndjzyzstj/ndjzylbtj";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequiresPermissions("tj:ndzyzstj:view")
	@RequestMapping(value = "findndjzytj")
	public String findndjzytj(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		List<String> newList  = new ArrayList<String>(); 
		List<String> yearList = new ArrayList<String>();
		List<ZytjJbxx> newZytjList = new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> nowYearList =new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> oldYearList = new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> list1= new ArrayList<ZytjJbxx>();
		if(zytjjbxx.getZsnd1() == null || zytjjbxx.getZsnd1().length ==0){
			zytjjbxx.setNewYear(DateUtils.getYear());
			yearList.add(0, zytjjbxx.getNewYear());
			//当前年份
			nowYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
			List<ZytjJbxx> zszyrwsMap = zyJbxxService.findNdzytjzysByid(zytjjbxx);
			model.addAttribute("zszyrwsMap", zszyrwsMap.get(0));
			//去年
			yearList.add(1, getYearByNowYear(zytjjbxx.getNewYear()));
			zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
			oldYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
			List<ZytjJbxx> zszyrwsMap1 = zyJbxxService.findNdzytjzysByid(zytjjbxx);
			model.addAttribute("zszyrwsMap1", zszyrwsMap1.get(0));
			newZytjList.addAll(nowYearList);
			newZytjList.addAll(oldYearList);
			
		}else
		{
			if(zytjjbxx.getZsnd1().length ==1)
			{
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[0]);
				yearList.add(0,zytjjbxx.getZsnd1()[0]);
				nowYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
				List<ZytjJbxx> zszyrwsMap = zyJbxxService.findNdzytjzysByid(zytjjbxx);
				model.addAttribute("zszyrwsMap", zszyrwsMap.get(0));
				
				//去年
				yearList.add(1, getYearByNowYear(zytjjbxx.getZsnd1()[0]));
				zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getZsnd1()[0]));
				oldYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
				List<ZytjJbxx> zszyrwsMap1 = zyJbxxService.findNdzytjzysByid(zytjjbxx);
				model.addAttribute("zszyrwsMap1", zszyrwsMap1.get(0));
				newZytjList.addAll(nowYearList);
				newZytjList.addAll(oldYearList);
			}else
			{
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[0]);
				yearList.add(0,zytjjbxx.getZsnd1()[0]);
				nowYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
				List<ZytjJbxx> zszyrwsMap = zyJbxxService.findNdzytjzysByid(zytjjbxx);
				model.addAttribute("zszyrwsMap", zszyrwsMap.get(0));
				
				//去年
				yearList.add(1, zytjjbxx.getZsnd1()[1]);
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[1]);
				oldYearList = zyJbxxService.findNdzytjListByid(zytjjbxx);
				List<ZytjJbxx> zszyrwsMap1 = zyJbxxService.findNdzytjzysByid(zytjjbxx);
				model.addAttribute("zszyrwsMap1", zszyrwsMap1.get(0));
				newZytjList.addAll(nowYearList);
				newZytjList.addAll(oldYearList);
				if(zytjjbxx.getZsnd1().length >=3 )
				{
					yearList.add(2, zytjjbxx.getZsnd1()[2]);
					zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[2]);
					list1 = zyJbxxService.findNdzytjListByid(zytjjbxx);
					List<ZytjJbxx> zszyrwsMap2 = zyJbxxService.findNdzytjzysByid(zytjjbxx);
					model.addAttribute("zszyrwsMap2", zszyrwsMap2.get(0));
					newZytjList.addAll(list1);
				}
			}
			
		}
		//去重后的招生部门
		List<Map<String,Object>> jgList = new ArrayList<Map<String,Object>>();
		if(newZytjList!=null && newZytjList.size()>0){
			for(int i=0; i<newZytjList.size(); i++){
				ZytjJbxx entity = newZytjList.get(i);
				String zsbm = entity.getZsbm();
				Map map = new HashMap();
				if(!newList.contains(zsbm)){
					newList.add(zsbm);
					map.put("zsbm", zsbm);
					map.put("zsbmmc", entity.getZsbmmc());
					jgList.add(map);
				}
			}
		}
		model.addAttribute("nowYearList", nowYearList);
		model.addAttribute("oldYearList", oldYearList);
		model.addAttribute("list1", list1);
		model.addAttribute("jgList", jgList);
		ZyJbxx zyEntity = get(zytjjbxx.getId());
		model.addAttribute("zyEntity", zyEntity);
		//招生机构类型
		List<Dict> zsjglist =DictUtils.getDictList("ly");
		model.addAttribute("zsjglist", zsjglist);
		
		model.addAttribute("yearList", yearList);
		return "modules/ndjzyzstj/findndjzytjform";
	}
		
	
	/**
	 * 根据当前年份获取上一年份
	 * @return
	 */
	public String getYearByNowYear(String dataStr)
	{
		SimpleDateFormat format = new SimpleDateFormat("yyyy");
		Calendar c = Calendar.getInstance();
		Date date= null;
		try {
			date = new SimpleDateFormat("yyyy").parse(dataStr);
		} catch (ParseException e) {
			e.printStackTrace();
		} 
		c.setTime(date);
        c.add(Calendar.YEAR, -1);
        Date y = c.getTime();
        String year = format.format(y);
		return year;
	}
	
	
	/**
	 * 	年度间专业统计导出
	 * @param zytjjbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws WriteException
	 */
	@ResponseBody
	@RequestMapping(value = "expotNdjZytjList")
	public String expotNdjZytjList(ZytjJbxx zytjjbxx, HttpServletRequest request, HttpServletResponse response, Model model) throws WriteException
	{
		List<String> nfList = new ArrayList<String>();
		List<ZytjJbxx> ndzytjList =new ArrayList<ZytjJbxx>();
		List<ZytjJbxx> ndzytjList1 = new ArrayList<ZytjJbxx>();
		List<List<ZytjJbxx>> list = new ArrayList<List<ZytjJbxx>>();
		Map map = new HashMap();
		if(zytjjbxx.getZsnd1() == null || zytjjbxx.getZsnd1().length ==0){
			zytjjbxx.setNewYear(DateUtils.getYear());
			
			nfList.add(zytjjbxx.getNewYear());
			//当前年份统计专业数
			ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
			//上一年
			nfList.add(getYearByNowYear(zytjjbxx.getNewYear()));
			zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
			ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
			list.add(0,ndzytjList);
			list.add(1,ndzytjList1);
		}else
		{
			if(zytjjbxx.getZsnd1().length ==1)
			{
				zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[0]);
				nfList.add(zytjjbxx.getZsnd1()[0]);
				//当前年份统计专业数
				ndzytjList = zyJbxxService.findNdzytjList(zytjjbxx);
				//上一年
				nfList.add(getYearByNowYear(zytjjbxx.getZsnd1()[0]));
				zytjjbxx.setNewYear(getYearByNowYear(zytjjbxx.getNewYear()));
				ndzytjList1 = zyJbxxService.findNdzytjList(zytjjbxx);
				list.add(0,ndzytjList);
				list.add(1,ndzytjList1);
			}else
			{
				for(int i=0;i<zytjjbxx.getZsnd1().length;i++){
					zytjjbxx.setNewYear(zytjjbxx.getZsnd1()[i]);
					nfList.add(i,zytjjbxx.getZsnd1()[i]);
					List<ZytjJbxx> tjList = zyJbxxService.findNdzytjList(zytjjbxx);
					list.add(i,tjList);
				}
			}
		}
		map = getDistinctZy(list,nfList);
		 WritableWorkbook wwb = null;
         String fileName = "";
		if(map!=null)
		{
			List<String> zyList = (List<String>)map.get("zy");//专业
			List<Map<String,Object>> listMap = (List<Map<String,Object>>)map.get("listMap");
			
			String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+"年度间专业招生统计.xls";
			fileName = savePath;
			 File file = new File(fileName);
			try {
				if (!file.exists())
				 {
				     file.getParentFile().mkdir();
				     file.createNewFile();
				 }
				 wwb = Workbook.createWorkbook(new File(fileName));
				// 创建一个可写入的工作表
				// Workbook的createSheet方法有两个参数，第一个是工作表的名称，第二个是工作表在工作薄中的位置
				WritableSheet ws = wwb.createSheet("sheet1", 0);
				 
				 /********************样式***************************/
				// 表头 字体样式[]
	            WritableFont wf_title = new WritableFont(WritableFont.createFont("黑体"), 13, WritableFont.NO_BOLD, false);
	            WritableCellFormat wctitle = new WritableCellFormat(wf_title);
	            wctitle.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
	            wctitle.setAlignment(Alignment.CENTRE);//横向居中
	            wctitle.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//垂直居中
	            wctitle.setBackground(Colour.GRAY_25);
	            
	            //内容样式
	            WritableFont w2 = new WritableFont(WritableFont.createFont("宋体"), 11,
	        			WritableFont.NO_BOLD, false,
	        			UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
	        	WritableCellFormat ww2 = new WritableCellFormat(w2);
	        	ww2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
	        	ww2.setAlignment(Alignment.CENTRE);
	        	ww2.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//单元格的内容垂直方向居中
	        	
	        	WritableFont w3 = new WritableFont(WritableFont.createFont("宋体"), 11,
	         			WritableFont.NO_BOLD, false,
	         			UnderlineStyle.NO_UNDERLINE, Colour.BLACK);
	         	WritableCellFormat ww3 = new WritableCellFormat(w3);
	         	ww3.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN);
	         	ww3.setAlignment(Alignment.RIGHT);
	         	ww3.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//单元格的内容垂直方向居中
				
				/*****************************************************表头创建 begin****************************************/
	         	// 写入表头
	            String[] titleName = {"招生专业名称","招生年度","专业招生任务数","专业招生登记数","专业招生完成数","专业招生完成率"};
	            for (int i = 0; i < titleName.length; i++)
	            {
	            	//行中内容
	            	Label titleLab = new Label(i, 0, titleName[i], wctitle);
					ws.addCell(titleLab);
					ws.setColumnView(i, 20);
					ws.setRowView(i+1,320);//高度
	            }
	            int ndLen = listMap.size();//年度数量
	            int index =0;
	            if(zyList!=null && zyList.size()>0)
	            {
	            	for(int i=0;i<zyList.size();i++)
	            	{
	            		String zymc = "";//专业名称
	            		if(zyList.get(i)!=null && zyList.get(i)!="null"){
	            			zymc = zyList.get(i);
	            		}
	            		Label labelC1 = new Label(0, 1+index, zymc,ww2);//专业名称
    					ws.addCell(labelC1);
    					ws.mergeCells(0, 1+index, 0, index+ndLen);
	            		for(int j=0;j<listMap.size();j++)
	            		{
	            			Map zyMap = listMap.get(j);
	            			String nd = (String)zyMap.get("nf");
	            			Map<String,Object> objMap = (Map<String,Object>)zyMap.get("nfMap");
	            			List<Integer> zsrwsList = (List<Integer>)objMap.get("zsrws");
	            			List<Integer> zsdjsList = (List<Integer>)objMap.get("zsdjs");
	            			List<Integer> zswcsList = (List<Integer>)objMap.get("zswcs");
	            			
	            			Integer rws = zsrwsList.get(i);
	            			Integer djs = zsdjsList.get(i);
	    					Integer wcs = zswcsList.get(i);
	    					String lv ="0.00%";
	    					if(rws!=0 && wcs!=0)
	    					{
	    						double gl = (double)wcs/rws;
	    				        DecimalFormat df = new DecimalFormat("#.00");
	    				        lv =df.format(gl*100) +"%";
	    					}
	    					
	    					Label labelC2 = new Label(1, j+1+index,nd,ww2);//年度
	    					ws.addCell(labelC2);
	    					
	    					Label labelC3 = new Label(2, j+1+index, rws.toString(),ww3);//招生登记哈数
	    					ws.addCell(labelC3);
	    					
	    					Label labelC4 = new Label(3, j+1+index, djs.toString(),ww3);//完成数
	    					ws.addCell(labelC4);
	    					
	    					Label labelC5 = new Label(4, j+1+index, wcs.toString(),ww3);//完成率
	    					ws.addCell(labelC5);
	    					
	    					Label labelC6 = new Label(5, j+1+index,lv,ww3);//完成率
	    					ws.addCell(labelC6);
	            		}
	            		index+=ndLen;
	            	}
	            	
	            }
				 
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				try {
					// 从内存中写入文件中
					wwb.write();
					// 关闭资源，释放内存
					wwb.close();
				} catch (Exception e) {
					e.printStackTrace();
				} 
			}
			
		}
		return JsonMapper.toJsonString(fileName);
	}
	
	
	
	
	
	
	
	
	/**
	 * 	去重专业
	 * @param zslist
	 * @param nfList 年份
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private Map getDistinctZy(List<List<ZytjJbxx>> zslist,List<String> nfList)
	{
		List<ZytjJbxx> listAll = new ArrayList<ZytjJbxx>();
		List<Map<String,Object>> zymapList = new ArrayList<Map<String,Object>>(); 
		List<String> zylist = new ArrayList<String>();//专业
		if(zslist!= null && zslist.size()>0)
		{
			for(List<ZytjJbxx> list : zslist){
				listAll.addAll(list);
			}
		}
		
		
		if(listAll!=null && listAll.size()>0)
		{
			for(int i=0;i<listAll.size();i++)
			{
				Map<String,Object> map = new HashMap<String, Object>();
				ZytjJbxx entity = listAll.get(i);
				String zymc = entity.getZymc();
				String zyxzmc = entity.getZyxzmc();
				if(i==0)
				{
					map.put("zyid", entity.getId());
					map.put("zymc", entity.getZymc());
					map.put("zyxzmc", entity.getZyxzmc());
					zymapList.add(map);
					zylist.add(entity.getZymc()+"("+zyxzmc+")");
				}else{
					
					if(!zylist.contains(zymc+"("+zyxzmc+")")){
						zylist.add(zymc+"("+zyxzmc+")");
						map.put("zyid", entity.getId());
						map.put("zymc", entity.getZymc());
						map.put("zyxzmc", entity.getZyxzmc());
						zymapList.add(map);
					}
				}
			}
		}
		
		Map map = new HashMap();
		map.put("zy", zylist);
		map.put("zymapList", zymapList);
		
		List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
		List<List<Integer>> list = new ArrayList<List<Integer>>();
		if(zslist!= null && zslist.size()>0)
		{
			for(int i=0;i<zslist.size();i++){
				Map<String,Object> mapJson = new HashMap<String, Object>();
				List<ZytjJbxx> zytjList = zslist.get(i);
				Map<String,Object> map1 = this.getZytjList(zytjList, zymapList);
				mapJson.put("nfMap", map1);
				mapJson.put("nf", nfList.get(i));
				listMap.add(mapJson);
			}
		}
		map.put("listMap", listMap);
		map.put("list", list);
		return map;
		
	}
	
	/**
	 * 去重专业并获取专业对应的登记数
	 * @param zytjList
	 * @param zymapList
	 * @return
	 */
	private Map<String,Object> getZytjList(List<ZytjJbxx> zytjList,List<Map<String,Object>> zymapList)
	{
		List<Integer> zsrws = new ArrayList<Integer>();//招生任务数
		List<Integer> zsdjs = new ArrayList<Integer>();//招生登记数
		List<Integer> zswcs = new ArrayList<Integer>();//招生完成数
		if(zymapList!=null && zymapList.size()>0)
		{
			for(int j=0;j<zymapList.size();j++)
			{
				Map<String,Object> zyMap = zymapList.get(j);
				String id = zyMap.get("zyid").toString();
				int index=0;
				int zstype=0;
				if(zytjList!=null && zytjList.size()>0)
				{
					for(int i=0;i<zytjList.size();i++)
					{
						ZytjJbxx entity = zytjList.get(i);
						String zid = entity.getId();
						int type = StringUtils.toInteger(entity.getZstype());
						if(id.equals(zid))
						{
							if(index==0)
							{
								if(type==1){
									zsrws.add(StringUtils.toInteger(entity.getZsrs()));
								}else if(type==2){
									zsrws.add(0);
									zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
								}else if(type==3){
									zsrws.add(0);
									zsdjs.add(0);
									zswcs.add(StringUtils.toInteger(entity.getZsrs()));
								}
								
							}else
							{
								if(type==1){
									zsrws.add(StringUtils.toInteger(entity.getZsrs()));
								}else if(type==2){
									zsdjs.add(StringUtils.toInteger(entity.getZsrs()));
								}else if(type==3){
									zswcs.add(StringUtils.toInteger(entity.getZsrs()));
								}
							}
							index++;
							zstype=type;
						}
					}
					if(index ==0)
					{
						zsrws.add(0);
						zsdjs.add(0);
						zswcs.add(0);
					}
					else if(index==1)
					{
						if(zstype==1)
						{
							zsdjs.add(0);
							zswcs.add(0);
						}else if(zstype==2)
						{
							zswcs.add(0);
						}
					}else if(index==2)
					{
						if(zstype==1)
						{
							zsdjs.add(0);
							zswcs.add(0);
							
						}else if(zstype==2)
						{
							zswcs.add(0);
						}
						
					}
				}else
				{
					zsrws.add(0);
					zsdjs.add(0);
					zswcs.add(0);
				}
			}
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("zsrws", zsrws);
		map.put("zsdjs", zsdjs);
		map.put("zswcs", zswcs);
		return map;
	}
	
	

}

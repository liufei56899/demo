/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsdj.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.CommonUtils;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.FileTxtUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.utils.excel.ImportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;
import com.thinkgem.jeesite.modules.school.service.SchoolinfoService;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.DictService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;
import com.thinkgem.jeesite.modules.zszy.service.JhZyInfoService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 招生登记Controller
 * 
 * @author lg
 * @version 2016-05-05
 */
@Controller
@RequestMapping(value = "${adminPath}/zsdj/zsdj")
public class ZsdjController extends BaseController {

	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private ZyJbxxService zyJbxxService;// 专业信息

	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private SchoolinfoService schoolinfoService;

	@Autowired
	private ZsdjService zsdjService;
	@Autowired
	private DictService dictService;
	@Autowired
	private JhZyInfoService jhZyInfoService;
	
/*	private POIFSFileSystem fs;
	private HSSFWorkbook wb;
	private HSSFSheet sheet;
	private HSSFRow row;*/
	private POIFSFileSystem fs;
	private HSSFWorkbook wb;
	private HSSFSheet sheet;
	private HSSFRow row;
	@ModelAttribute
	public Zsdj get(@RequestParam(required = false) String id) {
		Zsdj entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = zsdjService.get(id);
		}
		if (entity == null) {
			entity = new Zsdj();
		}
		return entity;
	}

	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "list", "list" })
	public String list(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		//zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		model.addAttribute("page", page);
		return "modules/zsdj/zsdjList";
	}

	/**
	 * 报到注册查询页面，查询列表
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listByXsbd", "listByXsbd" })
	public String listByXsbd(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		if (zsdj==null) {
			zsdj=new Zsdj();
		}
		if (zsdj.getZsdjzt()==null || zsdj.getZsdjzt().equals("")) {
			zsdj.setZsdjzt("1,2,3");
		}
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		model.addAttribute("page", page);
		return "modules/xsbd/bdByZsdjList";
	}
	//报到注册增加拍照页面
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "getImage")
	public String getImage(Zsdj zsdj, Model model) {
		model.addAttribute("id", zsdj.getId());
		model.addAttribute("zsdj", zsdj);
		return "modules/xsbd/getImages";
	}
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "getPic")
	public String getPic(Zsdj zsdj, Model model) {
		model.addAttribute("id", zsdj.getId());
		model.addAttribute("zsdj", zsdj);
		//System.out.println(zsdj.getXm()+"=========="+zsdj.getSfzjh());
		return "modules/xsbd/getImage";
	}
	/**
	 * 报名登记查询页面，查询列表
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listByXsbd2", "listByXsbd2" })
	public String listByXsbd2(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {		
		JsJbxx jsjbxx=new JsJbxx();
		jsjbxx.setId(UserUtils.getUser().getId());
		zsdj.setJs(jsjbxx);
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		
		model.addAttribute("page", page);
		return "modules/xsbd/bdByZsdjList2";
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listByXsbd3", "listByXsbd3" })
	public String listByXsbd3(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		
		model.addAttribute("page", page);
		return "modules/xsbd/bdByZsdjList3";
	}
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "bdzcExport")
	public String bdzcExport(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		
		return "modules/xsbd/bdzcExport";
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "IdCardExport")
	public String IdCardExport(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		
		return "modules/xsbd/IdCardExport";
	}
	
	@ResponseBody
	@RequestMapping(value = "exportBdzcByCol")
	public String exportBdzcByCol(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		//存取导出的列和字段
		List<Map<String,Object>> listStr = new ArrayList<Map<String,Object>>();
		String checkType = zsdj.getCheckType();
		if(checkType!=null && !"".equals(checkType))
		{
			String[] columnArr = checkType.split(",");
			for(int i=0;i<columnArr.length;i++){
				Integer val = StringUtils.toInteger(columnArr[i]) ;
				Map<String,Object> map = new HashMap<String, Object>();
				if(val==1){
					map.put("col", "学生姓名");
					map.put("key", "xm");
				}else if(val==2){
					map.put("col", "性别");
					map.put("key", "xbname");
				}else if(val==3){
					map.put("col", "身份证件号码");
					map.put("key", "sfzjh");
				}
				else if(val==4){
					map.put("col", "专业类别");
					map.put("key", "lxmc");
				}
				else if(val==5){
					map.put("col", "专业名称");
					map.put("key", "zymc");
				}
				else if(val==6){
					map.put("col", "出生日期");
					map.put("key", "csrq");
				}
				else if(val==7){
					map.put("col", "家庭住址");
					map.put("key", "jtzz");
				}else if(val==8){
					map.put("col", "报到状态");
					map.put("key", "zsdjztname");
				}else if(val==9){
					map.put("col", "创建时间");
					map.put("key", "createDate");
				}else if(val==10){
					map.put("col", "学生类别");
					map.put("key", "xslym");
				}else if(val==11){
					map.put("col", "毕业学校");
					map.put("key", "fromSchool");
				}else if(val==12){
					map.put("col", "准考证号");
					map.put("key", "zkzh");
				}else if(val==13){
					map.put("col", "招生老师");
					map.put("key", "name");
				}else if(val==14){
					map.put("col", "学制");
					map.put("key", "xz");
				}else if(val==15){
					map.put("col", "备注");
					map.put("key", "remarks");
				}
				listStr.add(map);
			}
		}
		
	    List<Zsdj> zsdjList = zsdjService.findList(zsdj);
	    String fileName = expotBdzcList(listStr, zsdjList, request, response, model);
		return fileName;
	}
	
	
	@ResponseBody
	@RequestMapping(value = "idCardexportByCol")
	public String idCardexportByCol(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		//存取导出的列和字段
		List<Map<String,Object>> listStr = new ArrayList<Map<String,Object>>();
		String checkType = zsdj.getCheckType();
		if(checkType!=null && !"".equals(checkType))
		{
			String[] columnArr = checkType.split(",");
			for(int i=0;i<columnArr.length;i++){
				Integer val = StringUtils.toInteger(columnArr[i]) ;
				Map<String,Object> map = new HashMap<String, Object>();
				if(val==1){
					map.put("col", "学生姓名");
					map.put("key", "xm");
				}else if(val==2){
					map.put("col", "班级");
					map.put("key", "bj");
				}else if(val==3){
					map.put("col", "性别");
					map.put("key", "xbname");
				}
				else if(val==4){
					map.put("col", "民族");
					map.put("key", "nation");
				}
				else if(val==5){
					map.put("col", "身份证件号");
					map.put("key", "sfzjh");
				}
				else if(val==6){
					map.put("col", "出生日期");
					map.put("key", "csrq");
				}
				else if(val==7){
					map.put("col", "家庭住址");
					map.put("key", "jtzz");
				}
				listStr.add(map);
			}
		}
		
	    List<Zsdj> zsdjList = zsdjService.findList(zsdj);
	    String fileName = expotBdzcList(listStr, zsdjList, request, response, model);
		return fileName;
	}
	
	public String expotBdzcList(List<Map<String,Object>> listStr,List<Zsdj> zsdjList,HttpServletRequest request, HttpServletResponse response, Model model)
	{
		 WritableWorkbook wwb = null;
         String fileName = "";
         try {
			String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+"StudentInfo.xls";
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
			 //********************样式***************************//*
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
			
			//*****************************************************表头创建 begin****************************************//*
         	
         	Label titleLab1 = new Label(0, 0, "序号", wctitle);
         	ws.addCell(titleLab1);
         	
         	ws.setColumnView(0, 20);
			ws.setRowView(0,320);//高度// 写入表头
            for (int i = 0; i < listStr.size(); i++)
            {
            	Map<String,Object> mapTit = listStr.get(i);
            	String titleName = mapTit.get("col").toString();
            	//行中内容
            	Label titleLab = new Label(i+1, 0, titleName, wctitle);
				ws.addCell(titleLab);
				ws.setColumnView(i, 20);
				ws.setRowView(i+1,320);//高度
            }
            
            int j=0;
            if(zsdjList!=null && zsdjList.size()>0){
            	for(Zsdj zsdjEn :zsdjList){
            		String xh = j+1+"";
            		Label labelC2 = new Label(0, j+1,xh ,ww2);
					ws.addCell(labelC2);
            		
            		for (int i = 0; i < listStr.size(); i++)
                    {
            			Map<String,Object> mapZiDuan = listStr.get(i);
            			String ziDuan = mapZiDuan.get("key").toString();
            			
            			//获取字段
            			java.lang.reflect.Field xmField = zsdjEn.getClass().getDeclaredField(ziDuan);
                		xmField.setAccessible(true);  
                		//获取字段值
                		String xmVal = "";
                		if(ziDuan.equals("csrq") || ziDuan.equals("createDate")){
                			Object obj=  xmField.get(zsdjEn);
                			if(obj!=null)
                			{
                				Date d =(Date) obj; 
                				xmVal = DateUtils.formatDate(d, "yyyy-MM-dd");
                			}
                    		if(xmVal ==null || "".equals(xmVal)){
                    			xmVal ="";
                    		}
            			}
            			else{
            				//获取字段值
                    		xmVal = (String) xmField.get(zsdjEn);
                    		if(xmVal ==null || "".equals(xmVal)){
                    			xmVal ="";
                    		}
                    		
                    		if(xmVal !=null && !"".equals(xmVal)){
                    			if(ziDuan.equals("xslym"))
                        		{
                        			xmVal = DictUtils.getDictLabels(xmVal, "xs_ly","0");
                        		}
                    		}
                    		
                    		if(xmVal !=null && !"".equals(xmVal)){
                    			if(ziDuan.equals("nation"))
                        		{
                        			xmVal = DictUtils.getDictLabels(xmVal, "nation","0");
                        		}
                    		}
                    		
                    		
            			}
                		Label labelC1 = new Label(1+i, j+1, xmVal,ww2);
    					ws.addCell(labelC1);
                    }
            		j++;
            	}
            }
         }catch (Exception e) {
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
	
	
	/**
	 * @param request
	 * @param response
	 * @param filePath
	 * @throws IOException
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "updateFile")
	public void updateFile(HttpServletRequest request, HttpServletResponse response,@RequestParam("filePath") String filePath) throws IOException
	{
		upload(request, response, filePath);
		try {
			com.thinkgem.jeesite.common.utils.FileUtils.deleteFile(filePath);
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
	
	
	

	/**
	 * 报到注册页面ajax异步请求查询
	 * 
	 * @param name
	 * @param sex
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "listByXsbdSerachZsdj")
	public String listByXsbdSerachZsdj(Zsdj zsdj, RedirectAttributes redirectAttributes) {
//		Page<Zsdj> page = zsdjService.findPage(
//				new Page<Zsdj>(request, response), zsdj);
//		model.addAttribute("page", page);
		zsdj.setRemarks("09");//查询招生计划时间段内的
		List<Zsdj> list=zsdjService.findList(zsdj);
		return JsonMapper.toJsonString(list);
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "bdzcList", "bdzcList" })
	public String bdzcList(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model)
	{
		zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		model.addAttribute("page", page);
		return "modules/zsdj/bdzcList";
		
	}

	/**
	 * 现场报名登记查询
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "mmlist", "" })
	public String mmlist(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		zsdj.setLy("3");
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);

		model.addAttribute("page", page);
		return "modules/zsdj/mmList";
	}

	/**
	 * 网上报名登记查询
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "wslist", "" })
	public String wslist(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		zsdj.setLy("2");
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		/*
		 * for (int i = 0; i < page.getList().size(); i++) { String jsid =
		 * page.getList().get(i).getJs().getId(); JsJbxx js =
		 * jsJbxxService.getJsByUser(jsid); page.getList().get(i).setJs(js); }
		 */
		model.addAttribute("page", page);
		return "modules/zsdj/wsList";
	}

	/**
	 * 招生老师报名登记查询
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "zslslist", "" })
	public String zslslist(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		zsdj.setLy("1");
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		/*
		 * for (int i = 0; i < page.getList().size(); i++) { String jsid =
		 * page.getList().get(i).getJs().getId(); JsJbxx js =
		 * jsJbxxService.getJsByUser(jsid); page.getList().get(i).setJs(js); }
		 */
		model.addAttribute("page", page);
		return "modules/zsdj/zslsList";
	}

	/**
	 * 代理机构报名登记查询
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "dljglist", "" })
	public String dljglist(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj.setCreateBy(UserUtils.getUser());// 查看当前登录人的招生登记信息
		zsdj.setLy("4");
		Page<Zsdj> page = zsdjService.findPage(
				new Page<Zsdj>(request, response), zsdj);
		/*
		 * for (int i = 0; i < page.getList().size(); i++) { String jsid =
		 * page.getList().get(i).getJs().getId(); JsJbxx js =
		 * jsJbxxService.getJsByUser(jsid); page.getList().get(i).setJs(js); }
		 */
		model.addAttribute("page", page);
		return "modules/zsdj/dljgList";
	}

	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "form")
	public String form(Zsdj zsdj, Model model) {
		model.addAttribute("zsdj", zsdj);
		return "modules/zsdj/zsdjForm";
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "editZsjsForm")
	public String editZsjsForm(Zsdj zsdj, Model model) {
		model.addAttribute("zsdj", zsdj);
		return "modules/zsdj/editZsjsForm";
	}

	//手机端新加=========
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "formMobile")
	public String formMobile(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		model.addAttribute("zsdj", zsdj);
		return "modules/zsdj/zsdjForm";
	}
	
	
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "save")
	public String save(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {
		if (zsdj.getNj()==null) {
			XnJbxx nj=new XnJbxx();
			zsdj.setNj(nj);
			
		}
		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);
		zsdj.setZsdjzt(CommonUtils.YUBAOMING);
		zsdj.setName(UserUtils.getUser().getName());
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}
		zsdjService.save(zsdj);
		addMessage(redirectAttributes, "保存招生登记成功");
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/listByXsbd2?repage";
	}
	
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "saveZsjs")
	public String saveZsjs(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}
		zsdjService.save(zsdj);
		addMessage(redirectAttributes, "修改招生老师成功");
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/list?repage";
	}
	
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "updateXsInfo")
	public String updateXsInfo(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {
		/*if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}*/
		zsdjService.save(zsdj);
		addMessage(redirectAttributes, "修改学生信息成功！");
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/listByXsbd3";
	}
	
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "saveWs")
	public String saveWs(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {

		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);

		zsdj.setName(UserUtils.getUser().getName());
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}
		zsdjService.save(zsdj);
		addMessage(redirectAttributes, "保存招生登记成功");
		/*pageWs = zsdj.getLy();
		if(pageWs!=null && !"".equals(pageWs))
		{
			urlPage = "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/wslist?repage";
		}*/
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/wslist?repage";
	}
	
	

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "savemm")
	public String saveMM(Zsdj zsdj, Model model, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		// 老师
		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);
		zsdj.setZsdjzt(CommonUtils.YUBAOMING);
		zsdj.setName(UserUtils.getUser().getName());
		// 当前登录用户的部门
		zsdj.setOffice(UserUtils.getUser().getOffice());
		if (!beanValidator(model, zsdj)) {
			return listmm(zsdj, request, response, model);
		}
		zsdjService.save(zsdj);
		this.addPropertys(model);
		model.addAttribute("tip", "保存招生登记成功");
		// return "modules/zsdj/zsdjFormMM";
		if (zsdj.getBcfs().equals("save")) {
			return "redirect:" + Global.getAdminPath()
					+ "/zsdj/zsdj/mmlist?repage";
		} else if (zsdj.getBcfs().equals("saveAndAdd")) {
			return "modules/zsdj/zsdjFormMM";
		}
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/mmlist?repage";
	}

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "savews")
	public String saveWS(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {

		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);

		zsdj.setName(UserUtils.getUser().getName());
		// 当前登录用户的部门
		zsdj.setOffice(UserUtils.getUser().getOffice());
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}

		zsdjService.save(zsdj);
		// addMessage(redirectAttributes, "保存招生登记成功");
		this.addPropertys(model);
		model.addAttribute("tip", "保存招生登记成功");
		// return "modules/zsdj/zsdjFormMM";
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/wslist?repage";
	}

	@SuppressWarnings("unchecked")
	@ResponseBody
	/* @RequiresPermissions("zsdj:zsdj:view") */
	@RequestMapping(value = "getZsdjBySfzh")
	public String getZsdjBySfzh(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {
		zsdj = zsdjService.getZsdjBySfzh(zsdj);
		@SuppressWarnings("rawtypes")
		Map m = new HashMap();
		m.put("zsdj", zsdj);
		//System.out.println(JsonMapper.toJsonString(m)+"    =======================================");
		return JsonMapper.toJsonString(m);
	}

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "savezs")
	public String saveZS(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {

		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);

		zsdj.setName(UserUtils.getUser().getName());
		zsdj.setOffice(UserUtils.getUser().getOffice());
		zsdj.setZsdjzt(CommonUtils.YUBAOMING);
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}
		zsdjService.save(zsdj);
		// addMessage(redirectAttributes, "保存招生登记成功");
		this.addPropertys(model);
		model.addAttribute("tip", "保存招生登记成功");
		// return "modules/zsdj/zsdjFormZS";
		if (zsdj.getBcfs().equals("save")) {
			return "redirect:" + Global.getAdminPath()
					+ "/zsdj/zsdj/zslslist?repage";
		} else if (zsdj.getBcfs().equals("saveAndAdd")) {
			return "modules/zsdj/zsdjFormZS";
		}
		return "redirect:" + Global.getAdminPath()
				+ "/zsdj/zsdj/zslslist?repage";
	}

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "savedl")
	public String saveDL(Zsdj zsdj, Model model,
			RedirectAttributes redirectAttributes) {

		JsJbxx jsjb = new JsJbxx();
		jsjb.setCurrentUser(UserUtils.getUser());
		jsjb.setId(UserUtils.getUser().getId());
		jsjb.setXm(UserUtils.getUser().getName());
		zsdj.setJs(jsjb);
		zsdj.setZsdjzt(CommonUtils.YUBAOMING);

		zsdj.setName(UserUtils.getUser().getName());
		zsdj.setOffice(UserUtils.getUser().getOffice());
		if (!beanValidator(model, zsdj)) {
			return form(zsdj, model);
		}
		zsdjService.save(zsdj);
		// addMessage(redirectAttributes, "保存招生登记成功");
		this.addPropertys(model);
		model.addAttribute("tip", "保存招生登记成功");
		if (zsdj.getBcfs().equals("save")) {
			return "redirect:" + Global.getAdminPath()
					+ "/zsdj/zsdj/dljglist?repage";
		} else if (zsdj.getBcfs().equals("saveAndAdd")) {
			return "modules/zsdj/zsdjFormDL";
		}
		return "redirect:" + Global.getAdminPath()
				+ "/zsdj/zsdj/dljglist?repage";
	}

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "delete")
	public String delete(Zsdj zsdj, String ids,String index,
			RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			Zsdj zsdjEn = get(id);
			zsdjService.delete(zsdjEn);
		}
		addMessage(redirectAttributes, "删除招生登记成功");
		if (index=="1"||index.equals("1")) {
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/mmlist?repage";
		}else if (index=="2"||index.equals("2")) {
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/wslist?repage";
		}else if (index=="3"||index.equals("3")) {
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/zslslist?repage";
		}else if (index=="4"||index.equals("4")) {
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/dljglist?repage";
		}else {
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/listByXsbd2?repage";
		}
		/**/
	}

	@ResponseBody
	@RequestMapping(value = "createPrintCode")
	public String createPrintCode(Zsdj zsdj, String ids,String index,
			HttpServletRequest request,
			HttpServletResponse response,RedirectAttributes redirectAttributes) {
		List<String> listPrintCode=new ArrayList<String>();
		FileTxtUtils txtUtil=new FileTxtUtils();
		String webPath=request.getSession().getServletContext().getRealPath("/");
		String[] idArr = ids.split(",");
		String schoolName=schoolinfoService.findList(new Schoolinfo()).get(0).getXxmc();
		String year=DateUtils.getYear();
		for (String id : idArr) {
			//获取打印代码
			String printCode=txtUtil.readFile(webPath+"WEB-INF/templet/printCode.txt");
			Zsdj zsdjEn = get(id);
			printCode=printCode.replace("#学校名称#", schoolName);
			printCode=printCode.replace("#年份#", year);
			printCode=printCode.replace("#姓名#", zsdjEn.getXm());
			printCode=printCode.replace("#性别#", DictUtils.getDictLabel(zsdjEn.getXbm(), "sex", ""));
			printCode=printCode.replace("#户口所在地#", zsdjEn.getJtzz());
			printCode=printCode.replace("#毕业学校#", zsdjEn.getFromSchool());
			printCode=printCode.replace("#编号#", (zsdjEn.getStuNumber()==null?"":zsdjEn.getStuNumber()));
			printCode=printCode.replace("#身份证号#", zsdjEn.getSfzjh());
			printCode=printCode.replace("#类型#", DictUtils.getDictLabel(zsdjEn.getXslx(), "xslx", ""));
			printCode=printCode.replace("#类别#", DictUtils.getDictLabel(zsdjEn.getXslym(), "xs_ly", ""));
			printCode=printCode.replace("#准考证号#", (zsdjEn.getZkzh()==null?"":zsdjEn.getZkzh()));
			printCode=printCode.replace("#专业#", zsdjEn.getZymc());
			for(int i=1;i<6;i++){
				if((i+"").equals(zsdjEn.getXslx())){
					printCode=printCode.replace("#"+i+"#", "√");
				}else{
					printCode=printCode.replace("#"+i+"#", "");
				}
			}
			listPrintCode.add(printCode);
		}
		return JsonMapper.toJsonString(listPrintCode);
	}
	
	/****************** 增加信息 *****************************************/
	/**
	 * 功能:慕名报名
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listmm", "" })
	public String listmm(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// this.addPropertys(model);
		model.addAttribute("zsdjmm", zsdj);
		return "modules/zsdj/zsdjFormMM";
	}
	/**
	 * 功能:打开批量导入界面
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "listmmDRTest/{lyxx}")
	public String listmmDRTest(@PathVariable String lyxx,Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// this.addPropertys(model);
		System.out.println(lyxx+"------------------------");
		model.addAttribute("zsdjmm", zsdj);
		model.addAttribute("lyxx", lyxx);
		return "modules/zsdj/zsdjFormXXMM";
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listwspage", "" })
	public String listwspage(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// this.addPropertys(model);
		model.addAttribute("zsdjmm", zsdj);
		return "modules/zsdj/zsdjFormWsedit";
	}

	/**
	 * 功能:招生登记
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listzs", "" })
	public String listzs(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// this.addPropertys(model);
		model.addAttribute("zsdjzsls", zsdj);
		return "modules/zsdj/zsdjFormZS";
	}


	/**
	 * 功能:招生代理登记
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "listdl", "" })
	public String listdl(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		// this.addPropertys(model);
		model.addAttribute("zsdjdl", zsdj);
		return "modules/zsdj/zsdjFormDL";
	}

	
	/**
	 * 功能:招生登记 查看详细信息
	 * 
	 * @param zsdj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "zsdjInfoForm", "" })
	public String zsdjInfoForm(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj=this.zsdjService.get(zsdj.getId());
		model.addAttribute("zsdjInfo", zsdj);
		return "modules/zsdj/zsdjInfoForm";
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = { "updateInfo", "" })
	public String updateInfo(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		zsdj=this.zsdjService.get(zsdj.getId());
		model.addAttribute("zsdjInfo", zsdj);
		return "modules/zsdj/updateInfo";
	}

	/**
	 * 功能:跳转带参数
	 */
	private void addPropertys(Model model) {
		Zsdj zsdj2 = new Zsdj();
		List<Zsjh> list2 = DictUtils.getZsjhList();
		// 通过时间来判断
		Date later = null;
		Zsjh zsjh = null;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		for (int i = 0; i < list2.size(); i++) {
			String date = sdf.format(list2.get(i).getCreateDate());
			try {
				if (later == null) {
					zsjh = list2.get(i);
					later = sdf.parse(date);
				} else {
					if (later.before(sdf.parse(date))) {
						zsjh = list2.get(i);
						later = sdf.parse(date);
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		zsdj2.setZsjh(zsjh);
		model.addAttribute("zsdj", zsdj2);
	}

	/**************************** 导入数据 ***********************************************/
	/**
	 * 下载导入用户数据模板
	 * 
	 * @param response
	 * @param redirectAttributes
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "import/template/{lyxx}")
	public String importFileTemplate(@PathVariable String lyxx, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		request.setCharacterEncoding("utf-8");
		try {
			this.upload(request, response);
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导入模板下载失败！失败信息：" + e.getMessage());
		}
		if(lyxx == "1" || lyxx.equals("1")){
			return "redirect:" + adminPath + "/zsdj/zsdjFormZS?repage";
		}else if(lyxx == "2" || lyxx.equals("2")){
			return "redirect:" + adminPath + "/zsdj/zsdjFormWS?repage";
		}else if(lyxx == "3" || lyxx.equals("3")){
			return "redirect:" + adminPath + "/zsdj/zsdjFormMM?repage";
		}
		return "redirect:" + adminPath + "/zsdj/zsdjFormDL?repage";
	}

	// 下载web应用下的文件
	private void upload(HttpServletRequest request, HttpServletResponse response) {
		try {
			String filePath = request.getSession().getServletContext()
					.getRealPath("/WEB-INF/templet/zsdjmb.xlsx"); // 文件在项目中的路径

			/*System.out.println(adminPath + "=filePath:=" + filePath);*/

			File outfile = new File(filePath);
			String filename = outfile.getName();// 获取文件名称
			InputStream fis = new BufferedInputStream(new FileInputStream(
					filePath));
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
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * 导出用户数据
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "exportFile", method = RequestMethod.POST)
	public String exportFile(Zsdj zsdj, HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) {
		try {
			String fileName = "招生登记数据" + DateUtils.getDate("yyyyMMddHHmmss")
					+ ".xlsx";
			Zsdj zsdj2 = new Zsdj();
			zsdj2.setCreateBy(UserUtils.getUser());
			List<Zsdj> list = zsdjService.findList(zsdj2);
			for (int i = 0; i < list.size(); i++) {
				String zymc = list.get(i).getZy().getZymc();
				list.get(i).setZymc(zymc);
				String lxmc = list.get(i).getZylx().getLxmc();
				list.get(i).setLxmc(lxmc);
			}
			new ExportExcel("招生登记", Zsdj.class).setDataList(list)
					.write(response, fileName).dispose();
			return null;
		} catch (Exception e) {
			addMessage(redirectAttributes, "导出信息失败！失败信息：" + e.getMessage());
		}
		return "redirect:" + adminPath + "/zsdj/zsdjList?repage";
	}

	/***************************** 获取专业信息 *************************************************************/
	
	/**
	 * Des:根据计划id查询专业类型
	 * 2016-12-28
	 * @author fn
	 * @param id
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findZyLxByJhId")
	public String findZyLxByJhId(String id)
	{
			JhZyInfo entity = new JhZyInfo();
			Zsjh zsjh= new Zsjh();
			zsjh.setId(id);
			entity.setZsjhId(zsjh);
			List<JhZyInfo> list = jhZyInfoService.findZylxListByJhId(entity);
			return JsonMapper.toJsonString(list);
	}
	/**
	 * Des:根据计划id专业Id查询专业
	 * @author fn
	 * @param jhid
	 * @param id
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findZyByjhzyLxId")
	public String findZyByjhzyLxId(String jhid,String id){	
		JhZyInfo entity = new JhZyInfo();
	    Zsjh zsjh= new Zsjh();
	    zsjh.setId(jhid);
	    entity.setZsjhId(zsjh);
	    if(id!=null && !"".equals(id)){
			ZylxJbxx zylxId = new ZylxJbxx();
			zylxId.setId(id);
			entity.setZylxId(zylxId);
	    }
	List<JhZyInfo> list = jhZyInfoService.findZyListByJhId(entity);
		return JsonMapper.toJsonString(list);
	}
	/**
	 * Des:根据计划id专业Id查询专业
	 * 2016-12-28
	 * @author fn
	 * @param jhid
	 * @param id
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findZyByJhLxId")
	public String findZyByJhLxId(String jhid,String id)
	{
		StringBuffer sb = new StringBuffer();
		JhZyInfo entity = new JhZyInfo();
		Zsjh zsjh= new Zsjh();
		zsjh.setId(jhid);
		entity.setZsjhId(zsjh);
		if(id!=null && !"".equals(id)){
			ZylxJbxx zylxId = new ZylxJbxx();
			zylxId.setId(id);
			entity.setZylxId(zylxId);
		}
		List<JhZyInfo> list = jhZyInfoService.findZyListByJhId(entity);
		sb.append("<select id='zyid' name='zy.id' style='width: 220px;'  class='input-xlarge required'>");
		sb.append("<option value='' >请选择</option>");
		if (list != null && list.size() > 0) {
			for (JhZyInfo jbxx : list) {
				sb.append("<option value='" + jbxx.getZyId().getId() + "' selected = 'selected'>"
						+ jbxx.getZyId().getZymc()+"("+jbxx.getZyId().getXzmc()+")" + "</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map<String, String> m = new HashMap<String, String>();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	/**
	 * Des:
	 * 2017-5-27
	 * @author lf
	 * @param jhid
	 * @param id
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findZyByJhLxIdm")
	public String findZyByJhLxIdm(String jhid,String id)
	{
		StringBuffer sb = new StringBuffer();
		JhZyInfo entity = new JhZyInfo();
		Zsjh zsjh= new Zsjh();
		zsjh.setId(jhid);
		entity.setZsjhId(zsjh);
		if(id!=null && !"".equals(id)){
			ZylxJbxx zylxId = new ZylxJbxx();
			zylxId.setId(id);
			entity.setZylxId(zylxId);
		}
		List<JhZyInfo> list = jhZyInfoService.findZyListByJhId(entity);
		/*sb.append("<select id='zyid' name='zy.id'  class='input-xlarge required'>");*/
		sb.append("<option value='' >请选择</option>");
		if (list != null && list.size() > 0) {
			for (JhZyInfo jbxx : list) {
				sb.append("<option value='" + jbxx.getZyId().getId() + "' selected = 'selected'>"
						+ jbxx.getZyId().getZymc()+"("+jbxx.getZyId().getXzmc()+")" + "</option>");
			}
		}
		/*sb.append("</select>");*/
		Map<String, String> m = new HashMap<String, String>();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	/**
	 * Des:
	 * 2017-5-27
	 * @author lf
	 * @param jhid
	 * @param id
	 * @return
	 * String
	 * 移动端页面加载专业（copyfindZyByJhLxId）
	 */
	@ResponseBody
	@RequestMapping(value = "findZyLxByJhIdm")
	public String findZyLxByJhIdm(String id)
	{
			JhZyInfo entity = new JhZyInfo();
			Zsjh zsjh= new Zsjh();
			zsjh.setId(id);
			entity.setZsjhId(zsjh);
			List<JhZyInfo> list = jhZyInfoService.findZylxListByJhId(entity);
			return JsonMapper.toJsonString(list);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "findZysByLxId")
	public String findZysByLxId(String id, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select id='zyid' name='zy.id' style='width: 284px;'  class='input-xlarge required'>");
		sb.append("<option value='' >请选择</option>");
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			for (ZyJbxx jbxx : zyJbxxs) {
				sb.append("<option value='" + jbxx.getId() + "'>"
						+ jbxx.getZymc()+"("+jbxx.getXzmc()+")" + "</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map<String, String> m = new HashMap<String, String>();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	@ResponseBody
	@RequestMapping(value = "findZysByLxIdList")
	public String findZysByLxIdList(String id,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select id='zyid' name='zy.id' style='width: 175px;margin-left:5px;' class='input-medium' >");
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			sb.append("<option value='' >请选择</option>");
			for (ZyJbxx jbxx : zyJbxxs) {
				sb.append("<option value='" + jbxx.getId() + "'>"
						+ jbxx.getZymc()+"("+jbxx.getXzmc()+")" + "</option>");
				
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font></span>");
		
		
		Map<String, String> m = new HashMap<String, String>();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	
	
	

	
	//=====================================学制
	@ResponseBody
	@RequestMapping(value = "findZysByzyIdList")
	public String findZysByzyIdList(String id,
			RedirectAttributes redirectAttributes) {
		ZyJbxx jbxx2 = zyJbxxService.get(id);
		String xz = jbxx2.getXz();
		Dict dict=new Dict();
		dict.setValue(xz);
		String label = dictService.getXZ(dict);
		Map m = new HashMap();
		m.put("html", label);
		return JsonMapper.toJsonString(m);
	}
	
	
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "findZyByLxIdAndZyId")
	public String findZyByLxIdAndZyId(String id, String zyId, String flag,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		if (flag == "1" || flag.equals("1")) {
			sb.append("<select name='zy.id'  class='input-medium'  id='zyId' style=\"width:175px;\">");
		} else if (flag == "2" || flag.equals("2")) {
			sb.append("<select name='zy.id'  class='input-xlarge required' style='width:284px;'  id='zyId2'>");
		}
		sb.append("<option value=''>请选择</option>");
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			for (ZyJbxx jbxx : zyJbxxs) {
				if (jbxx.getId() != null && jbxx.getId().equals(zyId)) {
					sb.append("<option selected='selected' value='"
							+ jbxx.getId() + "'>" + jbxx.getZymc()+"("+jbxx.getXzmc()+")"
							+ "</option>");
				} else {
					sb.append("<option value='" + jbxx.getId() + "'>"
							+ jbxx.getZymc()+"("+jbxx.getXzmc()+")" + "</option>");
				}
			}
		}
		if (flag == "1" || flag.equals("1")) {
			sb.append("</select>");
		} else if (flag == "2" || flag.equals("2")) {
			sb.append("</select><span class=\"help-inline\"><font color=\"red\">*</font> </span>");
		}
		@SuppressWarnings("rawtypes")
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/********************* 辅助方法 ***********************************************/
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "validateSfzxx")
	public String validateSfzxx(Zsdj zsdj,
			RedirectAttributes redirectAttributes, Model model) {
		Map map = new HashMap();
		List<Zsdj> list = zsdjService.findZsdjBySfzh(zsdj);
		if(list!=null && list.size()>0){
			map.put("isTrue", false);
		}else{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}

	/********************* 当前招生老师所招的学生信息 ************************************************/
	@ResponseBody
	@RequestMapping(value = "getZsdjListByCreate", method = RequestMethod.GET)
	public List<Zsdj> getZsdjListByCreate(
			RedirectAttributes redirectAttributes, Model model) {
		User user = UserUtils.getUser();
		String js_id = user.getId();
		List<Zsdj> list = zsdjService.getZsdjListByCreate(js_id);
		return list;
	}

	@ResponseBody
	@RequestMapping(value = "getZsdjList")
	public List<Zsdj> getZsdjList(Zsdj zsdj, HttpServletRequest request,HttpServletResponse response, Model model) {
		Zsjh zsjh = zsjhService.findUseZsjh();
		String jhid = zsjh.getId();
		List<Zsdj> list = zsdjService.getZsdjList(jhid);
		return list;
	}
	
	
	/**
	 * Des:根据计划id 获取 学年学期
	 * 2016-12-1
	 * @author fn
	 * @param zsjh
	 * @param request
	 * @param response
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findXueNianXueQiById")
	public String findXueNianXueQiById(Zsjh zsjh,HttpServletRequest request, HttpServletResponse response)
	{
			
		Zsjh entity = zsjhService.get(zsjh.getId());
		return JsonMapper.toJsonString(entity);
	}
	
	/**
	 * Des:根据专业获取学制
	 * 2016-12-1
	 * @author fn
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "findZyXueZhiById")
	public String findZyXueZhiById(ZyJbxx zyJbxx,HttpServletRequest request, HttpServletResponse response)
	{
		ZyJbxx entity = zyJbxxService.get(zyJbxx.getId());
		return JsonMapper.toJsonString(entity);
	}
	
	/**
	 * 判断并保存导入的学籍信息+
	 * 
	 * @param file
	 * @param request
	 * @param redirectAttributes
	 * @return
	 * @throws IllegalAccessException 
	 * @throws InstantiationException 
	 * @throws IOException 
	 */
	@ResponseBody
	@RequestMapping(value = "importfileTest")
	public String importfileTest(MultipartFile file, HttpServletRequest request,Zsdj zsdj1,
			RedirectAttributes redirectAttributes) throws InstantiationException, IllegalAccessException, IOException
	{	
		String ly = request.getParameter("ly");
		StringBuilder failureMsg = new StringBuilder();
		Map<String,Object> map = new HashMap<String, Object>();
		//存储信息
		List<Zsdj> zsdjs = new ArrayList<Zsdj>();
		
		try {
			ImportExcel ei = new ImportExcel(file, 1, 0);
			List<Zsdj> list = ei.getDataList(Zsdj.class);
			for (int i = 0; i < list.size(); i++) {
				// 老师信息
				Zsdj zsdj = list.get(i);
				JsJbxx jsjb = new JsJbxx();
				jsjb.setCurrentUser(UserUtils.getUser());
				jsjb.setId(UserUtils.getUser().getId());
				jsjb.setXm(UserUtils.getUser().getName());
				zsdj.setJs(jsjb);
				zsdj.setZsdjzt(CommonUtils.YUBAOMING);
				// 老师所在的部门
				zsdj.setOffice(UserUtils.getUser().getOffice());
				String zymc = zsdj.getZymc();// 专业类别信息
				String zylxmc = zsdj.getLxmc();// 专业信息
				String xm = zsdj.getXm(); //获取到学生姓名
				
				String errorStr ="第"+(i+3)+"行:姓名:"+xm;
				boolean istrue = false;
				// 获取专业信息
				List<ZyJbxx> zylist = zyJbxxService.findList(new ZyJbxx());
				for (int t = 0; t < zylist.size(); t++) {
					String getzymc = zylist.get(t).getZymc();
					String getzylxmc = zylist.get(t).getZylx().getLxmc();

					if ((zymc.equals(getzymc) || zymc == getzymc)
							&& (zylxmc.equals(getzylxmc) || zylxmc == getzylxmc)) {
						// 获取专业类别信息
						ZylxJbxx zylxJbxx = zylist.get(t).getZylx();
						zylxJbxx.setLxmc(zylxmc);
						zylist.get(t).setZylx(zylxJbxx);
						zsdj.setZylx(zylxJbxx);
						zsdj.setZy(zylist.get(t));
						zsdj.setXz(zylist.get(t).getXz());
						 istrue = true;
					}
				}
				if(!istrue)
				{
					errorStr+=",请检查专业类型和专业名称是否存在";
				}
				// 计划名称
				String id = zsdj1.getZsjh().getId();
				List<Zsjh> zsjhlist = zsjhService.findList(new Zsjh());
				for (Zsjh zsjh : zsjhlist) {
					String zsid = zsjh.getId();
					if (id.contains(zsid)) {
						zsdj.setZsjh(zsjh);
						zsdj.setXnxq(zsjh.getNf());
					}
				}
				errorStr+="</br>";
				// 设置招生来源
				zsdj.setLy(ly);
				failureMsg.append(errorStr);
				zsdjs.add(zsdj);
			}
			
			map.put("istrue", false);
			String str =failureMsg.toString();
			int n = str.length()-str.replaceAll(",", "").length();
			if(n==0)
			{
				map.put("istrue", true);
				saveXsdj(zsdjs);
			}
			
			
		} catch (InvalidFormatException e) {
			e.printStackTrace();
		}
		map.put("failureMsg", failureMsg);
		return JsonMapper.toJsonString(map);
	}
	
	/**
	 * 导入学生信息
	 * @param zsdjs
	 */
	public void saveXsdj(List<Zsdj> zsdjs)
	{
		if(zsdjs!=null && zsdjs.size()>0)
		{
			for(Zsdj entity :zsdjs){
				this.zsdjService.save(entity);
			}
		}
	}
	
	@RequiresPermissions("zsdj:zsdj:view")
	@RequestMapping(value = "importSuccess")
	public String importSuccess(HttpServletRequest request,
			HttpServletResponse response, RedirectAttributes redirectAttributes) throws Exception {
		request.setCharacterEncoding("utf-8");
		String lyxx = request.getParameter("ly");
		if(lyxx == "1" || lyxx.equals("1")){
			addMessage(redirectAttributes, "导入文档成功!");
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/zslslist?repage";
		}else if(lyxx == "2" || lyxx.equals("2")){
			addMessage(redirectAttributes, "导入文档成功!");
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/wslist?repage";
		}else if(lyxx == "3" || lyxx.equals("3")){
			addMessage(redirectAttributes, "导入文档成功!");
			return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/mmlist?repage";
		}
		addMessage(redirectAttributes, "导入文档成功!");
		return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/dljglist?repage";
	}
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "savezsdezt")
	public String saveZSdezt(Zsdj zsdj,RedirectAttributes redirectAttributes) {
		if (zsdj==null) {
			zsdj=new Zsdj();
		}
		zsdj=zsdjService.get(zsdj);
		zsdj.setUpdateBy(UserUtils.getUser());
		zsdj.setUpdateDate(new Date());
      if (zsdj.getJs()==null) {
    	  JsJbxx js=new JsJbxx();
    	  zsdj.setJs(js);
		}
      if(zsdj.getOffice()==null){
    	  Office of=new Office();
    	  zsdj.setOffice(of);
      }if (zsdj.getZy()==null) {
    	  ZyJbxx zy=new ZyJbxx();
    	  zsdj.setZy(zy);
	}if (zsdj.getZylx()==null) {
		ZylxJbxx zylx=new ZylxJbxx();
  	  zsdj.setZylx(zylx);
	}if (zsdj.getNj()==null) {
		XnJbxx nj=new XnJbxx();
	  	  zsdj.setNj(nj);
		}
	if (zsdj.getXnxq()==null) {
		XnxqJbxx xnxq=new XnxqJbxx();
	  	  zsdj.setXnxq(xnxq);
		}
		String zt=zsdj.getZsdjzt();
		if (zt.equals("0")) {
			zsdj.setZsdjzt("1");
		}else if(zt.equals("1")){
			zsdj.setZsdjzt("2");
		}
		zsdjService.save(zsdj);
		addMessage(redirectAttributes, "报到状态修改成功");
		if (zt.equals("0")) {
	     return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/listByXsbd2?repage";
		}else if(zt.equals("1")){
	     return "redirect:" + Global.getAdminPath() + "/zsdj/zsdj/listByXsbd?repage";	
		}else{
			return null;
		}
	   
		}
	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "addzsdj")
	public String addzsdj(Zsdj zsdj, HttpServletRequest request,
				HttpServletResponse response, Model model) {
			return "modules/zsdj/bmdjAdd";
		}

	@RequiresPermissions("zsdj:zsdj:edit")
	@RequestMapping(value = "bmdjAdd")
	public String bmdjAdd(Zsdj zsdj, Model model, RedirectAttributes redirectAttributes) {
		zsdj.setOffice(UserUtils.get(zsdj.getJs().getId()).getOffice());//招生教师所属部门	
		ZyJbxx zy=zyJbxxService.get(zsdj.getZy().getId());
		zsdj.setZy(zy);
		if (!beanValidator(model, zsdj)){
				return "modules/zsdj/bmdjAdd";
			}
			zsdj.setPhoto("/em/upload/images/"+zsdj.getSfzjh()+".jpg");
			zsdj.setOffice(UserUtils.get(zsdj.getJs().getId()).getOffice());//招生教师所属部门
			Zsjh zsjh = zsjhService.get(zsdj.getZsjh().getId());
			zsdj.setXnxq(zsjh.getNf());
			zsdj.setCreateDate(new Date());
			zsdj.setZsdjzt(CommonUtils.YUBAOMING);
			zsdj.setXxdate1(zsdj.getXxdate1().replace(",","至"));
			zsdj.setXxdate2(zsdj.getXxdate2().replace(",","至"));
			zsdj.setXxdate3(zsdj.getXxdate3().replace(",","至"));		
			zsdjService.save(zsdj);
			addMessage(redirectAttributes, "保存新生报名登记信息成功");
			return "redirect:"+Global.getAdminPath()+"/zsdj/zsdj/addzsdj";
		}
}	
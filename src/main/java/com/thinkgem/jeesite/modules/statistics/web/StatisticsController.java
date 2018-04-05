/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.statistics.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;
import jxl.write.Colour;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.utils.excel.ExportExcel;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.service.BjJbxxService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.statistics.entity.SchoolAndZy;
import com.thinkgem.jeesite.modules.statistics.entity.Statistics;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xjxx.service.XnJbxxService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;

/**
 * 统计分析Controller
 * 
 * @author lf
 * @version 2017-03-14
 */
@Controller
@RequestMapping(value = "${adminPath}/statistics")
public class StatisticsController extends BaseController {
	@Autowired
	private AreaService areaService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private ZsdjService zsdjService;

	@ResponseBody
	@RequestMapping(value = "getByArea")
	public String getByArea(String id, Model model, String zsnd) {
		Area area = new Area();
		area.setParent(new Area(id));
		List<Area> areas = areaService.findAllByChr(area);
		List<Statistics> statList = new ArrayList<Statistics>();
		List<Map> byAREA=null;
		Statistics s;
		for (int i = 0; i < areas.size(); i++) {
			Area a = areas.get(i);
			s = new Statistics();
			s.setId(a.getId());
			s.setName(a.getName());
			Map aMap = new HashMap();
			aMap.put("zsnd", zsnd);
			aMap.put("type", a.getType());
			aMap.put("id", a.getId());
			byAREA = areaService.findByAREA(aMap);
			s.setZsnd(zsnd);
			int rws = Integer.parseInt((String) byAREA.get(0).get("zrws").toString());
			int djs = Integer.parseInt((String)byAREA.get(0).get("zdjs").toString());
			int wcs = Integer.parseInt((String)byAREA.get(0).get("zwcs").toString());
			s.setNum1(rws);
			s.setNum2(djs);
			s.setNum3(wcs);
			if (rws<1) {
				s.setNum4("--");
			}else{
			s.setNum4((String)byAREA.get(0).get("wcPercent"));
			}
			if (rws<1&&djs<1&&wcs<1) {
				statList.remove(s);
			}else {
				statList.add(s);
			}
		}
		return JsonMapper.toJsonString(statList);
	}

	@ResponseBody
	@RequestMapping(value = "getByZstj")
	public String getByZstj(String id, Model model, String zsnd) {
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		Statistics s = null;
		int zrws = 0;// 总任务数
		int zdjs = 0;// 总登记数
		int zwcs = 0;// 总完成数
		Area area = new Area();
		area.setParent(new Area(id));
		List<Area> areas = areaService.findAllByChr(area);
		List<Statistics> statList = new ArrayList<Statistics>();
		List<Map> byAREA=null;
		for (int i = 0; i < areas.size(); i++) {
			Area a = areas.get(i);
			s = new Statistics();
			s.setId(a.getId());
			s.setName(a.getName());
			Map aMap = new HashMap();
			aMap.put("zsnd", zsnd);
			aMap.put("type", a.getType());
			aMap.put("id", a.getId());
			byAREA = areaService.findByAREA(aMap);
			int rws = Integer.parseInt((String) byAREA.get(0).get("zrws").toString());
			int djs = Integer.parseInt((String)byAREA.get(0).get("zdjs").toString());
			int wcs = Integer.parseInt((String)byAREA.get(0).get("zwcs").toString());
			zrws+=rws;
			zdjs+=djs;
			zwcs+=wcs;
		}
		s.setNum5(zrws);
		s.setNum6(zdjs);
		s.setNum7(zwcs);
		double wc=zwcs;
		double rw=zrws;
		if (zrws > 0) {
			s.setNum8(format.format(wc / rw));
		} else {
			s.setNum8("--");
		}
		model.addAttribute("zj", s);
		return JsonMapper.toJsonString(model);
	}

	@ResponseBody
	@RequestMapping(value = "getByAreas")
	public String getByAreas(String id, Model model) {
		Area area = new Area();
		area.setParent(new Area(id));
		List<Area> list = areaService.findAllByChr(area);
		return JsonMapper.toJsonString(list);
	}

	/**
	 * Des:年度招生任务完成情况统计--年度招生任务完成情况 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDZSRWWCQK")
	public String statNDZSRWWCQK(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		List<Map> maps = zsjhService.statAll(zsnd);
		List<Statistics> entitys = new ArrayList<Statistics>();
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
		int djNum = ((Number) maps.get(1).get("bdNum")).intValue();
		int wcNum = ((Number) maps.get(2).get("bdNum")).intValue();
		String wcPercent;
		if (jhNum == 0) {
			wcPercent = "--";
		} else {
			wcPercent = format.format(((double) wcNum) / ((double) jhNum));
		}
		Statistics entity1 = new Statistics();
		entity1.setName((String) maps.get(0).get("proName"));
		entity1.setNum1(jhNum);
		entitys.add(entity1);

		Statistics entity2 = new Statistics();
		entity2.setName((String) maps.get(1).get("proName"));
		entity2.setNum1(djNum);
		entitys.add(entity2);

		Statistics entity3 = new Statistics();
		entity3.setName((String) maps.get(2).get("proName"));
		entity3.setNum1(wcNum);
		entity3.setNum4(wcPercent);
		entitys.add(entity3);

		return JsonMapper.toJsonString(entitys);
	}

	/**
	 * Des:年度间招生任务完成情况统计--年度间招生任务完成情况 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDJZSRWWCQK")
	public String statNDJZSRWWCQK(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		String[] zsnds = zsnd.split("\\|");
		List<Statistics> entitys = new ArrayList<Statistics>();
		for (int i = 0; i < zsnds.length; i++) {
			String z = zsnds[i];
			List<Map> maps = zsjhService.statAll(z);
			int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
			int djNum = ((Number) maps.get(1).get("bdNum")).intValue();
			int wcNum = ((Number) maps.get(2).get("bdNum")).intValue();
			String wcPercent;
			if (jhNum == 0) {
				wcPercent = "--";
			} else {
				wcPercent = format.format(((double) wcNum) / ((double) jhNum));
			}
			Statistics entity1 = new Statistics();
			entity1.setName(z + "年度");
			entity1.setNum1(jhNum);
			entity1.setNum2(djNum);
			entity1.setNum3(wcNum);
			entity1.setNum4(wcPercent);
			entitys.add(entity1);
		}
		return JsonMapper.toJsonString(entitys);
	}

	/**
	 * Des:年度招生任务总完成情况分类统计--招生完成情况表格 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDZSRWWCQKTable")
	public String statNDZSRWWCQKTable(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		List<Map> maps = zsjhService.statAll(zsnd);
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
		int djNum = ((Number) maps.get(1).get("bdNum")).intValue();
		int wcNum = ((Number) maps.get(2).get("bdNum")).intValue();
		// String wcPercent="";
		// if(jhNum==0){
		// wcPercent="-";
		// }else{
		// wcPercent=format.format(((double)wcNum)/((double)jhNum));
		// }
		List<List<Statistics>> statPartList = new ArrayList<List<Statistics>>();
		// 个人分类统计处理
		List<Map> ryPartMaps = zsjhService.statRYPart(zsnd);
		List<Statistics> ryStats = new ArrayList<Statistics>();
		for (int i = 0; i < ryPartMaps.size(); i++) {
			Statistics s = new Statistics();
			String ryId = (String) ryPartMaps.get(i).get("ryId");
			String ryName = (String) ryPartMaps.get(i).get("ryName");
			int ryRws = ((Number) ryPartMaps.get(i).get("ryJhrs")).intValue();
			int ryDjs = ((Number) ryPartMaps.get(i).get("ryDjrs")).intValue();
			int ryWcs = ((Number) ryPartMaps.get(i).get("ryWcrs")).intValue();
			String ryWcPercent = "";
			if (ryRws == 0) {
				ryWcPercent = "--";
			} else {
				ryWcPercent = format
						.format(((double) ryWcs) / ((double) ryRws));
			}
			String bmId = (String) ryPartMaps.get(i).get("bmId");
			String bmName = (String) ryPartMaps.get(i).get("bmName");
			s.setId(ryId);
			s.setName(ryName);
			s.setNum1(ryRws);
			s.setNum2(ryDjs);
			s.setNum3(ryWcs);
			s.setNum4(ryWcPercent);
			s.setId2(bmId);
			s.setName2(bmName);
			ryStats.add(s);
		}
		statPartList.add(ryStats);
		// 部门分类统计处理
		List<Map> bmPartMaps = zsjhService.statBMPart(zsnd);
		List<Statistics> bmStats = new ArrayList<Statistics>();
		for (int i = 0; i < bmPartMaps.size(); i++) {
			Statistics s = new Statistics();
			String bmId = (String) bmPartMaps.get(i).get("bmId");
			String bmName = (String) bmPartMaps.get(i).get("bmName");
			int bmRwNum = ((Number) bmPartMaps.get(i).get("bmRws")).intValue();
			int bmDjNum = ((Number) bmPartMaps.get(i).get("bmDjs")).intValue();
			int bmWcNum = ((Number) bmPartMaps.get(i).get("bmWcs")).intValue();
			int bmType = Integer.parseInt(((String) bmPartMaps.get(i).get(
					"bmType")));
			String bmWcPercent = "";
			String bmWcInAllPercent = "";
			if (bmRwNum == 0) {
				bmWcPercent = "--";
			} else {
				bmWcPercent = format.format(((double) bmWcNum)
						/ ((double) bmRwNum));
			}
			if (jhNum == 0) {
				bmWcInAllPercent = "--";
			} else {
				bmWcInAllPercent = format.format(((double) bmWcNum)
						/ ((double) jhNum));
			}
			s.setId(bmId);
			s.setName(bmName);
			s.setNum1(bmRwNum);
			s.setNum2(bmDjNum);
			s.setNum3(bmWcNum);
			s.setNum4(bmWcPercent);
			s.setNum8(bmWcInAllPercent);
			s.setNum5(bmType);
			bmStats.add(s);
		}
		statPartList.add(bmStats);
		return JsonMapper.toJsonString(statPartList);
	}

	/**
	 * Des:年度间招生任务总完成情况分类统计--年度间招生完成情况表格 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDJZSRWWCQKTable")
	public String statNDJZSRWWCQKTable(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		String[] zsnds = zsnd.split("\\|");
		Map<String, List<List<Statistics>>> zsndParts = new HashMap<String, List<List<Statistics>>>();
		for (int m = 0; m < zsnds.length; m++) {
			String z = zsnds[m];
			List<Map> maps = zsjhService.statAll(z);
			// 计算部门占总比时用
			int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
			List<List<Statistics>> statPartList = new ArrayList<List<Statistics>>();
			// 个人分类统计处理
			List<Map> ryPartMaps = zsjhService.statRYPart(z);
			List<Statistics> ryStats = new ArrayList<Statistics>();
			for (int i = 0; i < ryPartMaps.size(); i++) {
				Statistics s = new Statistics();
				String ryId = (String) ryPartMaps.get(i).get("ryId");
				String ryName = (String) ryPartMaps.get(i).get("ryName");
				int ryRws = ((Number) ryPartMaps.get(i).get("ryJhrs"))
						.intValue();
				int ryDjs = ((Number) ryPartMaps.get(i).get("ryDjrs"))
						.intValue();
				int ryWcs = ((Number) ryPartMaps.get(i).get("ryWcrs"))
						.intValue();
				String ryWcPercent = "";
				if (ryRws == 0) {
					ryWcPercent = "--";
				} else {
					ryWcPercent = format.format(((double) ryWcs)
							/ ((double) ryRws));
				}
				String bmId = (String) ryPartMaps.get(i).get("bmId");
				String bmName = (String) ryPartMaps.get(i).get("bmName");
				s.setId(ryId);
				s.setName(ryName);
				s.setNum1(ryRws);
				s.setNum2(ryDjs);
				s.setNum3(ryWcs);
				s.setNum4(ryWcPercent);
				s.setId2(bmId);
				s.setName2(bmName);
				ryStats.add(s);
			}
			statPartList.add(ryStats);
			// 部门分类统计处理
			List<Map> bmPartMaps = zsjhService.statBMPart(z);
			List<Statistics> bmStats = new ArrayList<Statistics>();
			for (int i = 0; i < bmPartMaps.size(); i++) {
				Statistics s = new Statistics();
				String bmId = (String) bmPartMaps.get(i).get("bmId");
				String bmName = (String) bmPartMaps.get(i).get("bmName");
				int bmRwNum = ((Number) bmPartMaps.get(i).get("bmRws"))
						.intValue();
				int bmDjNum = ((Number) bmPartMaps.get(i).get("bmDjs"))
						.intValue();
				int bmWcNum = ((Number) bmPartMaps.get(i).get("bmWcs"))
						.intValue();
				int bmType = Integer.parseInt(((String) bmPartMaps.get(i).get(
						"bmType")));
				String bmWcPercent = "";
				String bmWcInAllPercent = "";
				if (bmRwNum == 0) {
					bmWcPercent = "--";
				} else {
					bmWcPercent = format.format(((double) bmWcNum)
							/ ((double) bmRwNum));
				}
				if (jhNum == 0) {
					bmWcInAllPercent = "--";
				} else {
					bmWcInAllPercent = format.format(((double) bmWcNum)
							/ ((double) jhNum));
				}
				s.setId(bmId);
				s.setName(bmName);
				s.setNum1(bmRwNum);
				s.setNum2(bmDjNum);
				s.setNum3(bmWcNum);
				s.setNum4(bmWcPercent);
				s.setNum8(bmWcInAllPercent);
				s.setNum5(bmType);
				bmStats.add(s);
			}
			statPartList.add(bmStats);
			maps = zsjhService.statBMAll(z);
			List<Statistics> otherZS = new ArrayList<Statistics>();
			// j从2开始，只取网上招生和学校招生
			for (int j = 2; j < maps.size(); j++) {
				Statistics entity1 = new Statistics();
				int rws = ((Number) maps.get(j).get("jhNum")).intValue();
				int djs = ((Number) maps.get(j).get("djNum")).intValue();
				int wcs = ((Number) maps.get(j).get("wcNum")).intValue();
				String num8 = "";
				if (jhNum == 0) {
					num8 = "--";
				} else {
					num8 = format.format(((double) wcs) / ((double) jhNum));
				}
				entity1.setId(z);
				entity1.setName((String) maps.get(j).get("proName"));
				entity1.setNum1(rws);
				entity1.setNum2(djs);
				entity1.setNum3(wcs);
				entity1.setNum8(num8);
				otherZS.add(entity1);
			}
			statPartList.add(otherZS);
			zsndParts.put(z, statPartList);
		}
		return JsonMapper.toJsonString(zsndParts);
	}

	/**
	 * Des:年度招生任务完成情况统计--招生机构招生完成情况 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDZSJGZSWCQK")
	public String statNDZSJGZSWCQK(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		List<Map> maps1 = zsjhService.statAll(zsnd);
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		int jhNum = ((Number) maps1.get(0).get("bdNum")).intValue();

		List<Map> maps = zsjhService.statBMAll(zsnd);
		List<Statistics> entitys = new ArrayList<Statistics>();
		for (int i = 0; i < maps.size(); i++) {
			Statistics entity1 = new Statistics();
			int rws = ((Number) maps.get(i).get("jhNum")).intValue();
			int djs = ((Number) maps.get(i).get("djNum")).intValue();
			int wcs = ((Number) maps.get(i).get("wcNum")).intValue();
			String num8 = "";
			if (jhNum == 0) {
				num8 = "--";
			} else {
				num8 = format.format(((double) wcs) / ((double) jhNum));
			}
			entity1.setName((String) maps.get(i).get("proName"));
			entity1.setNum1(rws);
			entity1.setNum2(djs);
			entity1.setNum3(wcs);
			entity1.setNum8(num8);
			entitys.add(entity1);
		}
		return JsonMapper.toJsonString(entitys);
	}

	/**
	 * Des:年度招生任务完成情况统计--招生机构招生完成情况excel导出 2017-04-06
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "expStatNDZSJGZSWCQK")
	public String expStatNDZSJGZSWCQK(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		List<Statistics> entitys = new ArrayList<Statistics>();
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		String[] zsnds = zsnd.split("\\|");
		for (int i = 0; i < zsnds.length; i++) {
			String z = zsnds[i];
			// 年度总任务数
			List<Map> maps = zsjhService.statAll(z);
			int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
			int djNum = ((Number) maps.get(1).get("bdNum")).intValue();
			int wcNum = ((Number) maps.get(2).get("bdNum")).intValue();
			String wcPercent;
			if (jhNum == 0) {
				wcPercent = "--";
			} else {
				wcPercent = format.format(((double) wcNum) / ((double) jhNum));
			}
			Statistics entity1 = new Statistics();
			entity1.setName(z);
			entity1.setNum1(jhNum);
			entity1.setNum2(djNum);
			entity1.setNum3(wcNum);
			entity1.setNum4(wcPercent);
			entitys.add(entity1);
		}
		// 定义Excel
		// 文件名
		String filename ="";
		if(zsnds.length>1){
			filename = zsnd+"年度间招生总任务完成情况比对"
					+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())
					+ ".xls";
		}else{
			filename = zsnd+"年度招生总任务完成情况"
					+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())
					+ ".xls";
		}
		
		OutputStream os = null;
		WritableWorkbook wwb = null;
		try {
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-Disposition", "attachment; filename="
					+ new String(filename.getBytes("GBK"), "ISO-8859-1"));
			os = response.getOutputStream();
			wwb = Workbook.createWorkbook(os);
			wwb.setProtected(true);
			// 创建Excel页面
			WritableSheet sheet = wwb.createSheet("sheet1", 0);
			// 设置每列单元格的宽度
			sheet.setColumnView(0, 18);
			sheet.setColumnView(1, 13);
			sheet.setColumnView(2, 13);
			sheet.setColumnView(3, 15);
			sheet.setColumnView(4, 15);
			sheet.setColumnView(5, 15);
			sheet.setColumnView(6, 15);
			sheet.setColumnView(7, 15);
			sheet.setColumnView(8, 15);
			sheet.setColumnView(9, 15);
			sheet.setColumnView(10, 15);
			sheet.setColumnView(11, 18);
			sheet.setColumnView(12, 18);
			// 设置单元格样式 居中显示
			WritableCellFormat cellCenterFormat = new WritableCellFormat();
			// 水平居中对齐
			cellCenterFormat.setAlignment(Alignment.CENTRE);
			// 竖直方向居中对齐
			cellCenterFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
			//加边框
			cellCenterFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
			// 填入数据
			int row = 0;// 当前行
			// 总表头
			sheet.addCell(new Label(0, row, "年度招生计划", cellCenterFormat));
			sheet.addCell(new Label(3, row, "招生总任务数", cellCenterFormat));
			sheet.addCell(new Label(6, row, "招生总登记数", cellCenterFormat));
			sheet.addCell(new Label(9, row, "招生总完成数", cellCenterFormat));
			sheet.addCell(new Label(11, row, "招生总完成率", cellCenterFormat));
			// 合并单元格
			sheet.mergeCells(0, row, 2, row);
			sheet.mergeCells(3, row, 5, row);
			sheet.mergeCells(6, row, 8, row);
			sheet.mergeCells(9, row, 10, row);
			sheet.mergeCells(11, row, 12, row);
			row += 1;
			// 年度总任务填充
			for (int i = 0; i < entitys.size(); i++) {
				sheet.addCell(new Label(0, row, entitys.get(i).getName() + "年度招生计划",
						cellCenterFormat));
				sheet.addCell(new Label(3, row, entitys.get(i).getNum1() + "",
						cellCenterFormat));
				sheet.addCell(new Label(6, row, entitys.get(i).getNum2() + "",
						cellCenterFormat));
				sheet.addCell(new Label(9, row, entitys.get(i).getNum3() + "",
						cellCenterFormat));
				sheet.addCell(new Label(11, row, entitys.get(i).getNum4() + "",
						cellCenterFormat));
				// 合并单元格
				sheet.mergeCells(0, row, 2, row);
				sheet.mergeCells(3, row, 5, row);
				sheet.mergeCells(6, row, 8, row);
				sheet.mergeCells(9, row, 10, row);
				sheet.mergeCells(11, row, 12, row);
				row += 1;
			}
			// 分表头
			sheet.addCell(new Label(0, row, "年度招生计划", cellCenterFormat));
			sheet.addCell(new Label(1, row, "招生机构", cellCenterFormat));
			sheet.addCell(new Label(3, row, "招生机构任务数", cellCenterFormat));
			sheet.addCell(new Label(4, row, "招生人员姓名", cellCenterFormat));
			sheet.addCell(new Label(5, row, "个人招生任务数", cellCenterFormat));
			sheet.addCell(new Label(6, row, "个人招生登记数", cellCenterFormat));
			sheet.addCell(new Label(7, row, "个人招生完成数", cellCenterFormat));
			sheet.addCell(new Label(8, row, "个人招生完成率", cellCenterFormat));
			sheet.addCell(new Label(9, row, "招生机构登记数", cellCenterFormat));
			sheet.addCell(new Label(10, row, "招生机构完成数", cellCenterFormat));
			sheet.addCell(new Label(11, row, "招生机构招生完成率", cellCenterFormat));
			sheet.addCell(new Label(12, row, "占总招生任务数比率", cellCenterFormat));
			// 合并单元格
			sheet.mergeCells(1, row, 2, row);
			row += 1;
			for (int m = 0; m < zsnds.length; m++) {
				String z = zsnds[m];
				List<Map> maps = zsjhService.statAll(z);
				// 计算部门占总比时用
				int jhNum = ((Number) maps.get(0).get("bdNum")).intValue();
				// 个人分类统计处理
				List<Map> ryPartMaps = zsjhService.statRYPart(z);
				List<Statistics> ryStats = new ArrayList<Statistics>();
				for (int i = 0; i < ryPartMaps.size(); i++) {
					Statistics s = new Statistics();
					String ryId = (String) ryPartMaps.get(i).get("ryId");
					String ryName = (String) ryPartMaps.get(i).get("ryName");
					int ryRws = ((Number) ryPartMaps.get(i).get("ryJhrs"))
							.intValue();
					int ryDjs = ((Number) ryPartMaps.get(i).get("ryDjrs"))
							.intValue();
					int ryWcs = ((Number) ryPartMaps.get(i).get("ryWcrs"))
							.intValue();
					String ryWcPercent = "";
					if (ryRws == 0) {
						ryWcPercent = "--";
					} else {
						ryWcPercent = format.format(((double) ryWcs)
								/ ((double) ryRws));
					}
					String bmId = (String) ryPartMaps.get(i).get("bmId");
					String bmName = (String) ryPartMaps.get(i).get("bmName");
					s.setId(ryId);
					s.setName(ryName);
					s.setNum1(ryRws);
					s.setNum2(ryDjs);
					s.setNum3(ryWcs);
					s.setNum4(ryWcPercent);
					s.setId2(bmId);
					s.setName2(bmName);
					ryStats.add(s);
				}
				// 部门分类统计处理
				List<Map> bmPartMaps = zsjhService.statBMPart(z);
				List<Statistics> bmStats = new ArrayList<Statistics>();
				for (int i = 0; i < bmPartMaps.size(); i++) {
					Statistics s = new Statistics();
					String bmId = (String) bmPartMaps.get(i).get("bmId");
					String bmName = (String) bmPartMaps.get(i).get("bmName");
					int bmRwNum = ((Number) bmPartMaps.get(i).get("bmRws"))
							.intValue();
					int bmDjNum = ((Number) bmPartMaps.get(i).get("bmDjs"))
							.intValue();
					int bmWcNum = ((Number) bmPartMaps.get(i).get("bmWcs"))
							.intValue();
					int bmType = Integer.parseInt(((String) bmPartMaps.get(i)
							.get("bmType")));
					String bmWcPercent = "";
					String bmWcInAllPercent = "";
					if (bmRwNum == 0) {
						bmWcPercent = "--";
					} else {
						bmWcPercent = format.format(((double) bmWcNum)
								/ ((double) bmRwNum));
					}
					if (jhNum == 0) {
						bmWcInAllPercent = "--";
					} else {
						bmWcInAllPercent = format.format(((double) bmWcNum)
								/ ((double) jhNum));
					}
					s.setId(bmId);
					s.setName(bmName);
					s.setNum1(bmRwNum);
					s.setNum2(bmDjNum);
					s.setNum3(bmWcNum);
					s.setNum4(bmWcPercent);
					s.setNum8(bmWcInAllPercent);
					s.setNum5(bmType);
					bmStats.add(s);
				}
				maps = zsjhService.statBMAll(z);
				// 其它招生渠道招生
				List<Statistics> otherEntitys = new ArrayList<Statistics>();
				// j从2开始，只取网上招生和学校招生
				for (int j = 2; j < maps.size(); j++) {
					Statistics entity1 = new Statistics();
					int rws = ((Number) maps.get(j).get("jhNum")).intValue();
					int djs = ((Number) maps.get(j).get("djNum")).intValue();
					int wcs = ((Number) maps.get(j).get("wcNum")).intValue();
					String num8 = "";
					if (jhNum == 0) {
						num8 = "--";
					} else {
						num8 = format.format(((double) wcs) / ((double) jhNum));
					}
					entity1.setId(z);
					entity1.setName((String) maps.get(j).get("proName"));
					entity1.setNum1(rws);
					entity1.setNum2(djs);
					entity1.setNum3(wcs);
					entity1.setNum8(num8);
					otherEntitys.add(entity1);
				}
				// 小计
				int sumJhNum = 0;
				int sumDjNum = 0;
				int sumWcNum = 0;
				int schoolBmCount = 0;// 学校招生部门数
				int otherBmCount = 0;// 代理机构招生部门数
				// 年度分任务填充
				int startRow = row;// 填充的起始行
				for (int i = 0; i < bmStats.size(); i++) {
					// 填充列表统计数据 中 年度部门任务情况统计
					String bmId = bmStats.get(i).getId();
					String bmName = bmStats.get(i).getName();
					int bmJhNum = bmStats.get(i).getNum1();
					int bmDjNum = bmStats.get(i).getNum2();
					int bmWcNum = bmStats.get(i).getNum3();
					String bmWcPercent = bmStats.get(i).getNum4();
					String bmWcInAllPercent = bmStats.get(i).getNum8();
					int bmType = bmStats.get(i).getNum5();
					sumJhNum += bmJhNum;
					sumDjNum += bmDjNum;
					sumWcNum += bmWcNum;
					sheet.addCell(new Label(2, row, bmName, cellCenterFormat));
					sheet.addCell(new Label(3, row, bmJhNum + "",
							cellCenterFormat));
					sheet.addCell(new Label(9, row, bmDjNum + "",
							cellCenterFormat));
					sheet.addCell(new Label(10, row, bmWcNum + "",
							cellCenterFormat));
					sheet.addCell(new Label(11, row, bmWcPercent,
							cellCenterFormat));
					sheet.addCell(new Label(12, row, bmWcInAllPercent,
							cellCenterFormat));
					// int currentBmCount=0;
					int bmStartRow = row;
					for (int j = 0; j < ryStats.size(); j++) {
						String ryId = ryStats.get(j).getId();
						String ryName = ryStats.get(j).getName();
						int ryJhNum = ryStats.get(j).getNum1();
						int ryDjNum = ryStats.get(j).getNum2();
						int ryWcNum = ryStats.get(j).getNum3();
						String ryWcPercent = ryStats.get(j).getNum4();
						String ryBmId = ryStats.get(j).getId2();
						String ryBmName = ryStats.get(j).getName2();
						if (bmId.equals(ryBmId)) {
							sheet.addCell(new Label(4, row, ryName,
									cellCenterFormat));
							sheet.addCell(new Label(5, row, ryJhNum + "",
									cellCenterFormat));
							sheet.addCell(new Label(6, row, ryDjNum + "",
									cellCenterFormat));
							sheet.addCell(new Label(7, row, ryWcNum + "",
									cellCenterFormat));
							sheet.addCell(new Label(8, row, ryWcPercent,
									cellCenterFormat));
							// currentBmCount+=1;
							row += 1;
							if (bmType == 2) {
								schoolBmCount += 1;
							} else {
								otherBmCount += 1;
							}
						}
					}
					// 合并单元格
					if (bmStartRow != row - 1) {
						sheet.mergeCells(2, bmStartRow, 2, row - 1);
						sheet.mergeCells(3, bmStartRow, 3, row - 1);
						sheet.mergeCells(9, bmStartRow, 9, row - 1);
						sheet.mergeCells(10, bmStartRow, 10, row - 1);
						sheet.mergeCells(11, bmStartRow, 11, row - 1);
						sheet.mergeCells(12, bmStartRow, 12, row - 1);
					}
				}
				if (schoolBmCount > 0) {
					sheet.addCell(new Label(1, startRow, "学校招生部门",
							cellCenterFormat));
					sheet.mergeCells(1, startRow, 1, startRow + schoolBmCount
							- 1);
				}
				if (otherBmCount > 0) {
					sheet.addCell(new Label(1, startRow + schoolBmCount,
							"招生代理机构", cellCenterFormat));
					sheet.mergeCells(1, startRow + schoolBmCount, 1, startRow
							+ schoolBmCount + otherBmCount - 1);
				}
				sheet.addCell(new Label(0, startRow, z + "年度招生计划",
						cellCenterFormat));
				sheet.mergeCells(0, startRow, 0, startRow + schoolBmCount
						+ otherBmCount + 2);
				// 小计
				sheet.addCell(new Label(1, row, "小计", cellCenterFormat));
				sheet.addCell(new Label(3, row, sumJhNum + "", cellCenterFormat));
				sheet.addCell(new Label(4, row, "", cellCenterFormat));
				sheet.addCell(new Label(5, row, "", cellCenterFormat));
				sheet.addCell(new Label(6, row, "", cellCenterFormat));
				sheet.addCell(new Label(7, row, "", cellCenterFormat));
				sheet.addCell(new Label(8, row, "", cellCenterFormat));
				sheet.addCell(new Label(9, row, sumDjNum + "", cellCenterFormat));
				sheet.addCell(new Label(10, row, sumWcNum + "",
						cellCenterFormat));
				sheet.addCell(new Label(11, row, "", cellCenterFormat));
				sheet.addCell(new Label(12, row, "", cellCenterFormat));
				sheet.mergeCells(1, row, 2, row);
				row += 1;
				// 其它招生渠道招生
				for (int i = 0; i < otherEntitys.size(); i++) {
					sheet.addCell(new Label(1, row, otherEntitys.get(i)
							.getName(), cellCenterFormat));
					sheet.addCell(new Label(3, row, "", cellCenterFormat));
					sheet.addCell(new Label(4, row, "", cellCenterFormat));
					sheet.addCell(new Label(5, row, "", cellCenterFormat));
					sheet.addCell(new Label(6, row, "", cellCenterFormat));
					sheet.addCell(new Label(7, row, "", cellCenterFormat));
					sheet.addCell(new Label(8, row, "", cellCenterFormat));
					sheet.addCell(new Label(9, row, otherEntitys.get(i)
							.getNum2() + "", cellCenterFormat));
					sheet.addCell(new Label(10, row, otherEntitys.get(i)
							.getNum3() + "", cellCenterFormat));
					sheet.addCell(new Label(11, row, "", cellCenterFormat));
					sheet.addCell(new Label(12, row, otherEntitys.get(i)
							.getNum8() + "", cellCenterFormat));
					sheet.mergeCells(1, row, 2, row);
					row += 1;
				}
			}
			wwb.write();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				wwb.close();
				os.close();
			} catch (WriteException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "exportGRpaiHang")
	public String exportGRpaiHang(String jhId,String bmId, HttpServletRequest request,
			HttpServletResponse response) {	
			List<Statistics> list = zsjhService.paiHangGRByZsjhAndBm(jhId, bmId);
			
			// 定义Excel
			// 文件名
			String filename ="个人排行榜.xls";			
			OutputStream os = null;
			WritableWorkbook wwb = null;
			try {				
				response.setContentType("application/vnd.ms-excel");
				response.addHeader("Content-Disposition", "attachment; filename="
						+ new String(filename.getBytes("GBK"), "ISO-8859-1"));
				os = response.getOutputStream();
				wwb = Workbook.createWorkbook(os);
				wwb.setProtected(true);
				// 创建Excel页面
				WritableSheet sheet = wwb.createSheet("sheet1", 0);
				// 设置每列单元格的宽度
				sheet.setColumnView(0, 18);
				sheet.setColumnView(1, 13);
				sheet.setColumnView(2, 13);
				sheet.setColumnView(3, 15);
				sheet.setColumnView(4, 15);
				sheet.setColumnView(5, 15);
				sheet.setColumnView(6, 15);
				// 设置单元格样式 居中显示
				WritableCellFormat cellCenterFormat = new WritableCellFormat();
				// 水平居中对齐
				cellCenterFormat.setAlignment(Alignment.CENTRE);
				// 竖直方向居中对齐
				cellCenterFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
				//加边框
				cellCenterFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
				// 填入数据
				int row = 0;// 当前行
				// 总表头
				sheet.addCell(new Label(0, row, "名次", cellCenterFormat));
				sheet.addCell(new Label(1, row, "部门", cellCenterFormat));
				sheet.addCell(new Label(2, row, "招生任务数", cellCenterFormat));
				sheet.addCell(new Label(3, row, "招生登记数", cellCenterFormat));
				sheet.addCell(new Label(4, row, "招生完成数", cellCenterFormat));
				sheet.addCell(new Label(5, row, "招生完成率", cellCenterFormat));				
				sheet.addCell(new Label(6, row, "部门", cellCenterFormat));				
				row += 1;
				for (int i = 0; i < list.size(); i++) {
					sheet.addCell(new Label(0, row, "第"+list.get(i).getRanking()+"名",
							cellCenterFormat));
					sheet.addCell(new Label(1, row, list.get(i).getName()+"",
							cellCenterFormat));
					sheet.addCell(new Label(2, row, list.get(i).getNum1()+"",
							cellCenterFormat));
					sheet.addCell(new Label(3, row, list.get(i).getNum2()+"",
							cellCenterFormat));
					sheet.addCell(new Label(4, row, list.get(i).getNum3()+"",
							cellCenterFormat));
					sheet.addCell(new Label(5, row, list.get(i).getNum4()+"",
							cellCenterFormat));				
					sheet.addCell(new Label(6, row, list.get(i).getName2()+"",
							cellCenterFormat));				
					row += 1;
				}
				wwb.write();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					wwb.close();
					os.close();
				} catch (WriteException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		return null;
	}
	
	@ResponseBody
	@RequestMapping(value = "exportBMpaiHang")
	public String exportBMpaiHang(String jhId, HttpServletRequest request,
			HttpServletResponse response) {
	
			List<Statistics> list = zsjhService.paiHangBMByZsjh(jhId);
			
			// 定义Excel
			// 文件名
			String filename ="部门排行榜.xls";			
			OutputStream os = null;
			WritableWorkbook wwb = null;
			try {				
				response.setContentType("application/vnd.ms-excel");
				response.addHeader("Content-Disposition", "attachment; filename="
						+ new String(filename.getBytes("GBK"), "ISO-8859-1"));
				os = response.getOutputStream();
				wwb = Workbook.createWorkbook(os);
				wwb.setProtected(true);
				// 创建Excel页面
				WritableSheet sheet = wwb.createSheet("sheet1", 0);
				// 设置每列单元格的宽度
				sheet.setColumnView(0, 18);
				sheet.setColumnView(1, 13);
				sheet.setColumnView(2, 13);
				sheet.setColumnView(3, 15);
				sheet.setColumnView(4, 15);
				sheet.setColumnView(5, 15);
				// 设置单元格样式 居中显示
				WritableCellFormat cellCenterFormat = new WritableCellFormat();
				// 水平居中对齐
				cellCenterFormat.setAlignment(Alignment.CENTRE);
				// 竖直方向居中对齐
				cellCenterFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
				//加边框
				cellCenterFormat.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN); 
				// 填入数据
				int row = 0;// 当前行
				// 总表头
				sheet.addCell(new Label(0, row, "名次", cellCenterFormat));
				sheet.addCell(new Label(1, row, "部门", cellCenterFormat));
				sheet.addCell(new Label(2, row, "招生任务数", cellCenterFormat));
				sheet.addCell(new Label(3, row, "招生登记数", cellCenterFormat));
				sheet.addCell(new Label(4, row, "招生完成数", cellCenterFormat));
				sheet.addCell(new Label(5, row, "招生完成率", cellCenterFormat));				
				row += 1;
				for (int i = 0; i < list.size(); i++) {
					sheet.addCell(new Label(0, row, "第"+list.get(i).getRanking()+"名",
							cellCenterFormat));
					sheet.addCell(new Label(1, row, list.get(i).getName()+"",
							cellCenterFormat));
					sheet.addCell(new Label(2, row, list.get(i).getNum1()+"",
							cellCenterFormat));
					sheet.addCell(new Label(3, row, list.get(i).getNum2()+"",
							cellCenterFormat));
					sheet.addCell(new Label(4, row, list.get(i).getNum3()+"",
							cellCenterFormat));
					sheet.addCell(new Label(5, row, list.get(i).getNum4()+"",
							cellCenterFormat));				
					row += 1;
				}
				wwb.write();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				try {
					wwb.close();
					os.close();
				} catch (WriteException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		return null;
	}
	/**
	 * Des:年度间招生任务完成情况统计--年度间招生机构招生完成情况 2017-03-14
	 * 
	 * @author dhp
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "statNDJZSJGZSWCQK")
	public String statNDJZSJGZSWCQK(String zsnd, HttpServletRequest request,
			HttpServletResponse response) {
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		String[] zsnds = zsnd.split("\\|");
		List<List<Statistics>> listMaps = new ArrayList<List<Statistics>>();
		for (int i = 0; i < zsnds.length; i++) {
			String z = zsnds[i];
			List<Map> maps1 = zsjhService.statAll(z);
			int jhNum = ((Number) maps1.get(0).get("bdNum")).intValue();
			List<Map> maps = zsjhService.statBMAll(z);
			List<Statistics> entitys = new ArrayList<Statistics>();
			for (int j = 0; j < maps.size(); j++) {
				Statistics entity1 = new Statistics();
				int rws = ((Number) maps.get(j).get("jhNum")).intValue();
				int djs = ((Number) maps.get(j).get("djNum")).intValue();
				int wcs = ((Number) maps.get(j).get("wcNum")).intValue();
				String num8 = "";
				if (jhNum == 0) {
					num8 = "--";
				} else {
					num8 = format.format(((double) wcs) / ((double) jhNum));
				}
				entity1.setId(z);
				entity1.setName((String) maps.get(j).get("proName"));
				entity1.setNum1(rws);
				entity1.setNum2(djs);
				entity1.setNum3(wcs);
				entity1.setNum8(num8);
				entitys.add(entity1);
			}
			listMaps.add(entitys);
		}
		return JsonMapper.toJsonString(listMaps);
	}

	/**
	 * Des:年度招生生源校分布搜索 2017-03-27
	 * 
	 * @author lf
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "getAll",produces = {"application/text;charset=UTF-8"})
	public String getAll(String zsnd, String syx,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response, Model model)throws Exception {
		HttpSession session = request.getSession();
		Object flag=session.getAttribute("exportRes");
		if (flag!=null) {
			session.removeAttribute("exportRes");
		}
		List<Map<String, Object>> statList=new ArrayList<Map<String, Object>>();
		Zsdj zsdj = new Zsdj();
		String school=null;
		String zymc=null;
		int djs=0;
		int wcs=0;
		String str=URLDecoder.decode(syx,"UTF-8");
		if (str==null||str.equals("")) {
			List<Map> schools = zsdjService.getBySchool(zsnd);
			for (int i = 0; i < schools.size(); i++) {
				zsdj.setFromSchool((String) schools.get(i).get("fromSchool"));
				zsdj.setZsnd(zsnd);
				List<Map> SchoolZys = zsdjService.getSchoolByZYMC(zsdj);
				for (int j = 0; j < SchoolZys.size(); j++) {
					school=(String)SchoolZys.get(j).get("fromSchool").toString();
					zymc=(String)SchoolZys.get(j).get("zymc").toString();
					djs=(Integer.parseInt((String) SchoolZys.get(j).get("djs").toString()));
					wcs=(Integer.parseInt((String) SchoolZys.get(j).get("wcs").toString()));
					Map map = new HashMap();
					map.put("school", school);
					map.put("zymc", zymc);
					map.put("djs", djs);
					map.put("wcs", wcs);
					statList.add(map);
				}
			}
		} else {
			zsdj.setFromSchool(str);
			zsdj.setZsnd(zsnd);
			List<Map> SchoolZys = zsdjService.getSchoolByZYMC(zsdj);
			for (int i = 0; i < SchoolZys.size(); i++) {
				school=(String)SchoolZys.get(i).get("fromSchool").toString();
				zymc=(String)SchoolZys.get(i).get("zymc").toString();
				djs=(Integer.parseInt((String) SchoolZys.get(i).get("djs").toString()));
				wcs=(Integer.parseInt((String) SchoolZys.get(i).get("wcs").toString()));
				Map map = new HashMap();
				map.put("school", school);
				map.put("zymc", zymc);
				map.put("djs", djs);
				map.put("wcs", wcs);
				statList.add(map);
			}
		}
		String filename = "生源校分布情况"
				+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())
				+ ".xls";
		OutputStream os = null;
		WritableWorkbook wwb = null;
		try {
			response.setContentType("application/vnd.ms-excel");
			response.addHeader("Content-Disposition", "attachment; filename="
					+ new String(filename.getBytes("GBK"), "ISO-8859-1"));
			os = response.getOutputStream();
			wwb = Workbook.createWorkbook(os);
			wwb.setProtected(true);
			// 创建Excel页面
			WritableSheet sheet = wwb.createSheet("sheet1", 0);
			// 设置每列单元格的宽度
			sheet.setColumnView(0, 20);
			sheet.setColumnView(1, 20);
			sheet.setColumnView(2, 20);
			sheet.setColumnView(3, 20);
			// 设置单元格样式 居中显示
						WritableCellFormat cellCenterFormat = new WritableCellFormat();
						// 水平居中对齐
						cellCenterFormat.setAlignment(Alignment.CENTRE);
						// 竖直方向居中对齐
						cellCenterFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
						// 表头 字体样式[]
			            WritableFont wf_title = new WritableFont(WritableFont.createFont("黑体"), 13, WritableFont.NO_BOLD, false);
			            WritableCellFormat wctitle = new WritableCellFormat(wf_title);
			            wctitle.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
			            wctitle.setAlignment(Alignment.CENTRE);//横向居中
			            wctitle.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//垂直居中
			            wctitle.setBackground(Colour.GRAY_25);
						// 填入数据
						//总表头
						int row=0;//当前行
						sheet.addCell(new Label(0, row, "招生生源校", wctitle));
						sheet.addCell(new Label(1, row, "专业名称", wctitle));
						sheet.addCell(new Label(2, row, "招生登记数", wctitle));
						sheet.addCell(new Label(3, row, "招生完成数", wctitle));
						row+=1;
						int startRow=row;//起始行
						//数据填充
						for (int i = 0; i < statList.size(); i++) {
								sheet.addCell(new Label(0, row, (String) statList.get(i).get("school").toString(), cellCenterFormat));
								sheet.addCell(new Label(1, row,  (String) statList.get(i).get("zymc").toString(), cellCenterFormat));
								sheet.addCell(new Label(2, row,  (String) statList.get(i).get("djs").toString(), cellCenterFormat));
								sheet.addCell(new Label(3, row,   (String) statList.get(i).get("wcs").toString(), cellCenterFormat));
								row++;
								if(i+1==statList.size()||!((String) statList.get(i).get("school").toString())
										.equals((String) statList.get(i+1).get("school").toString())){
				            		sheet.mergeCells(0, startRow, 0,row-1);//合并单元格
				            		startRow=row;//重新定义起始行
				            	}
							}
					
						wwb.write();
						session.setAttribute("exportRes", "exportRes");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				wwb.close();
				os.close();
			} catch (WriteException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return null;
	}

	@ResponseBody
	@RequestMapping(value = "seachResources")
	public String seachResources(String zsnd,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Map> schools = zsdjService.getBySchool(zsnd);
		return JsonMapper.toJsonString(schools);
	}

	@ResponseBody
	@RequestMapping(value = "sResources")
	public String sResources(String zsnd,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		List<Map> list = new ArrayList<Map>();
		String zsndString = zsnd;
		Map zsndmap = new HashMap();
		zsndmap.put("zsndString", zsndString);
		List<Map> schools = zsdjService.getBySchools(zsndmap);
		for (int j = 0; j < schools.size(); j++) {
			String str = (String) schools.get(j).get("fromSchool");
			Map map = new HashMap();
			if (str.length()>0) {//防止页面生源校出现空值
				map.put("str", str);
			}
			list.add(map);
		}
		return JsonMapper.toJsonString(list);
	}
	
	
	@ResponseBody
	@RequestMapping(value = "exportMx")
	public String exportMx(String zsnd, String syx,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response, Model model)throws Exception {
		HttpSession session = request.getSession();
		Object flag=session.getAttribute("exportRes");
		if (flag!=null) {
			session.removeAttribute("exportRes");
		}
		List<SchoolAndZy> statList = new ArrayList<SchoolAndZy>();
		// 创建List用于保存生源校与专业信息
		List<List<Map>> school_ZyList = new ArrayList<List<Map>>();
		Map zsndmap = new HashMap();
		zsndmap.put("zsndString", zsnd);
		String strr=URLDecoder.decode(syx,"UTF-8");
		zsndmap.put("syx", strr);
		List<Map> schoolAndZY = zsdjService.getSchoolAndZY(zsndmap);
		String key = null;
		String value = null;
		String[] str = zsnd.split(",");
		List<Map> ndjList = new ArrayList<Map>();
		for (int i = 0; i < schoolAndZY.size(); i++) {
			value = (String) schoolAndZY.get(i).get("zymc");
			if (strr == null || strr.equals("")) {
				key = (String) schoolAndZY.get(i).get("school");
			} else {
				key = strr;
			}
			for (int k = 0; k < str.length; k++) {
				Map map2 = new HashMap();
				boolean falg = false;
				String nd = str[k];
				Zsdj zsdj = new Zsdj();
				zsdj.setZsnd(nd);
				List<Map> SchoolZys = zsdjService.getSchoolByDATE(zsdj);
				for (int j = 0; j < SchoolZys.size(); j++) {
					String school = (String) SchoolZys.get(j).get("fromSchool");
					String zymc = (String) SchoolZys.get(j).get("zymc");
					if (school!=null&&zymc!=null) {
						if (school.equals(key) && value.equals(zymc)) {
							falg = true;
							map2 = SchoolZys.get(j);
						}
						
					}
				}
				if (!falg) {
					map2.put("fromSchool", key);
					map2.put("zymc", value);
					map2.put("zsnd", nd);
					/* map2.put("rws", 0); */
					map2.put("djs", 0);
					map2.put("wcs", 0);
				}
				ndjList.add(map2);
			}
		}
		
		 WritableWorkbook wwb = null;
         String fileName = "";
         String savePath = request.getSession().getServletContext().getRealPath("/") + "upload" + "/"+ "生源校分布情况"
  				+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())
  				+ ".xls";
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
		            String[] titleName = {"学生生源校","招生专业","招生年度","专业登记数","专业完成数"};
		            for (int i = 0; i < titleName.length; i++)
		            {
		            	//行中内容
		            	Label titleLab = new Label(i, 0, titleName[i], wctitle);
						ws.addCell(titleLab);
						ws.setColumnView(i, 20);
						ws.setRowView(i+1,320);//高度
		            }
		            int row =1;
		            int startRow=row;
		            int startZyRow=row;
		            for (int i = 0; i < ndjList.size(); i++) {
		            	String School = (String) ndjList.get(i).get("fromSchool").toString();//专业名称
	            		Label labelC1 = new Label(0, row, School,ww2);//专业名称
    					ws.addCell(labelC1);
    					/*ws.mergeCells(0, i+1+index, 0,4);  */       //合并单元格
    					String Zymc = (String) ndjList.get(i).get("zymc").toString();//专业名称
    					Label labelC2 = new Label(1, row,Zymc,ww2);//年度
    					ws.addCell(labelC2);
    					String Zsnd = (String) ndjList.get(i).get("zsnd").toString();//专业名称
    					Label labelC3 = new Label(2, row, Zsnd,ww3);//招生登记哈数
    					ws.addCell(labelC3);
    					
    					String Djs = (String) ndjList.get(i).get("djs").toString();//专业名称
    					Label labelC4 = new Label(3, row, Djs,ww3);//完成数
    					ws.addCell(labelC4);
    					String Wcs = (String) ndjList.get(i).get("wcs").toString();//专业名称
    					Label labelC5 = new Label(4, row,Wcs,ww3);//完成率
    					ws.addCell(labelC5);
    					row++;
		            	if(i+1==ndjList.size()||!((String) ndjList.get(i).get("fromSchool").toString()).equals((String) ndjList.get(i+1).get("fromSchool").toString())){
		            		ws.mergeCells(0, startRow, 0,row-1);
		            		startRow=row;
		            	}
		            	if(i+1==ndjList.size()||!((String) ndjList.get(i).get("fromSchool").toString()+(String) ndjList.get(i).get("zymc").toString()).equals((String) ndjList.get(i+1).get("fromSchool").toString()+(String) ndjList.get(i+1).get("zymc").toString())){
		            		ws.mergeCells(1, startZyRow, 1,row-1);
		            		startZyRow=row;
		            	}
		            }
			 }catch (Exception e) {
					// TODO Auto-generated catch block
					addMessage(redirectAttributes, "导出生源信息失败！失败信息：" + e.getMessage());
				}finally{

					try {
						// 从内存中写入文件中
						wwb.write();
						session.setAttribute("exportRes", "exportRes");
						// 关闭资源，释放内存
						wwb.close();
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					}

			 return JsonMapper.toJsonString(fileName);
	}

	@RequestMapping(value = "updateFile")
	public void updateFile(HttpServletRequest request, HttpServletResponse response,@RequestParam("filePath") String filePath) throws IOException
	{
		String str=URLDecoder.decode(filePath,"UTF-8");
		upload(request, response, str);
		try {
			com.thinkgem.jeesite.common.utils.FileUtils.deleteFile(str);
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
			}catch (Exception e) {
			e.printStackTrace();
		} 

	}
	
	
	
	@ResponseBody
	@RequestMapping(value = "getByAreas", method = RequestMethod.POST)
	public String getByAreas(String id, Model model, String zsnd) {
		Area area = new Area();
		area.setParent(new Area(id));
		// 所有省
		List<Area> areas = areaService.findAllByChr(area);
		List<Statistics> statList = new ArrayList<Statistics>();
		List<Statistics> statList1 = new ArrayList<Statistics>();
		List<Statistics> ssList = new ArrayList<Statistics>();
		NumberFormat format = NumberFormat.getPercentInstance();
		format.setMinimumFractionDigits(2);
		Statistics s;
		String[] str = zsnd.split(",");
		for (int i = 0; i < str.length; i++) {
			Statistics sata = new Statistics();
			sata.setZsnd(str[i]);
			sata.setNum5(0);
			sata.setNum6(0);
			sata.setNum7(0);
			ssList.add(sata);
		}
		for (int i = 0; i < areas.size(); i++) {
			Map aMap = new HashMap();
			statList1=new ArrayList<Statistics>();
			for (int j = 0; j < str.length; j++) {
				Area a = areas.get(i);
				s = new Statistics();
				s.setId(a.getId());
				s.setName(a.getName());
				String zndString = str[j];
				aMap.put("zsnd", zndString);
				aMap.put("type", a.getType());
				aMap.put("id", a.getId());
				List<Map> byAREA = areaService.findByAREA(aMap);
				s.setZsnd(zndString);
				s.setNum1(Integer.parseInt((String) byAREA.get(0).get("zrws")
						.toString()));
				s.setNum2(Integer.parseInt((String) byAREA.get(0).get("zdjs")
						.toString()));
				s.setNum3(Integer.parseInt((String) byAREA.get(0).get("zwcs")
						.toString()));
				s.setNum4((String) byAREA.get(0).get("wcPercent"));
				statList1.add(s);
				for (int k = 0; k < ssList.size(); k++) {
					if (zndString.equals(ssList.get(k).getZsnd())) {
						ssList.get(k)
								.setNum5(
										ssList.get(k).getNum5()
												+ Integer
														.parseInt((String) byAREA
																.get(0)
																.get("zrws")
																.toString()));
						ssList.get(k)
								.setNum6(
										ssList.get(k).getNum6()
												+ Integer
														.parseInt((String) byAREA
																.get(0)
																.get("zdjs")
																.toString()));
						ssList.get(k)
								.setNum7(
										ssList.get(k).getNum7()
												+ Integer
														.parseInt((String) byAREA
																.get(0)
																.get("zwcs")
																.toString()));
					}
				}
			}
			boolean flag=false;
			for (int j = 0; j < statList1.size(); j++) {
				if (statList1.get(j).getNum1()>0||statList1.get(j).getNum2()>0||statList1.get(j).getNum3()>0) {
					flag=true;
				}
			}
			if (flag) {
				statList.addAll(statList1);
			}
		}
		for (int i = 0; i < statList.size(); i++) {
			if (statList.get(i).getNum1() == 0) {
				statList.get(i).setNum4("--");
			}
		}
		for (int k = 0; k < ssList.size(); k++) {

			if (ssList.get(k).getNum5() > 0) {
				ssList.get(k).setNum8(
						format.format((double) ssList.get(k).getNum7()
								/ (double) ssList.get(k).getNum5()));
			} else {
				ssList.get(k).setNum8("--");
			}
		}
		List<List<Statistics>> list = new ArrayList<List<Statistics>>();
		list.add(statList);
		list.add(ssList);
		return JsonMapper.toJsonString(list);
	}
	@ResponseBody
	@RequestMapping(value = "exportRes")
	public String exportRes(Statistics statistics, HttpServletRequest request,
			HttpServletResponse response,String id,
			RedirectAttributes redirectAttributes, String zsnd) {
		HttpSession session = request.getSession();
		Object flag=session.getAttribute("exportRes");
		if (flag!=null) {
			session.removeAttribute("exportRes");
		}
		String filename = "年度招生区域分布情况"
				+ new SimpleDateFormat("yyyy-MM-dd").format(new Date())
				+ ".xls";
		List<Map<String, Object>> statList=new ArrayList<Map<String, Object>>();
		String[] str = zsnd.split(",");
		Map aMap = new HashMap();
		List<Map> byAREA=null;
		List<List<Map>> arrayList = new ArrayList<List<Map>>();
		for (int j = 0; j < str.length; j++) {
			String zndString=str[j];
			aMap.put("zsnd", zndString);
			aMap.put("id", StringUtils.removeLast(id, "0"));//去掉末尾0
			byAREA = areaService.expFindByAREA(aMap);
			arrayList.add(byAREA);
		}
	
		for (int i = 0; i < byAREA.size(); i++) {
			for (int j = 0; j < arrayList.size(); j++) {
				List<Map> ndAreaList=arrayList.get(j);
					String dqId=(String) ndAreaList.get(i).get("id").toString();
						int rws=(Integer.parseInt((String) ndAreaList.get(i).get("zrws").toString()));
						int djs=(Integer.parseInt((String)ndAreaList.get(i).get("zdjs").toString()));
						int wcs=(Integer.parseInt((String)ndAreaList.get(i).get("zwcs").toString()));
						String wcl=((String)ndAreaList.get(i).get("wcPercent").toString());
						String name=((String)ndAreaList.get(i).get("name").toString());
						String n=((String)ndAreaList.get(i).get("zsnd").toString());
						Map map = new HashMap();
						map.put("id", dqId);
						map.put("name", name);
						map.put("zsnd", n);
						map.put("rws", rws);
						map.put("djs", djs);
						map.put("wcs", wcs);
						if (rws==0) {
							map.put("wcl", "--");
						}else {
							map.put("wcl", wcl);
						}
						statList.add(map);
			}
		}
		
		OutputStream os = null;
		WritableWorkbook wwb = null;
	try {
		response.setContentType("application/vnd.ms-excel");
		response.addHeader("Content-Disposition", "attachment; filename="
				+ new String(filename.getBytes("GBK"), "ISO-8859-1"));
		os = response.getOutputStream();
		wwb = Workbook.createWorkbook(os);
		wwb.setProtected(true);
		
			
					for (int j = 1; j < (statList.size() / 65535) + 2; j++) {
						// 创建Excel页面
						WritableSheet sheet = wwb.createSheet("sheet"+j, j);
						// 设置每列单元格的宽度
						sheet.setColumnView(0, 20);
						sheet.setColumnView(1, 20);
						sheet.setColumnView(2, 20);
						sheet.setColumnView(3, 20);
						sheet.setColumnView(4, 20);
						sheet.setColumnView(5, 20);
						// 设置单元格样式 居中显示
									WritableCellFormat cellCenterFormat = new WritableCellFormat();
									// 水平居中对齐
									cellCenterFormat.setAlignment(Alignment.CENTRE);
									// 竖直方向居中对齐
									cellCenterFormat.setVerticalAlignment(VerticalAlignment.CENTRE);
									// 表头 字体样式[]
						            WritableFont wf_title = new WritableFont(WritableFont.createFont("黑体"), 13, WritableFont.NO_BOLD, false);
						            WritableCellFormat wctitle = new WritableCellFormat(wf_title);
						            wctitle.setBorder(jxl.format.Border.ALL, jxl.format.BorderLineStyle.THIN);
						            wctitle.setAlignment(Alignment.CENTRE);//横向居中
						            wctitle.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);//垂直居中
						            wctitle.setBackground(Colour.GRAY_25);
						            // 填入数据
									//总表头
									int row=0;//当前行
									sheet.addCell(new Label(0, row, "区域名称", wctitle));
									sheet.addCell(new Label(1, row, "招生年度", wctitle));
									sheet.addCell(new Label(2, row, "任务数", wctitle));
									sheet.addCell(new Label(3, row, "登记数", wctitle));
									sheet.addCell(new Label(4, row, "完成数", wctitle));
									sheet.addCell(new Label(5, row, "完成率", wctitle));
									
									row+=1;
									
									int startRow=row;//起始行
						for (int i = 1; i < 65535&& i + (j - 1) * 65535 < statList.size() + j; i++) {
							Map object =  statList.get(i - j + (j - 1)
									* 65535);
							Map object1=new HashMap();
							if ((i - j+1 + (j - 1)
										* 65535)!=statList.size()) {
								object1 =  statList.get(i - j+1 + (j - 1)
										* 65535);
							}
								

							//数据填充
								sheet.addCell(new Label(0, row, (String) object.get("name").toString(), cellCenterFormat));
								sheet.addCell(new Label(1, row,  (String) object.get("zsnd").toString(), cellCenterFormat));
								sheet.addCell(new Label(2, row,  (String) object.get("rws").toString(), cellCenterFormat));
								sheet.addCell(new Label(3, row,   (String) object.get("djs").toString(), cellCenterFormat));
								sheet.addCell(new Label(4, row,  (String) object.get("wcs").toString(), cellCenterFormat));
								sheet.addCell(new Label(5, row,   (String) object.get("wcl").toString(), cellCenterFormat));
								row++;
								if((row==65535)||(i - j+1 + (j - 1)
										* 65535)==statList.size()||!((String) object.get("id").toString())
										.equals((String) object1.get("id").toString())){
				            		sheet.mergeCells(0, startRow, 0,row-1);//合并单元格
				            		startRow=row;//重新定义起始行
				            	}
						}
					}

					
				wwb.write();
				session.setAttribute("exportRes", "exportRes");
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		addMessage(redirectAttributes, "导出生源信息失败！失败信息：" + e.getMessage());
	}finally {
		try {
			wwb.close();
			os.close();
		} catch (WriteException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
			return null;

	}
	@ResponseBody
	@RequestMapping(value = "exportSuccess")
	public String exportSuccess( HttpServletRequest request,
			HttpServletResponse response){
		Object flag=request.getSession().getAttribute("exportRes");
		if (flag!=null) {
			request.getSession().removeAttribute("exportRes");
			return "1";
		}else {
			request.getSession().removeAttribute("exportRes");
			return "0";
		}
	}
	@ResponseBody
	@RequestMapping(value = "ByAreas")
	public String ByAreas( HttpServletRequest request,String id,
			HttpServletResponse response){
		Area area = new Area();
		area.setId(id);
		List<Area> areas = areaService.findAllByChr(area);
		return JsonMapper.toJsonString(areas);
	}
}
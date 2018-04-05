/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRecordService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwRecordService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRecord;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRwRecord;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRecordService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwRecordService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrService;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;

/**
 * 计划分解Controller
 * @author lg
 * @version 2016-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfj/jhFj")
public class JhFjController extends BaseController {

	@Autowired
	private JhFjService jhFjService;
	@Autowired
	private JhFjRwService jhFjRwService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private AreaService areaService;
	@Autowired
	private JhFjGrService jhFjGrService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private JhFjRecordService jhFjRecordService;
	@Autowired
	private JhFjRwRecordService jhFjRwRecordService;
	@Autowired
	private JhFjGrRecordService jhFjGrRecordService;
	@Autowired
	private JhFjGrRwService jhFjGrRwService;
	@Autowired
	private JhFjGrRwRecordService jhFjGrRwRecordService;
	
	@ModelAttribute
	public JhFj get(@RequestParam(required=false) String id) {
		JhFj entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjService.get(id);
		}
		if (entity == null){
			entity = new JhFj();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFj jhFj, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFj> page = jhFjService.findPage(new Page<JhFj>(request, response), jhFj); 
		model.addAttribute("page", page);
		return "modules/jhfj/jhFjList";
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = {"shList", ""})
	public String shList(JhFj jhFj, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFj> page = jhFjService.findPage(new Page<JhFj>(request, response), jhFj); 
		model.addAttribute("page", page);
		return "modules/jhfj/jhFjShList";
	}
	
	/**
	 * 部门任务分解
	 * @param jhFj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = {"rwList", ""})
	public String rwList(JhFj jhFj, HttpServletRequest request, HttpServletResponse response, Model model) {
		//当前用户操作
		/*User user = UserUtils.getUser();
		Office office = user.getOffice();
		jhFj.setOffice(office);*/
		jhFj.setBcStatus("1");
		Page<JhFj> page = jhFjService.findPage(new Page<JhFj>(request, response), jhFj);
		model.addAttribute("page", page);
		model.addAttribute("jhFj",jhFj);
		return "modules/jhfj/officeRwFjList";
	}
	
	/**
	 * 部门内部任务分解审核
	 * @param jhFj
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = {"bmshList", ""})
	public String bmshList(JhFj jhFj, HttpServletRequest request, HttpServletResponse response, Model model) {
		jhFj.setBcStatus("1");
		jhFj.setFjFlag("1");
		Page<JhFj> page = jhFjService.findPage(new Page<JhFj>(request, response), jhFj);
		model.addAttribute("page", page);
		model.addAttribute("jhFj",jhFj);
		return "modules/jhfj/jhFjBmShList";
	}

	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "form")
	public String form(JhFj jhFj, Model model) {
		JhFjRw jhFjRw = new JhFjRw();
		jhFjRw.setJhFjId(jhFj.getId());
		List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
		model.addAttribute("jhFj", jhFj);
		//model.addAttribute("jhFjRwList", list);
		if(jhFj.getZsjh() != null){
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFj.getZsjh().getId())) {
				entity = zsjhService.get(jhFj.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//部门招生人数
			int zsrs = jhFj.getZsrs();
			//剩余招生人数=计划剩余人数+部门招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);
		
			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmIdStr = "";
			String oldBmmcStr = "";
			
			oldBmIdStr = jhFj.getOffice().getId()+",";
			oldBmmcStr = jhFj.getOffice().getName()+",";
			
			model.addAttribute("oldBmIdStr", oldBmIdStr);
			model.addAttribute("oldBmmcStr", oldBmmcStr);
			for (int i = 0; i < list.size(); i++) {
				JhFjRw rw = list.get(i);
				shengArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
				shiArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
				quArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
				zhenArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				oldAreaStr += rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				model.addAttribute("oldAreaStr", oldAreaStr);
			}
					
			int pn=0;
			int sn=0;
			int qn=0;
			for (int i = 0; i < list.size(); i++) {
				JhFjRw rw = list.get(i);
				innerTable += "<tr>";
				//省份
				if(rw.getSf() != "" || rw.getSf() != null){
					String sheng = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
					int shengCount = getSubCount(shengArray,sheng);
					
						if(shengCount>1){
							pn = pn+1;
							if(strSheng == ""){
								innerTable += "<td rowspan = "+shengCount+">";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							
							if(!strSheng.equals(rw.getSf())){
								innerTable += "<td>";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							if(pn == shengCount){
								strSheng = "";
								pn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
						}
					
					
					//市
					String shi = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
					int shiCount = getSubCount(shiArray,shi);
					
						if(shiCount>1){
							sn = sn+1;
							if(strShi == ""){
								innerTable += "<td rowspan = "+shiCount+">";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(!strShi.equals(rw.getCs())){
								innerTable += "<td>";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(sn == shiCount){
								strShi = "";
								sn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
						}
					
					
					//区
					String qu = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
					int quCount = getSubCount(quArray,qu);
					
						if(quCount>1){
							qn = qn+1;
							if(strQu == ""){
								innerTable += "<td rowspan = "+quCount+">";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							
							if(!strQu.equals(rw.getQx())){
								innerTable += "<td>";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							if(qn == quCount){
								strQu = "";
								qn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
						}
					
				}
				
				//镇
				if(!rw.getXz().equals("")&& rw.getXz() != null){
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}
				
				innerTable += "</tr>";
			}
			
			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
			
			if(jhFj.getOffice() != null){
				//点击查询加载选中的地区
				String areaStr = "";
				String tableShengStr = "";
				String tableShiStr = "";
				String tableQuStr = "";
				String tableZhenStr = "";
				//加载省
				List<Area> shengList = findAllByChr("1");
				tableShengStr += "<table>";
				for (int i = 0; i < shengList.size(); i++) {
					Area areaSheng = shengList.get(i);
					if(i==0){
						tableShengStr += "<tr>";
					}
					String strShengChecked = "";
					if(quArray.indexOf(areaSheng.getId())!=-1){
						strShengChecked = "checked=\"checked\"";
						
						//加载市
						List<Area> shiList = findAllByChr(areaSheng.getId());
						if(shiList.size() > 0){
						tableShiStr += "<div id=\"div"+jhFj.getOffice().getId()+areaSheng.getId()+"\">";
						tableShiStr += areaSheng.getName()+"<br/>";
						tableShiStr += "<table>";
						for (int j = 0; j < shiList.size(); j++) {
							Area areaShi = shiList.get(j);
							if(j==0){
								tableShiStr += "<tr>";
							}
							String strShiChecked = "";
							if(quArray.indexOf(areaShi.getId())!=-1){
								strShiChecked = "checked=\"checked\"";
								
								//加载区县
								List<Area> quList = findAllByChr(areaShi.getId());
								if(quList.size() > 0){
								tableQuStr += "<div id=\"div"+jhFj.getOffice().getId()+areaShi.getId()+"\">";
								tableQuStr += areaShi.getName()+"<br/>";
								tableQuStr += "<table>";
								for (int k = 0; k < quList.size(); k++) {
									Area areaQu = quList.get(k);
									if(k==0){
										tableQuStr += "<tr>";
									}
									String strQuChecked = "";
									if(quArray.indexOf(areaQu.getId())!=-1){
										strQuChecked = "checked=\"checked\"";
										
										
										//加载镇
										List<Area> zhenList = findAllByChr(areaQu.getId());
										if(zhenList.size() > 0){
										tableZhenStr += "<div id=\"div"+jhFj.getOffice().getId()+areaQu.getId()+"\">";
										tableZhenStr += areaQu.getName()+"<br/>";
										tableZhenStr += "<table>";
										for (int m = 0; m < zhenList.size(); m++) {
											Area areaZhen = zhenList.get(m);
											if(k==0){
												tableZhenStr += "<tr>";
											}
											String strZhenChecked = "";
											if(zhenArray.indexOf(areaZhen.getId())!=-1){
												strZhenChecked = "checked=\"checked\"";
											}
											
											tableZhenStr += "<td width=\"165\">";
											tableZhenStr += "<input type=\"checkbox\" id="+areaZhen.getId()+jhFj.getOffice().getId()+" "+strZhenChecked+" name="+areaZhen.getId()+jhFj.getOffice().getId()+" value="+areaZhen.getName()+" onclick=\"SaveAreaResult('"+jhFj.getOffice().getId()+"','"+areaSheng.getId()+"','"+areaShi.getId()+"','"+areaQu.getId()+"','"+areaZhen.getId()+"',this)\"/>";
											tableZhenStr +=areaZhen.getName();
											tableZhenStr += "</td>";
											if((m+1)%5==0 && m!=0){
												tableZhenStr += "</tr><tr>";
											}
										}
										tableZhenStr += "</tr>";
										tableZhenStr += "</table>";
										tableZhenStr += "<br/>";
										tableZhenStr += "</div>";
										//镇加载完毕
										}
									}
									
									tableQuStr += "<td width=\"165\">";
									tableQuStr += "<input type=\"checkbox\" id="+areaQu.getId()+jhFj.getOffice().getId()+" "+strQuChecked+" name="+areaQu.getId()+jhFj.getOffice().getId()+" value="+areaQu.getName()+" onclick=\"openZhen('"+jhFj.getOffice().getId()+"','"+areaSheng.getId()+"','"+areaShi.getId()+"','"+areaQu.getId()+"',this)\"/>";
									tableQuStr +=areaQu.getName();
									tableQuStr += "</td>";
									if((k+1)%5==0 && k!=0){
										tableQuStr += "</tr><tr>";
									}
								}
								tableQuStr += "</tr>";
								tableQuStr += "</table>";
								tableQuStr += "<br/>";
								tableQuStr += tableZhenStr;//将显示镇的层添加到显示区县的层中
								tableQuStr += "</div>";
								//区县加载完毕
								}
							}
							
							tableShiStr += "<td width=\"165\">";
							tableShiStr += "<input type=\"checkbox\" id="+areaShi.getId()+jhFj.getOffice().getId()+" "+strShiChecked+" name="+areaShi.getId()+jhFj.getOffice().getId()+" value="+areaShi.getName()+" onclick=\"openQu('"+jhFj.getOffice().getId()+"','"+areaSheng.getId()+"','"+areaShi.getId()+"',this)\"/>";
							tableShiStr +=areaShi.getName();
							tableShiStr += "</td>";
							if((j+1)%5==0 && j!=0){
								tableShiStr += "</tr><tr>";
							}
						}
						tableShiStr += "</tr>";
						tableShiStr += "</table>";
						tableShiStr += "<br/>";
						tableShiStr += tableQuStr;//将显示区县的层添加到显示市的层中
						tableShiStr += "</div>";
						}
						//市加载完毕
					}
					tableShengStr += "<td width=\"165\">";
					tableShengStr += "<input type=\"checkbox\" id="+areaSheng.getId()+jhFj.getOffice().getId()+" "+strShengChecked+" name="+areaSheng.getId()+jhFj.getOffice().getId()+" value="+areaSheng.getName()+" onclick=\"openShi('"+jhFj.getOffice().getId()+"','"+areaSheng.getId()+"',this)\"/>";
					tableShengStr +=areaSheng.getName();
					tableShengStr += "</td>";
					if((i+1)%5==0 && i!=0){
						tableShengStr += "</tr><tr>";
					}
				}
				tableShengStr += "</tr>";
				tableShengStr += "</table>";
				tableShengStr += tableShiStr;//将显示市的层添加到显示省的层中
				//省加载完毕
				areaStr += tableShengStr;
						
				String selectAreaStr = "";
				selectAreaStr = selectAreaStr +"<div class=\"modal fade\" style=\"width:880px;display:none;\" id=\"selectAreaShow\">";
				selectAreaStr = selectAreaStr +"<div class=\"modal-dialog\">";
				selectAreaStr = selectAreaStr +"<div class=\"modal-content\">";
		  		selectAreaStr = selectAreaStr +"<div class=\"modal-header\">";
		   		selectAreaStr = selectAreaStr +"<button type=\"button\" class=\"close\" data-dismiss=\"modal\" aria-hidden=\"true\"><span>&times;</span></button>";
		    	selectAreaStr = selectAreaStr +"<h4 class=\"modal-title\" id=\"myModalLabel"+jhFj.getOffice().getId()+"\">选择地区</h4>";
		  		selectAreaStr = selectAreaStr +"</div>";
		  		selectAreaStr = selectAreaStr +"<div class=\"modal-body\">";
		  		selectAreaStr = selectAreaStr +"<div id=\"areaPanel"+jhFj.getOffice().getId()+"\">"+areaStr+"</div>";
		  		selectAreaStr = selectAreaStr +"</div>";
		  		selectAreaStr = selectAreaStr +"<div class=\"modal-footer\">";
		    	selectAreaStr = selectAreaStr +"<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">关闭</button>";
		    	selectAreaStr = selectAreaStr +"<button type=\"button\" onclick=\"SaveSelectArea('"+jhFj.getOffice().getId()+"')\" class=\"btn btn-primary\" data-dismiss=\"modal\">确定</button>";
		  		selectAreaStr = selectAreaStr +"</div>";
				selectAreaStr = selectAreaStr +"</div>";
				selectAreaStr = selectAreaStr +"</div>";
				selectAreaStr = selectAreaStr +"</div>";
				model.addAttribute("selectAreaStr", selectAreaStr);
				
				System.out.println(selectAreaStr);
			}
		}
		return "modules/jhfj/jhFjForm";
	}
	
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "formsh")
	public String formsh(JhFj jhFj, Model model) {
		JhFjRw jhFjRw = new JhFjRw();
		jhFjRw.setJhFjId(jhFj.getId());
		List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
		jhFj.setGrApproveBy(UserUtils.getUser());
		if(jhFj.getGrApproveDate()==null)
		{
			jhFj.setGrApproveDate(new Date());
		}
		model.addAttribute("jhFj", jhFj);
		//model.addAttribute("jhFjRwList", list);
		if(jhFj.getZsjh() != null){
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFj.getZsjh().getId())) {
				entity = zsjhService.get(jhFj.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			model.addAttribute("zsjhEntity", entity);
			model.addAttribute("shenHeName", UserUtils.getUser().getName());
			model.addAttribute("shenHeDate", DateUtils.getDate());
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//部门招生人数
			int zsrs = jhFj.getZsrs();
			//剩余招生人数=计划剩余人数+部门招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);
		
			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmIdStr = "";
			String oldBmmcStr = "";
			
			oldBmIdStr = jhFj.getOffice().getId()+",";
			oldBmmcStr = jhFj.getOffice().getName()+",";
			
			model.addAttribute("oldBmIdStr", oldBmIdStr);
			model.addAttribute("oldBmmcStr", oldBmmcStr);
			for (int i = 0; i < list.size(); i++) {
				JhFjRw rw = list.get(i);
				shengArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
				shiArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
				quArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
				zhenArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				oldAreaStr += rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				model.addAttribute("oldAreaStr", oldAreaStr);
			}
					
			int pn=0;
			int sn=0;
			int qn=0;
			for (int i = 0; i < list.size(); i++) {
				JhFjRw rw = list.get(i);
				innerTable += "<tr>";
				//省份
				if(rw.getSf() != "" || rw.getSf() != null){
					String sheng = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
					int shengCount = getSubCount(shengArray,sheng);
					
						if(shengCount>1){
							pn = pn+1;
							if(strSheng == ""){
								innerTable += "<td rowspan = "+shengCount+">";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							
							if(!strSheng.equals(rw.getSf())){
								innerTable += "<td>";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							if(pn == shengCount){
								strSheng = "";
								pn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
						}
					
					
					//市
					String shi = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
					int shiCount = getSubCount(shiArray,shi);
					
						if(shiCount>1){
							sn = sn+1;
							if(strShi == ""){
								innerTable += "<td rowspan = "+shiCount+">";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(!strShi.equals(rw.getCs())){
								innerTable += "<td>";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(sn == shiCount){
								strShi = "";
								sn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
						}
					
					
					//区
					String qu = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
					int quCount = getSubCount(quArray,qu);
					
						if(quCount>1){
							qn = qn+1;
							if(strQu == ""){
								innerTable += "<td rowspan = "+quCount+">";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							
							if(!strQu.equals(rw.getQx())){
								innerTable += "<td>";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							if(qn == quCount){
								strQu = "";
								qn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
						}
					
				}
				
				//镇
				if(!rw.getXz().equals("")&& rw.getXz() != null){
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}
				
				innerTable += "</tr>";
			}
			
			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
		}
		return "modules/jhfj/jhFjFormShenHe";
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "jhfjView")
	public String jhfjView(JhFj jhFj, Model model)
	{
			JhFjRw jhFjRw = new JhFjRw();
			jhFjRw.setJhFjId(jhFj.getId());
			List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
			jhFj.setGrApproveBy(UserUtils.getUser());
			if(jhFj.getGrApproveDate()==null)
			{
				jhFj.setGrApproveDate(new Date());
			}
			model.addAttribute("jhFj", jhFj);
			//model.addAttribute("jhFjRwList", list);
			if(jhFj.getZsjh() != null){
				Zsjh entity = null;
				if (StringUtils.isNotBlank(jhFj.getZsjh().getId())) {
					entity = zsjhService.get(jhFj.getZsjh().getId());
				}
				if (entity == null) {
					entity = new Zsjh();
				}
				
				model.addAttribute("zsjhEntity", entity);
				model.addAttribute("shenHeName", UserUtils.getUser().getName());
				model.addAttribute("shenHeDate", DateUtils.getDate());
				//计划中的剩余数量
				int surplusValue = entity.getSurplus();
				//部门招生人数
				int zsrs = jhFj.getZsrs();
				//剩余招生人数=计划剩余人数+部门招生人数
				surplusValue = surplusValue + zsrs;
				//剩余招生人数
				model.addAttribute("surplusValue", surplusValue);
			
				String innerTable = "";
				innerTable += "<table class='table table-striped table-bordered table-condensed'>";
				String strSheng = "";
				String strShi = "";
				String strQu = "";
				String shengArray = "";
				String shiArray = "";
				String quArray = "";
				String zhenArray = "";
				String oldAreaStr = "";
				String oldBmIdStr = "";
				String oldBmmcStr = "";
				
				oldBmIdStr = jhFj.getOffice().getId()+",";
				oldBmmcStr = jhFj.getOffice().getName()+",";
				
				model.addAttribute("oldBmIdStr", oldBmIdStr);
				model.addAttribute("oldBmmcStr", oldBmmcStr);
				for (int i = 0; i < list.size(); i++) {
					JhFjRw rw = list.get(i);
					shengArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
					shiArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
					quArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
					zhenArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
					oldAreaStr += rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
					model.addAttribute("oldAreaStr", oldAreaStr);
				}
						
				int pn=0;
				int sn=0;
				int qn=0;
				for (int i = 0; i < list.size(); i++) {
					JhFjRw rw = list.get(i);
					innerTable += "<tr>";
					//省份
					if(rw.getSf() != "" || rw.getSf() != null){
						String sheng = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
						int shengCount = getSubCount(shengArray,sheng);
						
							if(shengCount>1){
								pn = pn+1;
								if(strSheng == ""){
									innerTable += "<td rowspan = "+shengCount+">";
									innerTable += rw.getSfName();
									innerTable += "</td>";
									strSheng = rw.getSf();
								}
								
								if(!strSheng.equals(rw.getSf())){
									innerTable += "<td>";
									innerTable += rw.getSfName();
									innerTable += "</td>";
									strSheng = rw.getSf();
								}
								if(pn == shengCount){
									strSheng = "";
									pn = 0;
								}
							}
							else{
								innerTable += "<td>";
								innerTable += rw.getSfName();
								innerTable += "</td>";
							}
						
						
						//市
						String shi = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
						int shiCount = getSubCount(shiArray,shi);
						
							if(shiCount>1){
								sn = sn+1;
								if(strShi == ""){
									innerTable += "<td rowspan = "+shiCount+">";
									innerTable += rw.getCsName();
									innerTable += "</td>";
									strShi = rw.getCs();
								}
								
								if(!strShi.equals(rw.getCs())){
									innerTable += "<td>";
									innerTable += rw.getCsName();
									innerTable += "</td>";
									strShi = rw.getCs();
								}
								
								if(sn == shiCount){
									strShi = "";
									sn = 0;
								}
							}
							else{
								innerTable += "<td>";
								innerTable += rw.getCsName();
								innerTable += "</td>";
							}
						
						
						//区
						String qu = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
						int quCount = getSubCount(quArray,qu);
						
							if(quCount>1){
								qn = qn+1;
								if(strQu == ""){
									innerTable += "<td rowspan = "+quCount+">";
									innerTable += rw.getQxName();
									innerTable += "</td>";
									strQu = rw.getQx();
								}
								
								if(!strQu.equals(rw.getQx())){
									innerTable += "<td>";
									innerTable += rw.getQxName();
									innerTable += "</td>";
									strQu = rw.getQx();
								}
								if(qn == quCount){
									strQu = "";
									qn = 0;
								}
							}
							else{
								innerTable += "<td>";
								innerTable += rw.getQxName();
								innerTable += "</td>";
							}
						
					}
					
					//镇
					if(!rw.getXz().equals("")&& rw.getXz() != null){
						innerTable += "<td>";
						innerTable += rw.getXzName();
						innerTable += "</td>";
					}
					
					innerTable += "</tr>";
				}
				
				innerTable += "</table>";
				model.addAttribute("innerTable", innerTable);
			}
			return "modules/jhfj/jhfjView";
	}
	
	/**
	 * 部门任务分解
	 * @param jhFj
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "bmRwFjForm")
	public String bmRwFjForm(JhFj jhFj, Model model) {
		JhFjRw jhFjRw = new JhFjRw();
		jhFjRw.setJhFjId(jhFj.getId());
		List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
		model.addAttribute("jhFj", jhFj);
		//model.addAttribute("jhFjRwList", list);

		String oldJsIdStr = "";
		String oldJsNameStr = "";
		String showTable = "";
		showTable += "<table class='table table-striped table-bordered table-condensed'>";
		showTable += "<tr>";
		showTable += "<td>教师名称</td>";
		showTable += "<td>招生人数</td>";
		showTable += "</tr>";
		List<User> users = systemService.findUserByOfficeId(jhFj.getOffice().getId());
		for(int i=0;i<users.size();i++){
			User user = users.get(i);
			JhFjGr jhfjgr = new JhFjGr();
			jhfjgr.setZsjh(jhFj.getZsjh());
			jhfjgr.setJsId(user.getId());
			jhfjgr.setFjfs("2");
			List<JhFjGr> jhFjGrs = jhFjGrService.findList(jhfjgr);
			for (int j = 0; j < jhFjGrs.size(); j++) {
				JhFjGr jhFjGr = jhFjGrs.get(j);
				oldJsIdStr += jhFjGr.getJsId()+",";
				oldJsNameStr += jhFjGr.getJsmc()+",";
				showTable += "<tr>";
				showTable += "<td><input id='hidden"+jhFjGr.getJsId()+"' type='hidden' name='jsmc' value='"+jhFjGr.getJsId()+"'/>"+jhFjGr.getJsmc()+"</td>";
				showTable += "<td><input id='input"+jhFjGr.getJsId()+"' type='text' name='zsrsInput' value='"+jhFjGr.getZsrs()+"' class='input-xlarge'/></td>";
				showTable += "</tr>";
			}
			/*if(jhFjGrs.size()>0){
				model.addAttribute("showTable", showTable);
			}*/
		}
		showTable += "</table>";
		model.addAttribute("showTable", showTable);
		model.addAttribute("oldJsIdStr", oldJsIdStr);
		model.addAttribute("oldJsNameStr", oldJsNameStr);
		
		return "modules/jhfj/officeRwFjForm";
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "bmRwFjShForm")
	public String bmRwFjShForm(JhFj jhFj, Model model) {
		JhFjRw jhFjRw = new JhFjRw();
		jhFjRw.setJhFjId(jhFj.getId());
		List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
		jhFj.setGrApproveBy(UserUtils.getUser());
		if(jhFj.getGrApproveDate() ==null || "".equals(jhFj.getGrApproveDate()))
		{
			jhFj.setGrApproveDate(new Date());
		}
		model.addAttribute("jhFj", jhFj);
		//model.addAttribute("jhFjRwList", list);
		
		model.addAttribute("zsjhEntity", zsjhService.get(jhFj.getZsjh().getId()));
		model.addAttribute("shenHeName", UserUtils.getUser().getName());
		/*model.addAttribute("shenHeDate", DateUtils.getDate());*/
		
		String oldJsIdStr = "";
		String oldJsNameStr = "";
		String showTable = "";
		showTable += "<table class='table table-striped table-bordered table-condensed'>";
		showTable += "<tr>";
		showTable += "<td>教师名称</td>";
		showTable += "<td>招生人数</td>";
		showTable += "</tr>";
		List<User> users = systemService.findUserByOfficeId(jhFj.getOffice().getId());
		for(int i=0;i<users.size();i++){
			User user = users.get(i);
			JhFjGr jhfjgr = new JhFjGr();
			jhfjgr.setZsjh(jhFj.getZsjh());
			jhfjgr.setJsId(user.getId());
			jhfjgr.setFjfs("2");
			List<JhFjGr> jhFjGrs = jhFjGrService.findList(jhfjgr);
			for (int j = 0; j < jhFjGrs.size(); j++) {
				JhFjGr jhFjGr = jhFjGrs.get(j);
				oldJsIdStr += jhFjGr.getJsId()+",";
				oldJsNameStr += jhFjGr.getJsmc()+",";
				showTable += "<tr>";
				showTable += "<td><input id='hidden"+jhFjGr.getId()+"' type='hidden' name='jhfjgrId' value='"+jhFjGr.getId()+"'/><input id='hidden"+jhFjGr.getJsId()+"' type='hidden' name='jsmc' value='"+jhFjGr.getJsId()+"'/>"+jhFjGr.getJsmc()+"</td>";
				showTable += "<td>"+jhFjGr.getZsrs()+"<input id='input"+jhFjGr.getJsId()+"' type='hidden' name='zsrsInput' value='"+jhFjGr.getZsrs()+"' class='input-xlarge'/></td>";
				showTable += "</tr>";
			}
			/*if(jhFjGrs.size()>0){
				model.addAttribute("showTable", showTable);
			}*/
		}
		showTable += "</table>";
		model.addAttribute("showTable", showTable);
		model.addAttribute("oldJsIdStr", oldJsIdStr);
		model.addAttribute("oldJsNameStr", oldJsNameStr);
		
		return "modules/jhfj/jhFjFormBmShenHe";
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "bmfjView")
	public String bmfjView(JhFj jhFj, Model model) {
		JhFjRw jhFjRw = new JhFjRw();
		jhFjRw.setJhFjId(jhFj.getId());
		List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);
		jhFj.setGrApproveBy(UserUtils.getUser());
		if(jhFj.getGrApproveDate() ==null || "".equals(jhFj.getGrApproveDate()))
		{
			jhFj.setGrApproveDate(new Date());
		}
		model.addAttribute("jhFj", jhFj);
		//model.addAttribute("jhFjRwList", list);
		
		model.addAttribute("zsjhEntity", zsjhService.get(jhFj.getZsjh().getId()));
		model.addAttribute("shenHeName", UserUtils.getUser().getName());
		/*model.addAttribute("shenHeDate", DateUtils.getDate());*/
		
		String oldJsIdStr = "";
		String oldJsNameStr = "";
		String showTable = "";
		showTable += "<table class='table table-striped table-bordered table-condensed'>";
		showTable += "<tr>";
		showTable += "<td>教师名称</td>";
		showTable += "<td>招生人数</td>";
		showTable += "</tr>";
		List<User> users = systemService.findUserByOfficeId(jhFj.getOffice().getId());
		for(int i=0;i<users.size();i++){
			User user = users.get(i);
			JhFjGr jhfjgr = new JhFjGr();
			jhfjgr.setZsjh(jhFj.getZsjh());
			jhfjgr.setJsId(user.getId());
			jhfjgr.setFjfs("2");
			List<JhFjGr> jhFjGrs = jhFjGrService.findList(jhfjgr);
			for (int j = 0; j < jhFjGrs.size(); j++) {
				JhFjGr jhFjGr = jhFjGrs.get(j);
				oldJsIdStr += jhFjGr.getJsId()+",";
				oldJsNameStr += jhFjGr.getJsmc()+",";
				showTable += "<tr>";
				showTable += "<td><input id='hidden"+jhFjGr.getId()+"' type='hidden' name='jhfjgrId' value='"+jhFjGr.getId()+"'/><input id='hidden"+jhFjGr.getJsId()+"' type='hidden' name='jsmc' value='"+jhFjGr.getJsId()+"'/>"+jhFjGr.getJsmc()+"</td>";
				showTable += "<td>"+jhFjGr.getZsrs()+"<input id='input"+jhFjGr.getJsId()+"' type='hidden' name='zsrsInput' value='"+jhFjGr.getZsrs()+"' class='input-xlarge'/></td>";
				showTable += "</tr>";
			}
			/*if(jhFjGrs.size()>0){
				model.addAttribute("showTable", showTable);
			}*/
		}
		showTable += "</table>";
		model.addAttribute("showTable", showTable);
		model.addAttribute("oldJsIdStr", oldJsIdStr);
		model.addAttribute("oldJsNameStr", oldJsNameStr);
		
		return "modules/jhfj/bmfjView";
	}
	
	@RequestMapping(value = "bmRwSh")
	public String bmRwSh(String jhfjId,String[] jhfjgrIds,String[] zsrses,String grShZt,String grSpnr) {
		JhFj jhfj = jhFjService.get(jhfjId);
		User u = UserUtils.getUser();
		for (int i = 0; i < jhfjgrIds.length-1; i++) {
			String id = jhfjgrIds[i].toString();
			JhFjGr jhFjgr = jhFjGrService.get(id);
			if (grShZt.equals("2")) {// 审核不通过
				// 记录部门计划分解历史信息
				JhFjGrRecord jhFjGrRecord = new JhFjGrRecord();
				jhFjGrRecord.setJhFjGrId(jhFjgr.getId());
				jhFjGrRecord.setJhId(jhFjgr.getZsjh().getId());
				jhFjGrRecord.setJsId(jhFjgr.getJsId());
				jhFjGrRecord.setZsrs(jhFjgr.getZsrs());
				jhFjGrRecord.setPx(jhFjgr.getPx());
				jhFjGrRecord.setBcstatus(jhFjgr.getBcStatus());
				jhFjGrRecord.setSpnr(jhFjgr.getSpnr());
				jhFjGrRecord.setCreateBy(jhFjgr.getCreateBy());
				jhFjGrRecord.setCreateDate(jhFjgr.getCreateDate());
				jhFjGrRecord.setUpdateBy(jhFjgr.getUpdateBy());
				jhFjGrRecord.setUpdateDate(jhFjgr.getUpdateDate());
				jhFjGrRecord.setRemarks(jhFjgr.getRemarks());
				jhFjGrRecord.setDelFlag(jhFjgr.getDelFlag());
				jhFjGrRecordService.save(jhFjGrRecord);
				
				JhFjGrRecord newJhGrFjRecord = new JhFjGrRecord();
				newJhGrFjRecord.setJhFjGrId(jhFjgr.getId());
				newJhGrFjRecord.setZsjh(jhFjgr.getZsjh());
				newJhGrFjRecord.setJsId(jhFjgr.getJsId());
				JhFjGrRecord lastJhFjGrRecord = jhFjGrRecordService.getLastJhFjInfo(newJhGrFjRecord);
				
				String jhFjGrRecordId = lastJhFjGrRecord.getId();
				
				//记录部门计划分解任务历史信息
				JhFjGrRw jhFjGrRw = new JhFjGrRw();
				jhFjGrRw.setJhFjId(jhFjgr.getId());
				List<JhFjGrRw> list = jhFjGrRwService.findList(jhFjGrRw);
				for (int j = 0; j < list.size(); j++) {
					JhFjGrRw newjhFjGrRw = list.get(j);
					JhFjGrRwRecord jhFjGrRwRecord = new JhFjGrRwRecord();
					jhFjGrRwRecord.setJhFjGrRecordId(jhFjGrRecordId);
					jhFjGrRwRecord.setJhFjGrRwId(newjhFjGrRw.getId());
					jhFjGrRwRecord.setJhFjId(newjhFjGrRw.getJhFjId());
					jhFjGrRwRecord.setSf(newjhFjGrRw.getSf());
					jhFjGrRwRecord.setCs(newjhFjGrRw.getCs());
					jhFjGrRwRecord.setQx(newjhFjGrRw.getQx());
					jhFjGrRwRecord.setXz(newjhFjGrRw.getXz());
					jhFjGrRwRecord.setCreateBy(newjhFjGrRw.getCreateBy());
					jhFjGrRwRecord.setCreateDate(newjhFjGrRw.getCreateDate());
					jhFjGrRwRecord.setUpdateBy(newjhFjGrRw.getUpdateBy());
					jhFjGrRwRecord.setUpdateDate(newjhFjGrRw.getUpdateDate());
					jhFjGrRwRecord.setRemarks(newjhFjGrRw.getRemarks());
					jhFjGrRwRecord.setDelFlag(newjhFjGrRw.getDelFlag());
					jhFjGrRwRecordService.save(jhFjGrRwRecord);
				}
				jhfj.setFjFlag("0");
			} else if (grShZt.equals("1")) {// 审核通过
				
			}
			jhFjgr.setZsrs(Integer.parseInt(zsrses[i].toString()));
			jhFjgr.setBcStatus(grShZt);
			jhFjgr.setSpnr(grSpnr);
			//修改人
            jhFjgr.setUpdateBy(u);
            //修改时间
            jhFjgr.setUpdateDate(new Date());
			jhFjGrService.save(jhFjgr);
		}
		jhfj.setGrShZt(grShZt);
		jhfj.setGrSpnr(grSpnr);
		jhfj.setGrApproveBy(u);
		jhfj.setGrApproveDate(new Date());
		//修改人
        jhfj.setUpdateBy(u);
        //修改时间
        jhfj.setUpdateDate(new Date());
        jhFjService.save(jhfj);
		
		return "modules/jhfj/jhFjFormBmShenHe";
	}
	
	@ResponseBody
	@RequestMapping(value = "morebmRwSh")
	public String morebmRwSh(String []ids,String [] jhIds,String[] officeIds,String grShZt,RedirectAttributes redirectAttributes) {
		for (int k = 0; k < ids.length; k++) {
			String jhfjId = ids[k].toString();
			JhFj jhfj = jhFjService.get(jhfjId);
			Zsjh zsjh = zsjhService.get(jhIds[k].toString());
			JhFjGr newJhFjGr = new JhFjGr();
			if(zsjh != null){
				newJhFjGr.setZsjh(zsjh);
			}
			newJhFjGr.setOfficeId(officeIds[k].toString());
			List<JhFjGr> jfFjGrList = jhFjGrService.findList(newJhFjGr);
			User u = UserUtils.getUser();
			for (int i = 0; i < jfFjGrList.size(); i++) {
				JhFjGr jhFjgr = jfFjGrList.get(i);
				if (grShZt.equals("2")) {// 审核不通过
					// 记录部门计划分解历史信息
					JhFjGrRecord jhFjGrRecord = new JhFjGrRecord();
					jhFjGrRecord.setJhFjGrId(jhFjgr.getId());
					jhFjGrRecord.setJhId(jhFjgr.getZsjh().getId());
					jhFjGrRecord.setJsId(jhFjgr.getJsId());
					jhFjGrRecord.setZsrs(jhFjgr.getZsrs());
					jhFjGrRecord.setPx(jhFjgr.getPx());
					jhFjGrRecord.setBcstatus(jhFjgr.getBcStatus());
					jhFjGrRecord.setSpnr(jhFjgr.getSpnr());
					jhFjGrRecord.setCreateBy(jhFjgr.getCreateBy());
					jhFjGrRecord.setCreateDate(jhFjgr.getCreateDate());
					jhFjGrRecord.setUpdateBy(jhFjgr.getUpdateBy());
					jhFjGrRecord.setUpdateDate(jhFjgr.getUpdateDate());
					jhFjGrRecord.setRemarks(jhFjgr.getRemarks());
					jhFjGrRecord.setDelFlag(jhFjgr.getDelFlag());
					jhFjGrRecordService.save(jhFjGrRecord);
					
					JhFjGrRecord newJhGrFjRecord = new JhFjGrRecord();
					newJhGrFjRecord.setJhFjGrId(jhFjgr.getId());
					newJhGrFjRecord.setZsjh(jhFjgr.getZsjh());
					newJhGrFjRecord.setJsId(jhFjgr.getJsId());
					JhFjGrRecord lastJhFjGrRecord = jhFjGrRecordService.getLastJhFjInfo(newJhGrFjRecord);
					
					String jhFjGrRecordId = lastJhFjGrRecord.getId();
					
					//记录部门计划分解任务历史信息
					JhFjGrRw jhFjGrRw = new JhFjGrRw();
					jhFjGrRw.setJhFjId(jhFjgr.getId());
					List<JhFjGrRw> list = jhFjGrRwService.findList(jhFjGrRw);
					for (int j = 0; j < list.size(); j++) {
						JhFjGrRw newjhFjGrRw = list.get(j);
						JhFjGrRwRecord jhFjGrRwRecord = new JhFjGrRwRecord();
						jhFjGrRwRecord.setJhFjGrRecordId(jhFjGrRecordId);
						jhFjGrRwRecord.setJhFjGrRwId(newjhFjGrRw.getId());
						jhFjGrRwRecord.setJhFjId(newjhFjGrRw.getJhFjId());
						jhFjGrRwRecord.setSf(newjhFjGrRw.getSf());
						jhFjGrRwRecord.setCs(newjhFjGrRw.getCs());
						jhFjGrRwRecord.setQx(newjhFjGrRw.getQx());
						jhFjGrRwRecord.setXz(newjhFjGrRw.getXz());
						jhFjGrRwRecord.setCreateBy(newjhFjGrRw.getCreateBy());
						jhFjGrRwRecord.setCreateDate(newjhFjGrRw.getCreateDate());
						jhFjGrRwRecord.setUpdateBy(newjhFjGrRw.getUpdateBy());
						jhFjGrRwRecord.setUpdateDate(newjhFjGrRw.getUpdateDate());
						jhFjGrRwRecord.setRemarks(newjhFjGrRw.getRemarks());
						jhFjGrRwRecord.setDelFlag(newjhFjGrRw.getDelFlag());
						jhFjGrRwRecordService.save(jhFjGrRwRecord);
					}
					jhfj.setFjFlag("0");
				} else if (grShZt.equals("1")) {// 审核通过
					
				}
				jhFjgr.setBcStatus(grShZt);
				//修改人
	            jhFjgr.setUpdateBy(u);
	            //修改时间
	            jhFjgr.setUpdateDate(new Date());
				jhFjGrService.save(jhFjgr);
			}
			
			jhfj.setGrShZt(grShZt);
			jhfj.setGrApproveBy(u);
			jhfj.setGrApproveDate(new Date());
			//修改人
	        jhfj.setUpdateBy(u);
	        //修改时间
	        jhfj.setUpdateDate(new Date());
	        jhFjService.save(jhfj);
		}
		
		if(grShZt.equals("2")){
        	return "2";//审核不通过成功
        }else if(grShZt.equals("1")){
        	return "1";//审核通过成功
        }
		return "0";
		//return "modules/jhfj/jhFjFormBmShenHe";
	}
	
	/**
	 * 查询地区
	 * @param parentId
	 * @return
	 */
	public List<Area> findAllByChr(String parentId) {
		Area area = new Area();
		area.setParent(new Area(parentId));
		return areaService.findAllByChr(area);
	}

	@RequiresPermissions("jhfj:jhFj:edit")
	@RequestMapping(value = "save")
	public String save(JhFj jhFj, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFj)){
			return form(jhFj, model);
		}
		jhFjService.save(jhFj);
		addMessage(redirectAttributes, "保存计划分解成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/?repage";
	}
	
	/**
	 * 单个审核
	 * @param jhFj
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("jhfj:jhFj:edit")
	@RequestMapping(value = "saveSh")
	public String saveSh(JhFj jhFj, Model model, RedirectAttributes redirectAttributes){
		if(jhFj.getBcStatus() == "1"){
			addMessage(redirectAttributes, "审核通过的不需要再次审核！");
			return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/shList?repage";
		}
		User user = UserUtils.getUser();
		String zt = jhFj.getBcStatus();
		if (zt.equals("2")) {// 审核不通过
			// 记录部门计划分解历史信息
			JhFjRecord jhFjRecord = new JhFjRecord();
			jhFjRecord.setJhFjId(jhFj.getId());
			jhFjRecord.setZsjh(jhFj.getZsjh());
			jhFjRecord.setOffice(jhFj.getOffice());
			jhFjRecord.setZsrs(jhFj.getZsrs());
			jhFjRecord.setPx(jhFj.getPx());
			jhFjRecord.setBcstatus(jhFj.getBcStatus());
			jhFjRecord.setSpnr(jhFj.getSpnr());
			jhFjRecord.setCreateBy(jhFj.getCreateBy());
			jhFjRecord.setCreateDate(jhFj.getCreateDate());
			jhFjRecord.setUpdateBy(jhFj.getUpdateBy());
			jhFjRecord.setUpdateDate(jhFj.getUpdateDate());
			jhFjRecord.setApproveBy(user);
			jhFjRecord.setApproveDate(new Date());
			jhFjRecord.setRemarks(jhFj.getRemarks());
			jhFjRecord.setDelFlag(jhFj.getDelFlag());
			jhFjRecordService.save(jhFjRecord);
			
			JhFjRecord newJhFjRecord = new JhFjRecord();
			newJhFjRecord.setJhFjId(jhFj.getId());
			newJhFjRecord.setZsjh(jhFj.getZsjh());
			newJhFjRecord.setOffice(jhFj.getOffice());
			JhFjRecord lastJhFjRecord = jhFjRecordService.getLastJhFj(newJhFjRecord);
			
			String jhFjRecordId = lastJhFjRecord.getId();
			//记录部门计划分解任务历史信息
			JhFjRw jhFjRw = new JhFjRw();
			jhFjRw.setJhFjId(jhFj.getId());
			List<JhFjRw> list = jhFjRwService.findList(jhFjRw);
			for (int i = 0; i < list.size(); i++) {
				JhFjRw newjhFjRw = list.get(i);
				JhFjRwRecord jhFjRwRecord = new JhFjRwRecord();
				jhFjRwRecord.setJhFjRecordId(jhFjRecordId);
				jhFjRwRecord.setJhFjRwId(newjhFjRw.getId());
				jhFjRwRecord.setJhFjId(newjhFjRw.getJhFjId());
				jhFjRwRecord.setSf(newjhFjRw.getSf());
				jhFjRwRecord.setCs(newjhFjRw.getCs());
				jhFjRwRecord.setQx(newjhFjRw.getQx());
				jhFjRwRecord.setXz(newjhFjRw.getXz());
				jhFjRwRecord.setCreateBy(newjhFjRw.getCreateBy());
				jhFjRwRecord.setCreateDate(newjhFjRw.getCreateDate());
				jhFjRwRecord.setUpdateBy(newjhFjRw.getUpdateBy());
				jhFjRwRecord.setUpdateDate(newjhFjRw.getUpdateDate());
				jhFjRwRecord.setRemarks(newjhFjRw.getRemarks());
				jhFjRwRecord.setDelFlag(newjhFjRw.getDelFlag());
				jhFjRwRecordService.save(jhFjRwRecord);
			}
		} else if (zt.equals("1")) {// 审核通过
			
		}
		jhFj.setApproveBy(user);
		jhFj.setApproveDate(new Date());
		jhFjService.save(jhFj);
		addMessage(redirectAttributes, "审核成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/shList?repage";
	}
	
	/**
	 * 批量审核
	 * @param jhFj
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "moreShenHe")
	public String piliangShenHe(@RequestParam("ids") String ids,
			@RequestParam("shStatu") String shStatu,
			RedirectAttributes redirectAttributes){
		User user = UserUtils.getUser();
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				JhFj jhFj = this.get(id);
				if(jhFj.getBcStatus() == null || !jhFj.getBcStatus().equals("1")){
					if (shStatu.equals("2")) {// 审核不通过
						// 记录部门计划分解历史信息
						JhFjRecord jhFjRecord = new JhFjRecord();
						jhFjRecord.setJhFjId(jhFj.getId());
						jhFjRecord.setZsjh(jhFj.getZsjh());
						jhFjRecord.setOffice(jhFj.getOffice());
						jhFjRecord.setZsrs(jhFj.getZsrs());
						jhFjRecord.setPx(jhFj.getPx());
						jhFjRecord.setBcstatus(jhFj.getBcStatus());
						jhFjRecord.setSpnr(jhFj.getSpnr());
						jhFjRecord.setCreateBy(jhFj.getCreateBy());
						jhFjRecord.setCreateDate(jhFj.getCreateDate());
						jhFjRecord.setUpdateBy(jhFj.getUpdateBy());
						jhFjRecord.setUpdateDate(jhFj.getUpdateDate());
						jhFjRecord.setApproveBy(user);
						jhFjRecord.setApproveDate(new Date());
						jhFjRecord.setRemarks(jhFj.getRemarks());
						jhFjRecord.setDelFlag(jhFj.getDelFlag());
						jhFjRecordService.save(jhFjRecord);
						
						JhFjRecord newJhFjRecord = new JhFjRecord();
						newJhFjRecord.setJhFjId(jhFj.getId());
						newJhFjRecord.setZsjh(jhFj.getZsjh());
						newJhFjRecord.setOffice(jhFj.getOffice());
						JhFjRecord lastJhFjRecord = jhFjRecordService.getLastJhFj(newJhFjRecord);
						
						String jhFjRecordId = lastJhFjRecord.getId();
						
						//记录部门计划分解任务历史信息
						JhFjRw jhFjRw = new JhFjRw();
						jhFjRw.setJhFjId(jhFj.getId());
						List<JhFjRw> list = jhFjRwService.findList(jhFjRw);
						for (int i = 0; i < list.size(); i++) {
							JhFjRw newjhFjRw = list.get(i);
							JhFjRwRecord jhFjRwRecord = new JhFjRwRecord();
							jhFjRwRecord.setJhFjRecordId(jhFjRecordId);
							jhFjRwRecord.setJhFjRwId(newjhFjRw.getId());
							jhFjRwRecord.setJhFjId(newjhFjRw.getJhFjId());
							jhFjRwRecord.setSf(newjhFjRw.getSf());
							jhFjRwRecord.setCs(newjhFjRw.getCs());
							jhFjRwRecord.setQx(newjhFjRw.getQx());
							jhFjRwRecord.setXz(newjhFjRw.getXz());
							jhFjRwRecord.setCreateBy(newjhFjRw.getCreateBy());
							jhFjRwRecord.setCreateDate(newjhFjRw.getCreateDate());
							jhFjRwRecord.setUpdateBy(newjhFjRw.getUpdateBy());
							jhFjRwRecord.setUpdateDate(newjhFjRw.getUpdateDate());
							jhFjRwRecord.setRemarks(newjhFjRw.getRemarks());
							jhFjRwRecord.setDelFlag(newjhFjRw.getDelFlag());
							jhFjRwRecordService.save(jhFjRwRecord);
						}
					} else if (shStatu.equals("1")) {// 审核通过
						
					}
					jhFj.setApproveBy(user);
					jhFj.setApproveDate(new Date());
					jhFj.setBcStatus(shStatu);
					jhFjService.save(jhFj);
				}
			}
		}
        if(shStatu.equals("2")){
        	return "2";//审核不通过成功
        }else if(shStatu.equals("1")){
        	return "1";//审核通过成功
        }
		return "0";
		
		
		//addMessage(redirectAttributes, "批量审核成功");
		//return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/shList?repage";
	}
	
	@RequiresPermissions("jhfj:jhFj:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFj jhFj, RedirectAttributes redirectAttributes) {
		jhFjService.delete(jhFj);
		addMessage(redirectAttributes, "删除计划分解成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/?repage";
	}
	
	@RequestMapping(value = "SaveSelectArea")
	public String SaveSelectArea(String jhfjId,String zsjhId,String []officeIds,String [] zsrses,String [] ids,int fjrs){
		int len = (ids.length-1)/5;
		System.out.println(len);
		Zsjh zsjh = zsjhService.get(zsjhId);

		//在修改的时候，先将之前保存的数据删除掉
		if(!jhfjId.equals("")){
			/*JhFj jhfj = jhFjService.get(jhfjId);
			if(jhfj != null){
				int zsrs = jhfj.getZsrs();
				//如果部门招生人数小于修改的人数，则继续减少计划剩余人数
				if(zsrs<fjrs){
					int cha = fjrs-zsrs;
					int syrs = zsjh.getSurplus()-cha;
					zsjh.setSurplus(syrs);
					zsjhService.save(zsjh);
				}
				//如果部门招生人数大于修改的人数，则增加计划剩余人数
				if(zsrs>fjrs){
					int cha = zsrs-fjrs;
					int syrs = zsjh.getSurplus()+cha;
					zsjh.setSurplus(syrs);
					zsjhService.save(zsjh);
				}
			}*/
			//删除计划分解表中的数据
			//jhFjService.deleteJhFj(jhfjId);
			//删除计划分解任务表中的数据
			jhFjRwService.deleteJhFjRw(jhfjId);
		}
		/*else
		{
			int syrs = zsjh.getSurplus()-fjrs;
			zsjh.setSurplus(syrs);
			zsjhService.save(zsjh);
		}*/
		
		System.out.println(officeIds.length);
		for (int i = 0; i < officeIds.length-1; i++) {
			JhFj jhFj = new JhFj();
			Office office = officeService.get(officeIds[i].toString());
			jhFj.setZsjh(zsjh);
			jhFj.setOffice(office);
			jhFj.setZsrs(Integer.parseInt(zsrses[i].toString()));
			
			jhFj.setFjFlag("0");
			jhFj.setBcStatus("0");
			if(jhFjService.getLastJhFj(jhFj) == null){
				//先得到计划剩余人数
				int syrs = zsjh.getSurplus();
				//分配的招生人数
				int rs = Integer.parseInt(zsrses[i].toString());
				//最终计划剩余人数 计划剩余人数+之前的招生人数-重新分配的招生人数
				int lastRs = syrs-rs;
				zsjh.setSurplus(lastRs);
				zsjhService.save(zsjh);
				jhFj.setPx(i);
				jhFjService.save(jhFj);
			}
			else
			{
				//如果再次分解部门计划的时候包含之前的部门，在重新计算剩余人数
				//先得到计划剩余人数
				int syrs = zsjh.getSurplus();
				//再得到之前部门的招生人数
				int bmzss = jhFjService.getLastJhFj(jhFj).getZsrs();
				//重新分配的招生人数
				int rs = Integer.parseInt(zsrses[i].toString());
				//最终计划剩余人数 计划剩余人数+之前的招生人数-重新分配的招生人数
				int lastRs = syrs+bmzss-rs;
				zsjh.setSurplus(lastRs);
				zsjhService.save(zsjh);
				jhFj.setId(jhFjService.getLastJhFj(jhFj).getId());
				//修改人
                User user = UserUtils.getUser();
                jhFj.setUpdateBy(user);
                //修改时间
                jhFj.setUpdateDate(new Date());
				jhFjService.update(jhFj);
			}
			
			JhFj newJhFj = new JhFj();
			newJhFj.setZsjh(zsjh);
			newJhFj.setOffice(office);
			JhFj lastJhFj = jhFjService.getLastJhFj(newJhFj);
			
			if(lastJhFj != null){
			String jhFjId = lastJhFj.getId();
				for (int j = 0; j < len; j++) {
					System.out.println(officeIds[i]);
					System.out.println(ids[j*5]);
					if(officeIds[i].equals(ids[j*5])){
						String shengId = ids[j*5+1].toString();
						String shiId = ids[j*5+2].toString();
						String quId = ids[j*5+3].toString();
						String zhenId = ids[j*5+4].toString();
						System.out.println("省："+shengId);
						System.out.println("市："+shiId);
						System.out.println("区/县："+quId);
						System.out.println("镇："+zhenId);
						
						JhFjRw jhFjRw = new JhFjRw();
						jhFjRw.setJhFjId(jhFjId);
						jhFjRw.setSf(shengId);
						jhFjRw.setCs(shiId);
						jhFjRw.setQx(quId);
						jhFjRw.setXz(zhenId);
						jhFjRwService.save(jhFjRw);
					}
				}
			}
		}
		return "modules/jhfj/jhFjList";
	}
	
	
	@RequiresPermissions("jhfj:jhFj:edit")
	@RequestMapping(value = "deleteJhfj")
	public String deleteJhfj(JhFj jhFj, RedirectAttributes redirectAttributes) {
		if(jhFj != null){
			Zsjh zsjh = zsjhService.get(jhFj.getZsjh().getId());
			int cha = jhFj.getZsrs();
			int syrs = zsjh.getSurplus()+cha;
			zsjh.setSurplus(syrs);
			zsjhService.save(zsjh);
			//删除计划分解表中的数据
			jhFjService.deleteJhFj(jhFj.getId());
			//删除计划分解任务表中的数据
			jhFjRwService.deleteJhFjRw(jhFj.getId());
		}
		addMessage(redirectAttributes, "删除计划分解成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/list?repage";
	}
	
	
	@RequiresPermissions("jhfj:jhFj:edit")
	@RequestMapping(value = "deletes")
	public String deletes(String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id:idArr)
		{
			JhFj jhFj = jhFjService.get(id);
			if(jhFj != null){
				Zsjh zsjh = zsjhService.get(jhFj.getZsjh().getId());
				int cha = jhFj.getZsrs();
				int syrs = zsjh.getSurplus()+cha;
				zsjh.setSurplus(syrs);
				zsjhService.save(zsjh);
				//删除计划分解表中的数据
				jhFjService.deleteJhFj(jhFj.getId());
				//删除计划分解任务表中的数据
				jhFjRwService.deleteJhFjRw(jhFj.getId());
			}
		}
		addMessage(redirectAttributes, "删除计划分解成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/list?repage";
	}
	
	public int getSubCount(String str,String key){
		int total = 0;
		for (String tmp = str; tmp != null&&tmp.length()>=key.length();){
		  if(tmp.indexOf(key) == 0){
		    total ++;
		  }
		  tmp = tmp.substring(1);
		}
		return total;
	}
	
	@RequiresPermissions("jhfj:jhFj:view")
	@RequestMapping(value = "formJhFjhistory")
	public String formJhFjhistory(String id, Model model) {
		JhFjRecord jhFjRecord = jhFjRecordService.get(id);
		JhFjRwRecord jhFjRecordRw = new JhFjRwRecord();
		jhFjRecordRw.setJhFjRecordId(jhFjRecord.getId());
		jhFjRecordRw.setJhFjId(jhFjRecord.getJhFjId());
		List<JhFjRwRecord> list = jhFjRwRecordService.getJhFjRwByJhFjId(jhFjRecordRw);
		model.addAttribute("jhFjRecord", jhFjRecord);
		if(jhFjRecord.getZsjh() != null){
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFjRecord.getZsjh().getId())) {
				entity = zsjhService.get(jhFjRecord.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//部门招生人数
			int zsrs = jhFjRecord.getZsrs();
			//剩余招生人数=计划剩余人数+部门招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);
		
			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmIdStr = "";
			String oldBmmcStr = "";
			
			oldBmIdStr = jhFjRecord.getOffice().getId()+",";
			oldBmmcStr = jhFjRecord.getOffice().getName()+",";
			
			model.addAttribute("oldBmIdStr", oldBmIdStr);
			model.addAttribute("oldBmmcStr", oldBmmcStr);
			for (int i = 0; i < list.size(); i++) {
				JhFjRwRecord rw = list.get(i);
				shengArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
				shiArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
				quArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
				zhenArray += rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				oldAreaStr += rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+","+rw.getXz()+",";
				model.addAttribute("oldAreaStr", oldAreaStr);
			}
					
			int pn=0;
			int sn=0;
			int qn=0;
			for (int i = 0; i < list.size(); i++) {
				JhFjRwRecord rw = list.get(i);
				innerTable += "<tr>";
				//省份
				if(rw.getSf() != "" || rw.getSf() != null){
					String sheng = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+",";
					int shengCount = getSubCount(shengArray,sheng);
					
						if(shengCount>1){
							pn = pn+1;
							if(strSheng == ""){
								innerTable += "<td rowspan = "+shengCount+">";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							
							if(!strSheng.equals(rw.getSf())){
								innerTable += "<td>";
								innerTable += rw.getSfName();
								innerTable += "</td>";
								strSheng = rw.getSf();
							}
							if(pn == shengCount){
								strSheng = "";
								pn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
						}
					
					
					//市
					String shi = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+",";
					int shiCount = getSubCount(shiArray,shi);
					
						if(shiCount>1){
							sn = sn+1;
							if(strShi == ""){
								innerTable += "<td rowspan = "+shiCount+">";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(!strShi.equals(rw.getCs())){
								innerTable += "<td>";
								innerTable += rw.getCsName();
								innerTable += "</td>";
								strShi = rw.getCs();
							}
							
							if(sn == shiCount){
								strShi = "";
								sn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
						}
					
					
					//区
					String qu = rw.getJhId()+","+rw.getBmId()+","+rw.getSf()+","+rw.getCs()+","+rw.getQx()+",";
					int quCount = getSubCount(quArray,qu);
					
						if(quCount>1){
							qn = qn+1;
							if(strQu == ""){
								innerTable += "<td rowspan = "+quCount+">";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							
							if(!strQu.equals(rw.getQx())){
								innerTable += "<td>";
								innerTable += rw.getQxName();
								innerTable += "</td>";
								strQu = rw.getQx();
							}
							if(qn == quCount){
								strQu = "";
								qn = 0;
							}
						}
						else{
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
						}
					
				}
				
				//镇
				if(!rw.getXz().equals("")&& rw.getXz() != null){
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}
				
				innerTable += "</tr>";
			}
			
			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
		}
		return "modules/jhfj/jhFjFormHistory";
	}

}
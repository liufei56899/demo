/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRecordService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwRecordService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;

/**
 * 部门任务分解记录Controller
 * @author lg
 * @version 2016-07-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfj/jhFjRecord")
public class JhFjRecordController extends BaseController {

	@Autowired
	private JhFjRecordService jhFjRecordService;
	@Autowired
	private JhFjRwRecordService jhFjRwRecordService;
	@Autowired
	private ZsjhService zsjhService;
	
	@ModelAttribute
	public JhFjRecord get(@RequestParam(required=false) String id) {
		JhFjRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjRecordService.get(id);
		}
		if (entity == null){
			entity = new JhFjRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfj:jhFjRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFjRecord jhFjRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFjRecord> page = jhFjRecordService.findPage(new Page<JhFjRecord>(request, response), jhFjRecord); 
		model.addAttribute("page", page);
		return "modules/jhfj/jhFjRecordList";
	}

	@RequiresPermissions("jhfj:jhFjRecord:view")
	@RequestMapping(value = "form")
	public String form(JhFjRecord jhFjRecord, Model model) {
		model.addAttribute("jhFjRecord", jhFjRecord);
		return "modules/jhfj/jhFjRecordForm";
	}

	@RequiresPermissions("jhfj:jhFjRecord:edit")
	@RequestMapping(value = "save")
	public String save(JhFjRecord jhFjRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjRecord)){
			return form(jhFjRecord, model);
		}
		jhFjRecordService.save(jhFjRecord);
		addMessage(redirectAttributes, "保存部门任务分解记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRecord/?repage";
	}
	
	@RequiresPermissions("jhfj:jhFjRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjRecord jhFjRecord, RedirectAttributes redirectAttributes) {
		jhFjRecordService.delete(jhFjRecord);
		addMessage(redirectAttributes, "删除部门任务分解记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRecord/?repage";
	}
	
	/*@RequiresPermissions("jhfj:jhFjRecord:view")
	@RequestMapping(value = "formJhFjhistory")
	public String formJhFjhistory(JhFjRecord jhFjRecord, Model model) {
		JhFjRwRecord jhFjRecordRw = new JhFjRwRecord();
		jhFjRecordRw.setJhFjId(jhFjRecord.getId());
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
	}*/
	
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
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "getJhFjRecordList")
	public String getJhFjRecordList(@RequestParam("jhfjId") String jhfjId) {
		JhFjRecord jhFjRecord = new JhFjRecord();
		jhFjRecord.setJhFjId(jhfjId);
		List<JhFjRecord> jhFjRecords = jhFjRecordService.findList(jhFjRecord);
		List<Map> pp = new ArrayList<Map>();
		for (int i = 0; i < jhFjRecords.size(); i++) {
			JhFjRecord newJhFjRecord = jhFjRecords.get(i);
			Map m1 = new HashMap();
			m1.put("id", newJhFjRecord.getId());
			m1.put("Record","历史记录"+(i+1));
			pp.add(m1);
		}
		return JsonMapper.toJsonString(pp);
	}

}
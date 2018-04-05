/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.practicemanagement.web;

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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.practicemanagement.entity.InformationTable;
import com.thinkgem.jeesite.modules.practicemanagement.service.InformationTableService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 艺术实践管理Controller
 * @author lf
 * @version 2018-03-19
 */
@Controller
@RequestMapping(value = "${adminPath}/practicemanagement/informationTable")
public class InformationTableController extends BaseController {

	@Autowired
	private InformationTableService informationTableService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	
	@ModelAttribute
	public InformationTable get(@RequestParam(required=false) String id) {
		InformationTable entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = informationTableService.get(id);
		}
		if (entity == null){
			entity = new InformationTable();
		}
		return entity;
	}
	
	@RequiresPermissions("practicemanagement:informationTable:view")
	@RequestMapping(value = {"list", ""})
	public String list(InformationTable informationTable, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<InformationTable> page = informationTableService.findPage(new Page<InformationTable>(request, response), informationTable); 
		model.addAttribute("page", page);
		return "modules/practicemanagement/informationTableList";
	}

	@RequiresPermissions("practicemanagement:informationTable:view")
	@RequestMapping(value = "form")
	public String form(InformationTable informationTable, Model model) {
		model.addAttribute("informationTable", informationTable);
		return "modules/practicemanagement/CopyinformationTableForm";
	}

	@RequiresPermissions("practicemanagement:informationTable:edit")
	@RequestMapping(value = "save")
	public String save(InformationTable informationTable, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, informationTable)){
			return form(informationTable, model);
		}
		informationTableService.save(informationTable);
		addMessage(redirectAttributes, "保存艺术实践管理成功");
		return "redirect:"+Global.getAdminPath()+"/practicemanagement/informationTable/?repage";
	}
	
	@ResponseBody
	@RequiresPermissions("practicemanagement:informationTable:edit")
	@RequestMapping(value = "saveq")
	public String saveq(InformationTable informationTable, Model model, RedirectAttributes redirectAttributes,String ids) {
		informationTable.setGroupstuid(ids);
		informationTableService.save(informationTable);
		addMessage(redirectAttributes, "保存信息成功");
		return JsonMapper.toJsonString("ok");
	}
	
	@RequiresPermissions("practicemanagement:informationTable:edit")
	@RequestMapping(value = "delete")
	public String delete(InformationTable informationTable, RedirectAttributes redirectAttributes) {
		informationTableService.delete(informationTable);
		addMessage(redirectAttributes, "删除艺术实践管理成功");
		return "redirect:"+Global.getAdminPath()+"/practicemanagement/informationTable/?repage";
	}
	/**
	 * 所有教师
	 * **/
	@ResponseBody
	@RequestMapping(value = "Alljs")
	public List<Map<String, Object>> Alljs(){
		List<Map<String, Object>> mapList = Lists.newArrayList();
		List<JsJbxx> list = systemService.findAllUser();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = Maps.newHashMap();
			JsJbxx js=list.get(i);
			map.put("id", js.getId());
			map.put("name", js.getXm());
			mapList.add(map);
		}
		return mapList;
	}
	@ResponseBody
	@RequestMapping(value = "ByStudent")
	public String ByAreas( HttpServletRequest request,String xnxq,
			HttpServletResponse response){
		XnxqJbxx xnxqJbxx = xnxqJbxxService.get(xnxq);
		XsJbxx xsJbxx=new XsJbxx();
		xsJbxx.setXnxq(xnxqJbxx.getXnmc());
		List<XsJbxx> studentList = xsJbxxService.getStudent(xsJbxx);
		return JsonMapper.toJsonString(studentList);
	}
}
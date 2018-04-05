/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.web;

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
import com.thinkgem.jeesite.modules.xs.entity.XsJbxxRecord;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxRecordService;

/**
 * 学生信息记录Controller
 * @author lg
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/xs/xsJbxxRecord")
public class XsJbxxRecordController extends BaseController {

	@Autowired
	private XsJbxxRecordService xsJbxxRecordService;
	
	@ModelAttribute
	public XsJbxxRecord get(@RequestParam(required=false) String id) {
		XsJbxxRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xsJbxxRecordService.get(id);
		}
		if (entity == null){
			entity = new XsJbxxRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("xs:xsJbxxRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(XsJbxxRecord xsJbxxRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XsJbxxRecord> page = xsJbxxRecordService.findPage(new Page<XsJbxxRecord>(request, response), xsJbxxRecord); 
		model.addAttribute("page", page);
		return "modules/xs/xsJbxxRecordList";
	}

	@RequiresPermissions("xs:xsJbxxRecord:view")
	@RequestMapping(value = "form")
	public String form(XsJbxxRecord xsJbxxRecord, Model model) {
		model.addAttribute("xsJbxxRecord", xsJbxxRecord);
		return "modules/xs/xsJbxxRecordForm";
	}

	@RequiresPermissions("xs:xsJbxxRecord:edit")
	@RequestMapping(value = "save")
	public String save(XsJbxxRecord xsJbxxRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xsJbxxRecord)){
			return form(xsJbxxRecord, model);
		}
		xsJbxxRecordService.save(xsJbxxRecord);
		addMessage(redirectAttributes, "保存学生信息记录成功");
		return "redirect:"+Global.getAdminPath()+"/xs/xsJbxxRecord/?repage";
	}
	
	@RequiresPermissions("xs:xsJbxxRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(XsJbxxRecord xsJbxxRecord, RedirectAttributes redirectAttributes) {
		xsJbxxRecordService.delete(xsJbxxRecord);
		addMessage(redirectAttributes, "删除学生信息记录成功");
		return "redirect:"+Global.getAdminPath()+"/xs/xsJbxxRecord/?repage";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "getXsJbxxRecordList")
	public String getXsJbxxRecordList(@RequestParam("xsId") String xsId) {
		XsJbxxRecord xsJbxxRecord = new XsJbxxRecord();
		xsJbxxRecord.setXsId(xsId);
		List<XsJbxxRecord> xsRecords = xsJbxxRecordService.findList(xsJbxxRecord);
		List<Map> pp = new ArrayList<Map>();
		for (int i = 0; i < xsRecords.size(); i++) {
			XsJbxxRecord newXsRecord = xsRecords.get(i);
			Map m1 = new HashMap();
			m1.put("id", newXsRecord.getId());
			m1.put("Record",newXsRecord.getXm()+"-历史记录"+(i+1));
			pp.add(m1);
		}
		return JsonMapper.toJsonString(pp);
	}

}
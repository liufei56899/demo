/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRwRecord;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwRecordService;

/**
 * 计划分解个人任务记录Controller
 * @author lg
 * @version 2016-07-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfjgr/jhFjGrRwRecord")
public class JhFjGrRwRecordController extends BaseController {

	@Autowired
	private JhFjGrRwRecordService jhFjGrRwRecordService;
	
	@ModelAttribute
	public JhFjGrRwRecord get(@RequestParam(required=false) String id) {
		JhFjGrRwRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjGrRwRecordService.get(id);
		}
		if (entity == null){
			entity = new JhFjGrRwRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfjgr:jhFjGrRwRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFjGrRwRecord jhFjGrRwRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFjGrRwRecord> page = jhFjGrRwRecordService.findPage(new Page<JhFjGrRwRecord>(request, response), jhFjGrRwRecord); 
		model.addAttribute("page", page);
		return "modules/jhfjgr/jhFjGrRwRecordList";
	}

	@RequiresPermissions("jhfjgr:jhFjGrRwRecord:view")
	@RequestMapping(value = "form")
	public String form(JhFjGrRwRecord jhFjGrRwRecord, Model model) {
		model.addAttribute("jhFjGrRwRecord", jhFjGrRwRecord);
		return "modules/jhfjgr/jhFjGrRwRecordForm";
	}

	@RequiresPermissions("jhfjgr:jhFjGrRwRecord:edit")
	@RequestMapping(value = "save")
	public String save(JhFjGrRwRecord jhFjGrRwRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjGrRwRecord)){
			return form(jhFjGrRwRecord, model);
		}
		jhFjGrRwRecordService.save(jhFjGrRwRecord);
		addMessage(redirectAttributes, "保存计划分解个人任务记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGrRwRecord/?repage";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGrRwRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjGrRwRecord jhFjGrRwRecord, RedirectAttributes redirectAttributes) {
		jhFjGrRwRecordService.delete(jhFjGrRwRecord);
		addMessage(redirectAttributes, "删除计划分解个人任务记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGrRwRecord/?repage";
	}

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.web;

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
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwRecordService;

/**
 * 计划分解任务历史记录Controller
 * @author lg
 * @version 2016-07-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfj/jhFjRwRecord")
public class JhFjRwRecordController extends BaseController {

	@Autowired
	private JhFjRwRecordService jhFjRwRecordService;
	
	@ModelAttribute
	public JhFjRwRecord get(@RequestParam(required=false) String id) {
		JhFjRwRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjRwRecordService.get(id);
		}
		if (entity == null){
			entity = new JhFjRwRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfj:jhFjRwRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFjRwRecord jhFjRwRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFjRwRecord> page = jhFjRwRecordService.findPage(new Page<JhFjRwRecord>(request, response), jhFjRwRecord); 
		model.addAttribute("page", page);
		return "modules/jhfj/jhFjRwRecordList";
	}

	@RequiresPermissions("jhfj:jhFjRwRecord:view")
	@RequestMapping(value = "form")
	public String form(JhFjRwRecord jhFjRwRecord, Model model) {
		model.addAttribute("jhFjRwRecord", jhFjRwRecord);
		return "modules/jhfj/jhFjRwRecordForm";
	}

	@RequiresPermissions("jhfj:jhFjRwRecord:edit")
	@RequestMapping(value = "save")
	public String save(JhFjRwRecord jhFjRwRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjRwRecord)){
			return form(jhFjRwRecord, model);
		}
		jhFjRwRecordService.save(jhFjRwRecord);
		addMessage(redirectAttributes, "保存计划分解任务历史记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRwRecord/?repage";
	}
	
	@RequiresPermissions("jhfj:jhFjRwRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjRwRecord jhFjRwRecord, RedirectAttributes redirectAttributes) {
		jhFjRwRecordService.delete(jhFjRwRecord);
		addMessage(redirectAttributes, "删除计划分解任务历史记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRwRecord/?repage";
	}

}
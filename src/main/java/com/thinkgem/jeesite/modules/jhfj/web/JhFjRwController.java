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
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwService;

/**
 * 计划分解任务Controller
 * @author lg
 * @version 2016-05-20
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfj/jhFjRw")
public class JhFjRwController extends BaseController {

	@Autowired
	private JhFjRwService jhFjRwService;
	
	@ModelAttribute
	public JhFjRw get(@RequestParam(required=false) String id) {
		JhFjRw entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjRwService.get(id);
		}
		if (entity == null){
			entity = new JhFjRw();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfj:jhFjRw:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFjRw jhFjRw, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFjRw> page = jhFjRwService.findPage(new Page<JhFjRw>(request, response), jhFjRw); 
		model.addAttribute("page", page);
		return "modules/jhfj/jhFjRwList";
	}

	@RequiresPermissions("jhfj:jhFjRw:view")
	@RequestMapping(value = "form")
	public String form(JhFjRw jhFjRw, Model model) {
		model.addAttribute("jhFjRw", jhFjRw);
		return "modules/jhfj/jhFjRwForm";
	}

	@RequiresPermissions("jhfj:jhFjRw:edit")
	@RequestMapping(value = "save")
	public String save(JhFjRw jhFjRw, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjRw)){
			return form(jhFjRw, model);
		}
		jhFjRwService.save(jhFjRw);
		addMessage(redirectAttributes, "保存计划分解任务成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRw/?repage";
	}
	
	@RequiresPermissions("jhfj:jhFjRw:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjRw jhFjRw, RedirectAttributes redirectAttributes) {
		jhFjRwService.delete(jhFjRw);
		addMessage(redirectAttributes, "删除计划分解任务成功");
		return "redirect:"+Global.getAdminPath()+"/jhfj/jhFjRw/?repage";
	}

}
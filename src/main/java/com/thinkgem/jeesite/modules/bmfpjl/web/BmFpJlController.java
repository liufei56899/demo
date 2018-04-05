/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmfpjl.web;

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
import com.thinkgem.jeesite.modules.bmfpjl.entity.BmFpJl;
import com.thinkgem.jeesite.modules.bmfpjl.service.BmFpJlService;

/**
 * 部门分配招生人数记录Controller
 * @author zw
 * @version 2016-04-26
 */
@Controller
@RequestMapping(value = "${adminPath}/bmfpjl/bmFpJl")
public class BmFpJlController extends BaseController {

	@Autowired
	private BmFpJlService bmFpJlService;
	
	@ModelAttribute
	public BmFpJl get(@RequestParam(required=false) String id) {
		BmFpJl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bmFpJlService.get(id);
		}
		if (entity == null){
			entity = new BmFpJl();
		}
		return entity;
	}
	
	@RequiresPermissions("bmfpjl:bmFpJl:view")
	@RequestMapping(value = {"list", ""})
	public String list(BmFpJl bmFpJl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BmFpJl> page = bmFpJlService.findPage(new Page<BmFpJl>(request, response), bmFpJl); 
		model.addAttribute("page", page);
		return "modules/bmfpjl/bmFpJlList";
	}

	@RequiresPermissions("bmfpjl:bmFpJl:view")
	@RequestMapping(value = "form")
	public String form(BmFpJl bmFpJl, Model model) {
		model.addAttribute("bmFpJl", bmFpJl);
		return "modules/bmfpjl/bmFpJlForm";
	}

	@RequiresPermissions("bmfpjl:bmFpJl:edit")
	@RequestMapping(value = "save")
	public String save(BmFpJl bmFpJl, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bmFpJl)){
			return form(bmFpJl, model);
		}
		bmFpJlService.save(bmFpJl);
		addMessage(redirectAttributes, "保存部门分配招生人数记录成功");
		return "redirect:"+Global.getAdminPath()+"/bmfpjl/bmFpJl/?repage";
	}
	
	@RequiresPermissions("bmfpjl:bmFpJl:edit")
	@RequestMapping(value = "delete")
	public String delete(BmFpJl bmFpJl, RedirectAttributes redirectAttributes) {
		bmFpJlService.delete(bmFpJl);
		addMessage(redirectAttributes, "删除部门分配招生人数记录成功");
		return "redirect:"+Global.getAdminPath()+"/bmfpjl/bmFpJl/?repage";
	}

}
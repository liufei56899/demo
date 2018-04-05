/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kscjwh.web;

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
import com.thinkgem.jeesite.modules.kscjwh.entity.Kscjwh;
import com.thinkgem.jeesite.modules.kscjwh.service.KscjwhService;

/**
 * 考试成绩维护Controller
 * @author lmy
 * @version 2018-03-21
 */
@Controller
@RequestMapping(value = "${adminPath}/kscjwh/kscjwh")
public class KscjwhController extends BaseController {

	@Autowired
	private KscjwhService kscjwhService;
	
	@ModelAttribute
	public Kscjwh get(@RequestParam(required=false) String id) {
		Kscjwh entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = kscjwhService.get(id);
		}
		if (entity == null){
			entity = new Kscjwh();
		}
		return entity;
	}
	
	@RequiresPermissions("kscjwh:kscjwh:view")
	@RequestMapping(value = {"list", ""})
	public String list(Kscjwh kscjwh, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Kscjwh> page = kscjwhService.findPage(new Page<Kscjwh>(request, response), kscjwh); 
		model.addAttribute("page", page);
		return "modules/kscjwh/kscjwhList";
	}

	@RequiresPermissions("kscjwh:kscjwh:view")
	@RequestMapping(value = "form")
	public String form(Kscjwh kscjwh, Model model) {
		model.addAttribute("kscjwh", kscjwh);
		return "modules/kscjwh/kscjwhForm";
	}

	@RequiresPermissions("kscjwh:kscjwh:edit")
	@RequestMapping(value = "save")
	public String save(Kscjwh kscjwh, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, kscjwh)){
			return form(kscjwh, model);
		}
		kscjwhService.save(kscjwh);
		addMessage(redirectAttributes, "保存考试成绩成功");
		return "redirect:"+Global.getAdminPath()+"/kscjwh/kscjwh/?repage";
	}
	
	@RequiresPermissions("kscjwh:kscjwh:edit")
	@RequestMapping(value = "delete")
	public String delete(Kscjwh kscjwh, RedirectAttributes redirectAttributes) {
		kscjwhService.delete(kscjwh);
		addMessage(redirectAttributes, "删除考试成绩成功");
		return "redirect:"+Global.getAdminPath()+"/kscjwh/kscjwh/?repage";
	}

}
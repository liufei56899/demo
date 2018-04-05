/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxgl.web;

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
import com.thinkgem.jeesite.modules.jxgl.entity.JxGl;
import com.thinkgem.jeesite.modules.jxgl.service.JxGlService;

/**
 * 教学管理Controller
 * @author zx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/jxgl/jxGl")
public class JxGlController extends BaseController {

	@Autowired
	private JxGlService jxGlService;
	
	@ModelAttribute
	public JxGl get(@RequestParam(required=false) String id) {
		JxGl entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxGlService.get(id);
		}
		if (entity == null){
			entity = new JxGl();
		}
		return entity;
	}
	
	@RequiresPermissions("jxgl:jxGl:view")
	@RequestMapping(value = {"list", ""})
	public String list(JxGl jxGl, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JxGl> page = jxGlService.findPage(new Page<JxGl>(request, response), jxGl); 
		model.addAttribute("page", page);
		return "modules/jxgl/jxGlList";
	}

	@RequiresPermissions("jxgl:jxGl:view")
	@RequestMapping(value = "form")
	public String form(JxGl jxGl, Model model) {
		model.addAttribute("jxGl", jxGl);
		return "modules/jxgl/jxGlForm";
	}

	@RequiresPermissions("jxgl:jxGl:edit")
	@RequestMapping(value = "save")
	public String save(JxGl jxGl, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jxGl)){
			return form(jxGl, model);
		}
		jxGlService.save(jxGl);
		addMessage(redirectAttributes, "保存教学管理成功");
		return "redirect:"+Global.getAdminPath()+"/jxgl/jxGl/?repage";
	}
	
	@RequiresPermissions("jxgl:jxGl:edit")
	@RequestMapping(value = "delete")
	public String delete(JxGl jxGl, RedirectAttributes redirectAttributes) {
		jxGlService.delete(jxGl);
		addMessage(redirectAttributes, "删除教学管理成功");
		return "redirect:"+Global.getAdminPath()+"/jxgl/jxGl/?repage";
	}

}
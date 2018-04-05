/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmqygx.web;

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
import com.thinkgem.jeesite.modules.bmqygx.entity.BmQyGx;
import com.thinkgem.jeesite.modules.bmqygx.service.BmQyGxService;

/**
 * 部门区域关系Controller
 * @author lg
 * @version 2016-04-25
 */
@Controller
@RequestMapping(value = "${adminPath}/bmqygx/bmQyGx")
public class BmQyGxController extends BaseController {

	@Autowired
	private BmQyGxService bmQyGxService;
	
	@ModelAttribute
	public BmQyGx get(@RequestParam(required=false) String id) {
		BmQyGx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bmQyGxService.get(id);
		}
		if (entity == null){
			entity = new BmQyGx();
		}
		return entity;
	}
	
	@RequiresPermissions("bmqygx:bmQyGx:view")
	@RequestMapping(value = {"list", ""})
	public String list(BmQyGx bmQyGx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BmQyGx> page = bmQyGxService.findPage(new Page<BmQyGx>(request, response), bmQyGx); 
		model.addAttribute("page", page);
		return "modules/bmqygx/bmQyGxList";
	}

	@RequiresPermissions("bmqygx:bmQyGx:view")
	@RequestMapping(value = "form")
	public String form(BmQyGx bmQyGx, Model model) {
		model.addAttribute("bmQyGx", bmQyGx);
		return "modules/bmqygx/bmQyGxForm";
	}

	@RequiresPermissions("bmqygx:bmQyGx:edit")
	@RequestMapping(value = "save")
	public String save(BmQyGx bmQyGx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bmQyGx)){
			return form(bmQyGx, model);
		}
		bmQyGxService.save(bmQyGx);
		addMessage(redirectAttributes, "保存部门区域关系成功");
		return "redirect:"+Global.getAdminPath()+"/bmqygx/bmQyGx/?repage";
	}
	
	@RequiresPermissions("bmqygx:bmQyGx:edit")
	@RequestMapping(value = "delete")
	public String delete(BmQyGx bmQyGx, RedirectAttributes redirectAttributes) {
		bmQyGxService.delete(bmQyGx);
		addMessage(redirectAttributes, "删除部门区域关系成功");
		return "redirect:"+Global.getAdminPath()+"/bmqygx/bmQyGx/?repage";
	}

}
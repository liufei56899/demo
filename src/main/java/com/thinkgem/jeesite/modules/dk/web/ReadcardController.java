/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.dk.web;

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
import com.thinkgem.jeesite.modules.dk.entity.Readcard;
import com.thinkgem.jeesite.modules.dk.service.ReadcardService;

/**
 * 身份证读卡信息Controller
 * @author lf
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/readcard/readcard")
public class ReadcardController extends BaseController {

	@Autowired
	private ReadcardService readcardService;
	
	@ModelAttribute
	public Readcard get(@RequestParam(required=false) String id) {
		Readcard entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = readcardService.get(id);
		}
		if (entity == null){
			entity = new Readcard();
		}
		return entity;
	}
	
	@RequiresPermissions("readcard:readcard:view")
	@RequestMapping(value = {"list", ""})
	public String list(Readcard readcard, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Readcard> page = readcardService.findPage(new Page<Readcard>(request, response), readcard); 
		model.addAttribute("page", page);
		return "modules/readcard/readcardList";
	}

	@RequiresPermissions("readcard:readcard:view")
	@RequestMapping(value = "form")
	public String form(Readcard readcard, Model model) {
		model.addAttribute("readcard", readcard);
		return "modules/readcard/readcardForm";
	}

	@RequiresPermissions("readcard:readcard:edit")
	@RequestMapping(value = "save")
	public String save(Readcard readcard, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, readcard)){
			return form(readcard, model);
		}
		readcardService.save(readcard);
		addMessage(redirectAttributes, "保存身份证读卡信息成功");
		return "redirect:"+Global.getAdminPath()+"/readcard/readcard/?repage";
	}
	
	@RequiresPermissions("readcard:readcard:edit")
	@RequestMapping(value = "delete")
	public String delete(Readcard readcard, RedirectAttributes redirectAttributes) {
		readcardService.delete(readcard);
		addMessage(redirectAttributes, "删除身份证读卡信息成功");
		return "redirect:"+Global.getAdminPath()+"/readcard/readcard/?repage";
	}

}
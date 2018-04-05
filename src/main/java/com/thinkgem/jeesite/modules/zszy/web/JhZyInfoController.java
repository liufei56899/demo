/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zszy.web;

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
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;
import com.thinkgem.jeesite.modules.zszy.service.JhZyInfoService;

/**
 * 招生计划专业人数记录Controller
 * @author zw
 * @version 2016-05-13
 */
@Controller
@RequestMapping(value = "${adminPath}/zszy/jhZyInfo")
public class JhZyInfoController extends BaseController {

	@Autowired
	private JhZyInfoService jhZyInfoService;
	
	@ModelAttribute
	public JhZyInfo get(@RequestParam(required=false) String id) {
		JhZyInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhZyInfoService.get(id);
		}
		if (entity == null){
			entity = new JhZyInfo();
		}
		return entity;
	}
	
	@RequiresPermissions("zszy:jhZyInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhZyInfo jhZyInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhZyInfo> page = jhZyInfoService.findPage(new Page<JhZyInfo>(request, response), jhZyInfo); 
		model.addAttribute("page", page);
		return "modules/zszy/jhZyInfoList";
	}

	@RequiresPermissions("zszy:jhZyInfo:view")
	@RequestMapping(value = "form")
	public String form(JhZyInfo jhZyInfo, Model model) {
		model.addAttribute("jhZyInfo", jhZyInfo);
		return "modules/zszy/jhZyInfoForm";
	}

	@RequiresPermissions("zszy:jhZyInfo:edit")
	@RequestMapping(value = "save")
	public String save(JhZyInfo jhZyInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhZyInfo)){
			return form(jhZyInfo, model);
		}
		jhZyInfoService.save(jhZyInfo);
		addMessage(redirectAttributes, "保存计划专业成功");
		return "redirect:"+Global.getAdminPath()+"/zszy/jhZyInfo/?repage";
	}
	
	@RequiresPermissions("zszy:jhZyInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(JhZyInfo jhZyInfo, RedirectAttributes redirectAttributes) {
		jhZyInfoService.delete(jhZyInfo);
		addMessage(redirectAttributes, "删除计划专业成功");
		return "redirect:"+Global.getAdminPath()+"/zszy/jhZyInfo/?repage";
	}

}
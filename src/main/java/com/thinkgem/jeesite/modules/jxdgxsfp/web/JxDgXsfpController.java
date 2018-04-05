/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdgxsfp.web;

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
import com.thinkgem.jeesite.modules.jxdgxsfp.entity.JxDgXsfp;
import com.thinkgem.jeesite.modules.jxdgxsfp.service.JxDgXsfpService;

/**
 * 学时分配Controller
 * @author zx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/jxdgxsfp/jxDgXsfp")
public class JxDgXsfpController extends BaseController {

	@Autowired
	private JxDgXsfpService jxDgXsfpService;
	
	@ModelAttribute
	public JxDgXsfp get(@RequestParam(required=false) String id) {
		JxDgXsfp entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxDgXsfpService.get(id);
		}
		if (entity == null){
			entity = new JxDgXsfp();
		}
		return entity;
	}
	
	@RequiresPermissions("jxdgxsfp:jxDgXsfp:view")
	@RequestMapping(value = {"list", ""})
	public String list(JxDgXsfp jxDgXsfp, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JxDgXsfp> page = jxDgXsfpService.findPage(new Page<JxDgXsfp>(request, response), jxDgXsfp); 
		model.addAttribute("page", page);
		return "modules/jxdgxsfp/jxDgXsfpList";
	}

	@RequiresPermissions("jxdgxsfp:jxDgXsfp:view")
	@RequestMapping(value = "form")
	public String form(JxDgXsfp jxDgXsfp, Model model) {
		model.addAttribute("jxDgXsfp", jxDgXsfp);
		return "modules/jxdgxsfp/jxDgXsfpForm";
	}

	@RequiresPermissions("jxdgxsfp:jxDgXsfp:edit")
	@RequestMapping(value = "save")
	public String save(JxDgXsfp jxDgXsfp, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jxDgXsfp)){
			return form(jxDgXsfp, model);
		}
		jxDgXsfpService.save(jxDgXsfp);
		addMessage(redirectAttributes, "保存学时分配成功");
		return "redirect:"+Global.getAdminPath()+"/jxdgxsfp/jxDgXsfp/?repage";
	}
	
	@RequiresPermissions("jxdgxsfp:jxDgXsfp:edit")
	@RequestMapping(value = "delete")
	public String delete(JxDgXsfp jxDgXsfp, RedirectAttributes redirectAttributes) {
		jxDgXsfpService.delete(jxDgXsfp);
		addMessage(redirectAttributes, "删除学时分配成功");
		return "redirect:"+Global.getAdminPath()+"/jxdgxsfp/jxDgXsfp/?repage";
	}

}
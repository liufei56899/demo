/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kcbh.web;

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
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.kcbh.service.KcJbxxService;

/**
 * 考场基本信息Controller
 * @author cpf
 * @version 2018-03-15
 */
@Controller
@RequestMapping(value = "${adminPath}/kcbh/kcJbxx")
public class KcJbxxController extends BaseController {

	@Autowired
	private KcJbxxService kcJbxxService;
	
	@ModelAttribute
	public KcJbxx get(@RequestParam(required=false) String id) {
		KcJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = kcJbxxService.get(id);
		}
		if (entity == null){
			entity = new KcJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("kcbh:kcJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(KcJbxx kcJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<KcJbxx> page = kcJbxxService.findPage(new Page<KcJbxx>(request, response), kcJbxx); 
		model.addAttribute("page", page);
		return "modules/kcbh/kcJbxxList";
	}

	@RequiresPermissions("kcbh:kcJbxx:view")
	@RequestMapping(value = "form")
	public String form(KcJbxx kcJbxx, Model model) {
		model.addAttribute("kcJbxx", kcJbxx);
		return "modules/kcbh/kcJbxxForm";
	}

	@RequiresPermissions("kcbh:kcJbxx:edit")
	@RequestMapping(value = "save")
	public String save(KcJbxx kcJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, kcJbxx)){
			return form(kcJbxx, model);
		}
		kcJbxxService.save(kcJbxx);
		addMessage(redirectAttributes, "保存考场基本信息成功");
		return "redirect:"+Global.getAdminPath()+"/kcbh/kcJbxx/?repage";
	}
	
	@RequiresPermissions("kcbh:kcJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(KcJbxx kcJbxx, String ids, RedirectAttributes redirectAttributes) {
			
		String[] idArr = ids.split(",");
		for(String id : idArr){
			kcJbxx = get(id);
			kcJbxxService.delete(kcJbxx);
		}
		addMessage(redirectAttributes, "删除考场基本信息成功");
		return "redirect:"+Global.getAdminPath()+"/kcbh/kcJbxx/?repage";
	}

}
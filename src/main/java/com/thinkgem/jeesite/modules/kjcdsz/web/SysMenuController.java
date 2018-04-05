/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kjcdsz.web;

import java.util.List;

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
import com.thinkgem.jeesite.modules.kjcdsz.entity.SysMenu;
import com.thinkgem.jeesite.modules.kjcdsz.service.SysMenuService;
import com.thinkgem.jeesite.modules.sys.entity.Role;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 快捷菜单设置Controller
 * @author st
 * @version 2016-07-26
 */
@Controller
@RequestMapping(value = "${adminPath}/kjcdsz/sysMenu")
public class SysMenuController extends BaseController {

	@Autowired
	private SysMenuService sysMenuService;
	
	@ModelAttribute
	public SysMenu get(@RequestParam(required=false) String id) {
		SysMenu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysMenuService.get(id);
		}
		if (entity == null){
			entity = new SysMenu();
		}
		return entity;
	}
	
	@RequestMapping(value = {"list", ""})
	public String list(SysMenu sysMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		sysMenu.setUserId(user.getId());
		Page<SysMenu> page = sysMenuService.findPage(new Page<SysMenu>(request, response), sysMenu); 
		model.addAttribute("page", page);
		return "modules/kjcdsz/sysMenuList";
	}

	@RequiresPermissions("kjcdsz:sysMenu:view")
	@RequestMapping(value = "form")
	public String form(SysMenu sysMenu, Model model) {
		model.addAttribute("sysMenu", sysMenu);
		return "modules/kjcdsz/sysMenuForm";
	}

	@RequiresPermissions("kjcdsz:sysMenu:edit")
	@RequestMapping(value = "save")
	public String save(SysMenu sysMenu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysMenu)){
			return form(sysMenu, model);
		}
		sysMenuService.save(sysMenu);
		addMessage(redirectAttributes, "保存快捷菜单设置成功");
		return "redirect:"+Global.getAdminPath()+"/kjcdsz/sysMenu/?repage";
	}
	
	@RequiresPermissions("kjcdsz:sysMenu:edit")
	@RequestMapping(value = "delete")
	public String delete(SysMenu sysMenu, RedirectAttributes redirectAttributes) {
		sysMenuService.delete(sysMenu);
		addMessage(redirectAttributes, "删除快捷菜单设置成功");
		return "redirect:"+Global.getAdminPath()+"/kjcdsz/sysMenu/?repage";
	}

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.um.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.um.entity.SysUserMenu;
import com.thinkgem.jeesite.modules.um.service.SysUserMenuService;

/**
 * 用户菜单关系Controller
 * @author lg
 * @version 2016-08-01
 */
@Controller
@RequestMapping(value = "${adminPath}/um/sysUserMenu")
public class SysUserMenuController extends BaseController {

	@Autowired
	private SysUserMenuService sysUserMenuService;
	
	@ModelAttribute
	public SysUserMenu get(@RequestParam(required=false) String id) {
		SysUserMenu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = sysUserMenuService.get(id);
		}
		if (entity == null){
			entity = new SysUserMenu();
		}
		return entity;
	}
	
	/*@RequiresPermissions("um:sysUserMenu:view")*/
	@RequestMapping(value = {"list", ""})
	public String list(SysUserMenu sysUserMenu, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<SysUserMenu> page = sysUserMenuService.findPage(new Page<SysUserMenu>(request, response), sysUserMenu); 
		model.addAttribute("page", page);
		return "modules/um/sysUserMenuList";
	}

	@RequiresPermissions("um:sysUserMenu:view")
	@RequestMapping(value = "form")
	public String form(SysUserMenu sysUserMenu, Model model) {
		model.addAttribute("sysUserMenu", sysUserMenu);
		return "modules/um/sysUserMenuForm";
	}

	@RequiresPermissions("um:sysUserMenu:edit")
	@RequestMapping(value = "save")
	public String save(SysUserMenu sysUserMenu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysUserMenu)){
			return form(sysUserMenu, model);
		}
		sysUserMenuService.save(sysUserMenu);
		addMessage(redirectAttributes, "保存用户菜单关系成功");
		return "redirect:"+Global.getAdminPath()+"/um/sysUserMenu/?repage";
	}
	
	/**
	 * Des:删除快捷菜单
	 * 2016-8-1
	 * @author fn
	 * @param ids
	 * @param redirectAttributes
	 * @return
	 * String
	 */
	@RequestMapping(value = "deleteMenu")
	public String deleteMenu(String ids, RedirectAttributes redirectAttributes)
	{
		List<String> menuIdList = new ArrayList<String>();
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			menuIdList.add(id);
		}
		if (menuIdList != null && menuIdList.size() > 0) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("idList", menuIdList);
			this.sysUserMenuService.deleteMenu(map);
		}
		addMessage(redirectAttributes, "删除菜单信息成功");
		return "redirect:" + Global.getAdminPath()
				+ "/kjcdsz/sysMenu/list?repage";
	}
	
	
	/*@RequiresPermissions("um:sysUserMenu:edit")*/
	/**
	 * Des:维护快捷菜单
	 * 2016-8-1
	 * @author fn
	 * @param menuIds
	 * @param redirectAttributes
	 * @return
	 * String
	 */
	@RequestMapping(value = "saveMenu")
	public String saveMenu(@RequestParam("menuIds") String menuIds,
			RedirectAttributes redirectAttributes) 
	{
		User user = UserUtils.getUser();
		String[] idArr = menuIds.split(",");
		if (idArr.length > 0) {
			for (String id : idArr) 
			{
				SysUserMenu entity = new SysUserMenu();
				entity.setMenuId(id);
				entity.setUser(user);
				this.sysUserMenuService.save(entity);
			}
		}
		
		addMessage(redirectAttributes, "快捷菜单设置成功");
		return "redirect:" + Global.getAdminPath()
				+ "/kjcdsz/sysMenu/list?repage";
		
	}
	
	@RequiresPermissions("um:sysUserMenu:edit")
	@RequestMapping(value = "delete")
	public String delete(SysUserMenu sysUserMenu, RedirectAttributes redirectAttributes) {
		sysUserMenuService.delete(sysUserMenu);
		addMessage(redirectAttributes, "删除用户菜单关系成功");
		return "redirect:"+Global.getAdminPath()+"/um/sysUserMenu/?repage";
	}

}
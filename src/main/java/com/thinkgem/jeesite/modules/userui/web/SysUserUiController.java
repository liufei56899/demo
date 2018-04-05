/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.userui.web;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.userui.entity.SysUserUi;
import com.thinkgem.jeesite.modules.userui.service.SysUserUiService;

/**
 * 终端用户Controller
 * 
 * @author XFB
 * @version 2016-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/userui/sysUserUi")
public class SysUserUiController extends BaseController {

	@Autowired
	private SysUserUiService sysUserUiService;

	@ModelAttribute
	public SysUserUi get(@RequestParam(required = false) String id) {
		SysUserUi entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = sysUserUiService.get(id);
		}
		if (entity == null) {
			entity = new SysUserUi();
		}
		return entity;
	}

	@RequiresPermissions("userui:sysUserUi:view")
	@RequestMapping(value = { "list2", "list2" })
	public String list2(SysUserUi sysUserUi, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<SysUserUi> page = sysUserUiService.findPage(new Page<SysUserUi>(
				request, response), sysUserUi);
		for (int i = 0; i < page.getList().size(); i++) {
			String sex = page.getList().get(i).getXbm();
			if (sex == "1" || sex.equals("1")) {
				page.getList().get(i).setXbm("男");
			} else {
				page.getList().get(i).setXbm("女");
			}
		}

		model.addAttribute("page", page);
		return "modules/userui/sysUserUiList";
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = { "listfrom2", "listfrom2" })
	public String listfrom2(@RequestParam("id") String id,
			HttpServletRequest request, HttpServletResponse response,
			Model model) {
		List<SysUserUi> lists = sysUserUiService.findListByOfficeId(id);
		List<Map> lists2 = new ArrayList<Map>();
		for (int i = 0; i < lists.size(); i++) {
			Map m = new HashMap();
			m.put("name", lists.get(i).getName());
			m.put("id", lists.get(i).getId());
			lists2.add(m);
		}
		System.out.println("========" + lists2);
		return JsonMapper.toJsonString(lists2);
	}

	@RequiresPermissions("userui:sysUserUi:view")
	@RequestMapping(value = { "list", "list" })
	public String list(SysUserUi sysUserUi, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		return "modules/userui/sysUserUiIndex";
	}

	@RequiresPermissions("userui:sysUserUi:view")
	@RequestMapping(value = "form")
	public String form(SysUserUi sysUserUi, Model model) {
		String departmentId = "";
		String username = "";
		if (sysUserUi.getOffice() == null) {
			departmentId = "";
			username = "";
		} else {
			departmentId = sysUserUi.getOffice().getName();
			username = sysUserUi.getUsername();
		}
		model.addAttribute("departmentId", departmentId);
		model.addAttribute("username", username);
		model.addAttribute("sysUserUi", sysUserUi);
		return "modules/userui/sysUserUiForm";
	}

	@RequiresPermissions("userui:sysUserUi:view")
	@RequestMapping(value = "formview")
	public String formview(SysUserUi sysUserUi, Model model) {
		if (sysUserUi.getOffice() == null
				|| sysUserUi.getOffice().getId() == null) {
			sysUserUi.setOffice(UserUtils.getUser().getOffice());
		}

		model.addAttribute("sysUserUi", sysUserUi);
		return "modules/userui/sysUserUiFormView";
	}

	@RequiresPermissions("userui:sysUserUi:edit")
	@RequestMapping(value = "save")
	public String save(SysUserUi sysUserUi, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, sysUserUi)) {
			return form(sysUserUi, model);
		}
		String strid = sysUserUi.getUsername();
		if (strid.contains("-")) {
			strid = strid.substring(strid.indexOf("-") + 1, strid.length());
			sysUserUi.setUsername(strid);
			sysUserUiService.save(sysUserUi);
		}
		addMessage(redirectAttributes, "保存终端用户成功");
		return "redirect:" + Global.getAdminPath()
				+ "/userui/sysUserUi/list2?repage";
	}

	@RequiresPermissions("userui:sysUserUi:edit")
	@RequestMapping(value = "delete")
	public String delete(SysUserUi sysUserUi, String ids,
			RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for (String id : idArr) {
			SysUserUi sysUserUi2 = get(id);
			sysUserUiService.delete(sysUserUi2);
		}
		addMessage(redirectAttributes, "删除终端用户成功");
		return "redirect:" + Global.getAdminPath()
				+ "/userui/sysUserUi/list2?repage";
	}
}
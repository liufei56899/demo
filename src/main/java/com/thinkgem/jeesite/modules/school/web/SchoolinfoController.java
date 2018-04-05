/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.school.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.restlet.security.User;
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
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;
import com.thinkgem.jeesite.modules.school.service.SchoolinfoService;
import com.thinkgem.jeesite.modules.sys.dao.UserDao;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;

/**
 * 学校信息Controller
 * @author lg
 * @version 2016-07-11
 */
@Controller
@RequestMapping(value = "${adminPath}/school/schoolinfo")
public class SchoolinfoController extends BaseController {

	@Autowired
	private SchoolinfoService schoolinfoService;
	@Autowired
	private UserDao userDao;
	@ModelAttribute
	public Schoolinfo get(@RequestParam(required=false) String id) {
		Schoolinfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = schoolinfoService.get(id);
		}
		if (entity == null){
			entity = new Schoolinfo();
		}
		return entity;
	}
	
	@RequiresPermissions("school:schoolinfo:view")
	@RequestMapping(value = {"list", "list"})
	public String list(Schoolinfo schoolinfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Schoolinfo> page = schoolinfoService.findPage(new Page<Schoolinfo>(request, response), schoolinfo); 
		model.addAttribute("page", page);
		return "modules/school/schoolinfoList";
	}

	@RequiresPermissions("school:schoolinfo:view")
	@RequestMapping(value = "form")
	public String form(Schoolinfo schoolinfo, Model model) {
		model.addAttribute("schoolinfo", schoolinfo);
		return "modules/school/schoolinfoForm";
	}

	@RequiresPermissions("school:schoolinfo:view")
	@RequestMapping(value = "form1")
	public String form1(Schoolinfo schoolinfo, Model model) {
		model.addAttribute("schoolinfo", schoolinfo);
		return "modules/school/schoolinfoFormnew";
	}
	
	
	@RequiresPermissions("school:schoolinfo:edit")
	@RequestMapping(value = "save")
	public String save(Schoolinfo schoolinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schoolinfo)){
			return form(schoolinfo, model);
		}
		schoolinfoService.save(schoolinfo);
com.thinkgem.jeesite.modules.sys.entity.User user = userDao.get(UserUtils.getUser().getId());
user.setCount(1);
userDao.update(user);
		addMessage(redirectAttributes, "保存学校信息成功");
//		return "redirect:"+Global.getAdminPath()+"/school/schoolinfo/list?repage";
		return "modules/sys/sysIndex";
	}
	@RequiresPermissions("school:schoolinfo:edit")
	@RequestMapping(value = "save1")
	public String save1(Schoolinfo schoolinfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, schoolinfo)){
			return form(schoolinfo, model);
		}
		schoolinfoService.save(schoolinfo);
		addMessage(redirectAttributes, "保存学校信息成功");
		return "redirect:"+Global.getAdminPath()+"/school/schoolinfo/list?repage";
//		return "modules/sys/sysIndex";
	}
	
	@RequiresPermissions("school:schoolinfo:edit")
	@RequestMapping(value = "delete")
	public String delete(Schoolinfo schoolinfo,String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id: idArr)
		{
			Schoolinfo info = get(id);
			schoolinfoService.delete(info);
		}
		addMessage(redirectAttributes, "删除学校信息成功");
		return "redirect:"+Global.getAdminPath()+"/school/schoolinfo/list?repage";
	}

}
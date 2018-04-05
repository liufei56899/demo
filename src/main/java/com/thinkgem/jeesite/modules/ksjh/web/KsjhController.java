/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ksjh.web;

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
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.ksjh.entity.Ksjh;
import com.thinkgem.jeesite.modules.ksjh.service.KsjhService;

/**
 * 考试计划Controller
 * @author cpf
 * @version 2018-03-16
 */
@Controller
@RequestMapping(value = "${adminPath}/ksjh/ksjh")
public class KsjhController extends BaseController {

	@Autowired
	private KsjhService ksjhService;
	
	@ModelAttribute
	public Ksjh get(@RequestParam(required=false) String id) {
		Ksjh entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = ksjhService.get(id);
		}
		if (entity == null){
			entity = new Ksjh();
		}
		return entity;
	}
	
	@RequiresPermissions("ksjh:ksjh:view")
	@RequestMapping(value = {"list", ""})
	public String list(Ksjh ksjh, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Ksjh> page = ksjhService.findPage(new Page<Ksjh>(request, response), ksjh); 
		model.addAttribute("page", page);
		// 查询班级信息
		List<BjJbxx> bjJbxx = ksjhService.findBjJbxx();
		model.addAttribute("bjJbxx", bjJbxx);
		return "modules/ksjh/ksjhList";
	}

	@RequiresPermissions("ksjh:ksjh:view")
	@RequestMapping(value = "form")
	public String form(Ksjh ksjh, Model model) {
		model.addAttribute("ksjh", ksjh);
		// 根据考试计划id查询考场信息
		String id = ksjh.getId();
		List<KcJbxx> kcJbxx = ksjhService.findClassroom(id);
		// 查询班级信息
		List<BjJbxx> bjJbxx = ksjhService.findBjJbxx();
		model.addAttribute("bjJbxx", bjJbxx);
	
		
		model.addAttribute("classroom", kcJbxx);
		model.addAttribute("nowDate", DateUtils.getDate());
		return "modules/ksjh/ksjhForm";
	}
	
	@RequiresPermissions("ksjh:ksjh:edit")
	@RequestMapping(value = "save")
	public String save(Ksjh ksjh, Model model, RedirectAttributes redirectAttributes) {
		String[] idArr = ksjh.getJclsId().split(",");
		ksjh.setJkrs(idArr.length+"");
		if (!beanValidator(model, ksjh)){
			return form(ksjh, model);
		}
		ksjhService.save(ksjh);
		addMessage(redirectAttributes, "保存考试计划成功");
		return "redirect:"+Global.getAdminPath()+"/ksjh/ksjh/?repage";
	}
	
	@RequiresPermissions("ksjh:ksjh:edit")
	@RequestMapping(value = "delete")
	public String delete(Ksjh ksjh, String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id : idArr){
			ksjh = get(id);
			ksjhService.delete(ksjh);
		}
		addMessage(redirectAttributes, "删除考试计划成功");
		return "redirect:"+Global.getAdminPath()+"/ksjh/ksjh/?repage";
	}
	
	@RequiresPermissions("ksjh:ksjh:view")
	@RequestMapping(value = "addKcxx")
	public String addKcxx(){
		
		
		
		return "modules/ksjh/addKcxx";
	}

}
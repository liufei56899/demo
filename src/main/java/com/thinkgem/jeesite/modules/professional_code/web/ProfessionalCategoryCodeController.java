/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.professional_code.web;

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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.professional_code.entity.ProfessionalCategoryCode;
import com.thinkgem.jeesite.modules.professional_code.service.ProfessionalCategoryCodeService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 专业类别代码表Controller
 * @author 邓和平
 * @version 2016-12-13
 */
@Controller
@RequestMapping(value = "${adminPath}/professional_code/professionalCategoryCode")
public class ProfessionalCategoryCodeController extends BaseController {

	@Autowired
	private ProfessionalCategoryCodeService professionalCategoryCodeService;
	@Autowired
	private ZyJbxxService zyJbxxService;
	@ModelAttribute
	public ProfessionalCategoryCode get(@RequestParam(required=false) String id) {
		ProfessionalCategoryCode entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = professionalCategoryCodeService.get(id);
		}
		if (entity == null){
			entity = new ProfessionalCategoryCode();
		}
		return entity;
	}
	
	@RequiresPermissions("professional_code:professionalCategoryCode:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProfessionalCategoryCode professionalCategoryCode, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProfessionalCategoryCode> page = professionalCategoryCodeService.findPage(new Page<ProfessionalCategoryCode>(request, response), professionalCategoryCode); 
		model.addAttribute("page", page);
		return "modules/professional_code/professionalCategoryCodeList";
	}

	@RequiresPermissions("professional_code:professionalCategoryCode:view")
	@RequestMapping(value = "form")
	public String form(ProfessionalCategoryCode professionalCategoryCode, Model model) {
		model.addAttribute("professionalCategoryCode", professionalCategoryCode);
		return "modules/professional_code/professionalCategoryCodeForm";
	}

	@RequiresPermissions("professional_code:professionalCategoryCode:edit")
	@RequestMapping(value = "save")
	public String save(ProfessionalCategoryCode professionalCategoryCode, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, professionalCategoryCode)){
			return form(professionalCategoryCode, model);
		}
		professionalCategoryCodeService.save(professionalCategoryCode);
		addMessage(redirectAttributes, "保存专业类别代码表成功");
		return "redirect:"+Global.getAdminPath()+"/professional_code/professionalCategoryCode/?repage";
	}
	
	@RequiresPermissions("professional_code:professionalCategoryCode:edit")
	@RequestMapping(value = "delete")
	public String delete(ProfessionalCategoryCode professionalCategoryCode, RedirectAttributes redirectAttributes) {
		professionalCategoryCodeService.delete(professionalCategoryCode);
		addMessage(redirectAttributes, "删除专业类别代码表成功");
		return "redirect:"+Global.getAdminPath()+"/professional_code/professionalCategoryCode/?repage";
	}
	

	/***************************** 获取专业类别信息 *************************************************************/
	@ResponseBody
	@RequestMapping(value = "getCategoryByVersion")
	public String getCategoryByVersion(ProfessionalCategoryCode professionalCategoryCode, RedirectAttributes redirectAttributes){
		System.out.println();
		List<ProfessionalCategoryCode> list=professionalCategoryCodeService.getCategoryByVersion(professionalCategoryCode);
		String jString=JsonMapper.toJsonString(list);
		return jString;
	}	
	/***************************** 获取专业信息 *************************************************************/
	@ResponseBody
	@RequestMapping(value = "getProfessionalCategoryId")
	public String getProfessionalCategoryId(ProfessionalCategoryCode professionalCategoryCode, RedirectAttributes redirectAttributes){
		System.out.println();
		List<ProfessionalCategoryCode> list=professionalCategoryCodeService.getProfessionalCategoryId(professionalCategoryCode);
		String jString=JsonMapper.toJsonString(list);
		return jString;
	}	
	/***************************** 获取专业技能方向信息 *************************************************************/
	@ResponseBody
	@RequestMapping(value = "getprofessionalEmphasisByProfessionalId")
	public String getprofessionalEmphasisByProfessionalId(ProfessionalCategoryCode professionalCategoryCode, RedirectAttributes redirectAttributes){
		System.out.println();
		ProfessionalCategoryCode list=professionalCategoryCodeService.getprofessionalEmphasisByProfessionalId(professionalCategoryCode);
		ZyJbxx zyjbxx = new ZyJbxx();
		ZylxJbxx zylx = new ZylxJbxx();
		zyjbxx.setId(zylx.getId());
		List<ZyJbxx> zymclist = zyJbxxService.findZyJbList(zyjbxx);
		Map map = new HashMap();	
		map.put("list", list);
		map.put("zymclist", zymclist);		
		return JsonMapper.toJsonString(map);
	}

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xnxq.web;

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
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;

/**
 * 学年学期Controller
 * @author st
 * @version 2016-09-22
 */
@Controller
@RequestMapping(value = "${adminPath}/xnxq/xnxqJbxx")
public class XnxqJbxxController extends BaseController {

	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	
	@Autowired
	private ZyJbxxService zyJbxxService;
	
	@ModelAttribute
	public XnxqJbxx get(@RequestParam(required=false) String id) {
		XnxqJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xnxqJbxxService.get(id);
		}
		if (entity == null){
			entity = new XnxqJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("xnxq:xnxqJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(XnxqJbxx xnxqJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XnxqJbxx> page = xnxqJbxxService.findPage(new Page<XnxqJbxx>(request, response), xnxqJbxx); 
		model.addAttribute("page", page);
		//专业
		List<ZyJbxx> zyList = zyJbxxService.findList(new ZyJbxx());
		model.addAttribute("zyList", zyList);
		return "modules/xnxq/xnxqJbxxList";
	}

	@RequiresPermissions("xnxq:xnxqJbxx:view")
	@RequestMapping(value = "form")
	public String form(XnxqJbxx xnxqJbxx, Model model) {
		model.addAttribute("xnxqJbxx", xnxqJbxx);
		return "modules/xnxq/xnxqJbxxForm";
	}

	@RequiresPermissions("xnxq:xnxqJbxx:edit")
	@RequestMapping(value = "save")
	public String save(XnxqJbxx xnxqJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xnxqJbxx)){
			return form(xnxqJbxx, model);
		}
		xnxqJbxxService.save(xnxqJbxx);
		addMessage(redirectAttributes, "保存学年学期成功");
		return "redirect:"+Global.getAdminPath()+"/xnxq/xnxqJbxx/?repage";
	}
	
	@RequiresPermissions("xnxq:xnxqJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(XnxqJbxx xnxqJbxx,String ids, RedirectAttributes redirectAttributes) {
		
		String[] idArr = ids.split(",");
		for(String id :idArr)
		{
			XnxqJbxx entity = xnxqJbxxService.get(id);
			xnxqJbxxService.delete(entity);
		}
		//xnxqJbxxService.delete(xnxqJbxx);
		addMessage(redirectAttributes, "删除学年学期成功");
		return "redirect:"+Global.getAdminPath()+"/xnxq/xnxqJbxx/?repage";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "validateXnmc")
	public String validateXnmc(XnxqJbxx xnxqJbxx)
	{
		Map map = new HashMap();
		List<XnxqJbxx> list= xnxqJbxxService.findXnxqList(xnxqJbxx);
		if(list!=null && list.size()>0)
		{
			map.put("isTrue", false);
		}
		else
		{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xjxx.web;

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
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xjxx.service.XnJbxxService;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;

/**
 * 年级信息Controller
 * @author st
 * @version 2016-09-27
 */
@Controller
@RequestMapping(value = "${adminPath}/xjxx/xnJbxx")
public class XnJbxxController extends BaseController {

	@Autowired
	private XnJbxxService xnJbxxService;
	
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	
	@ModelAttribute
	public XnJbxx get(@RequestParam(required=false) String id) {
		XnJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xnJbxxService.get(id);
		}
		if (entity == null){
			entity = new XnJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("xjxx:xnJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(XnJbxx xnJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<XnJbxx> page = xnJbxxService.findPage(new Page<XnJbxx>(request, response), xnJbxx); 
		model.addAttribute("page", page);
		//获取学年学期信息
		List<XnxqJbxx> xqList = xnxqJbxxService.findList(new XnxqJbxx());
		model.addAttribute("xqList", xqList);
		return "modules/xjxx/xnJbxxList";
	}

	@RequiresPermissions("xjxx:xnJbxx:view")
	@RequestMapping(value = "form")
	public String form(XnJbxx xnJbxx, Model model) {
		model.addAttribute("xnJbxx", xnJbxx);
		return "modules/xjxx/xnJbxxForm";
	}

	@RequiresPermissions("xjxx:xnJbxx:edit")
	@RequestMapping(value = "save")
	public String save(XnJbxx xnJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, xnJbxx)){
			return form(xnJbxx, model);
		}
		xnJbxxService.save(xnJbxx);
		addMessage(redirectAttributes, "保存年级信息成功");
		return "redirect:"+Global.getAdminPath()+"/xjxx/xnJbxx/?repage";
	}
	
	@RequiresPermissions("xjxx:xnJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(XnJbxx xnJbxx,String ids, RedirectAttributes redirectAttributes) {
		
		String[] idArr = ids.split(",");
		for(String id :idArr)
		{
			XnJbxx entity = xnJbxxService.get(id);
			xnJbxxService.delete(entity);
		}
			
		addMessage(redirectAttributes, "删除年级信息成功");
		return "redirect:"+Global.getAdminPath()+"/xjxx/xnJbxx/?repage";
	}
	
	/**
	 * Des:验证入学年份是否重复
	 * 2016-9-27
	 * @author fn
	 * @param xnJbxx
	 * @return
	 * String
	 */
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "validNf")
	public String validNf(XnJbxx xnJbxx)
	{
		Map map = new HashMap();
		List<XnJbxx> list= xnJbxxService.findXnList(xnJbxx);
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
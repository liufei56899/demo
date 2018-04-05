/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.js.web;

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
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.js.service.JsJbxxService;

/**
 * 教师信息Controller
 * @author st
 * @version 2016-05-19
 */
@Controller
@RequestMapping(value = "${adminPath}/js/jsJbxx")
public class JsJbxxController extends BaseController {

	@Autowired
	private JsJbxxService jsJbxxService;
	private String file;
	
	@ModelAttribute
	public JsJbxx get(@RequestParam(required=false) String id) {
		JsJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jsJbxxService.get(id);
		}
		if (entity == null){
			entity = new JsJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("js:jsJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(JsJbxx jsJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JsJbxx> page = jsJbxxService.findPage(new Page<JsJbxx>(request, response), jsJbxx); 
		model.addAttribute("page", page);
		return "modules/js/jsJbxxList";
	}

	@RequiresPermissions("js:jsJbxx:view")
	@RequestMapping(value = "form")
	public String form(JsJbxx jsJbxx, Model model) {
		model.addAttribute("jsJbxx", jsJbxx);
		return "modules/js/jsJbxxForm";
	}

	@RequiresPermissions("js:jsJbxx:edit")
	@RequestMapping(value = "save")
	public String save(JsJbxx jsJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jsJbxx)){
			return form(jsJbxx, model);
		}
		jsJbxxService.save(jsJbxx);
		addMessage(redirectAttributes, "保存教师信息成功");
		return "redirect:"+Global.getAdminPath()+"/js/jsJbxx/?repage";
	}
	
	@RequiresPermissions("js:jsJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(JsJbxx jsJbxx,String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		
		for(String id:idArr)
		{
			JsJbxx js= get(id);
			jsJbxxService.delete(js);
		}
		addMessage(redirectAttributes, "删除教师信息成功");
		return "redirect:"+Global.getAdminPath()+"/js/jsJbxx/?repage";
	}
	
	/**
	 * Des: 验证教师学工号是否重复
	 * 2016-5-20
	 * @author st
	 * @param jsJbxx
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "validateGhIsChongFu")
	public String validateGhIsChongFu(JsJbxx jsJbxx)
	{
		List<JsJbxx> jsList = jsJbxxService.findJsxxList(jsJbxx);
		Map map = new HashMap();
		if(jsList!=null && jsList.size()>0)
		{
			map.put("isTrue", false);
		}
		else
		{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}
	
	

}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bj.web;

import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

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
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.service.BjJbxxService;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;

/**
 * 班级信息Controller
 * @author zw
 * @version 2016-05-18
 */
@Controller
@RequestMapping(value = "${adminPath}/bj/bjJbxx")
public class BjJbxxController extends BaseController {
	@Autowired
	private BjJbxxService bjJbxxService;
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	
	@ModelAttribute
	public BjJbxx get(@RequestParam(required=false) String id) {
		BjJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bjJbxxService.get(id);
		}
		if (entity == null){
			entity = new BjJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("bj:bjJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(BjJbxx bjJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BjJbxx> page = bjJbxxService.findPage(new Page<BjJbxx>(request, response), bjJbxx); 
		model.addAttribute("page", page);
		//查询年级信息
		List<XnxqJbxx> xnList = xnxqJbxxService.getxnxx();		
		model.addAttribute("xnList", xnList);		
		return "modules/bj/bjJbxxList";
	}

	@RequiresPermissions("bj:bjJbxx:view")
	@RequestMapping(value = "form")
	public String form(BjJbxx bjJbxx, Model model) {
		model.addAttribute("bjJbxx", bjJbxx);
		//查询年级信息
		List<XnxqJbxx> xnList = xnxqJbxxService.getxnxx();
		model.addAttribute("xnList", xnList);
		return "modules/bj/bjJbxxForm";
	}

	@RequiresPermissions("bj:bjJbxx:edit")
	@RequestMapping(value = "save")
	public String save(BjJbxx bjJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bjJbxx)){
			return form(bjJbxx, model);
		}
		bjJbxxService.save(bjJbxx);
		addMessage(redirectAttributes, "保存班级成功");
		return "redirect:"+Global.getAdminPath()+"/bj/bjJbxx/?repage";
	}
	
	@RequiresPermissions("bj:bjJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(BjJbxx bjJbxx,String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id : idArr)
		{
			BjJbxx bj = get(id);
			bjJbxxService.delete(bj);
		}
		addMessage(redirectAttributes, "删除班级成功");
		return "redirect:"+Global.getAdminPath()+"/bj/bjJbxx/?repage";
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "validateBjmc")
	public String validateBjmc(BjJbxx bjJbxx)
	{
		Map map = new HashMap();
		List<BjJbxx> list = bjJbxxService.findBjJbxxList(bjJbxx);
		if(list!=null && list.size()>0){
			map.put("isTrue", false);
		}else{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}	
	
	@ResponseBody
	@RequestMapping(value = "getBjList")
	public String getBjList(String njid, RedirectAttributes redirectAttributes)
	{
		
		System.out.println("==============="+njid);
		BjJbxx bjJbxx=new BjJbxx();
		bjJbxx.getNjid().setId(njid);
		List<BjJbxx> list = bjJbxxService.findList(bjJbxx);
		String jString=JsonMapper.toJsonString(list);
		System.out.println("++++++++++++++++++++++++++++++"+jString);
		return jString;
	}

}
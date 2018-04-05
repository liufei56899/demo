/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdg.web;

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
import com.thinkgem.jeesite.modules.course.entity.Course;
import com.thinkgem.jeesite.modules.jxdg.entity.JxDg;
import com.thinkgem.jeesite.modules.jxdg.service.JxDgService;
import com.thinkgem.jeesite.modules.jxdgxsfp.entity.JxDgXsfp;
import com.thinkgem.jeesite.modules.jxgl.entity.JxGl;
import com.thinkgem.jeesite.modules.jxgl.service.JxGlService;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;

/**
 * 教学大纲Controller
 * @author zx
 * @version 2018-03-01
 */
@Controller
@RequestMapping(value = "${adminPath}/jxdg/jxDg")
public class JxDgController extends BaseController {

	@Autowired
	private JxDgService jxDgService;
	@Autowired
	private JxGlService jxglService;
	@ModelAttribute
	public JxDg get(@RequestParam(required=false) String id) {
		JxDg entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jxDgService.get(id);
		}
		if (entity == null){
			entity = new JxDg();
		}
		return entity;
	}
	
	@RequiresPermissions("jxdg:jxDg:view")
	@RequestMapping(value = {"list", ""})
	public String list(JxDg jxDg, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JxDg> page = jxDgService.findPage(new Page<JxDg>(request, response), jxDg); 
		model.addAttribute("page", page);
		return "modules/jxdg/jxDgList";
	}

	@RequiresPermissions("jxdg:jxDg:view")
	@RequestMapping(value = "form")
	public String form(JxDg jxDg, Model model) {
		int xh=1;
		if (jxDg==null) {
			jxDg=new JxDg();
		}
		JxDgXsfp  jx=new JxDgXsfp();
        jx.setJxdgId(jxDg.getId());
        List<JxDgXsfp> jxs=jxDgService.fingjxdgxsList(jx);
        jxDg.setJxdgXsfp(jxs);
		if (jxDg.getJxdgXsfp() != null && jxDg.getJxdgXsfp().size() > 0) {
			xh=jxDg.getJxdgXsfp().size()+1;
		}
		model.addAttribute("jxDg", jxDg);
		model.addAttribute("xh", xh);
		return "modules/jxdg/jxDgForm";
	}
	@RequiresPermissions("jxdg:jxDg:view")
	@RequestMapping(value = "form1")
	public String form1(JxDg jxDg, Model model) {
		int xh=1;
		if (jxDg==null) {
			jxDg=new JxDg();
		}
		JxDgXsfp  jx=new JxDgXsfp();
        jx.setJxdgId(jxDg.getId());
        List<JxDgXsfp> jxs=jxDgService.fingjxdgxsList(jx);
        jxDg.setJxdgXsfp(jxs);
		if (jxDg.getJxdgXsfp() != null && jxDg.getJxdgXsfp().size() > 0) {
			xh=jxDg.getJxdgXsfp().size()+1;
		}
		model.addAttribute("jxDg", jxDg);
		model.addAttribute("xh", xh);
		return "modules/jxdg/jxDgForm1";
	}

	@RequiresPermissions("jxdg:jxDg:edit")
	@RequestMapping(value = "save")
	public String save(JxDg jxDg, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jxDg)){
			return form(jxDg, model);
		}
		jxDgService.savejxdg(jxDg);
		addMessage(redirectAttributes, "保存教学大纲成功");
		return "redirect:"+Global.getAdminPath()+"/jxdg/jxDg/?repage";
	}
	
	@RequiresPermissions("jxdg:jxDg:edit")
	@RequestMapping(value = "delete")
	public String delete(JxDg jxDg, RedirectAttributes redirectAttributes) {
		jxDgService.delete(jxDg);
		addMessage(redirectAttributes, "删除教学大纲成功");
		return "redirect:"+Global.getAdminPath()+"/jxdg/jxDg/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "getCourse")
	public String getCourse(String id, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) {
		Course course=new Course();
		course = jxDgService.getcourseByid(id);
		List<Map> zymcs=jxDgService.findZyByCourseId(id);
		String zymc="";
		for (Map map : zymcs) {
			zymc+=","+map.get("zymc");
		}
	    if (!zymc.equals("")) {
	    zymc=zymc.substring(1, zymc.length());
		}
	   
		Map<String ,String> m1 = new HashMap<String ,String>();
		m1.put("teachername", course.getTeachername());
		m1.put("zymc", zymc);
		return JsonMapper.toJsonString(m1);
	}
	@ResponseBody
	@RequestMapping(value = "findjxdgByCourseXnxq")
	public String findjxdgByCourseXnxq(JxDg jxdg,String bjId, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) {
		JxDg jx=jxDgService.findjxdgByCourseXnxq(jxdg);
		JxGl jxgl=new JxGl();
		jxgl.setXnxqId(jxdg.getXnxq());
		jxgl.setKcId(jxdg.getKcId());
		jxgl.setBjId(bjId);
		int ywcconut=jxglService.findMaxKs(jxgl);
		if (jx==null) {
			jx=new JxDg();
		}
		Map<String ,String> m1 = new HashMap<String ,String>();
		m1.put("xuhao", jx.getXuhao());
		m1.put("zxsCount", jx.getZxsCount());
		m1.put("ywcconut", ywcconut+"");
		return JsonMapper.toJsonString(m1);
	}
}
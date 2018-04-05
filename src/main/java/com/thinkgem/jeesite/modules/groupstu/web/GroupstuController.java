/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.groupstu.web;

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

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.groupstu.entity.Groupstu;
import com.thinkgem.jeesite.modules.groupstu.service.GroupstuService;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.studentattendance.entity.Studentattendance;
import com.thinkgem.jeesite.modules.studentattendance.service.StudentattendanceService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;

/**
 * 学生小组信息Controller
 * @author lf
 * @version 2018-03-23
 */
@Controller
@RequestMapping(value = "${adminPath}/groupstu/groupstu")
public class GroupstuController extends BaseController {

	@Autowired
	private GroupstuService groupstuService;
	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private StudentattendanceService studentattendanceService;
	
	@ModelAttribute
	public Groupstu get(@RequestParam(required=false) String id) {
		Groupstu entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = groupstuService.get(id);
		}
		if (entity == null){
			entity = new Groupstu();
		}
		return entity;
	}
	
	@RequiresPermissions("groupstu:groupstu:view")
	@RequestMapping(value = {"list", ""})
	public String list(Groupstu groupstu, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Groupstu> page = groupstuService.findPage(new Page<Groupstu>(request, response), groupstu); 
		model.addAttribute("page", page);
		return "modules/groupstu/groupstuList";
	}

	@RequiresPermissions("groupstu:groupstu:view")
	@RequestMapping(value = "form")
	public String form(Groupstu groupstu, Model model) {
		List<Map<String, Object>> mapList = Lists.newArrayList();
		if(groupstu.getXnxq()!=null&&groupstu.getXnxq()!=""){
		XnxqJbxx xnxqJbxx = xnxqJbxxService.get(groupstu.getXnxq());
		XsJbxx xsJbxx=new XsJbxx();
		xsJbxx.setXnxq(xnxqJbxx.getXnmc());
		List<XsJbxx> studentList = xsJbxxService.getStudent(xsJbxx);
		for (int i = 0; i < studentList.size(); i++) {
			Map<String, Object> map = Maps.newHashMap();
			XsJbxx jbxx = studentList.get(i);
			map.put("id", jbxx.getId());
			map.put("name", jbxx.getXm());
			mapList.add(map);
		}
		}else{
			List<XnxqJbxx> list = xnxqJbxxService.getAll();
			/*List<Map<String, Object>> mapList = Lists.newArrayList();*/
			for (int i = 0; i < list.size(); i++) {
				XsJbxx xsJbxx=new XsJbxx();
				XnxqJbxx xnxqJbxx=list.get(i);
				xsJbxx.setXnxq(xnxqJbxx.getXnmc());
				List<XsJbxx> studentList = xsJbxxService.getStudent(xsJbxx);
				for (int a = 0; a < studentList.size(); a++) {
					Map<String, Object> map = Maps.newHashMap();
					XsJbxx jbxx = studentList.get(a);
					map.put("id", jbxx.getId());
					map.put("name", jbxx.getXm());
					mapList.add(map);
				}
			}
		}
		List<Map<String, Object>> mapList1 = Lists.newArrayList();
		List<JsJbxx> list = systemService.findAllUser();
		for (int i = 0; i < list.size(); i++) {
			Map<String, Object> map = Maps.newHashMap();
			JsJbxx js=list.get(i);
			map.put("id", js.getId());
			map.put("name", js.getXm());
			mapList1.add(map);
		}
		model.addAttribute("groupstu", groupstu);
		model.addAttribute("teacher",mapList1);
		model.addAttribute("studentList",mapList);
		return "modules/groupstu/groupstuFormEdit";
	}
	
	@RequiresPermissions("groupstu:groupstu:view")
	@RequestMapping(value = "form1")
	public String form1(Groupstu groupstu, Model model,String znum,String xnxq) {
		groupstu.setXnxq(xnxq);
		List<Groupstu> findList = groupstuService.findList(groupstu);
		List<Map<String, Object>> mapList = Lists.newArrayList();
		for (int i = 0; i < findList.size(); i++) {
				Map<String, Object> map = Maps.newHashMap();
				Groupstu stu = findList.get(i);
				map.put("id", stu.getId());
				map.put("groupname", stu.getGroupname());
				map.put("groupnum", stu.getGroupnum());
				map.put("groupstudent", stu.getGroupstudent());
				map.put("groupteacher", stu.getGroupteacher());
				mapList.add(map);
		}
		model.addAttribute("mapList", mapList);
		
		return "modules/groupstu/CopygroupstuForm";
	}
	@RequiresPermissions("groupstu:groupstu:edit")
	@RequestMapping(value = "save")
	public String save(Groupstu groupstu, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, groupstu)){
			return form(groupstu, model);
		}
		groupstuService.save(groupstu);
		addMessage(redirectAttributes, "保存学生小组信息成功");
		/*return "redirect:"+Global.getAdminPath()+"/groupstu/groupstu/?repage";*/
		return "redirect:"+Global.getAdminPath()+"/practicemanagement/informationTable/form";
	}
	
	@RequiresPermissions("groupstu:groupstu:edit")
	@RequestMapping(value = "delete")
	public String delete(Groupstu groupstu, RedirectAttributes redirectAttributes) {
		groupstuService.delete(groupstu);
		addMessage(redirectAttributes, "删除学生小组信息成功");
		return "redirect:"+Global.getAdminPath()+"/groupstu/groupstu/?repage";
	}
	@ResponseBody
	@RequestMapping(value = "save1")
	public String save1( Groupstu groupstu, Model model, RedirectAttributes redirectAttributes){
		groupstu.setTemp("1");
		groupstuService.save(groupstu);
		addMessage(redirectAttributes, "保存学生小组信息成功");
		return JsonMapper.toJsonString("ok");
	}
	@RequiresPermissions("groupstu:groupstu:edit")
	@RequestMapping(value = "save2")
	public String save2(Groupstu groupstu, Model model, RedirectAttributes redirectAttributes) {
		groupstu.setTemp("1");
		groupstuService.save(groupstu);
		addMessage(redirectAttributes, "保存学生小组信息成功");
		return "redirect:"+Global.getAdminPath()+"/groupstu/groupstu/?repage";
		
	}
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.studentattendance.web;

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
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.groupstu.entity.Groupstu;
import com.thinkgem.jeesite.modules.groupstu.service.GroupstuService;
import com.thinkgem.jeesite.modules.studentattendance.entity.Studentattendance;
import com.thinkgem.jeesite.modules.studentattendance.service.StudentattendanceService;

/**
 * 学生考勤信息Controller
 * @author lf
 * @version 2018-03-25
 */
@Controller
@RequestMapping(value = "${adminPath}/studentattendance/studentattendance")
public class StudentattendanceController extends BaseController {

	@Autowired
	private StudentattendanceService studentattendanceService;
	@Autowired
	private GroupstuService groupstuService;
	
	@ModelAttribute
	public Studentattendance get(@RequestParam(required=false) String id) {
		Studentattendance entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = studentattendanceService.get(id);
		}
		if (entity == null){
			entity = new Studentattendance();
		}
		return entity;
	}
	
	@RequiresPermissions("studentattendance:studentattendance:view")
	@RequestMapping(value = {"list", ""})
	public String list(Studentattendance studentattendance, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Studentattendance> page = studentattendanceService.findPage(new Page<Studentattendance>(request, response), studentattendance); 
		model.addAttribute("page", page);
		return "modules/studentattendance/studentattendanceList";
	}

	@RequiresPermissions("studentattendance:studentattendance:view")
	@RequestMapping(value = "form")
	public String form(Studentattendance studentattendance, Model model) {
		Groupstu groupstu=new Groupstu();
		groupstu.setTemp("1");
		List<Groupstu> findList = groupstuService.findList(groupstu);
		List<Map <String,String>> sList = new ArrayList<Map <String,String>>();
		for (int i = 0; i < findList.size(); i++) {
			Groupstu groupstu2 = findList.get(i);
			if(groupstu2.getGroupstudent().length()>1){
				String[] stus = groupstu2.getGroupstudent().split(",");
				for (int a = 0; a< stus.length; a++) {
					Map <String,String> map =new HashMap<String,String>();
					map.put("id", groupstu2.getId());
					map.put("name", stus[a]);
					map.put("groupname", groupstu2.getGroupname());
					sList.add(map);
				}
			}else{
				Map <String,String> map =new HashMap<String,String>();
				map.put("id", groupstu2.getId());
				map.put("name", groupstu2.getGroupstudent());
				map.put("groupname", groupstu2.getGroupname());
				sList.add(map);
			}
		}
		model.addAttribute("sList", sList);
		model.addAttribute("studentattendance", studentattendance);
		return "modules/studentattendance/studentattendanceForm";
	}

	@ResponseBody
	@RequestMapping(value = "save1")
	public String save1(Studentattendance studentattendance, Model model, RedirectAttributes redirectAttributes) {
		System.out.println(studentattendance.getId()+"=======ID=======");
		System.out.println(studentattendance.getGroupname()+"==小组名称============");
		System.out.println(studentattendance.getStudent()+"=======学生=======");
		System.out.println(studentattendance.getMusical()+"=======乐器=======");
		System.out.println(studentattendance.getMback()+"=====返还日期=========");
		System.out.println(studentattendance.getClothing()+"=======服装=======");
		System.out.println(studentattendance.getCback()+"========返还日期======");
		System.out.println(studentattendance.getWorktime1()+"======开始时间========");
		System.out.println(studentattendance.getWorktime2()+"=======结束时间=======");
		System.out.println(studentattendance.getScore()+"=========分数=====");
			studentattendanceService.save(studentattendance);
		addMessage(redirectAttributes, "保存学生考勤信息成功");
		return JsonMapper.toJsonString("ok");
	}
	@RequiresPermissions("studentattendance:studentattendance:edit")
	@RequestMapping(value = "save")
	public String save(Studentattendance studentattendance, Model model, RedirectAttributes redirectAttributes) {
			studentattendanceService.save(studentattendance);
		addMessage(redirectAttributes, "保存学生考勤信息成功");
		return "redirect:"+Global.getAdminPath()+"/studentattendance/studentattendance/?repage";
	}
	
	@RequiresPermissions("studentattendance:studentattendance:edit")
	@RequestMapping(value = "delete")
	public String delete(Studentattendance studentattendance, RedirectAttributes redirectAttributes) {
		studentattendanceService.delete(studentattendance);
		addMessage(redirectAttributes, "删除学生考勤信息成功");
		return "redirect:"+Global.getAdminPath()+"/studentattendance/studentattendance/?repage";
	}

}
package com.thinkgem.jeesite.modules.course.web;

import java.util.Date;
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

import com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.course.entity.Course;
import com.thinkgem.jeesite.modules.course.entity.CourseZy;
import com.thinkgem.jeesite.modules.course.service.CourseService;
import com.thinkgem.jeesite.modules.course.service.CourseZyService;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xjxx.service.XnJbxxService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
/**
 * 学校课程代码表Controller
 * @author 赵辉
 * @version 2018-02-05
 */
@Controller
@RequestMapping(value = "${adminPath}/course/course")
public class CourseController extends BaseController {

	@Autowired
	private CourseService courseService;
	@Autowired
	private CourseZyService coursezyService;
	@Autowired
	private ZyJbxxService zyJbxxService;

	@ModelAttribute
	public Course get(@RequestParam(required=false) String id) {
		Course entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = courseService.get(id);
		}
		if (entity == null){
			entity = new Course();
		}
		return entity;
	}
	
	@RequiresPermissions("course:course:view")
	@RequestMapping(value = {"list", ""})
	public String list(Course course, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Course> page = courseService.findPage(new Page<Course>(request, response), course); 
		model.addAttribute("page", page);
		return "modules/course/courseList";
	}

	@RequiresPermissions("course:course:view")
	@RequestMapping(value = "form")
	public String form(Course course, Model model) {
		User user=new User();
		/*ZyJbxx zyjbxx=new ZyJbxx();*/
		/*zyjbxx.setId(course.getZyid());
		course.setZyId(zyjbxx);*/
		user.setId(course.getTeacherid());
		user.setName(course.getTeachername());
		course.setJsId(user);
		model.addAttribute("course", course);
		//查询年级信息
		/*List<XnJbxx> xnList = xnJbxxService.findList(new XnJbxx());
		model.addAttribute("xnList", xnList);*/
		return "modules/course/courseForm";
	}
	@RequiresPermissions("course:course:view")
	@RequestMapping(value = "courseInfoForm")
	public String courseInfoForm(Course course, Model model) {
		
		model.addAttribute("course", course);
		return "modules/course/courseInfoForm";
	}	
	@RequiresPermissions("course:course:edit")
	@RequestMapping(value = "save")
	public String save(Course course, Model model, RedirectAttributes redirectAttributes) {
		course.setTeacherid(course.getJsId().getId());
		course.setTeachername(course.getJsId().getName());
		/*course.setZyid(course.getZyId().getId());*/
		course.setCreateperson(UserUtils.getUser().getId());
		course.setUpdateperson(UserUtils.getUser().getId());
		course.setUpdatedate(new Date());
		course.setCreatedate(new Date());
		if (!beanValidator(model, course)){
			return form(course, model);
		}
		try{
			courseService.save(course);
			addMessage(redirectAttributes, "保存学校课程信息成功！");
		}catch (Exception e) {
			addMessage(redirectAttributes, "保存学校课程信息失败！");
		}	
		return "redirect:"+Global.getAdminPath()+"/course/course/?repage";
	}
	
	@RequiresPermissions("course:course:edit")
	@RequestMapping(value = "delete")
	public String delete(Course course, RedirectAttributes redirectAttributes) {
		courseService.delete(course);
		addMessage(redirectAttributes, "删除学校课程代码表成功");
		return "redirect:"+Global.getAdminPath()+"/course/course/?repage";
	}
	@ResponseBody
	@RequestMapping(value = "checkCourseName")
	public String checkCourseName(String courseName) {
		int count =courseService.countCourseName(courseName);
		Map m = new HashMap();
		m.put("count",count );
		return JsonMapper.toJsonString(m);
	}
	@RequestMapping(value = "defendCoursce")
	public String defendCoursce(Course course,Model model){
		List<CourseZy> coursezy=coursezyService.findList(course.getId());
		if(coursezy.size()>0){
			model.addAttribute("coursezy", coursezy);
			course.setZylxid(coursezy.get(0).getZylxid());
			ZyJbxx zyJbxx = new ZyJbxx();
			ZylxJbxx zylxJbxx = new ZylxJbxx();
			zylxJbxx.setId(coursezy.get(0).getZylxid());
			zyJbxx.setZylx(zylxJbxx);
			List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
			model.addAttribute("zyJbxxs", zyJbxxs);
		}
		model.addAttribute("course", course);
		return "modules/course/defendCoursce";
	}
	@RequestMapping(value = "defendCourseSave")
	public String defendCourseSave(Course course,Model model,RedirectAttributes redirectAttributes){
		coursezyService.delete(course.getId());
		CourseZy coursezy=new CourseZy();
		coursezy.setCourseid(course.getId());
		coursezy.setZylxid(course.getZylxid());
		coursezy.setCreateperson(UserUtils.getUser().getId());
		coursezy.setUpdateperson(UserUtils.getUser().getId());
		coursezy.setCreatedate(new Date());
		coursezy.setUpdatedate(new Date());
		String[] zyidList=course.getZyid().split(",");
		for(int i=0;i<zyidList.length;i++){
			coursezy.setZyid(zyidList[i]);
			coursezyService.insert(coursezy);
		}	
		addMessage(redirectAttributes, "维护课程专业信息成功！");
		return "redirect:"+Global.getAdminPath()+"/course/course/?repage";
	}
}
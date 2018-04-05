/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.classroom.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.service.BjJbxxService;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;
import com.thinkgem.jeesite.modules.classroom.service.ClassroomService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 教室信息管理Controller
 * @author zh
 * @version 2018-02-07
 */
@Controller
@RequestMapping(value = "${adminPath}/classroom/classroom")
public class ClassroomController extends BaseController {

	@Autowired
	private ClassroomService classroomService;
	@Autowired
	private BjJbxxService bjJbxxService;
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	@ModelAttribute
	public Classroom get(@RequestParam(required=false) String id) {
		Classroom entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = classroomService.get(id);
		}
		if (entity == null){
			entity = new Classroom();
		}
		return entity;
	}
	
	@RequiresPermissions("classroom:classroom:view")
	@RequestMapping(value = {"list", ""})
	public String list(Classroom classroom, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<Classroom> page = classroomService.findPage(new Page<Classroom>(request, response), classroom); 
		model.addAttribute("page", page);
		return "modules/classroom/classroomList";
	}

	@RequiresPermissions("classroom:classroom:view")
	@RequestMapping(value = "form")
	public String form(Classroom classroom, Model model) {		
		model.addAttribute("classroom", classroom);
		return "modules/classroom/classroomForm";
	}

	@RequiresPermissions("classroom:classroom:edit")
	@RequestMapping(value = "save")
	public String save(Classroom classroom, Model model, RedirectAttributes redirectAttributes){
		classroom.setCreateperson(UserUtils.getUser().getId());
		classroom.setUpdateperson(UserUtils.getUser().getId());
		classroom.setUpdatedate(new Date());
		classroom.setCreatedate(new Date());
		if (!beanValidator(model, classroom)){
			return form(classroom, model);
		}
		classroomService.save(classroom);	
		addMessage(redirectAttributes, "保存教室信息成功");
		return "redirect:"+Global.getAdminPath()+"/classroom/classroom/?repage";
	}
	
	@RequiresPermissions("classroom:classroom:edit")
	@RequestMapping(value = "delete")
	public String delete(Classroom classroom, RedirectAttributes redirectAttributes) {
		classroomService.delete(classroom);
		addMessage(redirectAttributes, "删除教室信息成功");
		return "redirect:"+Global.getAdminPath()+"/classroom/classroom/?repage";
	}
	@ResponseBody
	@RequestMapping(value = "count", method = RequestMethod.POST)
	public String count(HttpServletRequest request,
			HttpServletResponse response, Model model,String id,String flag){
			String msg="";
			if(id!=null && !("").equals(id)){
				int counts = classroomService.count(id);
				if(("set").equals(flag)){
					if(counts>0){
						msg="已经设置为固定教室，不能重复设置！";
					}else{
						msg="true";
					}
				}
				if(("update").equals(flag)){
					if(counts==0){
						msg="未设置为固定教室，无法更改！";
					}else{
						msg="true";
					}
				}
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("msg", msg);
		return JsonMapper.toJsonString(map);
	}
	@RequiresPermissions("classroom:classroom:view")
	@RequestMapping(value = "setroom")
	public String setroom(Classroom classroom, Model model,String flag) {				
		//查询年级信息
		List<XnxqJbxx> xnList = xnxqJbxxService.getxnxx();			
		model.addAttribute("xnList", xnList);
		BjJbxx bjjbxx=classroomService.getBjJbxx(classroom.getId());
		if(bjjbxx!=null){
		List<Map<String, Object>> BjJbxx=classroomService.findBjJbxx(bjjbxx.getNjid().getId());
		model.addAttribute("BjJbxx", BjJbxx);
		}
		model.addAttribute("bjjbxx", bjjbxx);		
		model.addAttribute("flag", flag);
		model.addAttribute("classroom", classroom);
		return "modules/classroom/classroomSet";
	}
	@ResponseBody
	@RequestMapping(value = "findClassBynjId")
	public String findClassBynjId(String njid, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();		
		List<Map<String, Object>> BjJbxx=classroomService.findBjJbxx(njid);
		sb.append("<select id='classid' name='classid'  style='width: 270px;' class='input-xlarge'>");
		if(BjJbxx != null && BjJbxx.size() > 0){
			sb.append("<option value=''>请选择</option>");
			for(int i=0;i<BjJbxx.size();i++){
				BjJbxx.get(i).get("id");
				sb.append("<option value='"+BjJbxx.get(i).get("id") +"'>"+BjJbxx.get(i).get("bjmc")+"</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	
	
	
	@RequiresPermissions("classroom:classroom:edit")
	@RequestMapping(value = "saveset")
	public String save( RedirectAttributes redirectAttributes,String id,String classid,String classroomid){
		if(classroomid !=null || classroomid!=""){
			classroomService.emptyClassroomId(classroomid);
		}
		BjJbxx bjJbxx =bjJbxxService.get(classid);
		if(bjJbxx!=null){
			bjJbxx.setClassroomid(id);
			bjJbxxService.save(bjJbxx);		
		}
		addMessage(redirectAttributes, "保存设置固定教室信息成功!");
		return "redirect:"+Global.getAdminPath()+"/classroom/classroom/?repage";
	}
}
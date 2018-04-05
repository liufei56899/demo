/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.web;

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
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRecord;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRecordService;

/**
 * 计划分解个人记录Controller
 * @author lg
 * @version 2016-07-23
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfjgr/jhFjGrRecord")
public class JhFjGrRecordController extends BaseController {

	@Autowired
	private JhFjGrRecordService jhFjGrRecordService;
	
	@ModelAttribute
	public JhFjGrRecord get(@RequestParam(required=false) String id) {
		JhFjGrRecord entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = jhFjGrRecordService.get(id);
		}
		if (entity == null){
			entity = new JhFjGrRecord();
		}
		return entity;
	}
	
	@RequiresPermissions("jhfjgr:jhFjGrRecord:view")
	@RequestMapping(value = {"list", ""})
	public String list(JhFjGrRecord jhFjGrRecord, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<JhFjGrRecord> page = jhFjGrRecordService.findPage(new Page<JhFjGrRecord>(request, response), jhFjGrRecord); 
		model.addAttribute("page", page);
		return "modules/jhfjgr/jhFjGrRecordList";
	}

	@RequiresPermissions("jhfjgr:jhFjGrRecord:view")
	@RequestMapping(value = "form")
	public String form(JhFjGrRecord jhFjGrRecord, Model model) {
		model.addAttribute("jhFjGrRecord", jhFjGrRecord);
		return "modules/jhfjgr/jhFjGrRecordForm";
	}

	@RequiresPermissions("jhfjgr:jhFjGrRecord:edit")
	@RequestMapping(value = "save")
	public String save(JhFjGrRecord jhFjGrRecord, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjGrRecord)){
			return form(jhFjGrRecord, model);
		}
		jhFjGrRecordService.save(jhFjGrRecord);
		addMessage(redirectAttributes, "保存计划分解个人记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGrRecord/?repage";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGrRecord:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjGrRecord jhFjGrRecord, RedirectAttributes redirectAttributes) {
		jhFjGrRecordService.delete(jhFjGrRecord);
		addMessage(redirectAttributes, "删除计划分解个人记录成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGrRecord/?repage";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "getJhFjGrRecordList")
	public String getJhFjGrRecordList(@RequestParam("jhfjId") String jhfjId) {
		JhFjGrRecord jhFjGrRecord = new JhFjGrRecord();
		jhFjGrRecord.setJhFjGrId(jhfjId);
		List<JhFjGrRecord> jhFjRecords = jhFjGrRecordService.findList(jhFjGrRecord);
		List<Map> pp = new ArrayList<Map>();
		for (int i = 0; i < jhFjRecords.size(); i++) {
			JhFjGrRecord newJhFjRecord = jhFjRecords.get(i);
			Map m1 = new HashMap();
			m1.put("id", newJhFjRecord.getId());
			m1.put("Record","历史记录"+(i+1));
			pp.add(m1);
		}
		return JsonMapper.toJsonString(pp);
	}

}
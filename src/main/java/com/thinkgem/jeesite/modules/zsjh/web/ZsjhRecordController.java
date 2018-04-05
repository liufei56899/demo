/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhRecordService;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;

/**
 * 计划招生Controller
 * 
 * @author XFB
 * @version 2016-07-20
 */
@Controller
@RequestMapping(value = "${adminPath}/zsjh/zsjhrecord")
public class ZsjhRecordController extends BaseController {

	@Autowired
	private ZsjhRecordService zsjhRecordService;
	
	@Autowired
	private ZsjhService zsjhService;

	public ZsjhRecord get(@RequestParam(required = false) String id) {
		ZsjhRecord zsjhRecord = null;
		if (StringUtils.isNotBlank(id)) {
			zsjhRecord = zsjhRecordService.get(id);
		}
		if (zsjhRecord == null) {
			zsjhRecord = new ZsjhRecord();
		}
		return zsjhRecord;
	}

	@RequestMapping(value = "save")
	public String save(ZsjhRecord zsjhRecord) {
		zsjhRecordService.save(zsjhRecord);
		return "success";
	}

	@RequestMapping(value = "formshhistory")
	public String viewZsjhRecord(String id, Model model) {
		ZsjhRecord zsjhRecord = zsjhRecordService.get(id);
		if(zsjhRecord.getBcStatus().equals("1")){
			zsjhRecord.setBcStatus("通过");
		}else if(zsjhRecord.getBcStatus().equals("2")){
			zsjhRecord.setBcStatus("不通过");
		}
		model.addAttribute("zsjhRecord", zsjhRecord);
		Zsjh zsjh= zsjhService.get(zsjhRecord.getCid());
		model.addAttribute("zsjh1", zsjh);
		return "modules/zsjh/zsjhFormShenHeHistory";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "zsjhrecordlist")
	public String getZsjhRecordList(@RequestParam("rid") String id) {
		List<ZsjhRecord> zsjhRecords = new ArrayList<ZsjhRecord>();
		zsjhRecords = zsjhRecordService.getZsjhRecordLists(id);
		List<Map> pp = new ArrayList<Map>();
		for (int i = 0; i < zsjhRecords.size(); i++) {
			Map m1 = new HashMap();
			m1.put("id", zsjhRecords.get(i).getId());
			m1.put("cid", zsjhRecords.get(i).getJhmc());
			pp.add(m1);
		}
		return JsonMapper.toJsonString(pp);
	}
}
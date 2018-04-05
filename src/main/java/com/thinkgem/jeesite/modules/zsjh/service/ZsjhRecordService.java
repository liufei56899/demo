/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zsjh.dao.ZsjhRecordDao;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;

/**
 * 计划招生Service
 * 
 * @author XFB
 * @version 2016-07-20
 */
@Service
@Transactional(readOnly = true)
public class ZsjhRecordService extends CrudService<ZsjhRecordDao, ZsjhRecord> {

	public List<ZsjhRecord> getZsjhRecordLists(String id) {
		List<ZsjhRecord> zsjhRecordlist = dao.getZsjhRecordList(id);
		return zsjhRecordlist;
	}

}
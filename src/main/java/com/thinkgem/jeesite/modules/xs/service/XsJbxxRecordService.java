/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxxRecord;
import com.thinkgem.jeesite.modules.xs.dao.XsJbxxRecordDao;

/**
 * 学生信息记录Service
 * @author lg
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class XsJbxxRecordService extends CrudService<XsJbxxRecordDao, XsJbxxRecord> {

	public XsJbxxRecord get(String id) {
		return super.get(id);
	}
	
	public List<XsJbxxRecord> findList(XsJbxxRecord xsJbxxRecord) {
		return super.findList(xsJbxxRecord);
	}
	
	public Page<XsJbxxRecord> findPage(Page<XsJbxxRecord> page, XsJbxxRecord xsJbxxRecord) {
		return super.findPage(page, xsJbxxRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(XsJbxxRecord xsJbxxRecord) {
		super.save(xsJbxxRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(XsJbxxRecord xsJbxxRecord) {
		super.delete(xsJbxxRecord);
	}
	
}
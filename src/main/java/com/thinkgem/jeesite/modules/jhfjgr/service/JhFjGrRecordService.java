/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRecord;
import com.thinkgem.jeesite.modules.jhfjgr.dao.JhFjGrRecordDao;

/**
 * 计划分解个人记录Service
 * @author lg
 * @version 2016-07-23
 */
@Service
@Transactional(readOnly = true)
public class JhFjGrRecordService extends CrudService<JhFjGrRecordDao, JhFjGrRecord> {

	public JhFjGrRecord get(String id) {
		return super.get(id);
	}
	
	public List<JhFjGrRecord> findList(JhFjGrRecord jhFjGrRecord) {
		return super.findList(jhFjGrRecord);
	}
	
	public Page<JhFjGrRecord> findPage(Page<JhFjGrRecord> page, JhFjGrRecord jhFjGrRecord) {
		return super.findPage(page, jhFjGrRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjGrRecord jhFjGrRecord) {
		super.save(jhFjGrRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjGrRecord jhFjGrRecord) {
		super.delete(jhFjGrRecord);
	}
	
	public JhFjGrRecord getLastJhFjInfo(JhFjGrRecord jhFjGrRecord) {
		return dao.getLastJhFjInfo(jhFjGrRecord);
	}
	
}
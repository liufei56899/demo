/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRwRecord;
import com.thinkgem.jeesite.modules.jhfjgr.dao.JhFjGrRwRecordDao;

/**
 * 计划分解个人任务记录Service
 * @author lg
 * @version 2016-07-23
 */
@Service
@Transactional(readOnly = true)
public class JhFjGrRwRecordService extends CrudService<JhFjGrRwRecordDao, JhFjGrRwRecord> {

	public JhFjGrRwRecord get(String id) {
		return super.get(id);
	}
	
	public List<JhFjGrRwRecord> findList(JhFjGrRwRecord jhFjGrRwRecord) {
		return super.findList(jhFjGrRwRecord);
	}
	
	public Page<JhFjGrRwRecord> findPage(Page<JhFjGrRwRecord> page, JhFjGrRwRecord jhFjGrRwRecord) {
		return super.findPage(page, jhFjGrRwRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjGrRwRecord jhFjGrRwRecord) {
		super.save(jhFjGrRwRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjGrRwRecord jhFjGrRwRecord) {
		super.delete(jhFjGrRwRecord);
	}
	
	public List<JhFjGrRwRecord> getJhFjGrRwByJhFjId(JhFjGrRwRecord jhFjRwRecord) {
		return dao.getJhFjGrRwByJhFjId(jhFjRwRecord);
	}
	
}
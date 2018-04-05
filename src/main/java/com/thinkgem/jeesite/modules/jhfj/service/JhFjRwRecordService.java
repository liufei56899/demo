/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;
import com.thinkgem.jeesite.modules.jhfj.dao.JhFjRwRecordDao;

/**
 * 计划分解任务历史记录Service
 * @author lg
 * @version 2016-07-23
 */
@Service
@Transactional(readOnly = true)
public class JhFjRwRecordService extends CrudService<JhFjRwRecordDao, JhFjRwRecord> {

	public JhFjRwRecord get(String id) {
		return super.get(id);
	}
	
	public List<JhFjRwRecord> findList(JhFjRwRecord jhFjRwRecord) {
		return super.findList(jhFjRwRecord);
	}
	
	public Page<JhFjRwRecord> findPage(Page<JhFjRwRecord> page, JhFjRwRecord jhFjRwRecord) {
		return super.findPage(page, jhFjRwRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjRwRecord jhFjRwRecord) {
		super.save(jhFjRwRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjRwRecord jhFjRwRecord) {
		super.delete(jhFjRwRecord);
	}
	
	public List<JhFjRwRecord> getJhFjRwByJhFjId(JhFjRwRecord jhFjRwRecord) {
		return dao.getJhFjRwByJhFjId(jhFjRwRecord);
	}
	
}
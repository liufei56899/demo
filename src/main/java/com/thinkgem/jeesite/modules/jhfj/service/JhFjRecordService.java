/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;
import com.thinkgem.jeesite.modules.jhfj.dao.JhFjRecordDao;

/**
 * 部门任务分解记录Service
 * @author lg
 * @version 2016-07-23
 */
@Service
@Transactional(readOnly = true)
public class JhFjRecordService extends CrudService<JhFjRecordDao, JhFjRecord> {

	public JhFjRecord get(String id) {
		return super.get(id);
	}
	
	public List<JhFjRecord> findList(JhFjRecord jhFjRecord) {
		return super.findList(jhFjRecord);
	}
	
	public Page<JhFjRecord> findPage(Page<JhFjRecord> page, JhFjRecord jhFjRecord) {
		return super.findPage(page, jhFjRecord);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjRecord jhFjRecord) {
		super.save(jhFjRecord);
	}
	
	public JhFjRecord getLastJhFj(JhFjRecord jhFjRecord) {
		return dao.getLastJhFj(jhFjRecord);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjRecord jhFjRecord) {
		super.delete(jhFjRecord);
	}
	
}
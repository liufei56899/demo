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
import com.thinkgem.jeesite.modules.jhfj.dao.JhFjDao;

/**
 * 计划分解Service
 * @author lg
 * @version 2016-05-20
 */
@Service
@Transactional(readOnly = true)
public class JhFjService extends CrudService<JhFjDao, JhFj> {

	public JhFj get(String id) {
		return super.get(id);
	}
	
	public List<JhFj> findList(JhFj jhFj) {
		return super.findList(jhFj);
	}
	
	public Page<JhFj> findPage(Page<JhFj> page, JhFj jhFj) {
		return super.findPage(page, jhFj);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFj jhFj) {
		super.save(jhFj);
	}
	
	@Transactional(readOnly = false)
	public void update(JhFj jhFj) {
		dao.update(jhFj);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFj jhFj) {
		super.delete(jhFj);
	}
	
	public JhFj getLastJhFj(JhFj jhFj) {
		return dao.getLastJhFj(jhFj);
	}
	
	@Transactional(readOnly = false)
	public void deleteJhFj(String id) {
		dao.deleteJhFj(id);
	}
	
}
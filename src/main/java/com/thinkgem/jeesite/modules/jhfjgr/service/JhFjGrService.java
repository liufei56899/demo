/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.dao.JhFjGrDao;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 计划分解个人Service
 * @author lg
 * @version 2016-05-26
 */
@Service
@Transactional(readOnly = true)
public class JhFjGrService extends CrudService<JhFjGrDao, JhFjGr> {

	public JhFjGr get(String id) {
		return super.get(id);
	}
	
	
	public List<JhFjGr> findList(JhFjGr jhFjGr) {
		return super.findList(jhFjGr);
	}
	
	public Page<JhFjGr> findPage(Page<JhFjGr> page, JhFjGr jhFjGr) {
		return super.findPage(page, jhFjGr);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjGr jhFjGr) {
		super.save(jhFjGr);
	}
	
	@Transactional(readOnly = false)
	public void update(JhFjGr jhFjGr) {
		dao.update(jhFjGr);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjGr jhFjGr) {
		super.delete(jhFjGr);
	}
	
	public JhFjGr getLastJhFjInfo(JhFjGr jhFjGr) {
		return dao.getLastJhFjInfo(jhFjGr);
	}
	
	@Transactional(readOnly = false)
	public void deleteJhFjGr(String id) {
		dao.deleteJhFjGr(id);
	}
	
}
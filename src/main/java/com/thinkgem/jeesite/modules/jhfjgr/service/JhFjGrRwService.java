/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.jhfjgr.dao.JhFjGrRwDao;

/**
 * 计划分解个人任务明细Service
 * @author lg
 * @version 2016-05-26
 */
@Service
@Transactional(readOnly = true)
public class JhFjGrRwService extends CrudService<JhFjGrRwDao, JhFjGrRw> {

	public JhFjGrRw get(String id) {
		return super.get(id);
	}
	
	public List<JhFjGrRw> findList(JhFjGrRw jhFjGrRw) {
		return super.findList(jhFjGrRw);
	}
	
	public Page<JhFjGrRw> findPage(Page<JhFjGrRw> page, JhFjGrRw jhFjGrRw) {
		return super.findPage(page, jhFjGrRw);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjGrRw jhFjGrRw) {
		super.save(jhFjGrRw);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjGrRw jhFjGrRw) {
		super.delete(jhFjGrRw);
	}
	
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjGrRw> getJhFjGrRwByJhFjId(JhFjGrRw jhFjRw) {
		return dao.getJhFjGrRwByJhFjId(jhFjRw);
	}
	
	@Transactional(readOnly = false)
	public void deleteJhFjGrRw(String jhFjId) {
		dao.deleteJhFjGrRw(jhFjId);
	}
	
}
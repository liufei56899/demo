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
import com.thinkgem.jeesite.modules.jhfj.dao.JhFjRwDao;

/**
 * 计划分解任务Service
 * @author lg
 * @version 2016-05-20
 */
@Service
@Transactional(readOnly = true)
public class JhFjRwService extends CrudService<JhFjRwDao, JhFjRw> {

	public JhFjRw get(String id) {
		return super.get(id);
	}
	
	public List<JhFjRw> findList(JhFjRw jhFjRw) {
		return super.findList(jhFjRw);
	}
	
	public Page<JhFjRw> findPage(Page<JhFjRw> page, JhFjRw jhFjRw) {
		return super.findPage(page, jhFjRw);
	}
	
	@Transactional(readOnly = false)
	public void save(JhFjRw jhFjRw) {
		super.save(jhFjRw);
	}
	
	@Transactional(readOnly = false)
	public void delete(JhFjRw jhFjRw) {
		super.delete(jhFjRw);
	}
	
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjRw> getJhFjRwByJhFjId(JhFjRw jhFjRw) {
		return dao.getJhFjRwByJhFjId(jhFjRw);
	}
	
	@Transactional(readOnly = false)
	public void deleteJhFjRw(String jhFjId) {
		dao.deleteJhFjRw(jhFjId);
	}
	
}
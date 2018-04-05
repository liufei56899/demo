/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bj.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.dao.BjJbxxDao;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;

/**
 * 班级信息Service
 * @author zw
 * @version 2016-05-18
 */
@Service
@Transactional(readOnly = false)
public class BjJbxxService extends CrudService<BjJbxxDao, BjJbxx> {

	public BjJbxx get(String id) {
		return super.get(id);
	}
	
	public List<BjJbxx> findList(BjJbxx bjJbxx) {
		return super.findList(bjJbxx);
	}
	public List<BjJbxx> findBjJbxxList(BjJbxx bjJbxx)
	{
		return dao.findBjJbxxList(bjJbxx);
	}
	
	public Page<BjJbxx> findPage(Page<BjJbxx> page, BjJbxx bjJbxx) {
		return super.findPage(page, bjJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(BjJbxx bjJbxx){
		super.save(bjJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(BjJbxx bjJbxx) {
		super.delete(bjJbxx);
	}
	public List<XnJbxx> findAll()
	{
		return dao.findAll();
	}
	public List<BjJbxx> findAllBJ(XnJbxx xnJbxx)
	{
		return dao.findAllBJ(xnJbxx);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsfb.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.xsfb.dao.XsfbDao;

/**
 * 新生分班Service
 * @author st
 * @version 2016-07-13
 */
@Service
@Transactional(readOnly = true)
public class XsfbService extends CrudService<XsfbDao, BjJbxx> {

	public BjJbxx get(String id) {
		return super.get(id);
	}
	
	public List<BjJbxx> findList(BjJbxx bjJbxx) {
		return super.findList(bjJbxx);
	}
	
	public Page<BjJbxx> findPage(Page<BjJbxx> page, BjJbxx bjJbxx) {
		return super.findPage(page, bjJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(BjJbxx bjJbxx) {
		super.save(bjJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(BjJbxx bjJbxx) {
		super.delete(bjJbxx);
	}
	
}
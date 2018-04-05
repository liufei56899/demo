/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.syxx.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.syxx.entity.SyJbxx;
import com.thinkgem.jeesite.modules.syxx.dao.SyJbxxDao;

/**
 * 生源信息Service
 * @author xfb
 * @version 2016-05-05
 */
@Service
@Transactional(readOnly = true)
public class SyJbxxService extends CrudService<SyJbxxDao, SyJbxx> {

	public SyJbxx get(String id) {
		return super.get(id);
	}
	
	public List<SyJbxx> findList(SyJbxx syJbxx) {
		return super.findList(syJbxx);
	}
	
	public Page<SyJbxx> findPage(Page<SyJbxx> page, SyJbxx syJbxx) {
		return super.findPage(page, syJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(SyJbxx syJbxx) {
		super.save(syJbxx);
	}
	
	@Transactional(readOnly = false)
	public void bmrwfp(SyJbxx syJbxx) {
		dao.bmrwfp(syJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(SyJbxx syJbxx) {
		super.delete(syJbxx);
	}
	
}
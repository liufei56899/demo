/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmqygx.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bmqygx.entity.BmQyGx;
import com.thinkgem.jeesite.modules.bmqygx.dao.BmQyGxDao;

/**
 * 部门区域关系Service
 * @author lg
 * @version 2016-04-25
 */
@Service
@Transactional(readOnly = true)
public class BmQyGxService extends CrudService<BmQyGxDao, BmQyGx> {

	public BmQyGx get(String id) {
		return super.get(id);
	}
	
	public List<BmQyGx> findList(BmQyGx bmQyGx) {
		return super.findList(bmQyGx);
	}
	
	public Page<BmQyGx> findPage(Page<BmQyGx> page, BmQyGx bmQyGx) {
		return super.findPage(page, bmQyGx);
	}
	
	@Transactional(readOnly = false)
	public void save(BmQyGx bmQyGx) {
		super.save(bmQyGx);
	}
	
	@Transactional(readOnly = false)
	public void delete(BmQyGx bmQyGx) {
		super.delete(bmQyGx);
	}
	
	public List<BmQyGx> findListByYear(BmQyGx bmQyGx) {
		
		return dao.findListByYear(bmQyGx);
	}
	
}
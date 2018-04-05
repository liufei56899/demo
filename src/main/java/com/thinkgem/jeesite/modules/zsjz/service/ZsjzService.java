/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zsjz.entity.Zsjz;
import com.thinkgem.jeesite.modules.zsjz.dao.ZsjzDao;

/**
 * 招生简章Service
 * @author xfb
 * @version 2016-09-23
 */
@Service
@Transactional(readOnly = true)
public class ZsjzService extends CrudService<ZsjzDao, Zsjz> {

	public Zsjz get(String id) {
		return super.get(id);
	}
	
	public List<Zsjz> findList(Zsjz zsjz) {
		return super.findList(zsjz);
	}
	
	public Page<Zsjz> findPage(Page<Zsjz> page, Zsjz zsjz) {
		return super.findPage(page, zsjz);
	}
	
	@Transactional(readOnly = false)
	public void save(Zsjz zsjz) {
		super.save(zsjz);
	}
	
	@Transactional(readOnly = false)
	public void delete(Zsjz zsjz) {
		super.delete(zsjz);
	}
	
}
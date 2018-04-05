/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kscjwh.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.kscjwh.entity.Kscjwh;
import com.thinkgem.jeesite.modules.kscjwh.dao.KscjwhDao;

/**
 * 考试成绩维护Service
 * @author lmy
 * @version 2018-03-21
 */
@Service
@Transactional(readOnly = true)
public class KscjwhService extends CrudService<KscjwhDao, Kscjwh> {

	@Autowired
	private KscjwhDao kscjwh;
	
	public Kscjwh get(String id) {
		return super.get(id);
	}
	
	public List<Kscjwh> findList(Kscjwh kscjwh) {
		return super.findList(kscjwh);
	}
	
	public Page<Kscjwh> findPage(Page<Kscjwh> page, Kscjwh kscjwh) {
		return super.findPage(page, kscjwh);
	}
	
	@Transactional(readOnly = false)
	public void save(Kscjwh kscjwh) {
		super.save(kscjwh);
	}
	
	@Transactional(readOnly = false)
	public void delete(Kscjwh kscjwh) {
		super.delete(kscjwh);
	}
	
}
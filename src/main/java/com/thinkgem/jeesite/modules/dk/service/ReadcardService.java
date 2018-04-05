/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.dk.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.dk.entity.Readcard;
import com.thinkgem.jeesite.modules.dk.dao.ReadcardDao;

/**
 * 身份证读卡信息Service
 * @author lf
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class ReadcardService extends CrudService<ReadcardDao, Readcard> {

	public Readcard get(String id) {
		return super.get(id);
	}
	
	public List<Readcard> findList(Readcard readcard) {
		return super.findList(readcard);
	}
	
	public Page<Readcard> findPage(Page<Readcard> page, Readcard readcard) {
		return super.findPage(page, readcard);
	}
	
	@Transactional(readOnly = false)
	public void save(Readcard readcard) {
		super.save(readcard);
	}
	
	@Transactional(readOnly = false)
	public void delete(Readcard readcard) {
		super.delete(readcard);
	}
	
}
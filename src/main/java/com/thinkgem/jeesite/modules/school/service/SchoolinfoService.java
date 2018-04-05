/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.school.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;
import com.thinkgem.jeesite.modules.school.dao.SchoolinfoDao;

/**
 * 学校信息Service
 * @author lg
 * @version 2016-07-11
 */
@Service
@Transactional(readOnly = true)
public class SchoolinfoService extends CrudService<SchoolinfoDao, Schoolinfo> {

	public Schoolinfo get(String id) {
		return super.get(id);
	}
	
	public List<Schoolinfo> findList(Schoolinfo schoolinfo) {
		return super.findList(schoolinfo);
	}
	
	public Page<Schoolinfo> findPage(Page<Schoolinfo> page, Schoolinfo schoolinfo) {
		return super.findPage(page, schoolinfo);
	}
	
	@Transactional(readOnly = false)
	public void save(Schoolinfo schoolinfo) {
		super.save(schoolinfo);
	}
	
	@Transactional(readOnly = false)
	public void delete(Schoolinfo schoolinfo) {
		super.delete(schoolinfo);
	}
	
}
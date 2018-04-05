/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.practicemanagement.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.practicemanagement.entity.InformationTable;
import com.thinkgem.jeesite.modules.practicemanagement.dao.InformationTableDao;

/**
 * 艺术实践管理Service
 * @author lf
 * @version 2018-03-19
 */
@Service
@Transactional(readOnly = true)
public class InformationTableService extends CrudService<InformationTableDao, InformationTable> {

	public InformationTable get(String id) {
		return super.get(id);
	}
	
	public List<InformationTable> findList(InformationTable informationTable) {
		return super.findList(informationTable);
	}
	
	public Page<InformationTable> findPage(Page<InformationTable> page, InformationTable informationTable) {
		return super.findPage(page, informationTable);
	}
	
	@Transactional(readOnly = false)
	public void save(InformationTable informationTable) {
		super.save(informationTable);
	}
	
	@Transactional(readOnly = false)
	public void delete(InformationTable informationTable) {
		super.delete(informationTable);
	}
	
}
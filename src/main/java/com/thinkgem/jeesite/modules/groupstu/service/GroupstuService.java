/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.groupstu.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.groupstu.entity.Groupstu;
import com.thinkgem.jeesite.modules.groupstu.dao.GroupstuDao;

/**
 * 学生小组信息Service
 * @author lf
 * @version 2018-03-23
 */
@Service
@Transactional(readOnly = true)
public class GroupstuService extends CrudService<GroupstuDao, Groupstu> {

	public Groupstu get(String id) {
		return super.get(id);
	}
	
	public List<Groupstu> findList(Groupstu groupstu) {
		return super.findList(groupstu);
	}
	
	public Page<Groupstu> findPage(Page<Groupstu> page, Groupstu groupstu) {
		return super.findPage(page, groupstu);
	}
	
	@Transactional(readOnly = false)
	public void save(Groupstu groupstu) {
		super.save(groupstu);
	}
	
	@Transactional(readOnly = false)
	public void delete(Groupstu groupstu) {
		super.delete(groupstu);
	}
	
}
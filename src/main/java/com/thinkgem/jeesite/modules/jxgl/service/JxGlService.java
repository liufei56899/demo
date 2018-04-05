/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxgl.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.jxgl.entity.JxGl;
import com.thinkgem.jeesite.modules.jxgl.dao.JxGlDao;

/**
 * 教学管理Service
 * @author zx
 * @version 2018-03-01
 */
@Service
@Transactional(readOnly = true)
public class JxGlService extends CrudService<JxGlDao, JxGl> {
	
	
	@Autowired
	private JxGlDao jx;

	public JxGl get(String id) {
		return super.get(id);
	}
	
	public List<JxGl> findList(JxGl jxGl) {
		return super.findList(jxGl);
	}
	
	public Page<JxGl> findPage(Page<JxGl> page, JxGl jxGl) {
		return super.findPage(page, jxGl);
	}
	
	@Transactional(readOnly = false)
	public void save(JxGl jxGl) {
		super.save(jxGl);
	}
	
	@Transactional(readOnly = false)
	public void delete(JxGl jxGl) {
		super.delete(jxGl);
	}
	@Transactional(readOnly = false)
	public int findMaxKs(JxGl jxGl) {
		return jx.findMaxKs(jxGl);
	}
	
	
}
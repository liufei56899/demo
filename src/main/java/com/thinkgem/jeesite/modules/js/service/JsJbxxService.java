/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.js.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.js.dao.JsJbxxDao;

/**
 * 教师信息Service
 * @author st
 * @version 2016-05-19
 */
@Service
@Transactional(readOnly = true)
public class JsJbxxService extends CrudService<JsJbxxDao, JsJbxx> {

	public JsJbxx get(String id) {
		return super.get(id);
	}
	
	public List<JsJbxx> findList(JsJbxx jsJbxx) {
		return super.findList(jsJbxx);
	}
	
	public Page<JsJbxx> findPage(Page<JsJbxx> page, JsJbxx jsJbxx) {
		return super.findPage(page, jsJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(JsJbxx jsJbxx) {
		super.save(jsJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(JsJbxx jsJbxx) {
		super.delete(jsJbxx);
	}
	
	
	public List<JsJbxx> findJsxxList(JsJbxx jsJbxx)
	{
		return dao.findJsxxList(jsJbxx);
	}
	
	
	public JsJbxx getJsByUser(String userid){
		return dao.getJsByUser(userid);
	}
	
}
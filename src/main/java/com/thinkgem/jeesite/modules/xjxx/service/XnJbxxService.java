/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xjxx.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xjxx.dao.XnJbxxDao;

/**
 * 年级信息Service
 * @author st
 * @version 2016-09-27
 */
@Service
@Transactional(readOnly = true)
public class XnJbxxService extends CrudService<XnJbxxDao, XnJbxx> {

	public XnJbxx get(String id) {
		return super.get(id);
	}
	
	public List<XnJbxx> findList(XnJbxx xnJbxx) {
		return super.findList(xnJbxx);
	}
	
	public List<XnJbxx> findXnList(XnJbxx xnJbxx){
		return dao.findXnList(xnJbxx);
	}
	
	public Page<XnJbxx> findPage(Page<XnJbxx> page, XnJbxx xnJbxx) {
		return super.findPage(page, xnJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(XnJbxx xnJbxx) {
		super.save(xnJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(XnJbxx xnJbxx) {
		super.delete(xnJbxx);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xnxq.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.dao.XnxqJbxxDao;

/**
 * 学年学期Service
 * @author st
 * @version 2016-09-22
 */
@Service
@Transactional(readOnly = true)
public class XnxqJbxxService extends CrudService<XnxqJbxxDao, XnxqJbxx> {
	public XnxqJbxx get(String id) {
		return super.get(id);
	}
	
	public List<XnxqJbxx> findList(XnxqJbxx xnxqJbxx) {
		return super.findList(xnxqJbxx);
	}
	
	public List<XnxqJbxx> findXnxqList(XnxqJbxx xnxqJbxx){
		return dao.findXnxqList(xnxqJbxx);
	}
	
	
	public Page<XnxqJbxx> findPage(Page<XnxqJbxx> page, XnxqJbxx xnxqJbxx) {
		return super.findPage(page, xnxqJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(XnxqJbxx xnxqJbxx) {
		super.save(xnxqJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(XnxqJbxx xnxqJbxx) {
		super.delete(xnxqJbxx);
	}
	public List<XnxqJbxx> getxnxx(){
		return dao.getxnxx();
	}
	public List<XnxqJbxx> getAll(){
		return dao.getAll();
	}
}
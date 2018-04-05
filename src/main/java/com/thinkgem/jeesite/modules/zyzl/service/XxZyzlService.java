/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zyzl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zyzl.entity.XxZyzl;
import com.thinkgem.jeesite.modules.zyzl.dao.XxZyzlDao;

/**
 * 专业资料管理Service
 * @author zh
 * @version 2018-02-25
 */
@Service
@Transactional(readOnly = true)
public class XxZyzlService extends CrudService<XxZyzlDao, XxZyzl> {

	public XxZyzl get(String id) {
		return super.get(id);
	}
	
	public List<XxZyzl> findList(XxZyzl xxZyzl) {
		return super.findList(xxZyzl);
	}
	
	public Page<XxZyzl> findPage(Page<XxZyzl> page, XxZyzl xxZyzl) {
		return super.findPage(page, xxZyzl);
	}
	
	@Transactional(readOnly = false)
	public void save(XxZyzl xxZyzl) {
		super.save(xxZyzl);
	}
	
	@Transactional(readOnly = false)
	public void delete(XxZyzl xxZyzl) {
		super.delete(xxZyzl);
	}
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmfpjl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bmfpjl.entity.BmFpJl;
import com.thinkgem.jeesite.modules.bmfpjl.dao.BmFpJlDao;

/**
 * 部门分配招生人数记录Service
 * @author zw
 * @version 2016-04-26
 */
@Service
@Transactional(readOnly = true)
public class BmFpJlService extends CrudService<BmFpJlDao, BmFpJl> {

	public BmFpJl get(String id) {
		return super.get(id);
	}
	
	public List<BmFpJl> findList(BmFpJl bmFpJl) {
		return super.findList(bmFpJl);
	}
	
	public Page<BmFpJl> findPage(Page<BmFpJl> page, BmFpJl bmFpJl) {
		return super.findPage(page, bmFpJl);
	}
	
	@Transactional(readOnly = false)
	public void save(BmFpJl bmFpJl) {
		super.save(bmFpJl);
	}
	
	@Transactional(readOnly = false)
	public void delete(BmFpJl bmFpJl) {
		super.delete(bmFpJl);
	}
	
	public List<BmFpJl> findListByJhId(BmFpJl bmFpJl){
		return dao.findListByJhId(bmFpJl);
	}
}
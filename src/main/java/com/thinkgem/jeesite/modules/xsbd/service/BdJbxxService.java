/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsbd.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;
import com.thinkgem.jeesite.modules.xsbd.dao.BdJbxxDao;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;

/**
 * 新生报到Service
 * @author xfb_20161206
 * @version 2016-12-06
 */
@Service
@Transactional(readOnly = true)
public class BdJbxxService extends CrudService<BdJbxxDao, BdJbxx> {

	public BdJbxx get(String id) {
		return super.get(id);
	}
	
	public List<BdJbxx> findList(BdJbxx bdJbxx) {
		return super.findList(bdJbxx);
	}
	
	public Page<BdJbxx> findPage(Page<BdJbxx> page, BdJbxx bdJbxx) {
		return super.findPage(page, bdJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(BdJbxx bdJbxx) {
		super.save(bdJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(BdJbxx bdJbxx) {
		super.delete(bdJbxx);
	}
	public BdJbxx getBdJbxxBySfzh(BdJbxx bdJbxx) {
		return dao.getBdJbxxBySfzh(bdJbxx);
	}
	
}
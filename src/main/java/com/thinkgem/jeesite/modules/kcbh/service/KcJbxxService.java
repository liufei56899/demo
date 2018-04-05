/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kcbh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.kcbh.dao.KcJbxxDao;

/**
 * 考场基本信息Service
 * @author cpf
 * @version 2018-03-15
 */
@Service
@Transactional(readOnly = true)
public class KcJbxxService extends CrudService<KcJbxxDao, KcJbxx> {

	public KcJbxx get(String id) {
		return super.get(id);
	}
	
	public List<KcJbxx> findList(KcJbxx kcJbxx) {
		return super.findList(kcJbxx);
	}
	
	public Page<KcJbxx> findPage(Page<KcJbxx> page, KcJbxx kcJbxx) {
		return super.findPage(page, kcJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(KcJbxx kcJbxx) {
		super.save(kcJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(KcJbxx kcJbxx) {
		super.delete(kcJbxx);
	}
	
}
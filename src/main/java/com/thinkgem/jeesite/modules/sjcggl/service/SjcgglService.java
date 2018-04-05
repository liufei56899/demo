/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sjcggl.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.sjcggl.entity.Sjcggl;
import com.thinkgem.jeesite.modules.sjcggl.dao.SjcgglDao;

/**
 * 实践成果管理Service
 * @author zx
 * @version 2018-02-25
 */
@Service
@Transactional(readOnly = true)
public class SjcgglService extends CrudService<SjcgglDao, Sjcggl> {

	public Sjcggl get(String id) {
		return super.get(id);
	}
	
	public List<Sjcggl> findList(Sjcggl sjcggl) {
		return super.findList(sjcggl);
	}
	
	public Page<Sjcggl> findPage(Page<Sjcggl> page, Sjcggl sjcggl) {
		return super.findPage(page, sjcggl);
	}
	
	@Transactional(readOnly = false)
	public void save(Sjcggl sjcggl) {
		super.save(sjcggl);
	}
	
	@Transactional(readOnly = false)
	public void delete(Sjcggl sjcggl) {
		super.delete(sjcggl);
	}
	
}
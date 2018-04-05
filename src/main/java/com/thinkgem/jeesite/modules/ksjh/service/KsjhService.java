/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.ksjh.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.classroom.entity.Classroom;
import com.thinkgem.jeesite.modules.kcbh.entity.KcJbxx;
import com.thinkgem.jeesite.modules.ksjh.entity.Ksjh;
import com.thinkgem.jeesite.modules.ksjh.dao.KsjhDao;

/**
 * 考试计划Service
 * @author cpf
 * @version 2018-03-16
 */
@Service
@Transactional(readOnly = true)
public class KsjhService extends CrudService<KsjhDao, Ksjh> {

	public Ksjh get(String id) {
		return super.get(id);
	}
	
	public List<Ksjh> findList(Ksjh ksjh) {
		return super.findList(ksjh);
	}
	
	/**
	 * 查询考场信息
	 * @return 返回考场信息对象集合
	 */
	public List<KcJbxx> findClassroom(String id) {
		return dao.findClassroom(id);
	}
	
	public List<BjJbxx> findBjJbxx() {
		return dao.findBjJbxx();
	}
	
	public Page<Ksjh> findPage(Page<Ksjh> page, Ksjh ksjh) {
		return super.findPage(page, ksjh);
	}
	
	@Transactional(readOnly = false)
	public void save(Ksjh ksjh) {
		super.save(ksjh);
	}
	
	@Transactional(readOnly = false)
	public void delete(Ksjh ksjh) {
		super.delete(ksjh);
	}
	
}
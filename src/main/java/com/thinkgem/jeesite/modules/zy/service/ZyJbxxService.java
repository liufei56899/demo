/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zy.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.zy.dao.ZyJbxxDao;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.entity.ZytjJbxx;

/**
 * 专业Service
 * @author zw
 * @version 2016-04-25
 */
@Service
@Transactional(readOnly = true)
public class ZyJbxxService extends CrudService<ZyJbxxDao, ZyJbxx> {

	public ZyJbxx get(String id) {
		return super.get(id);
	}
	
	public ZyJbxx getValueByName(String name) {
		return dao.getValueByName(name);
	}
	
	public List<ZyJbxx> findList(ZyJbxx zyJbxx) {
		return super.findList(zyJbxx);
	}
	
	public List<ZyJbxx> findZyJbList(ZyJbxx zyJbxx){
		return dao.findZyJbList(zyJbxx);
	}
	
	public Page<ZyJbxx> findPage(Page<ZyJbxx> page, ZyJbxx zyJbxx) {
		return super.findPage(page, zyJbxx);
	}
	
	@Transactional(readOnly = false)
	public void save(ZyJbxx zyJbxx) {
		super.save(zyJbxx);
	}
	
	@Transactional(readOnly = false)
	public void delete(ZyJbxx zyJbxx) {
		super.delete(zyJbxx);
	}
	
	//年度专业统计
	public List<ZytjJbxx> findNdzytjList(ZytjJbxx zyJbxx){
		return dao.findNdzytjList(zyJbxx);
	}
	public List<ZytjJbxx> findAllZy(ZytjJbxx zyJbxx){
		return dao.findAllZy(zyJbxx);
	}
	public List<ZytjJbxx> findNdzytjzysByid(ZytjJbxx zyJbxx){
		return dao.findNdzytjzysByid(zyJbxx);
	}
	public List<ZytjJbxx> findNdzytjListByid(ZytjJbxx zyJbxx){
		return dao.findNdzytjListByid(zyJbxx);
	}
	
}
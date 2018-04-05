/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kjcdsz.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.kjcdsz.entity.SysMenu;
import com.thinkgem.jeesite.modules.kjcdsz.dao.SysMenuDao;

/**
 * 快捷菜单设置Service
 * @author st
 * @version 2016-07-26
 */
@Service
@Transactional(readOnly = true)
public class SysMenuService extends CrudService<SysMenuDao, SysMenu> {

	public SysMenu get(String id) {
		return super.get(id);
	}
	
	public List<SysMenu> findList(SysMenu sysMenu) {
		return super.findList(sysMenu);
	}
	
	public Page<SysMenu> findPage(Page<SysMenu> page, SysMenu sysMenu) {
		return super.findPage(page, sysMenu);
	}
	
	@Transactional(readOnly = false)
	public void save(SysMenu sysMenu) {
		super.save(sysMenu);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysMenu sysMenu) {
		super.delete(sysMenu);
	}
	
}
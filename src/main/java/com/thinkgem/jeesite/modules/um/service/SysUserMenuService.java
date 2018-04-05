/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.um.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.um.entity.SysUserMenu;
import com.thinkgem.jeesite.modules.um.dao.SysUserMenuDao;

/**
 * 用户菜单关系Service
 * @author lg
 * @version 2016-08-01
 */
@Service
@Transactional(readOnly = true)
public class SysUserMenuService extends CrudService<SysUserMenuDao, SysUserMenu> {

	public SysUserMenu get(String id) {
		return super.get(id);
	}
	
	public List<SysUserMenu> findList(SysUserMenu sysUserMenu) {
		return super.findList(sysUserMenu);
	}
	
	public Page<SysUserMenu> findPage(Page<SysUserMenu> page, SysUserMenu sysUserMenu) {
		return super.findPage(page, sysUserMenu);
	}
	
	@Transactional(readOnly = false)
	public void save(SysUserMenu sysUserMenu) {
		super.save(sysUserMenu);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysUserMenu sysUserMenu) {
		super.delete(sysUserMenu);
	}
	
	@Transactional(readOnly = false)
	public void deleteMenu(Map<String,Object> map)
	{
		super.dao.deleteMenu(map);
	}
	
}
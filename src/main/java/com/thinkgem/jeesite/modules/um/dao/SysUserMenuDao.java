/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.um.dao;

import java.util.Map;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.um.entity.SysUserMenu;

/**
 * 用户菜单关系DAO接口
 * @author lg
 * @version 2016-08-01
 */
@MyBatisDao
public interface SysUserMenuDao extends CrudDao<SysUserMenu> {
	
	public void deleteMenu(Map<String,Object> map);
	
}
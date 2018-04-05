/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kjcdsz.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.kjcdsz.entity.SysMenu;

/**
 * 快捷菜单设置DAO接口
 * @author st
 * @version 2016-07-26
 */
@MyBatisDao
public interface SysMenuDao extends CrudDao<SysMenu> {
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.userui.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.userui.entity.SysUserUi;

/**
 * 终端用户DAO接口
 * 
 * @author XFB
 * @version 2016-09-29
 */
@MyBatisDao
public interface SysUserUiDao extends CrudDao<SysUserUi> {
	public List<SysUserUi> findListByOfficeId(String id);
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxgl.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jxgl.entity.JxGl;

/**
 * 教学管理DAO接口
 * @author zx
 * @version 2018-03-01
 */
@MyBatisDao
public interface JxGlDao extends CrudDao<JxGl> {
	int findMaxKs(JxGl jxGl);
	
}
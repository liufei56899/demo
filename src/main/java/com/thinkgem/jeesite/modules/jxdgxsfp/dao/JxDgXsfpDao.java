/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jxdgxsfp.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jxdgxsfp.entity.JxDgXsfp;

/**
 * 学时分配DAO接口
 * @author zx
 * @version 2018-03-01
 */
@MyBatisDao
public interface JxDgXsfpDao extends CrudDao<JxDgXsfp> {
	public void deLByJxDgId(JxDgXsfp jxdgfp);
}
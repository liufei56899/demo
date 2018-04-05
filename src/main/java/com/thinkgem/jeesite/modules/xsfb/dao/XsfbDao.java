/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsfb.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;

/**
 * 新生分班DAO接口
 * @author st
 * @version 2016-07-13
 */
@MyBatisDao
public interface XsfbDao extends CrudDao<BjJbxx> {
	
}
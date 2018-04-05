/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.kscjwh.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.kscjwh.entity.Kscjwh;

/**
 * 考试成绩维护DAO接口
 * @author lmy
 * @version 2018-03-21
 */
@MyBatisDao
public interface KscjwhDao extends CrudDao<Kscjwh> {
	
}
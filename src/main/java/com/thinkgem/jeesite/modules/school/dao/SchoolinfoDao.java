/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.school.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.school.entity.Schoolinfo;

/**
 * 学校信息DAO接口
 * @author lg
 * @version 2016-07-11
 */
@MyBatisDao
public interface SchoolinfoDao extends CrudDao<Schoolinfo> {
	
}
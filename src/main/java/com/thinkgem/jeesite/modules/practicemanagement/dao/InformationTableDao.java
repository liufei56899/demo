/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.practicemanagement.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.practicemanagement.entity.InformationTable;

/**
 * 艺术实践管理DAO接口
 * @author lf
 * @version 2018-03-19
 */
@MyBatisDao
public interface InformationTableDao extends CrudDao<InformationTable> {
	
}
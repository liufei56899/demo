/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xs.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxxRecord;

/**
 * 学生信息记录DAO接口
 * @author lg
 * @version 2016-07-26
 */
@MyBatisDao
public interface XsJbxxRecordDao extends CrudDao<XsJbxxRecord> {
	
}
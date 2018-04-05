/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRecord;

/**
 * 计划分解个人记录DAO接口
 * @author lg
 * @version 2016-07-23
 */
@MyBatisDao
public interface JhFjGrRecordDao extends CrudDao<JhFjGrRecord> {
	/**
	 * 获取最新的一条计划分解
	 * @return
	 */
	public JhFjGrRecord getLastJhFjInfo(JhFjGrRecord jhFjGrRecord);
}
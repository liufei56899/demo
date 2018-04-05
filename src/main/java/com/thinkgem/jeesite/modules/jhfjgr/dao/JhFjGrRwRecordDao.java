/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRwRecord;

/**
 * 计划分解个人任务记录DAO接口
 * @author lg
 * @version 2016-07-23
 */
@MyBatisDao
public interface JhFjGrRwRecordDao extends CrudDao<JhFjGrRwRecord> {
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjGrRwRecord> getJhFjGrRwByJhFjId(JhFjGrRwRecord jhFjGrRwRecord);
}
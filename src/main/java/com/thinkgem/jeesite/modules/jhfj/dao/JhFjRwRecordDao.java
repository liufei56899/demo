/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;

/**
 * 计划分解任务历史记录DAO接口
 * @author lg
 * @version 2016-07-23
 */
@MyBatisDao
public interface JhFjRwRecordDao extends CrudDao<JhFjRwRecord> {
	/**
	 * 根据计划分解id查询计划分解任务
	 * @param id
	 * @return
	 */
	public List<JhFjRwRecord> getJhFjRwByJhFjId(JhFjRwRecord jhFjRwRecord);
}
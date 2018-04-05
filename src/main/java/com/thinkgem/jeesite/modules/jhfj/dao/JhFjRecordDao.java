/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfj.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;

/**
 * 部门任务分解记录DAO接口
 * @author lg
 * @version 2016-07-23
 */
@MyBatisDao
public interface JhFjRecordDao extends CrudDao<JhFjRecord> {
	/**
	 * 获取最新的一条计划分解
	 * @return
	 */
	public JhFjRecord getLastJhFj(JhFjRecord jhFjRecord);
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;

/**
 * 计划分解个人DAO接口
 * @author lg
 * @version 2016-05-26
 */
@MyBatisDao
public interface JhFjGrDao extends CrudDao<JhFjGr> {
	/**
	 * 获取最新的一条计划分解
	 * @return
	 */
	public JhFjGr getLastJhFjInfo(JhFjGr jhFjGr);
	/**
	 * 根据编号删除计划分解个人任务
	 * @param id
	 */
	public void deleteJhFjGr(String id);
}
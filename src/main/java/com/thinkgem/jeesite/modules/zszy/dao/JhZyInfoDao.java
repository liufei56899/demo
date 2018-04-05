/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zszy.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;

/**
 * 招生计划专业人数记录DAO接口
 * @author zw
 * @version 2016-05-13
 */
@MyBatisDao
public interface JhZyInfoDao extends CrudDao<JhZyInfo> {

	List<JhZyInfo> findListByJhId(JhZyInfo jhZyInfo);

	public List<JhZyInfo> findZyListByJhId(JhZyInfo jhZyInfo);
	public List<JhZyInfo> findZylxListByJhId(JhZyInfo jhZyInfo);

	void delByJhId(JhZyInfo jhZyInfo);
	
}
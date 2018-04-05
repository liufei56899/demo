/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmfpjl.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bmfpjl.entity.BmFpJl;

/**
 * 部门分配招生人数记录DAO接口
 * @author zw
 * @version 2016-04-26
 */
@MyBatisDao
public interface BmFpJlDao extends CrudDao<BmFpJl> {

	List<BmFpJl> findListByJhId(BmFpJl bmFpJl);
	
}
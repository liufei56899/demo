/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.bmqygx.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.bmqygx.entity.BmQyGx;

/**
 * 部门区域关系DAO接口
 * @author lg
 * @version 2016-04-25
 */
@MyBatisDao
public interface BmQyGxDao extends CrudDao<BmQyGx> {

	List<BmQyGx> findListByYear(BmQyGx bmQyGx);
	
}
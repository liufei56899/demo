/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsbd.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;

/**
 * 新生报到DAO接口
 * @author xfb_20161206
 * @version 2016-12-06
 */
@MyBatisDao
public interface BdJbxxDao extends CrudDao<BdJbxx> {
	BdJbxx getBdJbxxBySfzh(BdJbxx bdJbxx);
}
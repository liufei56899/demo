/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.syxx.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.syxx.entity.SyJbxx;

/**
 * 生源信息DAO接口
 * @author xfb
 * @version 2016-05-05
 */
@MyBatisDao
public interface SyJbxxDao extends CrudDao<SyJbxx> {
	public int bmrwfp(SyJbxx syjbxx);
}
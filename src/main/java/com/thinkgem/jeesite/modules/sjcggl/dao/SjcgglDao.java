/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.sjcggl.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.sjcggl.entity.Sjcggl;

/**
 * 实践成果管理DAO接口
 * @author zx
 * @version 2018-02-25
 */
@MyBatisDao
public interface SjcgglDao extends CrudDao<Sjcggl> {
	
}
/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zylx.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 专业类别DAO接口
 * 
 * @author zw
 * @version 2016-04-25
 */
@MyBatisDao
public interface ZylxJbxxDao extends CrudDao<ZylxJbxx> {
	public String getZhuanYeById(String id);
	
	public List<ZylxJbxx> findZylxList(ZylxJbxx zylxJbxx);
}
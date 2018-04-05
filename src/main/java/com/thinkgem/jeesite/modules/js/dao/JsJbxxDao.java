/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.js.dao;

import java.util.List;
import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;

/**
 * 教师信息DAO接口
 * 
 * @author st
 * @version 2016-05-19
 */
@MyBatisDao
public interface JsJbxxDao extends CrudDao<JsJbxx> {
	List<JsJbxx> findJsxxList(JsJbxx jsjbxx);

	JsJbxx getJsByUser(String userid);
}
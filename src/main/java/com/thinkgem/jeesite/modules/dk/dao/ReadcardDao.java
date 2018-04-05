/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.dk.dao;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.dk.entity.Readcard;

/**
 * 身份证读卡信息DAO接口
 * @author lf
 * @version 2016-12-06
 */
@MyBatisDao
public interface ReadcardDao extends CrudDao<Readcard> {
	
}
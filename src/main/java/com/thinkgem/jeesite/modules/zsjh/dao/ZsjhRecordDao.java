/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zsjh.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;

/**
 * 计划招生DAO接口
 * 
 * @author XFB
 * @version 2016-07-20
 */
@MyBatisDao
public interface ZsjhRecordDao extends CrudDao<ZsjhRecord> {

	List<ZsjhRecord> getZsjhRecordList(String id);

}
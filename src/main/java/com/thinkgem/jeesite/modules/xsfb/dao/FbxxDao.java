package com.thinkgem.jeesite.modules.xsfb.dao;

import org.apache.ibatis.annotations.Param;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.xsfb.entity.Fbxx;

/**
 * 新生分班DAO接口
 * @author zh
 * @version 2018-02-08
 */
@MyBatisDao
public interface FbxxDao extends CrudDao<Fbxx> {
	public void updateBjjbxx(@Param("id")String id,@Param("yyrs")String yyrs);
}

/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.professional_code.dao;

import java.util.List;

import com.thinkgem.jeesite.common.persistence.CrudDao;
import com.thinkgem.jeesite.common.persistence.annotation.MyBatisDao;
import com.thinkgem.jeesite.modules.professional_code.entity.ProfessionalCategoryCode;

/**
 * 专业类别代码表DAO接口
 * @author 邓和平
 * @version 2016-12-13
 */
@MyBatisDao
public interface ProfessionalCategoryCodeDao extends CrudDao<ProfessionalCategoryCode> {
	public List<ProfessionalCategoryCode> getCategoryByVersion(ProfessionalCategoryCode professionalCategoryCode);
	public List<ProfessionalCategoryCode> getProfessionalCategoryId(ProfessionalCategoryCode professionalCategoryCode);
	public ProfessionalCategoryCode getprofessionalEmphasisByProfessionalId(ProfessionalCategoryCode professionalCategoryCode);
}
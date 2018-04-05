/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.professional_code.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.professional_code.entity.ProfessionalCategoryCode;
import com.thinkgem.jeesite.modules.professional_code.dao.ProfessionalCategoryCodeDao;

/**
 * 专业类别代码表Service
 * @author 邓和平
 * @version 2016-12-13
 */
@Service
@Transactional(readOnly = true)
public class ProfessionalCategoryCodeService extends CrudService<ProfessionalCategoryCodeDao, ProfessionalCategoryCode> {

	public ProfessionalCategoryCode get(String id) {
		return super.get(id);
	}
	
	public List<ProfessionalCategoryCode> findList(ProfessionalCategoryCode professionalCategoryCode) {
		return super.findList(professionalCategoryCode);
	}
	
	public Page<ProfessionalCategoryCode> findPage(Page<ProfessionalCategoryCode> page, ProfessionalCategoryCode professionalCategoryCode) {
		return super.findPage(page, professionalCategoryCode);
	}
	
	@Transactional(readOnly = false)
	public void save(ProfessionalCategoryCode professionalCategoryCode) {
		super.save(professionalCategoryCode);
	}
	
	@Transactional(readOnly = false)
	public void delete(ProfessionalCategoryCode professionalCategoryCode) {
		super.delete(professionalCategoryCode);
	}
	
	public List<ProfessionalCategoryCode> getCategoryByVersion(ProfessionalCategoryCode professionalCategoryCode){
		return dao.getCategoryByVersion(professionalCategoryCode);
	}	
	
	public List<ProfessionalCategoryCode> getProfessionalCategoryId(ProfessionalCategoryCode professionalCategoryCode){
		return dao.getProfessionalCategoryId(professionalCategoryCode);
	}	
	
	public ProfessionalCategoryCode getprofessionalEmphasisByProfessionalId(ProfessionalCategoryCode professionalCategoryCode){
		return dao.getprofessionalEmphasisByProfessionalId(professionalCategoryCode);
	}
}
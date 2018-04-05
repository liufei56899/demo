/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.professional_code.entity;

import org.hibernate.validator.constraints.Length;

import com.thinkgem.jeesite.common.persistence.DataEntity;

/**
 * 专业类别代码表Entity
 * @author 邓和平
 * @version 2016-12-13
 */
public class ProfessionalCategoryCode extends DataEntity<ProfessionalCategoryCode> {
	
	private static final long serialVersionUID = 1L;
	private String categoryId;		// category_id
	private String categoryName;		// category_name
	private String professionalId;		// professional_id
	private String professionalName;		// professional_name
	private String professionalEmphasis;		// professional_emphasis
	private String professionalVersionDate;		// professional_version_date
	
	public ProfessionalCategoryCode() {
		super();
	}

	public ProfessionalCategoryCode(String id){
		super(id);
	}

	@Length(min=0, max=20, message="category_id长度必须介于 0 和 20 之间")
	public String getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(String categoryId) {
		this.categoryId = categoryId;
	}
	
	@Length(min=0, max=40, message="category_name长度必须介于 0 和 40 之间")
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	@Length(min=1, max=20, message="professional_id长度必须介于 1 和 20 之间")
	public String getProfessionalId() {
		return professionalId;
	}

	public void setProfessionalId(String professionalId) {
		this.professionalId = professionalId;
	}
	
	@Length(min=0, max=40, message="professional_name长度必须介于 0 和 40 之间")
	public String getProfessionalName() {
		return professionalName;
	}

	public void setProfessionalName(String professionalName) {
		this.professionalName = professionalName;
	}
	
	@Length(min=0, max=100, message="professional_emphasis长度必须介于 0 和 100 之间")
	public String getProfessionalEmphasis() {
		return professionalEmphasis;
	}

	public void setProfessionalEmphasis(String professionalEmphasis) {
		this.professionalEmphasis = professionalEmphasis;
	}
	
	@Length(min=0, max=50, message="professional_version_date长度必须介于 0 和 50 之间")
	public String getProfessionalVersionDate() {
		return professionalVersionDate;
	}

	public void setProfessionalVersionDate(String professionalVersionDate) {
		this.professionalVersionDate = professionalVersionDate;
	}
	
}
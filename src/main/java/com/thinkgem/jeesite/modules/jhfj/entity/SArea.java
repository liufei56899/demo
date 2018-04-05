package com.thinkgem.jeesite.modules.jhfj.entity;

import java.util.List;

public class SArea {

	private List<QArea> qAreas;
	
	private  String code;
	
	private  String name;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<QArea> getqAreas() {
		return qAreas;
	}

	public void setqAreas(List<QArea> qAreas) {
		this.qAreas = qAreas;
	}
}

package com.thinkgem.jeesite.modules.jhfj.entity;

import java.util.List;

public class DQArea {
	private List<ShArea> shAreas;
	
	private  String code;
	
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

	private  String name;

	public List<ShArea> getShAreas() {
		return shAreas;
	}

	public void setShAreas(List<ShArea> shAreas) {
		this.shAreas = shAreas;
	}
}

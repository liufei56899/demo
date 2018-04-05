package com.thinkgem.jeesite.modules.jhfj.entity;

import java.util.List;

public class QArea {

	private List<ZArea> zAreas;
	
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

	public List<ZArea> getzAreas() {
		return zAreas;
	}

	public void setzAreas(List<ZArea> zAreas) {
		this.zAreas = zAreas;
	}
}

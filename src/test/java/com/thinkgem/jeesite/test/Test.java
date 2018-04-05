package com.thinkgem.jeesite.test;

import com.thinkgem.jeesite.modules.sys.entity.Area;

public class Test {


	public static void main(String[] args) {
		Area area=new Area();
		System.out.println(area.getName()==null?"":area.getName());
	}

}

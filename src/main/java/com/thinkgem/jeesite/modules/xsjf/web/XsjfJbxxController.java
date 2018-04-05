package com.thinkgem.jeesite.modules.xsjf.web;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;
import com.thinkgem.jeesite.modules.xsbd.service.BdJbxxService;

@Controller
@RequestMapping(value = "${adminPath}/xsjf/xsjfjbxx")
public class XsjfJbxxController  extends BaseController {
	@Autowired
	private BdJbxxService bdJbxxService;
	
	
	public BdJbxx get(@RequestParam(required=false) String id) {
		BdJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = bdJbxxService.get(id);
		}
		if (entity == null){
			entity = new BdJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("xsjf:xsjfjbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(BdJbxx bdJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BdJbxx> page = bdJbxxService.findPage(new Page<BdJbxx>(request, response), bdJbxx); 
		model.addAttribute("page", page);
		model.addAttribute("bdJbxx",bdJbxx);
		return "modules/xsjf/xsjfjbxxList";
	}
	
	@RequiresPermissions("xsjf:xsjfjbxx:view")
	@RequestMapping(value = "getXueShengInfo")
	public String getXueShengInfo(BdJbxx bdJbxx, Model model)
	{
		//获取当前年份
		SimpleDateFormat formatter = new SimpleDateFormat( "yyyy");
		Date nowYear = null;
		try {
			nowYear = formatter.parse(DateUtils.getYear());
			bdJbxx = bdJbxxService.get(bdJbxx.getId());
			if(bdJbxx.getNf() != null && !bdJbxx.getNf().equals(""))
			{
				nowYear = formatter.parse(bdJbxx.getNf());
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		model.addAttribute("nowYear",nowYear);
		model.addAttribute("bdJbxx", bdJbxx);
		return "modules/xsjf/xsjfjbxxForm";
	}

}

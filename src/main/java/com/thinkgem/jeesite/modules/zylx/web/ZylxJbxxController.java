/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zylx.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import com.thinkgem.jeesite.modules.zylx.service.ZylxJbxxService;

/**
 * 专业类别Controller
 * @author zw
 * @version 2016-04-25
 */
@Controller
@RequestMapping(value = "${adminPath}/zylx/zylxJbxx")
public class ZylxJbxxController extends BaseController {

	@Autowired
	private ZylxJbxxService zylxJbxxService;
	
	@ModelAttribute
	public ZylxJbxx get(@RequestParam(required=false) String id) {
		ZylxJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zylxJbxxService.get(id);
		}
		if (entity == null){
			entity = new ZylxJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("zylx:zylxJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZylxJbxx zylxJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ZylxJbxx> page = zylxJbxxService.findPage(new Page<ZylxJbxx>(request, response), zylxJbxx); 
		model.addAttribute("page", page);
		return "modules/zylx/zylxJbxxList";
	}

	@RequiresPermissions("zylx:zylxJbxx:view")
	@RequestMapping(value = "form")
	public String form(ZylxJbxx zylxJbxx, Model model) {
		model.addAttribute("zylxJbxx", zylxJbxx);
		return "modules/zylx/zylxJbxxForm";
	}

	@RequiresPermissions("zylx:zylxJbxx:edit")
	@RequestMapping(value = "save")
	public String save(ZylxJbxx zylxJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zylxJbxx)){
			return form(zylxJbxx, model);
		}
		zylxJbxxService.save(zylxJbxx);
		addMessage(redirectAttributes, "保存专业类别成功");
		return "redirect:"+Global.getAdminPath()+"/zylx/zylxJbxx/?repage";
	}
	
	@RequiresPermissions("zylx:zylxJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(ZylxJbxx zylxJbxx,String ids,RedirectAttributes redirectAttributes) {
		if(ids!=null && !"".equals(ids) && ids.length()>0)
		{
			String[] idArr = ids.split(",");
			for(String id: idArr)
			{
				ZylxJbxx zylxEntity= this.get(id);
				zylxJbxxService.delete(zylxEntity);
			}
		}
		addMessage(redirectAttributes, "删除专业类别成功");
		return "redirect:"+Global.getAdminPath()+"/zylx/zylxJbxx/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "findInitZylx")
	public String findInitZylx(String id, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		List<ZylxJbxx> zylxs = zylxJbxxService.findList(new ZylxJbxx());
		sb.append("<select id='zylxId' onclick='zhuanYeOnClick(this.value)' name='zylxId.id' style='width: 270px;'>");
		//sb.append("<option value=''><option>");
		if(zylxs != null && zylxs.size()>0){
			for(ZylxJbxx jbxx : zylxs){
				if(jbxx.getId().equals(id)){
					sb.append("<option selected='selected' value='"+jbxx.getId()+"'>"+jbxx.getLxmc()+"</option>");
				}else{
					sb.append("<option  value='"+jbxx.getId()+"'>"+jbxx.getLxmc()+"</option>");
				}
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	
	@ResponseBody
	@RequestMapping(value = "getZhuanYeMingCheng")
	public String getZhuanYeMingCheng(ZylxJbxx zylxJbxx)
	{
		List<ZylxJbxx> list = zylxJbxxService.findZylxList(zylxJbxx);
		Map map = new HashMap();
		if(list!=null && list.size()>0)
		{
			map.put("isTrue", false);
		}
		else
		{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
		
	}

}
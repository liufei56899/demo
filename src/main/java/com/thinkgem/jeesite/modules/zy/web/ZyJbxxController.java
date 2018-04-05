/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.zy.web;

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
import com.thinkgem.jeesite.modules.professional_code.entity.ProfessionalCategoryCode;
import com.thinkgem.jeesite.modules.professional_code.service.ProfessionalCategoryCodeService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import com.thinkgem.jeesite.modules.zylx.service.ZylxJbxxService;

/**
 * 专业Controller
 * @author zw
 * @version 2016-04-25
 */
@Controller
@RequestMapping(value = "${adminPath}/zy/zyJbxx")
public class ZyJbxxController extends BaseController {

	@Autowired
	private ZyJbxxService zyJbxxService;

	@Autowired
	private ProfessionalCategoryCodeService professionalCategoryCodeService;
	
	@Autowired
	private ZylxJbxxService zylxJbxxService;
	
	
	@ModelAttribute
	public ZyJbxx get(@RequestParam(required=false) String id) {
		ZyJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = zyJbxxService.get(id);
		}
		if (entity == null){
			entity = new ZyJbxx();
		}
		return entity;
	}
	
	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(ZyJbxx zyJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ZyJbxx> page = zyJbxxService.findPage(new Page<ZyJbxx>(request, response), zyJbxx); 
		model.addAttribute("page", page);
		return "modules/zy/zyJbxxList";
	}

	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = "form")
	public String form(ZyJbxx zyJbxx, Model model) {
		
		model.addAttribute("zyJbxx", zyJbxx);
		return "modules/zy/zyJbxxForm";
	}
	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = "zyJbxxUpdateForm")
	public String zyJbxxUpdateForm(ZyJbxx zyJbxx, Model model) {
		
		model.addAttribute("zyJbxx", zyJbxx);
		return "modules/zy/zyJbxxUpdateForm";
	}
	
	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = "zyJbxxINForm")
	public String zyJbxxINForm(ZyJbxx zyJbxx, Model model) {
		
		model.addAttribute("zyJbxx", zyJbxx);
		return "modules/zy/zyJbxxINForm";
	}	
	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = "zyJbxxOUTForm")
	public String zyJbxxOUTForm(ZyJbxx zyJbxx, Model model) {
		
		model.addAttribute("zyJbxx", zyJbxx);
		return "modules/zy/zyJbxxOUTForm";
	}
	
	/**
	 * 页面查看专业详细信息
	 * @param zyJbxx
	 * 
	 */
	@RequiresPermissions("zy:zyJbxx:view")
	@RequestMapping(value = "zyInfoForm")
	public String zyInfoForm(ZyJbxx zyJbxx, Model model) {
		zyJbxx=this.zyJbxxService.get(zyJbxx.getId());
		model.addAttribute("zyJbxx", zyJbxx);
		return "modules/zy/zyJbxxInfoForm";
	}
	
	
	@ResponseBody
	@RequestMapping(value = "findZyfxAndZyjc")
	public String findZyfxAndZyjc(String id, Model model) {
		ZyJbxx z=this.zyJbxxService.get(id);
		String s=JsonMapper.toJsonString(z);
		//System.out.println("****************************"+s);
		return s;
	}

	/**
	 * Des:验证同一专业类别下专业名称是否重复
	 * 2016-9-22
	 * @author fn
	 * @param zyJbxx
	 * @param zylxid
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "validateZyMc")
	public String validateZyMc(ZyJbxx zyJbxx,@RequestParam("zylxid") String zylxid)
	{
		ZylxJbxx zylx = new ZylxJbxx();
		zylx.setId(zylxid);
		zyJbxx.setZylx(zylx);
		List<ZyJbxx> list = zyJbxxService.findZyJbList(zyJbxx);
		Map map = new HashMap();
		if(list!=null && list.size()>0)
		{
			map.put("isTrue", false);
		}
		else
		{
			map.put("isTrue", true);
		}
		System.out.println("==========="+JsonMapper.toJsonString(map));
		return JsonMapper.toJsonString(map);
		
	}
	
	
	@RequiresPermissions("zy:zyJbxx:edit")
	@RequestMapping(value = "save")
	public String save(ZyJbxx zyJbxx, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zyJbxx)){
			return form(zyJbxx, model);
		}
		ProfessionalCategoryCode professionalCategoryCode = new ProfessionalCategoryCode();
		String category_ID=zyJbxx.getZylx().getId();
		if (!category_ID.equals("0")) {
			String zyjnfx_indexString = zyJbxx.getZymc();
			String professional_ID = zyJbxx.getZyfxmc();
			//		System.out.println("=========================="+zyjnfx_indexString);
			professionalCategoryCode.setProfessionalId(professional_ID);
			professionalCategoryCode = professionalCategoryCodeService
					.getprofessionalEmphasisByProfessionalId(professionalCategoryCode);
			ZylxJbxx zylxJbxx = new ZylxJbxx();
			zylxJbxx.setLxmc(professionalCategoryCode.getCategoryName());
			List<ZylxJbxx> list = zylxJbxxService.findZylxList(zylxJbxx);
			if (list != null && list.size() > 0) {
				String zylxid = list.get(0).getId();
				zyJbxx.getZylx().setId(zylxid);
			} else {
				zylxJbxxService.save(zylxJbxx);
				ZylxJbxx zylxJbxx1 = new ZylxJbxx();
				zylxJbxx1.setLxmc(professionalCategoryCode.getCategoryName());
				zyJbxx.getZylx().setId(
						zylxJbxxService.findZylxList(zylxJbxx1).get(0).getId());
			}
			zyJbxx.setZydm(professional_ID);
			zyJbxx.setZyfxmc(professionalCategoryCode.getProfessionalName());
			String zyjnfx = professionalCategoryCode.getProfessionalEmphasis();
			if (zyjnfx != null && zyjnfx.trim() != "") {
				String[] zStrings = zyjnfx.split("\\|");
				if (zyjnfx_indexString != null && zyjnfx_indexString.length()!= 0) {
					zyJbxx.setZymc(zStrings[Integer
							.parseInt(zyjnfx_indexString)]);
				} else {
					zyJbxx.setZymc("");
				}
			}
			List<ZyJbxx> listzyJbxxs = zyJbxxService.findZyJbList(zyJbxx);
			if (listzyJbxxs != null && listzyJbxxs.size() > 0) {
				zyJbxx.setId(listzyJbxxs.get(0).getId());
			}
			zyJbxxService.save(zyJbxx);
		}else{
			/*professionalCategoryCode.setCategoryId(category_ID);
			List<ProfessionalCategoryCode> pccs=professionalCategoryCodeService.findList(professionalCategoryCode);
			professionalCategoryCode=pccs.get(0);*/
			ZylxJbxx zylxJbxx = new ZylxJbxx();
			zylxJbxx.setLxmc("目录外");
			List<ZylxJbxx> list = zylxJbxxService.findZylxList(zylxJbxx);
			if (list != null && list.size() > 0) {
				String zylxid = list.get(0).getId();
				zyJbxx.getZylx().setId(zylxid);
			} else {
				zylxJbxxService.save(zylxJbxx);
				ZylxJbxx zylxJbxx1 = new ZylxJbxx();
				zylxJbxx1.setLxmc("目录外");
				zyJbxx.getZylx().setId(
						zylxJbxxService.findZylxList(zylxJbxx1).get(0).getId());
			}
			zyJbxxService.save(zyJbxx);
		}
		addMessage(redirectAttributes, "保存专业名称成功");
		return "redirect:"+Global.getAdminPath()+"/zy/zyJbxx/?repage";
	}
	
	@RequiresPermissions("zy:zyJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(ZyJbxx zyJbxx,String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id:idArr)
		{
			ZyJbxx zyEntity = this.get(id);
			zyJbxxService.delete(zyEntity);
		}
		addMessage(redirectAttributes, "删除专业名称成功");
		return "redirect:"+Global.getAdminPath()+"/zy/zyJbxx/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "findZysByLxIdForBgyd")
	public String findZysByLxIdForBgyd(String id, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select id='zyid' name='newZyid.id'  style='width: 270px;' class='input-xlarge required'>");
		if(zyJbxxs != null && zyJbxxs.size() > 0){
			sb.append("<option value=''>请选择</option>");
			for(ZyJbxx jbxx : zyJbxxs){
				sb.append("<option value='"+jbxx.getId()+"'>"+jbxx.getZymc()+"</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	
	@ResponseBody
	@RequestMapping(value = "findZysByLxId")
	public String findZysByLxId(String id, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select id='zyid' name='zyId.id'  style='width: 270px;' class='input-xlarge required'>");
		if(zyJbxxs != null && zyJbxxs.size() > 0){
			sb.append("<option value=''>请选择</option>");
			for(ZyJbxx jbxx : zyJbxxs){
				sb.append("<option value='"+jbxx.getId()+"'>"+jbxx.getZymc()+"</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	@ResponseBody
	@RequestMapping(value = "findInitZysByLxId")
	public String findInitZysByLxId(String id,String zyId, RedirectAttributes redirectAttributes,HttpServletRequest request,HttpServletResponse response) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select id='zyid' name='zyId.id' path='zyId.id' style='width: 270px;' onchange='getBanJi(this.value);' >");
		if(zyJbxxs != null && zyJbxxs.size() > 0){
			sb.append("<option value=''>请选择</option>");
			for(ZyJbxx jbxx : zyJbxxs){
				if(jbxx.getId().equals(zyId)){
		     sb.append("<option selected='selected' value='"+jbxx.getId()+"'>"+jbxx.getZymc()+"</option>");
			
					
				}else{
		     sb.append("<option value='"+jbxx.getId()+"'>"+jbxx.getZymc()+"</option>");
				
				}
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}
	@ResponseBody
	@RequestMapping(value = "findZyListByLxId")
	public String findZyListByLxId(String id, RedirectAttributes redirectAttributes) {
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		Map m = new HashMap();
		m.put("zyJbxxList", zyJbxxs);
		return JsonMapper.toJsonString(m);
	}
}
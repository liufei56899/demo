/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsfb.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.bj.entity.BjJbxx;
import com.thinkgem.jeesite.modules.bj.service.BjJbxxService;
import com.thinkgem.jeesite.modules.sys.entity.Dict;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.xjxx.entity.XnJbxx;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;
import com.thinkgem.jeesite.modules.xsfb.entity.Fbxx;
import com.thinkgem.jeesite.modules.xsfb.service.FbxxService;
import com.thinkgem.jeesite.modules.xsfb.service.XsfbService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;

/**
 * 新生分班Controller
 * @author Controller
 * @version 2016-07-13
 */
@Controller
@RequestMapping(value = "${adminPath}/xsfb/xsfb")
public class XsfbController extends BaseController {

	@Autowired
	private XsfbService xsfbService;
	@Autowired
	private FbxxService fbxxService;
	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private ZyJbxxService zyJbxxService;
	@Autowired
	private BjJbxxService bjJbxxService;
	@Autowired
	private ZsdjService zsdjService;
	
	@ModelAttribute
	public BjJbxx get(@RequestParam(required=false) String id) {
		BjJbxx entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = xsfbService.get(id);
		}
		if (entity == null){
			entity = new BjJbxx();
		}
		return entity;
	}
	@RequiresPermissions("xsfb:xsfb:view")
	@RequestMapping(value = {"list", ""})
	public String list(Fbxx fbxx, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Fbxx> page = fbxxService.findPage(new Page<Fbxx>(request, response), fbxx); 
		List<Fbxx> list=page.getList();
		for(int i=0;i<list.size();i++){
			String bjid=list.get(i).getId();
			String yyrs=list.get(i).getYyxs();
			fbxxService.updateBjjbxx(bjid,yyrs);
		} 
		model.addAttribute("page", page);		
		return "modules/xsfb/xsfbList";
	}

	@RequiresPermissions("xsfb:xsfb:view")
	@RequestMapping(value={"form", "form"})	
	public String form(BjJbxx xsfb, Model model,String yyrs,HttpServletRequest request,
			HttpServletResponse response,String zsjhid) {
		model.addAttribute("xsfb", xsfb);
		model.addAttribute("yyrs", yyrs);
		ZyJbxx zy=new ZyJbxx();
		Zsdj zsdj=new Zsdj();
		zsdj.setZy(zy);
		zsdj.getZy().setZymc(xsfb.getZyId().getZymc());	
		zsdj.setZsdjzt("2");
		if(zsjhid!=null && zsjhid!=""){
			Zsjh zsjh=new Zsjh();
			zsjh.setId(zsjhid);
			zsdj.setZsjh(zsjh);	
		}
		model.addAttribute("zsjhid", zsjhid);
		Page<Zsdj> page = zsdjService.findPage(new Page<Zsdj>(request, response), zsdj); 
		model.addAttribute("page", page);
		return "modules/xsfb/xsfbForm";
	}
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "fb")
	public String fb(String id,Model model,String bjid){
		String [] xsid=null;
		if(id!=null && id!=""){
			xsid=id.split(",");
			for(String xsId :xsid){
				Zsdj zsdj = this.zsdjService.get(xsId);
				zsdj.setZsdjzt("3");
				XsJbxx xsJbxx= new XsJbxx();				
				xsJbxx.setJhid(zsdj.getJhId());
				xsJbxx.setXm(zsdj.getXm());
				BjJbxx bjjbxx=new BjJbxx();
				bjjbxx.setId(bjid);
				xsJbxx.setBjmc(bjjbxx);			
				xsJbxx.setNj(zsdj.getNj());
				xsJbxx.setXbm(zsdj.getXbm());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				xsJbxx.setCsrq(sdf.format(zsdj.getCsrq()));
				xsJbxx.setSfzjlxm(zsdj.getSfzjlx());
				xsJbxx.setSfzjh(zsdj.getSfzjh());
				xsJbxx.setXslbm(zsdj.getXslx());
				xsJbxx.setHkszdqxyxxxdz(zsdj.getJtzz());
				xsJbxx.setScpcs(zsdj.getQfjg());
				xsJbxx.setZyId(zsdj.getZy());
				xsJbxx.setZylxId(zsdj.getZylx());
				xsJbxx.setZyName(zsdj.getZy().getZymc());
				xsJbxx.setXz(zsdj.getXz());
				xsJbxx.setMzm(zsdj.getNation());
				xsJbxx.setXslym(zsdj.getXslym());
				xsJbxx.setByxx(zsdj.getFromSchool());
				xsJbxx.setLxdh(zsdj.getLxdh());
				xsJbxx.setZkzh(zsdj.getZkzh());
				xsJbxx.setShzt("3");			
				xsJbxx.setXnxq(zsdj.getXnxq().getId());
				xsJbxxService.save(xsJbxx);
				zsdjService.save(zsdj);
			}
		}	
		return "redirect:"+Global.getAdminPath()+"/xsfb/xsfb/?repage";		
	}
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "save")
	public String save(@RequestParam("weiFenBanIds") String weiFenBanIds,@RequestParam("yiFenBanIds") String yiFenBanIds,BjJbxx xsfb, Model model, RedirectAttributes redirectAttributes) {
		
		//未分班人数IDS
		String[] wfbIds = null;
		if(weiFenBanIds!=null && !"".equals(weiFenBanIds))
		{
			wfbIds = weiFenBanIds.split(",");
		}
		//已分班人数IDS
		String[] yfbIds = null;
		if(yiFenBanIds!=null && !"".equals(yiFenBanIds))
		{
			yfbIds = yiFenBanIds.split(",");
		}
		/******未分班学生*******/
		List<String> ids = new ArrayList<String>();
		if(wfbIds!=null && wfbIds.length>0)
		{
			for(String id :wfbIds)
			{
				XsJbxx xsJbxx = this.xsJbxxService.get(id);
				if(xsJbxx.getBjmc()!=null)
				{
					ids.add(id);
				}
			}
		}
		
		if(ids!=null && ids.size()>0)
		{
			Map<String,Object> map = new HashMap<String,Object>();
			map.put("idList", ids);
			map.put("name", null);
			this.xsJbxxService.updateBanJi(map);
		}
		
		
		/****************已分班学生*******************/
		List<String> idsList = new ArrayList<String>();
		if(yfbIds!=null && yfbIds.length>0)
		{
			for(String id :yfbIds)
			{
				XsJbxx xsJbxx = this.xsJbxxService.get(id);
				if(xsJbxx.getBjmc()==null || (xsJbxx.getBjmc().getId() !=xsfb.getId() && !xsfb.getId().equals(xsJbxx.getBjmc().getId())) )
				{
					idsList.add(id);
				}
			}
		}
		
		if(idsList!=null && idsList.size()>0)
		{
			Map<String,Object> map1 = new HashMap<String,Object>();
			map1.put("idList", idsList);
			map1.put("name", xsfb.getId());
			this.xsJbxxService.updateBanJi(map1);
		}
		
		addMessage(redirectAttributes, "本次成功给"+idsList.size()+"人分班");
		return "redirect:"+Global.getAdminPath()+"/xsfb/xsfb/?repage";
	}
	/*@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "delete")
	public String delete(BjJbxx xsfb, RedirectAttributes redirectAttributes) {
		xsfbService.delete(xsfb);
		addMessage(redirectAttributes, "删除新生分班成功"); xueShengIds,
		return "redirect:"+Global.getAdminPath()+"/xsfb/xsfb/?repage";
	}*/
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "saveXueShengFb")
	public String saveXueShengFb(@RequestParam("xueShengIds") String xueShengIds,BjJbxx xsfb, Model model, RedirectAttributes redirectAttributes)
	{
		List<String> idsList = new ArrayList<String>();
		String[] idArr = xueShengIds.split(",");
		for(String id : idArr)
		{
			idsList.add(id);
		}
		
		if(idsList!=null && idsList.size()>0)
		{
			Map<String,Object> map1 = new HashMap<String,Object>();
			map1.put("idList", idsList);
			map1.put("name", xsfb.getId());
			map1.put("njId", bjJbxxService.get(xsfb.getId()).getNjid().getId());
			this.xsJbxxService.updateBanJi(map1);
		}
		addMessage(redirectAttributes, "本次成功给"+idsList.size()+"人分班");
		return "redirect:"+Global.getAdminPath()+"/xsfb/xsfb/?repage";
	}
	
	
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "xueShengFenBan")
	public String xueShengFenBan(BjJbxx xsfb,String ids,String zyid, Model model, RedirectAttributes redirectAttributes)
	{
		/*List<BjJbxx> bjList = this.xsfbService.findList(xsfb);
		model.addAttribute("bjJbxx", bjList.get(0));
		//学生
		XsJbxx xsJbxx= new XsJbxx();
		//未分班学生
		List<XsJbxx> weiFenBanList = xsJbxxService.findXueShengListByBj(xsJbxx);
		model.addAttribute("weiFenBanList", weiFenBanList);
		BjJbxx bjJbxx = bjList.get(0);
		xsJbxx.setBjmc(bjJbxx);
		//已分班学生
		List<XsJbxx> yiFenBanList = xsJbxxService.findXueShengListByBj(xsJbxx);
		model.addAttribute("yiFenBanList", yiFenBanList);*/
		/*ZyJbxx zyJbxx = new ZyJbxx();
		zyJbxx.setId(zyid);
		xsfb.setZyId(zyJbxx);
		List<BjJbxx> bjList = this.xsfbService.findList(xsfb);*/
		List<XnJbxx> list = bjJbxxService.findAll();
		String year = DateUtils.getYear();
		for (int i = 0; i < list.size(); i++) {
			if (year.equals(list.get(i).getNf()+"")) {
				list.get(i).setRemarks("1");
			}
		}
		model.addAttribute("nf", list);
		model.addAttribute("zyid", zyid);
		model.addAttribute("ids", ids);
		
		return "modules/xsfb/xsfbForm";
	}
	
	
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "getBanJiInfo")
	public String getBanJiInfo(BjJbxx xsfb)
	{
		Map map = new HashMap();
		List<BjJbxx> bjList = this.xsfbService.findList(xsfb);
		BjJbxx bjxx = bjList.get(0);
		map.put("bjxx", bjxx);
		return JsonMapper.toJsonString(map);
	}
	
	//根据年份查班级
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "getBanJi")
	public String getBanJi(String njid,String zyid)
	{
		XnJbxx xnJbxx = new XnJbxx ();
		xnJbxx.setId(njid);
		xnJbxx.setRemarks(zyid);
		List<BjJbxx> list = bjJbxxService.findAllBJ(xnJbxx);
	
		return JsonMapper.toJsonString(list);
	}
	
	/**
	 * Des:学生学籍信息
	 * 2016-9-19
	 * @author fn
	 * @param xsJbxx
	 * @param model
	 * @return
	 * String
	 */
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "getXueShengInfo")
	public String getXueShengInfo(XsJbxx xsJbxx, Model model)
	{
		xsJbxx = this.xsJbxxService.get(xsJbxx.getId());
		ZyJbxx jbxx = zyJbxxService.get(xsJbxx.getZyId().getId());
		if(xsJbxx.getZyfx()==null||xsJbxx.getZyfx()==""){
			xsJbxx.setZyfx(jbxx.getZyfxmc());
		}
		if(xsJbxx.getZyjc()==null||xsJbxx.getZyjc()==""){
			xsJbxx.setZyjc(jbxx.getZyjc());
		}
		model.addAttribute("xsJbxx", xsJbxx);
		/*System.out.println(jbxx.getZyjc()+"    mmmmmm    "+jbxx.getZyfxmc());
		System.out.println(xsJbxx.getZyfx()+"    vvvvvvvv    "+xsJbxx.getZyjc());*/
		return "modules/xsfb/xsInfoForm";
	}
	
	
	/**
	 * Des:学生学籍信息
	 * 2017-5-11
	 * @author mhf
	 * @param xsJbxx
	 * @param model
	 * @return
	 * String
	 */
	/*@ResponseBody*/
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "getXsInfo")
	public String getXsInfo(XsJbxx xsJbxx, Model model)
	{
		xsJbxx = this.xsJbxxService.get(xsJbxx.getId());
		ZyJbxx jbxx = zyJbxxService.get(xsJbxx.getZyId().getId());
		if(xsJbxx.getZyfx()==null||xsJbxx.getZyfx()==""){
			xsJbxx.setZyfx(jbxx.getZyfxmc());
		}
		if(xsJbxx.getZyjc()==null||xsJbxx.getZyjc()==""){
			xsJbxx.setZyjc(jbxx.getZyjc());
		}
		System.out.println(xsJbxx.getBjmc().getBjmc()+"==========="+xsJbxx.getNewBjmc());
		model.addAttribute("xsJbxx", xsJbxx);
		/*System.out.println(jbxx.getZyjc()+"    mmmmmm    "+jbxx.getZyfxmc());
		System.out.println(xsJbxx.getZyfx()+"    vvvvvvvv    "+xsJbxx.getZyjc());*/
		return "modules/xsfb/stuInfoForm";
	}
	
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "getChengYuanInfo")
	public String getChengYuanInfo(XsJbxx xsJbxx, Model model)
	{
		xsJbxx = this.xsJbxxService.get(xsJbxx.getId());
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xsfb/xscyInfoForm";
		
	}
	
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "getXueShengTab")
	public String getXueShengTab(XsJbxx xsJbxx, Model model)
	{
		model.addAttribute("id", xsJbxx.getId());
		return "modules/xsfb/xsInfoTab";
	}
	/**
	 * Des:学生基本信息
	 * 2016-9-19
	 * @author fn
	 * @param xsJbxx
	 * @param model
	 * @return
	 * String
	 */
	@RequiresPermissions("xsfb:xsfb:edit")
	@RequestMapping(value = "getBaoMingDengJiInfo")
	public String getBaoMingDengJiInfo(XsJbxx xsJbxx, Model model)
	{
		xsJbxx = this.xsJbxxService.get(xsJbxx.getId());
		model.addAttribute("xsJbxx", xsJbxx);
		return "modules/xsfb/xsBaoMingForm";
	}
	
	
	
	
	
	
	
	

}
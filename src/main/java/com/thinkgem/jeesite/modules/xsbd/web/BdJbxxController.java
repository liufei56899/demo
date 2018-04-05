/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.xsbd.web;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import sun.misc.BASE64Decoder;

import com.sun.tools.javac.util.List;
import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.CommonUtils;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.js.entity.JsJbxx;
import com.thinkgem.jeesite.modules.js.service.JsJbxxService;
import com.thinkgem.jeesite.modules.sys.utils.DictUtils;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xnxq.service.XnxqJbxxService;
import com.thinkgem.jeesite.modules.xs.entity.XsJbxx;
import com.thinkgem.jeesite.modules.xs.service.XsJbxxService;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;
import com.thinkgem.jeesite.modules.xsbd.service.BdJbxxService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;

/**
 * 新生报到Controller
 * @author xfb_20161206
 * @version 2016-12-06
 */
@Controller
@RequestMapping(value = "${adminPath}/xsbd/bdJbxx")
public class BdJbxxController extends BaseController {

	@Autowired
	private BdJbxxService bdJbxxService;
	@Autowired
	private XsJbxxService xsJbxxService;
	@Autowired
	private JsJbxxService jsJbxxService;
	
	@Autowired
	private ZsdjService zsdjService;
	@Autowired
	private ZyJbxxService zyJbxxService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private XnxqJbxxService xnxqJbxxService;
	
	
	@ModelAttribute
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
	
	@RequiresPermissions("xsbd:bdJbxx:view")
	@RequestMapping(value = {"list", ""})
	public String list(BdJbxx bdJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*Page<BdJbxx> page = bdJbxxService.findPage(new Page<BdJbxx>(request, response), bdJbxx); 
		model.addAttribute("page", page);*/
		return "modules/xsbd/bdJbxxList";
	}
	
	//2017-6-21新加报名登记（复制之前报到注册）
	@RequiresPermissions("xsbd:bdJbxx:view")
	@RequestMapping(value = {"list2", ""})
	public String list2(BdJbxx bdJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*Page<BdJbxx> page = bdJbxxService.findPage(new Page<BdJbxx>(request, response), bdJbxx); 
		model.addAttribute("page", page);*/
		return "modules/xsbd/bdJbxxList4";
	}
	
	//2017-9-5  报名登记页面根据建材工业学校修改身份证页面读取数据（复制之前报到注册）
	@RequiresPermissions("xsbd:bdJbxx:view")
	@RequestMapping(value = {"list3", ""})
	public String list3(BdJbxx bdJbxx, HttpServletRequest request, HttpServletResponse response, Model model) {
		/*Page<BdJbxx> page = bdJbxxService.findPage(new Page<BdJbxx>(request, response), bdJbxx); 
		model.addAttribute("page", page);*/
		return "modules/xsbd/bdJbxxList3";
	}
	
	/**
	 * Des:报到注册查询
	 * 2016-12-13
	 * @author fn
	 * @param bdJbxx
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * String
	 */
	@RequiresPermissions("xsbd:bdJbxx:view")
	@RequestMapping(value = {"bdlist", ""})
	public String bdlist(BdJbxx bdJbxx, HttpServletRequest request, HttpServletResponse response, Model model)
	{
		Page<BdJbxx> page = bdJbxxService.findPage(new Page<BdJbxx>(request, response), bdJbxx); 
		model.addAttribute("page", page);
		return "modules/xsbd/bdList";
	}

	@RequiresPermissions("xsbd:bdJbxx:view")
	@RequestMapping(value = "form")
	public String form(BdJbxx bdJbxx, Model model) {
		model.addAttribute("bdJbxx", bdJbxx);
		return "modules/xsbd/bdJbxxForm";
	}

	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "save")
	public String save(BdJbxx bdJbxx,String saveZsdj, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bdJbxx)){
			return form(bdJbxx, model);
		}
		//System.out.println("dsfvffsffffffffffffffffffffffffffffffffffffffffff"+saveZsdj);
		
		BdJbxx bdJbxx1=new BdJbxx();
		bdJbxx1=bdJbxxService.getBdJbxxBySfzh(bdJbxx);
		if(bdJbxx1!=null){
			bdJbxx.setId(bdJbxx1.getId());
		}
		
		bdJbxx.setPhoto("/em/upload/images/"+bdJbxx.getSfzjh()+".jpg");
		bdJbxx.setJfzt(CommonUtils.SYS_FOU);
		
		
//		Zsdj zsdj=(Zsdj)JsonMapper.fromJsonString(saveZsdj, Zsdj.class);
		Zsdj zsdj=new Zsdj();
		zsdj.setId(saveZsdj);
		zsdj=zsdjService.get(zsdj);
		//System.out.println("======================"+zsdj.getXz()+"+++++++++"+zsdj.getZy().getXz());
		zsdj.setXm(bdJbxx.getXm());
		zsdj.setXbm(bdJbxx.getXbm());
		zsdj.setSfzjh(bdJbxx.getSfzjh());
		zsdj.setNation(bdJbxx.getNation());
		zsdj.setSfzjlx(bdJbxx.getSfzjlx());
		zsdj.setCsrq(bdJbxx.getCsrq());
		if(bdJbxx.getSf()!=null&&bdJbxx.getSf().length()!=0){
			zsdj.setSf(bdJbxx.getSf());
		}
		if(bdJbxx.getCs()!=null&&bdJbxx.getCs().length()!=0){
			zsdj.setCs(bdJbxx.getCs());
		}
		if(bdJbxx.getQx()!=null&&bdJbxx.getQx().length()!=0){
			zsdj.setQx(bdJbxx.getQx());
		}
		if(bdJbxx.getFromSchool()!=null&&bdJbxx.getFromSchool().length()!=0){
			zsdj.setFromSchool(bdJbxx.getFromSchool());
		}
		zsdj.setZsdjzt(CommonUtils.YIBAOMING);
		if(bdJbxx.getLxdh()!=null&&bdJbxx.getLxdh().length()!=0){
			zsdj.setLxdh(bdJbxx.getLxdh());
		}
		if(bdJbxx.getZyId()!=null){
		zsdj.setZylx(bdJbxx.getZyId());
		}
		ZyJbxx zy=zyJbxxService.get(bdJbxx.getZylxId());
		
		//System.out.println(bdJbxx.getZylxId()+"+++++"+bdJbxx.getZyId()+"====="+zy.getZymc());
		if(bdJbxx.getZylxId()!=null&&bdJbxx.getZylxId()!=""){
		zsdj.getZy().setId(bdJbxx.getZylxId());
		}
		if(zy!=null&&zy.getXz()!=""){
			
			zsdj.setXz(zy.getXz());
		}
		zsdj.setJtzz(bdJbxx.getJtzz());//更新招生登记表里的家庭住址
		zsdjService.save(zsdj);
		bdJbxx.setLxdh(zsdj.getLxdh());
		bdJbxx.setZsjh(zsdj.getZsjh());
		bdJbxx.setLy(zsdj.getLy());
		bdJbxx.setJs(zsdj.getJs());
		bdJbxxService.save(bdJbxx);
		
		addMessage(redirectAttributes, "保存新生报到成功");
		return "redirect:"+Global.getAdminPath()+"/xsbd/bdJbxx/list?repage";
	}
	
	//2017-6-21新加的报名登记页面提交保存方法（复制之前的save方法）
	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "save2")
	public String save2(BdJbxx bdJbxx,String JSID, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, bdJbxx)){
			return form(bdJbxx, model);
		}
		bdJbxx.setPhoto("/em/upload/images/"+bdJbxx.getSfzjh()+".jpg");
		bdJbxx.setJfzt(CommonUtils.SYS_FOU);

		Zsdj zsdj=new Zsdj();
		zsdj.setXm(bdJbxx.getXm());
		zsdj.setXbm(bdJbxx.getXbm());
		zsdj.setSfzjh(bdJbxx.getSfzjh());
		zsdj.setNation(bdJbxx.getNation());
		zsdj.setSfzjlx(bdJbxx.getSfzjlx());
		zsdj.setCsrq(bdJbxx.getCsrq());
		if(bdJbxx.getBkcc()!=null&&bdJbxx.getBkcc().length()!=0){
			zsdj.setBkcc(bdJbxx.getBkcc());
		}
		if(bdJbxx.getYyxykszsdj()!=null&&bdJbxx.getYyxykszsdj().length()!=0){
			zsdj.setYyxykszsdj(bdJbxx.getYyxykszsdj());
		}
		if(bdJbxx.getYyxukszscj()!=null&&bdJbxx.getYyxukszscj().length()!=0){
			zsdj.setYyxykszsdj(bdJbxx.getYyxukszscj());
		}
		if(bdJbxx.getIsyyjb()!=null&&bdJbxx.getIsyyjb().length()!=0){
			zsdj.setIsyyjb(bdJbxx.getIsyyjb());
		}
		if(bdJbxx.getJbzylxid()!=null&&bdJbxx.getJbzylxid().length()!=0){
			zsdj.setJbzylxid(bdJbxx.getJbzylxid());
		}
		if(bdJbxx.getJbzyid()!=null&&bdJbxx.getJbzyid().length()!=0){
			zsdj.setJbzyid(bdJbxx.getJbzyid());
		}
		if(bdJbxx.getJbxz()!=null&&bdJbxx.getJbxz().length()!=0){
			zsdj.setJbxz(bdJbxx.getJbxz());
		}
		if(bdJbxx.getIsdszcks()!=null&&bdJbxx.getIsdszcks().length()!=0){
			zsdj.setIsdszcks(bdJbxx.getIsdszcks());
		}
		if(bdJbxx.getXxdate1()!=null&&bdJbxx.getXxdate1().length()!=0){
			zsdj.setXxdate1(bdJbxx.getXxdate1());
		}
		if(bdJbxx.getJdxy1()!=null&&bdJbxx.getJdxy1().length()!=0){
			zsdj.setJdxy1(bdJbxx.getJdxy1());
		}
		if(bdJbxx.getXxdate2()!=null&&bdJbxx.getXxdate2().length()!=0){
			zsdj.setXxdate2(bdJbxx.getXxdate2());
		}
		if(bdJbxx.getJdxy2()!=null&&bdJbxx.getJdxy2().length()!=0){
			zsdj.setJdxy2(bdJbxx.getJdxy2());
		}
		if(bdJbxx.getXxdate3()!=null&&bdJbxx.getXxdate3().length()!=0){
			zsdj.setXxdate3(bdJbxx.getXxdate3());
		}
		if(bdJbxx.getJdxy3()!=null&&bdJbxx.getJdxy3().length()!=0){
			zsdj.setJdxy3(bdJbxx.getJdxy3());
		}
		if(bdJbxx.getSf()!=null&&bdJbxx.getSf().length()!=0){
			zsdj.setSf(bdJbxx.getSf());
		}
		if(bdJbxx.getCs()!=null&&bdJbxx.getCs().length()!=0){
			zsdj.setCs(bdJbxx.getCs());
		}
		if(bdJbxx.getQx()!=null&&bdJbxx.getQx().length()!=0){
			zsdj.setQx(bdJbxx.getQx());
		}
		if(bdJbxx.getFromSchool()!=null&&bdJbxx.getFromSchool().length()!=0){
			zsdj.setFromSchool(bdJbxx.getFromSchool());
		}
		zsdj.setZsdjzt("0");
		if(bdJbxx.getLxdh()!=null&&bdJbxx.getLxdh().length()!=0){
			zsdj.setLxdh(bdJbxx.getLxdh());
		}
		if(bdJbxx.getZyId()!=null){
			zsdj.setZylx(bdJbxx.getZyId());
		}
		ZyJbxx zy=zyJbxxService.get(bdJbxx.getZylxId());
		zsdj.setZy(zy);
		if(zy!=null&&zy.getXz()!=""){
			zsdj.setXz(zy.getXz());
		}
		zsdj.setJs(bdJbxx.getJs());
		zsdj.setOffice(UserUtils.get(bdJbxx.getJs().getId()).getOffice());//招生教师所属部门
		zsdj.setZsjh(bdJbxx.getZsjh());
		Zsjh zsjh = zsjhService.get(bdJbxx.getZsjh().getId());
		zsdj.setXnxq(zsjh.getNf());
		zsdj.setLxdh(bdJbxx.getLxdh());
		zsdj.setJtzz(bdJbxx.getJtzz());//更新招生登记表里的家庭住址
		zsdj.setLy("1");
		zsdj.setCreateDate(new Date());
		if (bdJbxx.getXslym()!=null) {
			zsdj.setXslym(bdJbxx.getXslym());
		}
		if (bdJbxx.getZkzh()!=null) {
			zsdj.setZkzh(bdJbxx.getZkzh());
		}
		if (bdJbxx.getXslx()!=null) {
			zsdj.setXslx(bdJbxx.getXslx());
		}
		zsdjService.save(zsdj);
		bdJbxx.setLy(zsdj.getLy());
		bdJbxxService.save(bdJbxx);
		
		addMessage(redirectAttributes, "保存新生报到成功");
		return "redirect:"+Global.getAdminPath()+"/xsbd/bdJbxx/list2";
	}
	
	//2017-6-21新加的报名登记页面提交保存方法（复制之前的save方法）
		@RequiresPermissions("xsbd:bdJbxx:edit")
		@RequestMapping(value = "save3")
		public String save3(BdJbxx bdJbxx,String JSID, Model model, RedirectAttributes redirectAttributes) {
			if (!beanValidator(model, bdJbxx)){
				return form(bdJbxx, model);
			}
			bdJbxx.setPhoto("/em/upload/images/"+bdJbxx.getSfzjh()+".jpg");
			bdJbxx.setJfzt(CommonUtils.SYS_FOU);

			Zsdj zsdj=new Zsdj();
			zsdj.setXm(bdJbxx.getXm());
			zsdj.setXbm(bdJbxx.getXbm());
			zsdj.setSfzjh(bdJbxx.getSfzjh());
			zsdj.setNation(bdJbxx.getNation());
			zsdj.setSfzjlx(bdJbxx.getSfzjlx());
			zsdj.setCsrq(bdJbxx.getCsrq());
			zsdj.setBj(bdJbxx.getBj());
			if(bdJbxx.getSf()!=null&&bdJbxx.getSf().length()!=0){
				zsdj.setSf(bdJbxx.getSf());
			}
			if(bdJbxx.getCs()!=null&&bdJbxx.getCs().length()!=0){
				zsdj.setCs(bdJbxx.getCs());
			}
			if(bdJbxx.getQx()!=null&&bdJbxx.getQx().length()!=0){
				zsdj.setQx(bdJbxx.getQx());
			}
			if(bdJbxx.getFromSchool()!=null&&bdJbxx.getFromSchool().length()!=0){
				zsdj.setFromSchool(bdJbxx.getFromSchool());
			}
			zsdj.setZsdjzt(CommonUtils.YIBAOMING);
			if(bdJbxx.getLxdh()!=null&&bdJbxx.getLxdh().length()!=0){
				zsdj.setLxdh(bdJbxx.getLxdh());
			}
			if(bdJbxx.getZyId()!=null){
				zsdj.setZylx(bdJbxx.getZyId());
			}
			ZyJbxx zy=zyJbxxService.get(bdJbxx.getZylxId());
			zsdj.setZy(zy);
			if(zy!=null&&zy.getXz()!=""){
				zsdj.setXz(zy.getXz());
			}
			zsdj.setJs(bdJbxx.getJs());
			//zsdj.setOffice(UserUtils.get(bdJbxx.getJs().getId()).getOffice());//招生教师所属部门
			zsdj.setZsjh(bdJbxx.getZsjh());
			//Zsjh zsjh = zsjhService.get(bdJbxx.getZsjh().getId());
			//zsdj.setXnxq(zsjh.getNf());
			zsdj.setLxdh(bdJbxx.getLxdh());
			zsdj.setJtzz(bdJbxx.getJtzz());//更新招生登记表里的家庭住址
			zsdj.setLy("1");
			zsdj.setCreateDate(new Date());
			if (bdJbxx.getXslym()!=null) {
				zsdj.setXslym(bdJbxx.getXslym());
			}
			if (bdJbxx.getZkzh()!=null) {
				zsdj.setZkzh(bdJbxx.getZkzh());
			}
			if (bdJbxx.getXslx()!=null) {
				zsdj.setXslx(bdJbxx.getXslx());
			}
			zsdjService.save(zsdj);
			bdJbxx.setLy(zsdj.getLy());
			bdJbxxService.save(bdJbxx);
			
			addMessage(redirectAttributes, "保存新生报到成功");
			return "redirect:"+Global.getAdminPath()+"/xsbd/bdJbxx/list3";
		}
	
	
	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "delete")
	public String delete(BdJbxx bdJbxx, RedirectAttributes redirectAttributes) {
		bdJbxxService.delete(bdJbxx);
		addMessage(redirectAttributes, "删除新生报到成功");
		return "redirect:"+Global.getAdminPath()+"/xsbd/bdJbxx/?repage";
	}

	
	
	/**
	 * Des:批量删除
	 * 2016-5-19
	 * @author st
	 * @param ids 新生报到IDS 多个用逗号隔开
	 * @param redirectAttributes
	 * @return
	 * String
	 */
	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "piLiangDelete")
	public String piLiangDelete(String ids, RedirectAttributes redirectAttributes)
	{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			BdJbxx bdJbxx = new BdJbxx();
			bdJbxx.setId(idArr[i]);
			bdJbxxService.delete(bdJbxx);
		}
		addMessage(redirectAttributes, "删除新生报到成功");
		return "redirect:"+Global.getAdminPath()+"/xsbd/bdJbxx/?repage";
	}
	
	/**
	 * Des: 根据专业类别获取专业
	 * 2016-5-18
	 * @author st
	 * @param zhuanYeLeiXingId 专业类别ID
	 * @return
	 * List<ZyJbxx>
	 */
	@ResponseBody
	@RequestMapping(value = "getZhuanYe")
	public List<ZyJbxx> getZhuanYeList(String zhuanYeLeiXingId)
	{
		ZyJbxx jbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(zhuanYeLeiXingId);
		jbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = (List<ZyJbxx>) zyJbxxService.findList(jbxx);
		StringBuffer sb = new StringBuffer();
		return zyJbxxs;
	}
	/**
	 * 图片上传
	 * @param request
	 * @param photoName
	 * @return
	 */
	public boolean uploadPhoto(HttpServletRequest request,String photoName){
		boolean flag = true;
		MultipartFile multipartFile=null;
		String savePath = request.getSession().getServletContext().getRealPath("/static/photo/");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map m = multipartRequest.getFileMap();
		
		Set set=m.keySet();//用接口实例接口
		Iterator iter = set.iterator();
		//File file=null;
		while (iter.hasNext()) {//遍历二次,速度慢
			String k=(String)iter.next();
			multipartFile = (MultipartFile) m.get(k);
		}
		if(multipartFile==null || multipartFile.getSize()<=0){
			return true;
		}
	   CommonsMultipartFile cf= (CommonsMultipartFile)multipartFile; 
	   DiskFileItem fi = (DiskFileItem)cf.getFileItem(); 
	   File fp  = fi.getStoreLocation();
	   String type = multipartFile.getOriginalFilename();
	   type = type.split("\\.")[1];
	   String fileName = photoName+"."+type;
	   File f = fi.getStoreLocation();
	   // 获得文件名：   
	   String filen = f.getName();
	        // 获得输入流：   
	        try {
				InputStream input = multipartFile.getInputStream();
				SaveFileFromInputStream(input,savePath,fileName);
			} catch (IOException e) {
				flag = false;
			}   
		return flag; 
	}
	
	public void SaveFileFromInputStream(InputStream stream,String path,String filename) throws IOException {      
        FileOutputStream fs=new FileOutputStream( path + "/"+ filename); 
        byte[] buffer =new byte[1024*1024]; 
        int bytesum = 0; 
        int byteread = 0; 
        while ((byteread=stream.read(buffer))!=-1) 
        { 
           bytesum+=byteread; 
           fs.write(buffer,0,byteread); 
           fs.flush(); 
        } 
        fs.close(); 
        stream.close();      
    }      
	
	/**
	 * Des:修改学生缴费状态 同时向学生表中添加一条数据
	 * 2016-5-23
	 * @author st
	 * @param bdJbxx
	 * @param redirectAttributes
	 * @return
	 * String
	 */
	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "xinShengJiaoFei")
	public String xinShengJiaoFei(BdJbxx bdJbxx,RedirectAttributes redirectAttributes)
	{
		bdJbxx.setJfzt(CommonUtils.SYS_SHI);//缴费状态 
		bdJbxxService.save(bdJbxx);
		//学生信息
		XsJbxx xsJbxx = new XsJbxx();
		xsJbxx.setXm(bdJbxx.getXm());//姓名
		xsJbxx.setXbm(bdJbxx.getXbm());//性别
		xsJbxx.setCsrq(DateUtils.getStrDateTime(bdJbxx.getCsrq()));//出生日期
		xsJbxx.setSfzjh(bdJbxx.getSfzjh());//身份证
		
		xsJbxx.getZyId().setId(bdJbxx.getZylxId());;//专业
		
		xsJbxx.setZylxId(bdJbxx.getZyId());//专业类别
		
		xsJbxx.setShzt("3");
		xsJbxxService.save(xsJbxx);
		addMessage(redirectAttributes, "缴费成功");
		return "redirect:"+Global.getAdminPath()+"/xsjf/xsjfjbxx/?repage";
	}
	
	@RequiresPermissions("xsbd:bdJbxx:edit")
	@RequestMapping(value = "piLiangJiaoFei")
	public String piLiangJiaoFei(String ids,String yiJiaoFeiNum,String weiJiaoFeiNum,RedirectAttributes redirectAttributes)
	{
		String[] idArr = ids.split(",");
		for(int i=0;i<idArr.length;i++)
		{
			BdJbxx bdJbxx =this.get(idArr[i]);
			bdJbxx.setJfzt(CommonUtils.SYS_SHI);//缴费状态 
			bdJbxxService.save(bdJbxx);
			
			//学生缴费同时 将登记表中招生登记状态改成 已缴费状态
//			Zsdj zsdj = new Zsdj();
//			zsdj.setSfzjh(bdJbxx.getSfzjh());
//			Zsdj zsdjEntity =zsdjService.getZsdjBySfzh(zsdj);
//			if(zsdjEntity!=null)
//			{
//				zsdjEntity.setZsdjzt(CommonUtils.yiJiaoFei);//已缴费状态
//				zsdjService.save(zsdjEntity);
//			}
			
			//学生信息
			XsJbxx xsJbxx = new XsJbxx();
			xsJbxx.setXm(bdJbxx.getXm());//姓名
			xsJbxx.setXbm(bdJbxx.getXbm());//性别
			xsJbxx.setCsrq(DateUtils.getStrDateTime(bdJbxx.getCsrq()));//出生日期
			xsJbxx.setSfzjh(bdJbxx.getSfzjh());//身份证
			xsJbxx.setSfzjlxm(bdJbxx.getSfzjlx());//身份证件类型
			xsJbxx.setMzm(bdJbxx.getNation());//民族
			xsJbxx.setLxdh(bdJbxx.getLxdh());//联系电话
			
//			xsJbxx.getZyId().setId(bdJbxx.getZylxId());;//专业
//			xsJbxx.setZylxId(bdJbxx.getZyId());//专业类别
			
			ZyJbxx zy=zyJbxxService.get(bdJbxx.getZylxId());
			xsJbxx.setZyId(zy);//专业
			xsJbxx.setXz(zy.getXz());//学制

			xsJbxx.setZylxId(bdJbxx.getZyId());//专业类别
			//xsJbxx.setZyId(bdJbxx.getZyId());//专业
			//xsJbxx.setZylxId(bdJbxx.getZylxId());//专业类别
			
			Zsjh jh=zsjhService.get(bdJbxx.getZsjh().getId());
			XnxqJbxx nf=xnxqJbxxService.get(jh.getNf().getId());
			xsJbxx.setZsjj(nf.getXq());//招生季节
			xsJbxx.setZssyd(DictUtils.getAreaName(bdJbxx.getSf())//生源地区
					+DictUtils.getAreaName(bdJbxx.getCs())
					+DictUtils.getAreaName(bdJbxx.getQx())
					+DictUtils.getAreaName(bdJbxx.getJd()));
			xsJbxx.setPhoto(bdJbxx.getPhoto());
			
			xsJbxx.setShzt("3");
			xsJbxxService.save(xsJbxx);
		}
		addMessage(redirectAttributes, "已成功缴费"+weiJiaoFeiNum+"人!");
		return "redirect:"+Global.getAdminPath()+"/xsjf/xsjfjbxx/?repage";
	}
	
	@ResponseBody
	@RequestMapping(value = "generateImage")
	public String generateImage(@RequestParam("imgStr") String imgStr,@RequestParam("sfzjh") String sfzjh,HttpServletRequest request)
	{
		String imgFilePath =request.getSession().getServletContext().getRealPath("/") + "upload" + "/images/";
		File uploadDir = new File(imgFilePath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}
		imgFilePath += sfzjh+".jpg";
		boolean ret=true;
		Map<String,Object> map = new HashMap<String, Object>();
		if(imgStr==null)
		{
			ret= false;
			map.put("ret", ret);
			return JsonMapper.toJsonString(map);
		}
		BASE64Decoder decoder = new BASE64Decoder();
		try {
			byte[] bytes = decoder.decodeBuffer(imgStr);
			for (int i = 0; i < bytes.length; ++i)
			{
				if (bytes[i] < 0)// 调整异常数据
				{
					bytes[i] += 256;
				}
			}
			// 生成jpeg图片
			OutputStream out = new FileOutputStream(imgFilePath);
			out.write(bytes);
			out.flush();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			map.put("ret", ret);
			return JsonMapper.toJsonString(map);
		}
		return JsonMapper.toJsonString(map);
	}

}
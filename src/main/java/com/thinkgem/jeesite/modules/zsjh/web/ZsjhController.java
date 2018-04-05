package com.thinkgem.jeesite.modules.zsjh.web;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.thinkgem.jeesite.common.config.Global;
import com.thinkgem.jeesite.common.mapper.JsonMapper;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.CommonUtils;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.bmfpjl.entity.BmFpJl;
import com.thinkgem.jeesite.modules.bmfpjl.entity.BmFpJlObject;
import com.thinkgem.jeesite.modules.bmfpjl.service.BmFpJlService;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrService;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.Office;
import com.thinkgem.jeesite.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.OfficeService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.xnxq.entity.XnxqJbxx;
import com.thinkgem.jeesite.modules.xsbd.entity.BdJbxx;
import com.thinkgem.jeesite.modules.xsbd.service.BdJbxxService;
import com.thinkgem.jeesite.modules.zsdj.entity.Zsdj;
import com.thinkgem.jeesite.modules.zsdj.service.ZsdjService;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.entity.ZsjhRecord;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;
import com.thinkgem.jeesite.modules.zszy.entity.JhZyInfo;
import com.thinkgem.jeesite.modules.zszy.service.JhZyInfoService;
import com.thinkgem.jeesite.modules.zy.entity.ZyJbxx;
import com.thinkgem.jeesite.modules.zy.service.ZyJbxxService;
import com.thinkgem.jeesite.modules.zylx.entity.ZylxJbxx;
import com.thinkgem.jeesite.modules.zylx.service.ZylxJbxxService;

/**
 * 计划招生Controller
 * 
 * @author zw
 * @version 2016-04-25
 */
@Controller
@RequestMapping(value = "${adminPath}/zsjh/zsjh")
public class ZsjhController extends BaseController {

	@Autowired
	private JhFjGrService jhFjGrService;
	@Autowired
	private JhFjService jhFjService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private BmFpJlService bmFpJlService;
	@Autowired
	private OfficeService officeService;
	@Autowired
	private AreaService areaService;
	@Autowired
	private ZylxJbxxService zylxJbxxService;
	@Autowired
	private ZyJbxxService zyJbxxService;
	@Autowired
	private JhZyInfoService jhZyInfoService;
	@Autowired
	private ZsdjService zsdjService;
	@Autowired
	private BdJbxxService bdJbxxService;
	@Autowired
	private ZsjhRecordController zsjhRecordController;

	@ModelAttribute
	public Zsjh get(@RequestParam(required = false) String id) {
		Zsjh entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = zsjhService.get(id);
		}
		if (entity == null) {
			entity = new Zsjh();
		}
		return entity;
	}

	/*
	 * 获取启用的招生计划列表
	 */
	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = { "list", "list" })
	public String list(Zsjh zsjh, HttpServletRequest request,
			HttpServletResponse response, Model model) {		zsjh.setDqdlr(UserUtils.getUser().getId());
		Page<Zsjh> page = zsjhService.findPage(new Page<Zsjh>(request, response), zsjh);
		model.addAttribute("page", page);
		return "modules/zsjh/zsjhList";
	}

	/**
	 * Des:统计审核中的招生计划、分解任务到部门、分解任务到个人数据 2016-10-28
	 * 
	 * @author fn
	 * @param request
	 * @param response
	 * @param model
	 * @return String
	 */
	@ResponseBody
	@RequestMapping(value = "getShdbsx", method = RequestMethod.GET)
	public String getShdbsx(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Zsjh zsjh = new Zsjh();
		zsjh.setZt("1");
		// 审核中的招生计划
		List<Zsjh> zsjhList = zsjhService.findList(zsjh);

		// 审核中的分解任务到部门
		JhFj jhfj = new JhFj();
		jhfj.setBcStatus("0");
		List<JhFj> jhFjList = jhFjService.findList(jhfj);

		// 审核中分解任务到个人
		JhFjGr jhfjgr = new JhFjGr();
		jhfjgr.setBcStatus("0");
		List<JhFjGr> grList = jhFjGrService.findList(jhfjgr);

		int dbCount = 0;
		if (zsjhList != null && zsjhList.size() > 0) {
			dbCount += zsjhList.size();
		}
		if (jhFjList != null && jhFjList.size() > 0) {
			dbCount += jhFjList.size();
		}
		if (grList != null && grList.size() > 0) {
			dbCount += grList.size();
		}
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("dbCount", dbCount);
		return JsonMapper.toJsonString(map);
	}

	/*
	 * 待办审核
	 */
	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "zsjh_dbsh")
	public String zsjh_dbsh(HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Zsjh zsjh = new Zsjh();
		zsjh.setZt("1");
		Page<Zsjh> page1 = zsjhService.findPage(new Page<Zsjh>(request,
				response), zsjh);
		model.addAttribute("page1", page1);
		JhFj jhFj = new JhFj();
		jhFj.setBcStatus("0");
		Page<JhFj> page2 = jhFjService.findPage(new Page<JhFj>(request,
				response), jhFj);
		model.addAttribute("page2", page2);
		JhFjGr jhFjGr = new JhFjGr();
		jhFjGr.setBcStatus("0");
		Page<JhFjGr> page = jhFjGrService.findPage(new Page<JhFjGr>(request,
				response), jhFjGr);
		model.addAttribute("page3", page);
		return "modules/zsjh/zsjh_dbsx";
	}

	/*
	 * 获停用的招生计划列表
	 */
	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = { "disableList", "disableList" })
	public String disableList(Zsjh zsjh, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Zsjh> page = zsjhService.findPage(new Page<Zsjh>(request, response), zsjh);
		model.addAttribute("page", page);
		return "modules/zsjh/zsjhDisableList";
	}

	/**
	 * 启用停用
	 * 
	 * @param zsjh
	 * @param ids
	 * @param used
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "updateUsed")
	public String updateUsed(Zsjh zsjh, String ids, String used,
			RedirectAttributes redirectAttributes) {
		Zsjh newZsjh = new Zsjh();
		newZsjh.setId(ids);
		newZsjh.setUsed(used);
		zsjhService.updateUsed(newZsjh);
		addMessage(redirectAttributes, "异常处理成功");
		if (used == "1") {
			return "redirect:" + Global.getAdminPath()
					+ "/zsjh/zsjh/list?repage";
		} else if (used == "0") {
			return "redirect:" + Global.getAdminPath()
					+ "/zsjh/zsjh/disableList?repage";
		}
		return "redirect:" + Global.getAdminPath() + "/zsjh/zsjh/list?repage";
	}

	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "save")
	public String save(Zsjh zsjh, Model model,RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zsjh)) {
			return form(zsjh, model);
		}
		if (!zsjh.getZsrs().equals("")) {
			int surplus = Integer.parseInt(zsjh.getZsrs());
			zsjh.setSurplus(surplus);
		}
		String result = zsjhService.saveProcess(zsjh);
		addMessage(redirectAttributes, result);
		return "redirect:" + Global.getAdminPath() + "/zsjh/zsjh/list?repage";
	}
	
	/**
	 * Des: 保存数据
	 * 2016-12-14
	 * @author fn
	 * @param zsjh
	 * @param model
	 * @param redirectAttributes
	 * @return
	 * String
	 */
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "saveJh")
	public String saveJh(Zsjh zsjh, Model model,RedirectAttributes redirectAttributes)
	{
		if (!zsjh.getZsrs().equals("")) {
			int surplus = Integer.parseInt(zsjh.getZsrs());
			zsjh.setSurplus(surplus);
		}
		String result = zsjhService.saveJh(zsjh);
		Map map = new HashMap();
		map.put("isTrue", result);
		return JsonMapper.toJsonString(map);
	}
	
	
	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "jhForm")
	public String jhForm(Zsjh zsjh, Model model,RedirectAttributes redirectAttributes)
	{
		addMessage(redirectAttributes, "提交计划招生成功");
		return "redirect:" + Global.getAdminPath() + "/zsjh/zsjh/list?repage";
	}


	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "form")
	public String form(Zsjh zsjh, Model model) {
		model.addAttribute("nowDate", DateUtils.getDate());
		model.addAttribute("zsjh", zsjh);
		return "modules/zsjh/zsjhForm";
	}

	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "delete")
	public String delete(Zsjh zsjh, String ids,
			RedirectAttributes redirectAttributes) {
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				Zsjh zsjhEntity = this.get(id);
				zsjhService.delete(zsjhEntity);
			}
		}
		addMessage(redirectAttributes, "删除招生计划成功");
		return "redirect:" + Global.getAdminPath() + "/zsjh/zsjh/list?repage";
	}

	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "moresubmit")
	public String piliangSubmit(Zsjh zsjh, String ids,
			RedirectAttributes redirectAttributes) {
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				Zsjh zsjhEntity = this.get(id);
				zsjhEntity.setZt("1");
				zsjhService.save(zsjhEntity);
				String result = zsjhService.saveProcess(zsjhEntity);
				addMessage(redirectAttributes, result);
			}
		}
		addMessage(redirectAttributes, "批处理计划招生成功");
		return "redirect:" + Global.getAdminPath() + "/zsjh/zsjh/list?repage";
	}

	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "zsjhShenHe")
	public String zsjhListShenHe(Zsjh zsjh, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		Page<Zsjh> page = zsjhService.findPage(new Page<Zsjh>(request, response), zsjh);
		model.addAttribute("page", page);
		return "modules/zsjh/zsjhListShenHe";
	}

	@ResponseBody
	@RequestMapping(value = "moreShenHe")
	public String piliangShenHe(Zsjh zsjh, @RequestParam("ids") String ids,
			@RequestParam("shStatu") String shStatu,
			RedirectAttributes redirectAttributes) {
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				Zsjh zsjhEntity = this.get(id);
				if (shStatu.equals("1")) {// 审核不通过
					if (zsjhEntity.getZt().equals("3")) {
						zsjhEntity.setZt("2");
						zsjhService.save(zsjhEntity);
					}
					if (zsjhEntity.getZt().equals("1")) {
						zsjhEntity.setZt("2");
						zsjhService.save(zsjhEntity);
					}
				} else if (shStatu.equals("2")) {// 审核通过
					zsjhEntity.setZt("3");
					zsjhService.save(zsjhEntity);
				}
			}
			if (shStatu.equals("1")) {// 审核不通过
				return "1";
			} else if (shStatu.equals("2")) {
				return "2";
			}
		}
		return "0";
	}

	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "formsh")
	public String formsh(Zsjh zsjh, Model model) throws ParseException {
		String zt = zsjh.getZt();
		if (zt.equals("1") || zt == "1") {
			zsjh.setBcStatus("");
		}
		if (zt.equals("2") || zt == "2") {
			zsjh.setBcStatus("2");
		}
		if (zt.equals("3") || zt == "3") {
			zsjh.setBcStatus("1");
		}
		zsjh.setApproveBy(UserUtils.getUser());
		zsjh.setApproveDate(new Date());
		model.addAttribute("zsjh", zsjh);
		return "modules/zsjh/zsjhFormShenHe";
	}

	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "savesh")
	public String savesh(Zsjh zsjh, Model model,
			RedirectAttributes redirectAttributes) throws ParseException {
		String bcstatus = zsjh.getBcStatus();
		if (bcstatus.equals("2")) {// 审核不通过
			zsjh.setZt("2");
			// 记录审核历史信息
			ZsjhRecord zsjhRecord = new ZsjhRecord();
			zsjhRecord.setCid(zsjh.getId());
			zsjhRecord.setJhmc(zsjh.getJhmc());
			zsjhRecord.setNf(zsjh.getNf());
			zsjhRecord.setXqId(zsjh.getXqId());
			zsjhRecord.setZsrs(zsjh.getZsrs());
			zsjhRecord.setSpnr(zsjh.getSpnr());
			zsjhRecord.setBcStatus(zsjh.getBcStatus());
			zsjhRecordController.save(zsjhRecord);
		} else if (bcstatus.equals("1")) {// 审核通过
			zsjh.setZt("3");
		}
		zsjhService.save(zsjh);
		addMessage(redirectAttributes, "计划招生审核成功");
		return "redirect:" + Global.getAdminPath()
				+ "/zsjh/zsjh/zsjhShenHe?repage";
	}

	/**
	 * 修改页面 初始化数据
	 * 
	 * @param zsjh
	 * @param rows
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findInit")
	public String findInit(Zsjh zsjh, int rows,
			RedirectAttributes redirectAttributes) {
		BmFpJl bmFpJl = new BmFpJl();
		bmFpJl.setJhId(zsjh.getId());
		List<BmFpJl> bmFpJls = bmFpJlService.findListByJhId(bmFpJl);
		StringBuffer sb = new StringBuffer();
		if (bmFpJls != null && bmFpJls.size() > 0) {
			for (BmFpJl bm : bmFpJls) {
				sb.append("<tr><td><input type='button' onclick='qyxzShow(this)' value='设置地区' /></td><td><input type='button' onclick=del(this) value='删除'/></td><td><input name='bmFpJls["
						+ (rows - 1)
						+ "].id' value="
						+ bm.getId()
						+ " type='hidden' /><select  name='bmFpJls["
						+ (rows - 1) + "].bmId.id'><option value=''></option>");
				// 查询所有的部门
				Office office = new Office();
				office.setParentIds("0,1");
				List<Office> offices = officeService.findList(office);
				for (Office o : offices) {
					if (o.getId().equals(bm.getBmId().getId())) {
						sb.append("<option value='" + o.getId()
								+ "' selected='selected'>" + o.getName()
								+ "</option>");
					} else {
						sb.append("<option value='" + o.getId() + "'>"
								+ o.getName() + "</option>");
					}
				}
				sb.append("</select></td>");
				// 查询所有省
				Area area = new Area();
				area.setType("2");
				List<Area> areas = areaService.findAllP(area);
				sb.append("<td><select  name='bmFpJls[" + (rows - 1)
						+ "].areaSh.id' id='selectp" + rows
						+ "' onchange=areaSh('" + rows
						+ "',this)><option value=''></option>");
				for (Area a : areas) {
					if (a.getId().equals(bm.getAreaSh().getId())) {
						sb.append("<option value='" + a.getId()
								+ "' selected='selected'>" + a.getName()
								+ "</option>");
					} else {
						sb.append("<option value='" + a.getId() + "'>"
								+ a.getName() + "</option>");
					}
				}
				sb.append("</td>");
				if (bm.getAreaS() != null) {
					if (bm.getAreaS().getId() != null
							&& !bm.getAreaS().getId().equals("")) {
						// 查询所有市
						area.setParent(new Area(bm.getAreaSh().getId()));
						List<Area> a2 = areaService.findAllByChr(area);
						if (a2 != null && a2.size() > 0) {
							sb.append("<td><select  name='bmFpJls["
									+ (rows - 1) + "].areaS.id' id='selects"
									+ rows + "' onchange=areaS('" + rows
									+ "',this)><option value=''></option>");
							for (Area a : a2) {
								if (a.getId().equals(bm.getAreaS().getId())) {
									sb.append("<option value='" + a.getId()
											+ "' selected='selected'>"
											+ a.getName() + "</option>");
								} else {
									sb.append("<option value='" + a.getId()
											+ "'>" + a.getName() + "</option>");
								}
							}
							sb.append("</td>");
						}
						if (bm.getAreaQ() != null) {
							if (bm.getAreaQ().getId() != null
									&& !bm.getAreaQ().getId().equals("")) {
								area.setParent(new Area(bm.getAreaS().getId()));
								List<Area> a3 = areaService.findAllByChr(area);
								if (a3 != null && a3.size() > 0) {
									sb.append("<td><select  name='bmFpJls["
											+ (rows - 1)
											+ "].areaQ.id' id='selectq" + rows
											+ "'><option value=''></option>");
									for (Area a : a3) {
										if (a.getId().equals(
												bm.getAreaQ().getId())) {
											sb.append("<option value='"
													+ a.getId()
													+ "' selected='selected'>"
													+ a.getName() + "</option>");
										} else {
											sb.append("<option value='"
													+ a.getId() + "'>"
													+ a.getName() + "</option>");
										}
									}
									sb.append("</td>");
								}
							}
						} else {
							sb.append("<td><select style='width: 120px;' name='bmFpJls["
									+ (rows - 1)
									+ "].areaQ.id' id='selectq"
									+ rows
									+ "'><option value=''></option></td>");
						}
					} else {
						sb.append("<td><select style='width: 120px;' name='bmFpJls["
								+ (rows - 1)
								+ "].areaS.id' id='selects"
								+ rows
								+ "' onchange=areaS('"
								+ rows
								+ "',this)><option value=''></option></td>");
						sb.append("<td><select style='width: 120px;' name='bmFpJls["
								+ (rows - 1)
								+ "].areaQ.id' id='selectq"
								+ rows
								+ "'><option value=''></option></td>");
					}
				} else {
					sb.append("<td><select style='width: 120px;' name='bmFpJls["
							+ (rows - 1)
							+ "].areaS.id' id='selects"
							+ rows
							+ "' onchange=areaS('"
							+ rows
							+ "',this)><option value=''></option></td>");
					sb.append("<td><select style='width: 120px;' name='bmFpJls["
							+ (rows - 1)
							+ "].areaQ.id' id='selectq"
							+ rows
							+ "'><option value=''></option></td>");
				}
				sb.append("<td><input style='width: 100px;' value='"
						+ bm.getBmZsrs()
						+ "' name='bmFpJls["
						+ (rows - 1)
						+ "].bmZsrs' class='input-xlarge required' /><span class='help-inline'><font color='red'>*</font> </span></td>");
				sb.append("</tr>");
				rows++;
			}
		}
		addMessage(redirectAttributes, "删除计划招生成功");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/****************************************************************************************************************/

	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "dqInfo")
	public String dqInfo(Zsjh zsjh, Model model) {
		return "modules/zsjh/dqInfo";
	}

	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "taskCommit")
	public String taskCommit(Zsjh zsjh, BmFpJlObject bmFpJls, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, zsjh)) {
			return form(zsjh, model);
		}
		zsjhService.reNew(zsjh);
		addMessage(redirectAttributes, "提交计划招生成功");
		return "redirect:" + Global.getAdminPath()
				+ "/zsjh/zsjh/todoList?repage";
	}

	/**
	 * 计划审核
	 * 
	 * @param zsjh
	 * @param bmFpJls
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("zsjh:zsjh:edit")
	@RequestMapping(value = "reNew")
	public String reNew(Zsjh zsjh, Model model,
			RedirectAttributes redirectAttributes) {
		List<BmFpJl> bmFpJls = null;
		if (zsjh != null) {
			if (zsjh.getId() == null || zsjh.getId().equals("")) {
				Zsjh zsjh2 = new Zsjh();
				zsjh2.setProcInsId(zsjh.getAct().getProcInsId());
				List<Zsjh> ls = zsjhService.findZsjhByPnsId(zsjh2);
				zsjh2 = ls.get(0);
				zsjh2.setAct(zsjh.getAct());
				zsjh = zsjh2;
			}
			// 通过招生计划id 查询部门分配记录
			BmFpJl bmFpJl = new BmFpJl();
			bmFpJl.setJhId(zsjh.getId());
			bmFpJls = bmFpJlService.findListByJhId(bmFpJl);
		}
		model.addAttribute("zsjh", zsjh);
		model.addAttribute("bmFpJls", bmFpJls);
		return "modules/zsjh/zsjhRenew";
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findAreaByPid")
	public String findAreaByPid(String areaId) {
		Area area = new Area();
		area.setParent(new Area(areaId));
		List<Area> areas = areaService.findAllByChr(area);
		StringBuffer sb = new StringBuffer();
		sb.append("<option value=''></option>");
		if (areas != null && areas.size() > 0) {
			for (Area a : areas) {
				sb.append("<option value='" + a.getId() + "'>" + a.getName()
						+ "</option>");
			}
		}
		Map m = new HashMap();
		m.put("htmlS", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findAllAreaSh")
	public String findAllAreaSh(Zsjh zsjh) {
		// 查询所有省
		Area area = new Area();
		area.setType("2");
		List<Area> areas = areaService.findAllP(area);
		StringBuffer sb = new StringBuffer();
		sb.append("<label>省</label>");
		if (areas != null && areas.size() > 0) {
			for (int i = 0; i < areas.size(); i++) {
				sb.append("<label class='checkbox-inline'>");
				sb.append("<input type='checkbox' onclick='selectedSh(this)' name='shIds' value='"
						+ areas.get(i).getId() + "'>" + areas.get(i).getName());
				sb.append("</label>");
			}
		}
		Map m = new HashMap();
		m.put("shHtml", sb);
		return JsonMapper.toJsonString(m);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findAllAreaS")
	public String findAllAreaS(Area area) {
		// 查询所有市
		area.setParent(new Area(area.getId()));
		List<Area> areas = areaService.findAllByChr(area);
		StringBuffer sb = new StringBuffer();
		sb.append("<label>市</label>");
		if (areas != null && areas.size() > 0) {
			for (int i = 0; i < areas.size(); i++) {
				sb.append("<label class='checkbox-inline'>");
				sb.append("<input type='checkbox' name='sIds' value="
						+ areas.get(i).getId() + ">" + areas.get(i).getName());
				sb.append("</label>");
			}
		}
		Map m = new HashMap();
		m.put("shHtml", sb);
		return JsonMapper.toJsonString(m);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findTable")
	public String findTable(Zsjh zsjh, int rows,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		sb.append("<tr><td><input type='button' onclick='qyxzShow(this)' value='设置地区'/><td></td><input type='button' onclick=del(this) value='删除'/></td><td><select style='width: 120px;' name='bmFpJls["
				+ (rows - 1) + "].bmId.id'><option value=''></option>");
		// 查询所有的部门
		Office office = new Office();
		office.setParentIds("0,1");
		List<Office> offices = officeService.findList(office);
		for (Office o : offices) {
			sb.append("<option value='" + o.getId() + "'>" + o.getName()
					+ "</option>");
		}
		sb.append("</select></td>");
		// 查询所有省
		Area area = new Area();
		area.setType("2");
		List<Area> areas = areaService.findAllP(area);
		sb.append("<td><select style='width: 120px;' name='bmFpJls["
				+ (rows - 1) + "].areaSh.id' id='selectp" + rows
				+ "' onchange=areaSh('" + rows
				+ "',this)><option value=''></option>");
		for (Area a : areas) {
			sb.append("<option value='" + a.getId() + "'>" + a.getName()
					+ "</option>");
		}
		sb.append("</td>");
		sb.append("<td><select style='width: 120px;' name='bmFpJls["
				+ (rows - 1) + "].areaS.id' id='selects" + rows
				+ "' onchange=areaS('" + rows
				+ "',this)><option value=''></option></td>");
		sb.append("<td><select style='width: 120px;' name='bmFpJls["
				+ (rows - 1) + "].areaQ.id' id='selectq" + rows
				+ "'><option value=''></option></td>");
		sb.append("<td><input style='width: 100px;' name='bmFpJls["
				+ (rows - 1)
				+ "].bmZsrs' class='input-xlarge required' /><span class='help-inline'><font color='red'>*</font> </span></td>");
		sb.append("</tr>");

		addMessage(redirectAttributes, "删除计划招生成功");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 添加专业行
	 * 
	 * @param zsjh
	 * @param rows
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findPsTable")
	public String findPsTable(Zsjh zsjh, int rows,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		sb.append("<tr><td><select class='input-xlarge required'  id='zylx"
				+ rows
				+ "' onchange=zyLx('"
				+ rows
				+ "',this) name='jhZyInfos["
				+ (rows - 1)
				+ "].zylxId.id' style='width:150px;' ><option value=''></option>");
		// 查询所有专业类别
		List<ZylxJbxx> zylxJbxxs = zylxJbxxService.findList(new ZylxJbxx());
		if (zylxJbxxs != null && zylxJbxxs.size() > 0) {
			for (ZylxJbxx jbxx : zylxJbxxs) {
				sb.append("<option value='" + jbxx.getId() + "'>"
						+ jbxx.getLxmc() + "</option>");
			}
		}
		sb.append("</select></td>");
		sb.append("<td id='zyS"
				+ rows
				+ "'><select class='input-xlarge required' id='zy"
				+ rows
				+ "' onchange=checkZy(this,'zy"
				+ rows
				+ "')  name='jhZyInfos["
				+ (rows - 1)
				+ "].zyId.id'  style='width:150px;' ><option value=''></option></select></td>");
		sb.append("<td><input type='text' id='rowNum' name='jhZyInfos["
				+ (rows - 1)
				+ "].zsrs' onchange=sumZsrs(this,this.value) class='input-xlarge required digits' style='width:100px;' /></td>");
		/*sb.append("<td><p id='zy" + rows + "'></p></td>");*/
		sb.append("<td><input type='button' onclick=del(this) value='删除'/></td>");
		sb.append("</tr>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 
	 * 
	 * 根据专业获取班级数
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "getZhuanYeById")
	public String getZhuanyeBanjishu(@RequestParam("id") String id) {
		String num = zylxJbxxService.getZhuanYeById(id);
		return num;
	}

	/**
	 * 通过专业类别查询专业
	 * 
	 * @param zsjh
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findZyByLxId")
	public String findZyByLxId(String id, int rows,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<select class='input-xlarge ' onchange=checkZy(this,'zy"
				+ rows + "') id='zy" + rows + "'  name='jhZyInfos["
				+ (rows - 1) + "].zyId.id'>");
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			sb.append("<option value=''>请选择</option>");
			for (ZyJbxx jbxx : zyJbxxs) {
				sb.append("<option value='" + jbxx.getId() + "'>"
						+ jbxx.getZymc()+ "</option>");
			}
		}
		sb.append("</select><span class='help-inline'><font color='red'>*</font> </span>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/**
	 * Des:根据专业类别查找专业 2016-5-30
	 * 
	 * @author fn
	 * @param id
	 *            专业类别
	 * @param redirectAttributes
	 * @return String
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = "findZyByZylx")
	public String findZyByZylx(String id, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			sb.append("<option value=''>全部</option>");
			for (ZyJbxx jbxx : zyJbxxs) {
				sb.append("<option value='" + jbxx.getId() + "'>"
						+ jbxx.getZymc() + "</option>");
			}
		}   
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = "findZyByLxIdAndZyId")
	public String findZyByLxIdAndZyId(String id, String zyId,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		ZyJbxx zyJbxx = new ZyJbxx();
		ZylxJbxx zylxJbxx = new ZylxJbxx();
		zylxJbxx.setId(id);
		zyJbxx.setZylx(zylxJbxx);
		List<ZyJbxx> zyJbxxs = zyJbxxService.findList(zyJbxx);
		sb.append("<label>专业名称：</label>");
		sb.append("<select name='zyId.id' class='input-medium'  id='zyId'>");
		sb.append("<option value=''>全部</option>");
		if (zyJbxxs != null && zyJbxxs.size() > 0) {
			for (ZyJbxx jbxx : zyJbxxs) {
				if (jbxx.getId() != null && jbxx.getId().equals(zyId)) {
					sb.append("<option selected='selected' value='"
							+ jbxx.getId() + "'>" + jbxx.getZymc()+ "</option>");
				} else {
					sb.append("<option value='" + jbxx.getId() + "'>"
							+ jbxx.getZymc()+ "</option>");
				}
			}
		}
		sb.append("</select>");
		Map m = new HashMap();
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 初始化专业计划列表
	 * 
	 * @param zsjh
	 * @param rows
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@ResponseBody
	@RequestMapping(value = "findZyJhInit")
	public String findZyJhInit(@RequestParam("viewmodel") String viewmodel,
			Zsjh zsjh, int rows, RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		JhZyInfo jhZyInfo = new JhZyInfo();
		jhZyInfo.setZsjhId(zsjh);
		List<JhZyInfo> jhZyInfos = jhZyInfoService.findListByJhId(jhZyInfo);
		ZyJbxx zyJbxx = new ZyJbxx();
		if (jhZyInfos != null && jhZyInfos.size() > 0) {
			List<ZylxJbxx> zylxJbxxs = zylxJbxxService.findList(new ZylxJbxx());
			List<ZyJbxx> zyJbxxs = null;
			for (JhZyInfo info : jhZyInfos) {
				sb.append("<tr>");
				sb.append("<td><input type='hidden' path='jhZyInfos["
						+ (rows - 1) + "].id' value='" + info.getId() + "'/>");
				if (zylxJbxxs != null && zylxJbxxs.size() > 0) {
					if (viewmodel != "0" && !viewmodel.equals("0")) {
						sb.append("<select class='input-xlarge required'  id='zylx"
								+ rows
								+ "' onchange=zyLx('"
								+ rows
								+ "',this) name='jhZyInfos["
								+ (rows - 1)
								+ "].zylxId.id'><option value=''></option>");
					}
					for (ZylxJbxx jbxx : zylxJbxxs) {
						if (jbxx.getId().equals(info.getZylxId().getId())) {
							if (viewmodel == "0" || viewmodel.equals("0")) {
								sb.append("<p>" + jbxx.getLxmc() + "</p>");
							} else {
								sb.append("<option value='" + jbxx.getId()
										+ "' selected='selected'>"
										+ jbxx.getLxmc() + "</option>");
							}
						}
					}
				}
				sb.append("</select>");
				sb.append("</td>");
				zyJbxx.setZylx(info.getZylxId());
				zyJbxxs = zyJbxxService.findList(zyJbxx);
				sb.append("<td id='zyS" + rows + "'>");
				if (zyJbxxs != null && zyJbxxs.size() > 0) {
					if (viewmodel != "0" && !viewmodel.equals("0")) {
						sb.append("<select class='input-xlarge required' onchange=checkZy(this,'zy"
								+ rows
								+ "') id='zy"
								+ rows
								+ "'  name='jhZyInfos["
								+ (rows - 1)
								+ "].zyId.id'>");
						sb.append("<option value=''></option>");
					}
					for (ZyJbxx jbxx : zyJbxxs) {
						if (jbxx.getId().equals(info.getZyId().getId())) {
							if (viewmodel == "0" || viewmodel.equals("0")) {
								sb.append("<p>" + jbxx.getZymc()+"("+jbxx.getXzmc()+")" + "</p>");
							} else {
								sb.append("<option value='" + jbxx.getId()
										+ "' selected='selected'>"
										+ jbxx.getZymc() + "</option>");
							}
						}
					}
					sb.append("</select>");
				}
				sb.append("</td>");
				if (viewmodel == "0" || viewmodel.equals("0")) {
					sb.append("<td><p>" + info.getZsrs() + "</p></td>");
				} else {
					sb.append("<td><input class='input-medium required digits' onchange=sumZsrs(this,this.value) name='jhZyInfos["
							+ (rows - 1)
							+ "].zsrs' value='"
							+ info.getZsrs()
							+ "' /></td>");
				}
				String id = info.getZyId().getId();
				String num = zylxJbxxService.getZhuanYeById(id);
				/*sb.append("<td><p id='zy" + rows + "'>" + num + "</p></td>");*/
				if (viewmodel != "0" && !viewmodel.equals("0")) {
					sb.append("<td><input type='button' disabled='disabled' onclick=del(this) value='删除'/></td>");
				} else if (viewmodel == "2" || viewmodel.equals("2")) {
					sb.append("<td><input type='button' onclick=del(this) value='删除'/></td>");
				} else {
					sb.append("<td><input type='button' onclick=del(this) value='删除'/></td>");
				}
				rows++;
			}
		}
		Map m = new HashMap();
		m.put("rows", rows);
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	/**
	 * 初始化 只读
	 * 
	 * @param zsjh
	 * @param rows
	 * @param redirectAttributes
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findZyJhInitDisplay")
	public String findZyJhInitDisplay(
			@RequestParam("viewmodel") String viewmodel, Zsjh zsjh, int rows,
			RedirectAttributes redirectAttributes) {
		StringBuffer sb = new StringBuffer();
		JhZyInfo jhZyInfo = new JhZyInfo();
		jhZyInfo.setZsjhId(zsjh);
		List<JhZyInfo> jhZyInfos = jhZyInfoService.findListByJhId(jhZyInfo);
		ZyJbxx zyJbxx = new ZyJbxx();
		if (jhZyInfos != null && jhZyInfos.size() > 0) {
			List<ZylxJbxx> zylxJbxxs = zylxJbxxService.findList(new ZylxJbxx());
			List<ZyJbxx> zyJbxxs = null;
			for (JhZyInfo info : jhZyInfos) {
				sb.append("<tr>");
				sb.append("<td><input type='hidden' path='jhZyInfos["
						+ (rows - 1) + "].id' value='" + info.getId() + "'/>");
				if (zylxJbxxs != null && zylxJbxxs.size() > 0) {
					if (viewmodel != "0" && !viewmodel.equals("0")) {
						sb.append("<select class='input-xlarge required'  id='zylx"
								+ rows
								+ "' disabled='true' onchange=zyLx('"
								+ rows
								+ "',this) name='jhZyInfos["
								+ (rows - 1)
								+ "].zylxId.id'><option value=''></option>");
					}
					for (ZylxJbxx jbxx : zylxJbxxs) {

						if (jbxx.getId().equals(info.getZylxId().getId())) {
							if (viewmodel == "0" || viewmodel.equals("0")) {
								sb.append("<p>" + jbxx.getLxmc() + "</p>");
							} else {
								sb.append("<option style=\"font-size:14px;\" value='"
										+ jbxx.getId()
										+ "' selected='selected'>"
										+ jbxx.getLxmc() + "</option>");
							}
						}
					}
				}
				sb.append("</select>");
				sb.append("</td>");
				zyJbxx.setZylx(info.getZylxId());
				zyJbxxs = zyJbxxService.findList(zyJbxx);
				sb.append("<td id='zyS" + rows + "'>");
				if (zyJbxxs != null && zyJbxxs.size() > 0) {
					if (viewmodel != "0" && !viewmodel.equals("0")) {
						sb.append("<select disabled='true' class='input-xlarge required' id='zy"
								+ rows
								+ "'  name='jhZyInfos["
								+ (rows - 1)
								+ "].zyId.id'>");
						sb.append("<option style=\"font-size:14px;\" value=''></option>");
					}
					for (ZyJbxx jbxx : zyJbxxs) {

						if (jbxx.getId().equals(info.getZyId().getId())) {
							if (viewmodel == "0" || viewmodel.equals("0")) {
								sb.append("<p>" + jbxx.getZymc() +"("+jbxx.getXzmc()+")"+ "</p>");
							} else {
								sb.append("<option style=\"font-size:14px;\" value='"
										+ jbxx.getId()
										+ "' selected='selected'>"
										+ jbxx.getZymc()+"("+jbxx.getXzmc()+")" + "</option>");
							}
						}
					}
					sb.append("</select>");
				}
				sb.append("</td>");
				if (viewmodel == "0" || viewmodel.equals("0")) {
					sb.append("<td><p>" + info.getZsrs() + "</p></td>");
				} else {
					sb.append("<td><input  class='input-xlarge required digits' name='jhZyInfos["
							+ (rows - 1)
							+ "].zsrs' value='"
							+ info.getZsrs()
							+ "' /></td>");
				}
				String id = info.getZyId().getId();
				String num = zylxJbxxService.getZhuanYeById(id);
			/*	sb.append("<td><p id='zy" + rows + "'>" + num + "</p></td>");*/
				if (viewmodel != "0" && !viewmodel.equals("0")) {
					sb.append("<td><input  type='button' onclick=del(this) value='删除'/></td>");
				}
				rows++;
			}
		}

		Map m = new HashMap();
		m.put("rows", rows);
		m.put("html", sb.toString());
		return JsonMapper.toJsonString(m);
	}

	@ResponseBody
	@RequestMapping(value = "upLoad")
	public String upLoad(MultipartFile multipartFile,
			RedirectAttributes redirectAttributes, HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		String savePath = request.getSession().getServletContext().getRealPath("/static/photo/");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<?, ?> m = multipartRequest.getFileMap();
		Set<?> set = m.keySet();// 用接口实例接口
		Iterator<?> iter = set.iterator();
		// File file=null;
		while (iter.hasNext()) {// 遍历二次,速度慢
			String k = (String) iter.next();
			multipartFile = (MultipartFile) m.get(k);
		}
		CommonsMultipartFile cf = (CommonsMultipartFile) multipartFile;
		DiskFileItem fi = (DiskFileItem) cf.getFileItem();
		String type = fi.getContentType();
		type = type.split("\\/")[1];
		String fileName = "abc." + type;
		// 获得输入流：
		try {
			InputStream input = multipartFile.getInputStream();
			SaveFileFromInputStream(input, savePath, fileName);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "gggg";
	}

	public void SaveFileFromInputStream(InputStream stream, String path,
			String filename) throws IOException {
		FileOutputStream fs = new FileOutputStream(path + "/" + filename);
		byte[] buffer = new byte[1024 * 1024];
		int byteread = 0;
		while ((byteread = stream.read(buffer)) != -1) {
			fs.write(buffer, 0, byteread);
			fs.flush();
		}
		fs.close();
		stream.close();
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "findSurplus")
	public String findSurplus(String id) {
		Zsjh entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = zsjhService.get(id);
		}
		if (entity == null) {
			entity = new Zsjh();
		}

		Map m = new HashMap();
		m.put("surplusValue", entity.getSurplus());
		return JsonMapper.toJsonString(m);
	}

	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "zjform")
	public String zjform(Zsjh zsjh, Model model) {
		model.addAttribute("zsjh", zsjh);
		return "modules/zsjh/zsjhFormZjjh";
	}

	@RequiresPermissions("zsjh:zsjh:view")
	@RequestMapping(value = "viewform")
	public String viewform(Zsjh zsjh, Model model) {
		model.addAttribute("zsjh", zsjh);
		return "modules/zsjh/zsjhView";
	}

	/**
	 * Des:验证计划名称是否重复 2016-10-26
	 * 
	 * @author fn
	 * @param zsjh
	 * @return String
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@ResponseBody
	@RequestMapping(value = "validateJhmc")
	public String validateJhmc(Zsjh zsjh) {
		Map map = new HashMap();
		List<Zsjh> list = zsjhService.findAllListZsjh(zsjh);
		if (list != null && list.size() > 0) {
			map.put("isTrue", false);
		} else {
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}
	
	/**
	 * 获取启用的招生计划
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping("isUsedZsjh")
	@ResponseBody
	public String getIsUsedZsjh(){
		Zsjh isUsed = zsjhService.findUseZsjh();
		Map map = new HashMap();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		map.put("jhid", isUsed.getId());
		map.put("jhmc", isUsed.getJhmc());
		map.put("kssj", formatter.format( isUsed.getStartDate()));
		map.put("jssj", formatter.format( isUsed.getEndDate()));
		return JsonMapper.toJsonString(map);
	}
	
	@RequestMapping("validateDate")
	@ResponseBody
	public String validateDate(@RequestParam("validateDate") String validateDate) throws ParseException{
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(validateDate);
		List<Zsjh> result = zsjhService.findList(new Zsjh());
		for(int i=0;i<result.size();i++){
			Date startDate = result.get(i).getStartDate();
			Date endDate = result.get(i).getEndDate();
			if(startDate.before(date)&&endDate.after(date)){
				return "1"; 
			}
		}
		return "0";
	}
	
	@RequestMapping("getTeachNum")
	@ResponseBody
	public int getTeacherNum(@RequestParam("jhid") String jhid){
		//System.out.println("dfxvmdflkgbmdlgb"+"         "+jhid);
		int num  = zsjhService.getTeacherNum(jhid);
		//System.out.println(jhid+"================================"+num);
		return num;
	}
	
	
	@RequestMapping(value = "getZsjhnum", method = RequestMethod.GET)
	@ResponseBody
	public String getZsjhnum(@RequestParam("id") String jhid){
	 Zsjh zsjh = zsjhService.get(jhid);
	 List<Zsdj> list = zsdjService.getZsdjList(jhid);
	 BdJbxx bdJbxx=new BdJbxx();
	 bdJbxx.setZsjh(zsjh);
	 bdJbxx.setJfzt(CommonUtils.SYS_SHI);
	 List<BdJbxx> list2 = bdJbxxService.findList(bdJbxx);
		Map map = new HashMap();
		map.put("zsrs",zsjh.getZsrs() );
		map.put("wcrs", list2.size());
		map.put("djrs", list.size());
		return JsonMapper.toJsonString(map);
	}
	
	
	/**
	 * Des:根据id查询 审核中 审核通过 不通过的数据
	 * 2016-12-23
	 * @author fn
	 * @param zsjh
	 * @return
	 * String
	 */
	@ResponseBody
	@RequestMapping(value = "getZsjhList")
	public String getZsjhList(Zsjh zsjh){
		List<Zsjh> list = zsjhService.getZsjhList(zsjh);
		Map map = new HashMap();
		if(list!=null && list.size()>0)
		{
			map.put("isTrue", false);
		}else
		{
			map.put("isTrue", true);
		}
		return JsonMapper.toJsonString(map);
	}
	
	
}
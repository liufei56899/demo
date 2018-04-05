/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.thinkgem.jeesite.modules.jhfjgr.web;

import java.util.Date;
import java.util.List;

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
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.utils.DateUtils;
import com.thinkgem.jeesite.common.utils.StringUtils;
import com.thinkgem.jeesite.common.web.BaseController;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFj;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRecord;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRw;
import com.thinkgem.jeesite.modules.jhfj.entity.JhFjRwRecord;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRecordService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwRecordService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjRwService;
import com.thinkgem.jeesite.modules.jhfj.service.JhFjService;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGr;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRecord;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRw;
import com.thinkgem.jeesite.modules.jhfjgr.entity.JhFjGrRwRecord;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRecordService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwRecordService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrRwService;
import com.thinkgem.jeesite.modules.jhfjgr.service.JhFjGrService;
import com.thinkgem.jeesite.modules.sys.entity.Area;
import com.thinkgem.jeesite.modules.sys.entity.User;
import com.thinkgem.jeesite.modules.sys.service.AreaService;
import com.thinkgem.jeesite.modules.sys.service.SystemService;
import com.thinkgem.jeesite.modules.sys.utils.UserUtils;
import com.thinkgem.jeesite.modules.zsjh.entity.Zsjh;
import com.thinkgem.jeesite.modules.zsjh.service.ZsjhService;

/**
 * 计划分解个人Controller
 * 
 * @author lg
 * @version 2016-05-26
 */
@Controller
@RequestMapping(value = "${adminPath}/jhfjgr/jhFjGr")
public class JhFjGrController extends BaseController {

	@Autowired
	private JhFjGrService jhFjGrService;
	@Autowired
	private JhFjGrRwService jhFjGrRwService;
	@Autowired
	private ZsjhService zsjhService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private AreaService areaService;
	@Autowired
	private JhFjService jhFjService;
	@Autowired
	private JhFjRwService jhFjRwService;
	@Autowired
	private JhFjGrRecordService jhFjGrRecordService;
	@Autowired
	private JhFjGrRwRecordService jhFjGrRwRecordService;

	@ModelAttribute
	public JhFjGr get(@RequestParam(required = false) String id) {
		JhFjGr entity = null;
		if (StringUtils.isNotBlank(id)) {
			entity = jhFjGrService.get(id);
		}
		if (entity == null) {
			entity = new JhFjGr();
		}
		return entity;
	}

	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = { "list", "" })
	public String list(JhFjGr jhFjGr, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		jhFjGr.setCreateBy(user);
		jhFjGr.setFjfs("1");
		Page<JhFjGr> page = jhFjGrService.findPage(new Page<JhFjGr>(request,
				response), jhFjGr);
		model.addAttribute("page", page);
		return "modules/jhfjgr/jhFjGrList";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = { "shList", "" })
	public String shList(JhFjGr jhFjGr, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		jhFjGr.setFjfs("1");
		Page<JhFjGr> page = jhFjGrService.findPage(new Page<JhFjGr>(request,
				response), jhFjGr);
		model.addAttribute("page", page);
		return "modules/jhfjgr/jhFjGrShList";
	}
	
	/**
	 * 部门全体员工任务查看
	 * 
	 * @param jhFjGr
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = { "bmrwList", "" })
	public String bmrwList(JhFjGr jhFjGr, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		//jhFjGr.setJsId(user.getId());
		//jhFjGr.setJsmc(user.getName());
		jhFjGr.setOfficeId(user.getOffice().getId());
		jhFjGr.setBcStatus("1");
		Page<JhFjGr> page = jhFjGrService.findPage(new Page<JhFjGr>(request,
				response), jhFjGr);
		model.addAttribute("page", page);
		return "modules/jhfjgr/bmRwList";
	}

	/**
	 * 个人任务查看
	 * 
	 * @param jhFjGr
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = { "rwList", "" })
	public String rwList(JhFjGr jhFjGr, HttpServletRequest request,
			HttpServletResponse response, Model model) {
		User user = UserUtils.getUser();
		jhFjGr.setJsId(user.getId());
		jhFjGr.setJsmc(user.getName());
		jhFjGr.setBcStatus("1");
		jhFjGr.setRemarks("0");
		Page<JhFjGr> page = jhFjGrService.findPage(new Page<JhFjGr>(request,
				response), jhFjGr);
		model.addAttribute("page", page);
		return "modules/jhfjgr/grRwList";
	}

	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = "form")
	public String form(JhFjGr jhFjGr, Model model) {
		if (jhFjGr.getZsjh() != null) {
			JhFjGrRw jhFjGrRw = new JhFjGrRw();
			jhFjGrRw.setJhFjId(jhFjGr.getId());
			List<JhFjGrRw> list = jhFjGrRwService.getJhFjGrRwByJhFjId(jhFjGrRw);
			model.addAttribute("jhFjGr", jhFjGr);
			
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFjGr.getZsjh().getId())) {
				entity = zsjhService.get(jhFjGr.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//个人招生人数
			int zsrs = jhFjGr.getZsrs();
			//剩余招生人数=计划剩余人数+个人招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);

			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmStr = "";
			String oldJsStr = "";
			String oldBmJsStr = "";
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				shengArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + ",";
				shiArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + ",";
				quArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
						+ "," + rw.getCs() + "," + rw.getQx() + ",";
				zhenArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
						+ "," + rw.getXz() + ",";
				oldAreaStr += rw.getJsId() + "," + rw.getSf() + ","
						+ rw.getCs() + "," + rw.getQx() + "," + rw.getXz()
						+ ",";
				User user = systemService.getUserById(rw.getJsId());
				oldBmStr += user.getOffice().getId() + ",";
				oldJsStr += user.getId() + ",";
				oldBmJsStr += user.getOffice().getId() + "," + user.getId()
						+ ",";
			}
			model.addAttribute("oldAreaStr", oldAreaStr);
			model.addAttribute("oldBmStr", oldBmStr);
			model.addAttribute("oldJsStr", oldJsStr);
			model.addAttribute("oldBmJsStr", oldBmJsStr);

			int pn = 0;
			int sn = 0;
			int qn = 0;
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				innerTable += "<tr>";
				// 省份
				if (rw.getSf() != "" || rw.getSf() != null) {
					String sheng = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + ",";
					int shengCount = getSubCount(shengArray, sheng);

					if (shengCount > 1) {
						pn = pn + 1;
						if (strSheng == "") {
							innerTable += "<td rowspan = " + shengCount + ">";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}

						if (!strSheng.equals(rw.getSf())) {
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}
						if (pn == shengCount) {
							strSheng = "";
							pn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getSfName();
						innerTable += "</td>";
					}

					// 市
					String shi = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + ",";
					int shiCount = getSubCount(shiArray, shi);

					if (shiCount > 1) {
						sn = sn + 1;
						if (strShi == "") {
							innerTable += "<td rowspan = " + shiCount + ">";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (!strShi.equals(rw.getCs())) {
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (sn == shiCount) {
							strShi = "";
							sn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getCsName();
						innerTable += "</td>";
					}

					// 区
					String qu = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
							+ ",";
					int quCount = getSubCount(quArray, qu);

					if (quCount > 1) {
						qn = qn + 1;
						if (strQu == "") {
							innerTable += "<td rowspan = " + quCount + ">";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}

						if (!strQu.equals(rw.getQx())) {
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}
						if (qn == quCount) {
							strQu = "";
							qn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getQxName();
						innerTable += "</td>";
					}

				}

				// 镇
				if (!rw.getXz().equals("") && rw.getXz() != null) {
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}

				innerTable += "</tr>";
			}

			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);

			if (jhFjGr.getJsId() != null) {
				// 点击查询加载选中的地区
				String areaStr = "";
				String tableShengStr = "";
				String tableShiStr = "";
				String tableQuStr = "";
				String tableZhenStr = "";
				// 加载省
				List<Area> shengList = findAllByChr("1");
				tableShengStr += "<table>";
				for (int i = 0; i < shengList.size(); i++) {
					Area areaSheng = shengList.get(i);
					if (i == 0) {
						tableShengStr += "<tr>";
					}
					String strShengChecked = "";
					if (quArray.indexOf(areaSheng.getId()) != -1) {
						strShengChecked = "checked=\"checked\"";

						// 加载市
						List<Area> shiList = findAllByChr(areaSheng.getId());
						if (shiList.size() > 0) {
							tableShiStr += "<div id=\"div" + jhFjGr.getJsId()
									+ areaSheng.getId() + "\">";
							tableShiStr += areaSheng.getName() + "<br/>";
							tableShiStr += "<table>";
							for (int j = 0; j < shiList.size(); j++) {
								Area areaShi = shiList.get(j);
								if (j == 0) {
									tableShiStr += "<tr>";
								}
								String strShiChecked = "";
								if (quArray.indexOf(areaShi.getId()) != -1) {
									strShiChecked = "checked=\"checked\"";

									// 加载区县
									List<Area> quList = findAllByChr(areaShi
											.getId());
									if (quList.size() > 0) {
										tableQuStr += "<div id=\"div"
												+ jhFjGr.getJsId()
												+ areaShi.getId() + "\">";
										tableQuStr += areaShi.getName()
												+ "<br/>";
										tableQuStr += "<table>";
										for (int k = 0; k < quList.size(); k++) {
											Area areaQu = quList.get(k);
											if (k == 0) {
												tableQuStr += "<tr>";
											}
											String strQuChecked = "";
											if (quArray.indexOf(areaQu.getId()) != -1) {
												strQuChecked = "checked=\"checked\"";

												// 加载镇
												List<Area> zhenList = findAllByChr(areaQu
														.getId());
												if (zhenList.size() > 0) {
													tableZhenStr += "<div id=\"div"
															+ jhFjGr.getJsId()
															+ areaQu.getId()
															+ "\">";
													tableZhenStr += areaQu
															.getName()
															+ "<br/>";
													tableZhenStr += "<table>";
													for (int m = 0; m < zhenList
															.size(); m++) {
														Area areaZhen = zhenList
																.get(m);
														if (k == 0) {
															tableZhenStr += "<tr>";
														}
														String strZhenChecked = "";
														if (zhenArray
																.indexOf(areaZhen
																		.getId()) != -1) {
															strZhenChecked = "checked=\"checked\"";
														}

														tableZhenStr += "<td width=\"165\">";
														tableZhenStr += "<input type=\"checkbox\" id="
																+ areaZhen
																		.getId()
																+ jhFjGr.getJsId()
																+ " "
																+ strZhenChecked
																+ " name="
																+ areaZhen
																		.getId()
																+ jhFjGr.getJsId()
																+ " value="
																+ areaZhen
																		.getName()
																+ " onclick=\"SaveAreaResult('"
																+ jhFjGr.getJsId()
																+ "','"
																+ areaSheng
																		.getId()
																+ "','"
																+ areaShi
																		.getId()
																+ "','"
																+ areaQu.getId()
																+ "','"
																+ areaZhen
																		.getId()
																+ "',this)\"/>";
														tableZhenStr += areaZhen
																.getName();
														tableZhenStr += "</td>";
														if ((m + 1) % 5 == 0
																&& m != 0) {
															tableZhenStr += "</tr><tr>";
														}
													}
													tableZhenStr += "</tr>";
													tableZhenStr += "</table>";
													tableZhenStr += "<br/>";
													tableZhenStr += "</div>";
													// 镇加载完毕
												}
											}

											tableQuStr += "<td width=\"165\">";
											tableQuStr += "<input type=\"checkbox\" id="
													+ areaQu.getId()
													+ jhFjGr.getJsId()
													+ " "
													+ strQuChecked
													+ " name="
													+ areaQu.getId()
													+ jhFjGr.getJsId()
													+ " value="
													+ areaQu.getName()
													+ " onclick=\"openZhen('"
													+ jhFjGr.getJsId()
													+ "','"
													+ areaSheng.getId()
													+ "','"
													+ areaShi.getId()
													+ "','"
													+ areaQu.getId()
													+ "',this)\"/>";
											tableQuStr += areaQu.getName();
											tableQuStr += "</td>";
											if ((k + 1) % 5 == 0 && k != 0) {
												tableQuStr += "</tr><tr>";
											}
										}
										tableQuStr += "</tr>";
										tableQuStr += "</table>";
										tableQuStr += "<br/>";
										tableQuStr += tableZhenStr;// 将显示镇的层添加到显示区县的层中
										tableQuStr += "</div>";
										// 区县加载完毕
									}
								}

								tableShiStr += "<td width=\"165\">";
								tableShiStr += "<input type=\"checkbox\" id="
										+ areaShi.getId() + jhFjGr.getJsId()
										+ " " + strShiChecked + " name="
										+ areaShi.getId() + jhFjGr.getJsId()
										+ " value=" + areaShi.getName()
										+ " onclick=\"openQu('"
										+ jhFjGr.getJsId() + "','"
										+ areaSheng.getId() + "','"
										+ areaShi.getId() + "',this)\"/>";
								tableShiStr += areaShi.getName();
								tableShiStr += "</td>";
								if ((j + 1) % 5 == 0 && j != 0) {
									tableShiStr += "</tr><tr>";
								}
							}
							tableShiStr += "</tr>";
							tableShiStr += "</table>";
							tableShiStr += "<br/>";
							tableShiStr += tableQuStr;// 将显示区县的层添加到显示市的层中
							tableShiStr += "</div>";
						}
						// 市加载完毕
					}
					tableShengStr += "<td width=\"165\">";
					tableShengStr += "<input type=\"checkbox\" id="
							+ areaSheng.getId() + jhFjGr.getJsId() + " "
							+ strShengChecked + " name=" + areaSheng.getId()
							+ jhFjGr.getJsId() + " value="
							+ areaSheng.getName() + " onclick=\"openShi('"
							+ jhFjGr.getJsId() + "','" + areaSheng.getId()
							+ "',this)\"/>";
					tableShengStr += areaSheng.getName();
					tableShengStr += "</td>";
					if ((i + 1) % 5 == 0 && i != 0) {
						tableShengStr += "</tr><tr>";
					}
				}
				tableShengStr += "</tr>";
				tableShengStr += "</table>";
				tableShengStr += tableShiStr;// 将显示市的层添加到显示省的层中
				// 省加载完毕
				areaStr += tableShengStr;

				String selectAreaStr = "";
				selectAreaStr = selectAreaStr
						+ "<div class=\"modal fade\" style=\"width:880px;display:none;\" id=\"selectAreaShow\">";
				selectAreaStr = selectAreaStr + "<div class=\"modal-dialog\">";
				selectAreaStr = selectAreaStr + "<div class=\"modal-content\">";
				selectAreaStr = selectAreaStr + "<div class=\"modal-header\">";
				selectAreaStr = selectAreaStr
						+ "<button type=\"button\" class=\"close\" data-dismiss=\"modal\"><span>&times;</span></button>";
				selectAreaStr = selectAreaStr
						+ "<h4 class=\"modal-title\" id=\"myModalLabel"
						+ jhFjGr.getJsId() + "\">选择地区</h4>";
				selectAreaStr = selectAreaStr + "</div>";
				selectAreaStr = selectAreaStr + "<div class=\"modal-body\">";
				selectAreaStr = selectAreaStr + "<div id=\"areaPanel"
						+ jhFjGr.getJsId() + "\">" + areaStr + "</div>";
				selectAreaStr = selectAreaStr + "</div>";
				selectAreaStr = selectAreaStr + "<div class=\"modal-footer\">";
				selectAreaStr = selectAreaStr
						+ "<button type=\"button\" class=\"btn btn-default\" data-dismiss=\"modal\">关闭</button>";
				selectAreaStr = selectAreaStr
						+ "<button type=\"button\" onclick=\"SaveSelectArea('"
						+ jhFjGr.getJsId()
						+ "')\" class=\"btn btn-primary\" data-dismiss=\"modal\">确定</button>";
				selectAreaStr = selectAreaStr + "</div>";
				selectAreaStr = selectAreaStr + "</div>";
				selectAreaStr = selectAreaStr + "</div>";
				selectAreaStr = selectAreaStr + "</div>";
				model.addAttribute("selectAreaStr", selectAreaStr);
			}
		}
		return "modules/jhfjgr/jhFjGrForm";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = "formsh")
	public String formsh(JhFjGr jhFjGr, Model model) {
		if (jhFjGr.getZsjh() != null) {
			JhFjGrRw jhFjGrRw = new JhFjGrRw();
			jhFjGrRw.setJhFjId(jhFjGr.getId());
			List<JhFjGrRw> list = jhFjGrRwService.getJhFjGrRwByJhFjId(jhFjGrRw);
			jhFjGr.setApproveBy(UserUtils.getUser());
			if(jhFjGr.getApproveDate()==null)
			{
				jhFjGr.setApproveDate(new Date());
			}
			model.addAttribute("jhFjGr", jhFjGr);
			
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFjGr.getZsjh().getId())) {
				entity = zsjhService.get(jhFjGr.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			model.addAttribute("zsjhEntity", entity);
			model.addAttribute("shenHeName", UserUtils.getUser().getName());
			model.addAttribute("shenHeDate", DateUtils.getDate());
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//个人招生人数
			int zsrs = jhFjGr.getZsrs();
			//剩余招生人数=计划剩余人数+个人招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);

			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmStr = "";
			String oldJsStr = "";
			String oldBmJsStr = "";
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				shengArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + ",";
				shiArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + ",";
				quArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
						+ "," + rw.getCs() + "," + rw.getQx() + ",";
				zhenArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
						+ "," + rw.getXz() + ",";
				oldAreaStr += rw.getJsId() + "," + rw.getSf() + ","
						+ rw.getCs() + "," + rw.getQx() + "," + rw.getXz()
						+ ",";
				User user = systemService.getUserById(rw.getJsId());
				oldBmStr += user.getOffice().getId() + ",";
				oldJsStr += user.getId() + ",";
				oldBmJsStr += user.getOffice().getId() + "," + user.getId()
						+ ",";
			}
			model.addAttribute("oldAreaStr", oldAreaStr);
			model.addAttribute("oldBmStr", oldBmStr);
			model.addAttribute("oldJsStr", oldJsStr);
			model.addAttribute("oldBmJsStr", oldBmJsStr);

			int pn = 0;
			int sn = 0;
			int qn = 0;
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				innerTable += "<tr>";
				// 省份
				if (rw.getSf() != "" || rw.getSf() != null) {
					String sheng = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + ",";
					int shengCount = getSubCount(shengArray, sheng);

					if (shengCount > 1) {
						pn = pn + 1;
						if (strSheng == "") {
							innerTable += "<td rowspan = " + shengCount + ">";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}

						if (!strSheng.equals(rw.getSf())) {
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}
						if (pn == shengCount) {
							strSheng = "";
							pn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getSfName();
						innerTable += "</td>";
					}

					// 市
					String shi = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + ",";
					int shiCount = getSubCount(shiArray, shi);

					if (shiCount > 1) {
						sn = sn + 1;
						if (strShi == "") {
							innerTable += "<td rowspan = " + shiCount + ">";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (!strShi.equals(rw.getCs())) {
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (sn == shiCount) {
							strShi = "";
							sn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getCsName();
						innerTable += "</td>";
					}

					// 区
					String qu = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
							+ ",";
					int quCount = getSubCount(quArray, qu);

					if (quCount > 1) {
						qn = qn + 1;
						if (strQu == "") {
							innerTable += "<td rowspan = " + quCount + ">";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}

						if (!strQu.equals(rw.getQx())) {
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}
						if (qn == quCount) {
							strQu = "";
							qn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getQxName();
						innerTable += "</td>";
					}

				}

				// 镇
				if (!rw.getXz().equals("") && rw.getXz() != null) {
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}

				innerTable += "</tr>";
			}

			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
		}
		return "modules/jhfjgr/jhFjGrFormShenHe";
	}
	
	
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = "jhFjGrView")
	public String jhFjGrView(JhFjGr jhFjGr, Model model) {
		if (jhFjGr.getZsjh() != null) {
			JhFjGrRw jhFjGrRw = new JhFjGrRw();
			jhFjGrRw.setJhFjId(jhFjGr.getId());
			List<JhFjGrRw> list = jhFjGrRwService.getJhFjGrRwByJhFjId(jhFjGrRw);
			jhFjGr.setApproveBy(UserUtils.getUser());
			if(jhFjGr.getApproveDate()==null)
			{
				jhFjGr.setApproveDate(new Date());
			}
			model.addAttribute("jhFjGr", jhFjGr);
			
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFjGr.getZsjh().getId())) {
				entity = zsjhService.get(jhFjGr.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			model.addAttribute("zsjhEntity", entity);
			model.addAttribute("shenHeName", UserUtils.getUser().getName());
			model.addAttribute("shenHeDate", DateUtils.getDate());
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//个人招生人数
			int zsrs = jhFjGr.getZsrs();
			//剩余招生人数=计划剩余人数+个人招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);

			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmStr = "";
			String oldJsStr = "";
			String oldBmJsStr = "";
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				shengArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + ",";
				shiArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + ",";
				quArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
						+ "," + rw.getCs() + "," + rw.getQx() + ",";
				zhenArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
						+ "," + rw.getXz() + ",";
				oldAreaStr += rw.getJsId() + "," + rw.getSf() + ","
						+ rw.getCs() + "," + rw.getQx() + "," + rw.getXz()
						+ ",";
				User user = systemService.getUserById(rw.getJsId());
				oldBmStr += user.getOffice().getId() + ",";
				oldJsStr += user.getId() + ",";
				oldBmJsStr += user.getOffice().getId() + "," + user.getId()
						+ ",";
			}
			model.addAttribute("oldAreaStr", oldAreaStr);
			model.addAttribute("oldBmStr", oldBmStr);
			model.addAttribute("oldJsStr", oldJsStr);
			model.addAttribute("oldBmJsStr", oldBmJsStr);

			int pn = 0;
			int sn = 0;
			int qn = 0;
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw rw = list.get(i);
				innerTable += "<tr>";
				// 省份
				if (rw.getSf() != "" || rw.getSf() != null) {
					String sheng = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + ",";
					int shengCount = getSubCount(shengArray, sheng);

					if (shengCount > 1) {
						pn = pn + 1;
						if (strSheng == "") {
							innerTable += "<td rowspan = " + shengCount + ">";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}

						if (!strSheng.equals(rw.getSf())) {
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}
						if (pn == shengCount) {
							strSheng = "";
							pn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getSfName();
						innerTable += "</td>";
					}

					// 市
					String shi = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + ",";
					int shiCount = getSubCount(shiArray, shi);

					if (shiCount > 1) {
						sn = sn + 1;
						if (strShi == "") {
							innerTable += "<td rowspan = " + shiCount + ">";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (!strShi.equals(rw.getCs())) {
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (sn == shiCount) {
							strShi = "";
							sn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getCsName();
						innerTable += "</td>";
					}

					// 区
					String qu = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
							+ ",";
					int quCount = getSubCount(quArray, qu);

					if (quCount > 1) {
						qn = qn + 1;
						if (strQu == "") {
							innerTable += "<td rowspan = " + quCount + ">";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}

						if (!strQu.equals(rw.getQx())) {
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}
						if (qn == quCount) {
							strQu = "";
							qn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getQxName();
						innerTable += "</td>";
					}

				}

				// 镇
				if (!rw.getXz().equals("") && rw.getXz() != null) {
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}

				innerTable += "</tr>";
			}

			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
		}
		return "modules/jhfjgr/jhFjGrView";
	}
	
	

	/**
	 * 个人任务查看
	 * 
	 * @param jhFjGr
	 * @param model
	 * @return
	 */
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = "grRwForm")
	public String grRwForm(JhFjGr jhFjGr, Model model) {
		JhFjGrRw jhFjGrRw = new JhFjGrRw();
		jhFjGrRw.setJhFjId(jhFjGr.getId());
		List<JhFjGrRw> list = jhFjGrRwService.getJhFjGrRwByJhFjId(jhFjGrRw);
		model.addAttribute("jhFjGr", jhFjGr);

		String innerTable = "";
		innerTable += "<table class='table table-striped table-bordered table-condensed'>";
		String strSheng = "";
		String strShi = "";
		String strQu = "";
		String shengArray = "";
		String shiArray = "";
		String quArray = "";
		for (int i = 0; i < list.size(); i++) {
			JhFjGrRw rw = list.get(i);
			shengArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
					+ ",";
			shiArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
					+ "," + rw.getCs() + ",";
			quArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
					+ "," + rw.getCs() + "," + rw.getQx() + ",";
		}

		int pn = 0;
		int sn = 0;
		int qn = 0;
		for (int i = 0; i < list.size(); i++) {
			JhFjGrRw rw = list.get(i);
			innerTable += "<tr>";
			// 省份
			if (rw.getSf() != "" || rw.getSf() != null) {
				String sheng = rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + ",";
				int shengCount = getSubCount(shengArray, sheng);

				if (shengCount > 1) {
					pn = pn + 1;
					if (strSheng == "") {
						innerTable += "<td rowspan = " + shengCount + ">";
						innerTable += rw.getSfName();
						innerTable += "</td>";
						strSheng = rw.getSf();
					}

					if (!strSheng.equals(rw.getSf())) {
						innerTable += "<td>";
						innerTable += rw.getSfName();
						innerTable += "</td>";
						strSheng = rw.getSf();
					}
					if (pn == shengCount) {
						strSheng = "";
						pn = 0;
					}
				} else {
					innerTable += "<td>";
					if(rw.getSfName()!=null && !"".equals(rw.getSfName())){
						innerTable += rw.getSfName();
					}
					innerTable += "</td>";
				}

				// 市
				String shi = rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + ",";
				int shiCount = getSubCount(shiArray, shi);

				if (shiCount > 1) {
					sn = sn + 1;
					if (strShi == "") {
						innerTable += "<td rowspan = " + shiCount + ">";
						innerTable += rw.getCsName();
						innerTable += "</td>";
						strShi = rw.getCs();
					}

					if (!strShi.equals(rw.getCs())) {
						innerTable += "<td>";
						innerTable += rw.getCsName();
						innerTable += "</td>";
						strShi = rw.getCs();
					}

					if (sn == shiCount) {
						strShi = "";
						sn = 0;
					}
				} else {
					innerTable += "<td>";
					innerTable += rw.getCsName();
					innerTable += "</td>";
				}

				// 区
				String qu = rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
						+ ",";
				int quCount = getSubCount(quArray, qu);

				if (quCount > 1) {
					qn = qn + 1;
					if (strQu == "") {
						innerTable += "<td rowspan = " + quCount + ">";
						innerTable += rw.getQxName();
						innerTable += "</td>";
						strQu = rw.getQx();
					}

					if (!strQu.equals(rw.getQx())) {
						innerTable += "<td>";
						innerTable += rw.getQxName();
						innerTable += "</td>";
						strQu = rw.getQx();
					}
					if (qn == quCount) {
						strQu = "";
						qn = 0;
					}
				} else {
					innerTable += "<td>";
					innerTable += rw.getQxName();
					innerTable += "</td>";
				}

			}

			// 镇
			if (!rw.getXz().equals("") && rw.getXz() != null) {
				innerTable += "<td>";
				innerTable += rw.getXzName();
				innerTable += "</td>";
			}

			innerTable += "</tr>";
		}

		innerTable += "</table>";
		model.addAttribute("innerTable", innerTable);
		return "modules/jhfjgr/grRwForm";
	}

	/**
	 * 查询地区
	 * 
	 * @param parentId
	 * @return
	 */
	public List<Area> findAllByChr(String parentId) {
		Area area = new Area();
		area.setParent(new Area(parentId));
		return areaService.findAllByChr(area);
	}

	@RequiresPermissions("jhfjgr:jhFjGr:edit")
	@RequestMapping(value = "save")
	public String save(JhFjGr jhFjGr, Model model,
			RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, jhFjGr)) {
			return form(jhFjGr, model);
		}
		jhFjGrService.save(jhFjGr);
		addMessage(redirectAttributes, "保存计划分解个人成功");
		return "redirect:" + Global.getAdminPath() + "/jhfjgr/jhFjGr/?repage";
	}
	
	/**
	 * 单个审核
	 * @param jhFj
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@RequiresPermissions("jhfjgr:jhFjGr:edit")
	@RequestMapping(value = "saveSh")
	public String saveSh(JhFjGr jhFjgr, Model model, RedirectAttributes redirectAttributes){
		if(jhFjgr.getBcStatus() == "1"){
			addMessage(redirectAttributes, "审核通过的不需要再次审核！");
			return "redirect:"+Global.getAdminPath()+"/jhfj/jhFj/shList?repage";
		}
		User user = UserUtils.getUser();
		String zt = jhFjgr.getBcStatus();
		if (zt.equals("2")) {// 审核不通过
			// 记录部门计划分解历史信息
			JhFjGrRecord jhFjGrRecord = new JhFjGrRecord();
			jhFjGrRecord.setJhFjGrId(jhFjgr.getId());
			jhFjGrRecord.setJhId(jhFjgr.getZsjh().getId());
			jhFjGrRecord.setJsId(jhFjgr.getJsId());
			jhFjGrRecord.setZsrs(jhFjgr.getZsrs());
			jhFjGrRecord.setPx(jhFjgr.getPx());
			jhFjGrRecord.setBcstatus(jhFjgr.getBcStatus());
			jhFjGrRecord.setSpnr(jhFjgr.getSpnr());
			jhFjGrRecord.setCreateBy(jhFjgr.getCreateBy());
			jhFjGrRecord.setCreateDate(jhFjgr.getCreateDate());
			jhFjGrRecord.setUpdateBy(jhFjgr.getUpdateBy());
			jhFjGrRecord.setUpdateDate(jhFjgr.getUpdateDate());
			jhFjGrRecord.setApproveBy(user);
			jhFjGrRecord.setApproveDate(new Date());
			jhFjGrRecord.setRemarks(jhFjgr.getRemarks());
			jhFjGrRecord.setDelFlag(jhFjgr.getDelFlag());
			jhFjGrRecordService.save(jhFjGrRecord);
			
			JhFjGrRecord newJhGrFjRecord = new JhFjGrRecord();
			newJhGrFjRecord.setJhFjGrId(jhFjgr.getId());
			newJhGrFjRecord.setZsjh(jhFjgr.getZsjh());
			newJhGrFjRecord.setJsId(jhFjgr.getJsId());
			JhFjGrRecord lastJhFjGrRecord = jhFjGrRecordService.getLastJhFjInfo(newJhGrFjRecord);
			
			String jhFjGrRecordId = lastJhFjGrRecord.getId();
			
			//记录部门计划分解任务历史信息
			JhFjGrRw jhFjGrRw = new JhFjGrRw();
			jhFjGrRw.setJhFjId(jhFjgr.getId());
			List<JhFjGrRw> list = jhFjGrRwService.findList(jhFjGrRw);
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRw newjhFjGrRw = list.get(i);
				JhFjGrRwRecord jhFjGrRwRecord = new JhFjGrRwRecord();
				jhFjGrRwRecord.setJhFjGrRecordId(jhFjGrRecordId);
				jhFjGrRwRecord.setJhFjGrRwId(newjhFjGrRw.getId());
				jhFjGrRwRecord.setJhFjId(newjhFjGrRw.getJhFjId());
				jhFjGrRwRecord.setSf(newjhFjGrRw.getSf());
				jhFjGrRwRecord.setCs(newjhFjGrRw.getCs());
				jhFjGrRwRecord.setQx(newjhFjGrRw.getQx());
				jhFjGrRwRecord.setXz(newjhFjGrRw.getXz());
				jhFjGrRwRecord.setCreateBy(newjhFjGrRw.getCreateBy());
				jhFjGrRwRecord.setCreateDate(newjhFjGrRw.getCreateDate());
				jhFjGrRwRecord.setUpdateBy(newjhFjGrRw.getUpdateBy());
				jhFjGrRwRecord.setUpdateDate(newjhFjGrRw.getUpdateDate());
				jhFjGrRwRecord.setRemarks(newjhFjGrRw.getRemarks());
				jhFjGrRwRecord.setDelFlag(newjhFjGrRw.getDelFlag());
				jhFjGrRwRecordService.save(jhFjGrRwRecord);
			}
		} else if (zt.equals("1")) {// 审核通过
			
		}
		jhFjgr.setApproveBy(user);
		jhFjgr.setApproveDate(new Date());
		jhFjGrService.save(jhFjgr);
		addMessage(redirectAttributes, "审核成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGr/shList?repage";
	}
	
	/**
	 * 批量审核
	 * @param jhFj
	 * @param model
	 * @param redirectAttributes
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "moreShenHe")
	public String piliangShenHe(@RequestParam("ids") String ids,
			@RequestParam("shStatu") String shStatu,
			RedirectAttributes redirectAttributes){
		User user = UserUtils.getUser();
		if (ids != null && !"".equals(ids) && ids.length() > 0) {
			String[] idArr = ids.split(",");
			for (String id : idArr) {
				JhFjGr jhFjgr = this.get(id);
				if(jhFjgr.getBcStatus() == null || !jhFjgr.getBcStatus().equals("1")){
					if (shStatu.equals("2")) {// 审核不通过
						// 记录个人计划分解历史信息
						JhFjGrRecord jhFjGrRecord = new JhFjGrRecord();
						jhFjGrRecord.setJhFjGrId(jhFjgr.getId());
						jhFjGrRecord.setJhId(jhFjgr.getZsjh().getId());
						jhFjGrRecord.setJsId(jhFjgr.getJsId());
						jhFjGrRecord.setZsrs(jhFjgr.getZsrs());
						jhFjGrRecord.setPx(jhFjgr.getPx());
						jhFjGrRecord.setBcstatus(jhFjgr.getBcStatus());
						jhFjGrRecord.setSpnr(jhFjgr.getSpnr());
						jhFjGrRecord.setCreateBy(jhFjgr.getCreateBy());
						jhFjGrRecord.setCreateDate(jhFjgr.getCreateDate());
						jhFjGrRecord.setUpdateBy(jhFjgr.getUpdateBy());
						jhFjGrRecord.setUpdateDate(jhFjgr.getUpdateDate());
						jhFjGrRecord.setApproveBy(user);
						jhFjGrRecord.setApproveDate(new Date());
						jhFjGrRecord.setRemarks(jhFjgr.getRemarks());
						jhFjGrRecord.setDelFlag(jhFjgr.getDelFlag());
						jhFjGrRecordService.save(jhFjGrRecord);
						
						JhFjGrRecord newJhGrFjRecord = new JhFjGrRecord();
						newJhGrFjRecord.setJhFjGrId(jhFjgr.getId());
						newJhGrFjRecord.setZsjh(jhFjgr.getZsjh());
						newJhGrFjRecord.setJsId(jhFjgr.getJsId());
						JhFjGrRecord lastJhFjGrRecord = jhFjGrRecordService.getLastJhFjInfo(newJhGrFjRecord);
						
						String jhFjGrRecordId = lastJhFjGrRecord.getId();
						
						//记录个人计划分解任务历史信息
						JhFjGrRw jhFjGrRw = new JhFjGrRw();
						jhFjGrRw.setJhFjId(jhFjgr.getId());
						List<JhFjGrRw> list = jhFjGrRwService.findList(jhFjGrRw);
						for (int i = 0; i < list.size(); i++) {
							JhFjGrRw newjhFjGrRw = list.get(i);
							JhFjGrRwRecord jhFjGrRwRecord = new JhFjGrRwRecord();
							jhFjGrRwRecord.setJhFjGrRecordId(jhFjGrRecordId);
							jhFjGrRwRecord.setJhFjGrRwId(newjhFjGrRw.getId());
							jhFjGrRwRecord.setJhFjId(newjhFjGrRw.getJhFjId());
							jhFjGrRwRecord.setSf(newjhFjGrRw.getSf());
							jhFjGrRwRecord.setCs(newjhFjGrRw.getCs());
							jhFjGrRwRecord.setQx(newjhFjGrRw.getQx());
							jhFjGrRwRecord.setXz(newjhFjGrRw.getXz());
							jhFjGrRwRecord.setCreateBy(newjhFjGrRw.getCreateBy());
							jhFjGrRwRecord.setCreateDate(newjhFjGrRw.getCreateDate());
							jhFjGrRwRecord.setUpdateBy(newjhFjGrRw.getUpdateBy());
							jhFjGrRwRecord.setUpdateDate(newjhFjGrRw.getUpdateDate());
							jhFjGrRwRecord.setRemarks(newjhFjGrRw.getRemarks());
							jhFjGrRwRecord.setDelFlag(newjhFjGrRw.getDelFlag());
							jhFjGrRwRecordService.save(jhFjGrRwRecord);
						}
					} else if (shStatu.equals("1")) {// 审核通过
						
					}
					jhFjgr.setApproveBy(user);
					jhFjgr.setApproveDate(new Date());
					jhFjgr.setBcStatus(shStatu);
					jhFjGrService.save(jhFjgr);
				}
			}
		}
		if(shStatu.equals("2")){
        	return "2";//审核不通过成功
        }else if(shStatu.equals("1")){
        	return "1";//审核通过成功
        }
		return "0";
		/*addMessage(redirectAttributes, "批量审核成功");
		return "redirect:"+Global.getAdminPath()+"/jhfjgr/jhFjGr/shList?repage";*/
	}

	@RequiresPermissions("jhfjgr:jhFjGr:edit")
	@RequestMapping(value = "delete")
	public String delete(JhFjGr jhFjGr, RedirectAttributes redirectAttributes) {
		jhFjGrService.delete(jhFjGr);
		addMessage(redirectAttributes, "删除计划分解个人成功");
		return "redirect:" + Global.getAdminPath() + "/jhfjgr/jhFjGr/?repage";
	}

	@RequestMapping(value = "SaveSelectArea")
	public String SaveSelectArea(String jhfjId, String zsjhId, String[] jsIds,
			String[] zsrses, String[] ids, int fjrs) {
		int len = (ids.length - 1) / 5;
		System.out.println(len);
		Zsjh zsjh = zsjhService.get(zsjhId);

		// 在修改的时候，先将之前保存的数据删除掉
		if (!jhfjId.equals("")) {
			/*JhFjGr jhfjgr = jhFjGrService.get(jhfjId);
			if (jhfjgr != null) {
				int zsrs = jhfjgr.getZsrs();
				// 如果部门招生人数小于修改的人数，则继续减少计划剩余人数
				if (zsrs < fjrs) {
					int cha = fjrs - zsrs;
					int syrs = zsjh.getSurplus() - cha;
					zsjh.setSurplus(syrs);
					zsjhService.save(zsjh);
				}
				// 如果部门招生人数大于修改的人数，则增加计划剩余人数
				if (zsrs > fjrs) {
					int cha = zsrs - fjrs;
					int syrs = zsjh.getSurplus() + cha;
					zsjh.setSurplus(syrs);
					zsjhService.save(zsjh);
				}
			}*/
			// 删除计划分解表中的数据
			//jhFjGrService.deleteJhFjGr(jhfjId);
			// 删除计划分解任务表中的数据
			jhFjGrRwService.deleteJhFjGrRw(jhfjId);
		}
		/*else {
			int syrs = zsjh.getSurplus() - fjrs;
			zsjh.setSurplus(syrs);
			zsjhService.save(zsjh);
		}*/

		System.out.println(jsIds.length);
		for (int i = 0; i < jsIds.length - 1; i++) {
			JhFjGr jhFjGr = new JhFjGr();
			User user = systemService.getUserById(jsIds[i].toString());
			if (user != null) {
				jhFjGr.setJsId(user.getId());
			}
			jhFjGr.setZsjh(zsjh);
			jhFjGr.setZsrs(Integer.parseInt(zsrses[i].toString()));
			jhFjGr.setBcStatus("0");
			jhFjGr.setFjfs("1");
			if(jhFjGrService.getLastJhFjInfo(jhFjGr) == null){
				//先得到计划剩余人数
				int syrs = zsjh.getSurplus();
				//分配的招生人数
				int rs = Integer.parseInt(zsrses[i].toString());
				//最终计划剩余人数 计划剩余人数+之前的招生人数-重新分配的招生人数
				int lastRs = syrs-rs;
				zsjh.setSurplus(lastRs);
				zsjhService.save(zsjh);
				jhFjGr.setPx(i);
				jhFjGrService.save(jhFjGr);
			}
			else
			{
				//如果再次分解个人计划的时候包含之前的人员，在重新计算剩余人数
				//先得到计划剩余人数
				int syrs = zsjh.getSurplus();
				//再得到之前人员的招生人数
				int bmzss = jhFjGrService.getLastJhFjInfo(jhFjGr).getZsrs();
				//重新分配的招生人数
				int rs = Integer.parseInt(zsrses[i].toString());
				//最终计划剩余人数 计划剩余人数+之前的招生人数-重新分配的招生人数
				int lastRs = syrs+bmzss-rs;
				zsjh.setSurplus(lastRs);
				zsjhService.save(zsjh);
				jhFjGr.setId(jhFjGrService.getLastJhFjInfo(jhFjGr).getId());
				//修改人
                User u = UserUtils.getUser();
                jhFjGr.setUpdateBy(u);
                //修改时间
                jhFjGr.setUpdateDate(new Date());
				jhFjGrService.update(jhFjGr);
			}
			
			JhFjGr newJhFjGr = new JhFjGr();
			newJhFjGr.setZsjh(zsjh);
			newJhFjGr.setJsId(user.getId());
			JhFjGr lastJhFj = jhFjGrService.getLastJhFjInfo(newJhFjGr);

			if (lastJhFj != null) {
				String jhFjId = lastJhFj.getId();
				for (int j = 0; j < len; j++) {
					System.out.println(ids[j * 5]);
					if (jsIds[i].equals(ids[j * 5])) {
						String shengId = ids[j * 5 + 1].toString();
						String shiId = ids[j * 5 + 2].toString();
						String quId = ids[j * 5 + 3].toString();
						String zhenId = ids[j * 5 + 4].toString();
						System.out.println("省：" + shengId);
						System.out.println("市：" + shiId);
						System.out.println("区/县：" + quId);
						System.out.println("镇：" + zhenId);

						JhFjGrRw jhFjGrRw = new JhFjGrRw();
						jhFjGrRw.setJhFjId(jhFjId);
						jhFjGrRw.setSf(shengId);
						jhFjGrRw.setCs(shiId);
						jhFjGrRw.setQx(quId);
						jhFjGrRw.setXz(zhenId);
						jhFjGrRwService.save(jhFjGrRw);
					}
				}
			}
		}

		return "modules/jhfjgr/jhFjGrForm";
	}

	@RequiresPermissions("jhfjgr:jhFjGr:edit")
	@RequestMapping(value = "deleteJhfjGr")
	public String deleteJhfjGr(JhFjGr jhFjGr,
			RedirectAttributes redirectAttributes) {
		if (jhFjGr != null) {
			Zsjh zsjh = zsjhService.get(jhFjGr.getZsjh().getId());
			int cha = jhFjGr.getZsrs();
			int syrs = zsjh.getSurplus() + cha;
			zsjh.setSurplus(syrs);
			zsjhService.save(zsjh);
			// 删除计划分解表中的数据
			jhFjGrService.deleteJhFjGr(jhFjGr.getId());
			// 删除计划分解任务表中的数据
			jhFjGrRwService.deleteJhFjGrRw(jhFjGr.getId());
		}
		addMessage(redirectAttributes, "删除计划分解个人成功");
		return "redirect:" + Global.getAdminPath()
				+ "/jhfjgr/jhFjGr/list?repage";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGr:edit")
	@RequestMapping(value = "deletes")
	public String deletes(String ids, RedirectAttributes redirectAttributes) {
		String[] idArr = ids.split(",");
		for(String id:idArr)
		{
			JhFjGr jhFjGr = jhFjGrService.get(id);
			if (jhFjGr != null) {
				Zsjh zsjh = zsjhService.get(jhFjGr.getZsjh().getId());
				int cha = jhFjGr.getZsrs();
				int syrs = zsjh.getSurplus() + cha;
				zsjh.setSurplus(syrs);
				zsjhService.save(zsjh);
				// 删除计划分解表中的数据
				jhFjGrService.deleteJhFjGr(jhFjGr.getId());
				// 删除计划分解任务表中的数据
				jhFjGrRwService.deleteJhFjGrRw(jhFjGr.getId());
			}
		}
		addMessage(redirectAttributes, "删除计划分解个人成功");
		return "redirect:" + Global.getAdminPath()
				+ "/jhfjgr/jhFjGr/list?repage";
	}

	@RequestMapping(value = "SaveGrRwFj")
	public String SaveGrRwFj(String jhfjId, String zsjhId, String[] jsIds,
			String[] zsrses) {
		Zsjh zsjh = zsjhService.get(zsjhId);
		System.out.println(jhfjId);
		System.out.println(zsjhId);
		// 在修改的时候，先将之前保存的数据删除掉
		if (!jhfjId.equals("")) {
			for (int i = 0; i < jsIds.length - 1; i++) {
				JhFjGr jhfjgr = new JhFjGr();
				jhfjgr.setZsjh(zsjh);
				jhfjgr.setJsId(jsIds[i].toString());
				// 根据计划编号和教师编号查询个人任务分解计划
				List<JhFjGr> jhFjGrs = jhFjGrService.findList(jhfjgr);
				for (int j = 0; j < jhFjGrs.size(); j++) {
					JhFjGr jfg = jhFjGrs.get(j);
					// 删除计划分解个人表中的数据
					//jhFjGrService.deleteJhFjGr(jfg.getId());
					// 删除计划分解个人任务表中的数据
					jhFjGrRwService.deleteJhFjGrRw(jfg.getId());
				}
			}
		}

		System.out.println(jsIds.length);
		for (int i = 0; i < jsIds.length - 1; i++) {
			JhFjGr jhFjGr = new JhFjGr();
			User user = systemService.getUserById(jsIds[i].toString());
			if (user != null) {
				jhFjGr.setJsId(user.getId());
			}
			
			jhFjGr.setZsjh(zsjh);
			jhFjGr.setZsrs(Integer.parseInt(zsrses[i].toString()));
			jhFjGr.setBcStatus("0");
			jhFjGr.setFjfs("2");
			if(jhFjGrService.getLastJhFjInfo(jhFjGr) == null){
				jhFjGr.setPx(i);
				jhFjGrService.save(jhFjGr);
			}
			else
			{
				jhFjGr.setId(jhFjGrService.getLastJhFjInfo(jhFjGr).getId());
				//修改人
                User u = UserUtils.getUser();
                jhFjGr.setUpdateBy(u);
                //修改时间
                jhFjGr.setUpdateDate(new Date());
				jhFjGrService.update(jhFjGr);
			}
			
			JhFjGr newJhFjGr = new JhFjGr();
			newJhFjGr.setZsjh(zsjh);
			newJhFjGr.setJsId(user.getId());
			JhFjGr lastJhFj = jhFjGrService.getLastJhFjInfo(newJhFjGr);
			
			
			JhFjRw jhFjRw = new JhFjRw();
			jhFjRw.setJhFjId(jhfjId);
			List<JhFjRw> list = jhFjRwService.getJhFjRwByJhFjId(jhFjRw);

			if (lastJhFj != null) {
				String jhFjId = lastJhFj.getId();
				for (int j = 0; j < list.size(); j++) {
					JhFjRw jh = list.get(j);
					String shengId = jh.getSf();
					String shiId = jh.getCs();
					String quId = jh.getQx();
					String zhenId = jh.getXz();
					System.out.println("省：" + shengId);
					System.out.println("市：" + shiId);
					System.out.println("区/县：" + quId);
					System.out.println("镇：" + zhenId);

					JhFjGrRw jhFjGrRw = new JhFjGrRw();
					jhFjGrRw.setJhFjId(jhFjId);
					jhFjGrRw.setSf(shengId);
					jhFjGrRw.setCs(shiId);
					jhFjGrRw.setQx(quId);
					jhFjGrRw.setXz(zhenId);
					jhFjGrRwService.save(jhFjGrRw);
				}
			}
			JhFj jhfj = jhFjService.get(jhfjId);
			jhfj.setFjFlag("1");
			jhfj.setGrShZt("0");
			jhfj.setGrSpnr("");
			jhfj.setGrApproveBy(null);
			jhfj.setGrApproveDate(null);
			jhFjService.save(jhfj);
		}
		return "modules/jhfjgr/jhFjGrForm";
	}
	
	@RequiresPermissions("jhfjgr:jhFjGr:view")
	@RequestMapping(value = "formJhFjhistory")
	public String formJhFjhistory(String id, Model model) {
		JhFjGrRecord jhFjGrRecord = jhFjGrRecordService.get(id); 
		if (jhFjGrRecord.getZsjh() != null) {
			JhFjGrRwRecord jhFjGrRwRecord = new JhFjGrRwRecord();
			jhFjGrRwRecord.setJhFjGrRecordId(jhFjGrRecord.getId());
			jhFjGrRwRecord.setJhFjId(jhFjGrRecord.getId());
			List<JhFjGrRwRecord> list = jhFjGrRwRecordService.getJhFjGrRwByJhFjId(jhFjGrRwRecord);
			model.addAttribute("jhFjGrRecord", jhFjGrRecord);
			
			Zsjh entity = null;
			if (StringUtils.isNotBlank(jhFjGrRecord.getZsjh().getId())) {
				entity = zsjhService.get(jhFjGrRecord.getZsjh().getId());
			}
			if (entity == null) {
				entity = new Zsjh();
			}
			
			//计划中的剩余数量
			int surplusValue = entity.getSurplus();
			//个人招生人数
			int zsrs = jhFjGrRecord.getZsrs();
			//剩余招生人数=计划剩余人数+个人招生人数
			surplusValue = surplusValue + zsrs;
			//剩余招生人数
			model.addAttribute("surplusValue", surplusValue);

			String innerTable = "";
			innerTable += "<table class='table table-striped table-bordered table-condensed'>";
			String strSheng = "";
			String strShi = "";
			String strQu = "";
			String shengArray = "";
			String shiArray = "";
			String quArray = "";
			String zhenArray = "";
			String oldAreaStr = "";
			String oldBmStr = "";
			String oldJsStr = "";
			String oldBmJsStr = "";
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRwRecord rw = list.get(i);
				shengArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + ",";
				shiArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + ",";
				quArray += rw.getJhId() + "," + rw.getJsId() + "," + rw.getSf()
						+ "," + rw.getCs() + "," + rw.getQx() + ",";
				zhenArray += rw.getJhId() + "," + rw.getJsId() + ","
						+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
						+ "," + rw.getXz() + ",";
				oldAreaStr += rw.getJsId() + "," + rw.getSf() + ","
						+ rw.getCs() + "," + rw.getQx() + "," + rw.getXz()
						+ ",";
				User user = systemService.getUserById(rw.getJsId());
				oldBmStr += user.getOffice().getId() + ",";
				oldJsStr += user.getId() + ",";
				oldBmJsStr += user.getOffice().getId() + "," + user.getId()
						+ ",";
			}
			model.addAttribute("oldAreaStr", oldAreaStr);
			model.addAttribute("oldBmStr", oldBmStr);
			model.addAttribute("oldJsStr", oldJsStr);
			model.addAttribute("oldBmJsStr", oldBmJsStr);

			int pn = 0;
			int sn = 0;
			int qn = 0;
			for (int i = 0; i < list.size(); i++) {
				JhFjGrRwRecord rw = list.get(i);
				innerTable += "<tr>";
				// 省份
				if (rw.getSf() != "" || rw.getSf() != null) {
					String sheng = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + ",";
					int shengCount = getSubCount(shengArray, sheng);

					if (shengCount > 1) {
						pn = pn + 1;
						if (strSheng == "") {
							innerTable += "<td rowspan = " + shengCount + ">";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}

						if (!strSheng.equals(rw.getSf())) {
							innerTable += "<td>";
							innerTable += rw.getSfName();
							innerTable += "</td>";
							strSheng = rw.getSf();
						}
						if (pn == shengCount) {
							strSheng = "";
							pn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getSfName();
						innerTable += "</td>";
					}

					// 市
					String shi = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + ",";
					int shiCount = getSubCount(shiArray, shi);

					if (shiCount > 1) {
						sn = sn + 1;
						if (strShi == "") {
							innerTable += "<td rowspan = " + shiCount + ">";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (!strShi.equals(rw.getCs())) {
							innerTable += "<td>";
							innerTable += rw.getCsName();
							innerTable += "</td>";
							strShi = rw.getCs();
						}

						if (sn == shiCount) {
							strShi = "";
							sn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getCsName();
						innerTable += "</td>";
					}

					// 区
					String qu = rw.getJhId() + "," + rw.getJsId() + ","
							+ rw.getSf() + "," + rw.getCs() + "," + rw.getQx()
							+ ",";
					int quCount = getSubCount(quArray, qu);

					if (quCount > 1) {
						qn = qn + 1;
						if (strQu == "") {
							innerTable += "<td rowspan = " + quCount + ">";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}

						if (!strQu.equals(rw.getQx())) {
							innerTable += "<td>";
							innerTable += rw.getQxName();
							innerTable += "</td>";
							strQu = rw.getQx();
						}
						if (qn == quCount) {
							strQu = "";
							qn = 0;
						}
					} else {
						innerTable += "<td>";
						innerTable += rw.getQxName();
						innerTable += "</td>";
					}

				}

				// 镇
				if (!rw.getXz().equals("") && rw.getXz() != null) {
					innerTable += "<td>";
					innerTable += rw.getXzName();
					innerTable += "</td>";
				}

				innerTable += "</tr>";
			}

			innerTable += "</table>";
			model.addAttribute("innerTable", innerTable);
		}
		return "modules/jhfjgr/jhFjGrFormHistory";
	}

	public int getSubCount(String str, String key) {
		int total = 0;
		for (String tmp = str; tmp != null && tmp.length() >= key.length();) {
			if (tmp.indexOf(key) == 0) {
				total++;
			}
			tmp = tmp.substring(1);
		}
		return total;
	}

}
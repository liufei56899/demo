package com.thinkgem.jeesite.modules.xsfb.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.thinkgem.jeesite.common.persistence.Page;
import com.thinkgem.jeesite.common.service.CrudService;
import com.thinkgem.jeesite.modules.xsfb.dao.FbxxDao;
import com.thinkgem.jeesite.modules.xsfb.entity.Fbxx;
import com.thinkgem.jeesite.modules.zszy.dao.JhZyInfoDao;

/**
 * 新生分班Service
 * @author zh
 * @version 2018-02-08
 */
@Service
@Transactional(readOnly = false)
public class FbxxService extends CrudService<FbxxDao, Fbxx> {
	
	@Autowired
	private FbxxDao dao;
	public Page<Fbxx> findPage(Page<Fbxx> page, Fbxx fbxx) {
		return super.findPage(page, fbxx);
	}
	public void updateBjjbxx(String id,String yyrs){
		dao.updateBjjbxx(id,yyrs);
	}
}

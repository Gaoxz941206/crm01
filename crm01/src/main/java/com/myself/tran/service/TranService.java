package com.myself.tran.service;

import com.myself.Utils.Page;
import com.myself.tran.entity.Tran;
import com.myself.vo.TranHistoryPoss;
import com.myself.vo.TranQueryParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

public interface TranService {

    /**
     * 添加交易
     * @param tran
     * @return
     */
    String addTran(HttpSession session,Tran tran,String customerName);

    /**
     * 条件分页查询交易
     * @param param
     * @return
     */
    Page<Tran> pageQuery(TranQueryParam param);

    /**
     * 跳转详情页
     * @param id
     * @return
     */
    Tran gotoDetail(String id);

    /**
     * 根据交易id查询交易历史列表，request用来获取全局作用域，在全局作用域中拿到可能性
     * @param request
     * @param tranId
     * @return
     */
    List<TranHistoryPoss> getTranHistoryList(HttpServletRequest request, String tranId);

    /**
     * 点击交易状态图标，变更交易状态，添加交易历史
     * @param user      更改人
     * @param tranId    交易id
     * @param stage     更改后状态
     * @return
     */
    Tran changeStage(String user,String tranId,String stage);
}

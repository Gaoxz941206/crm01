package com.myself.tran.dao;

import com.myself.tran.entity.Tran;
import com.myself.tran.entity.TranHistory;
import com.myself.vo.TranHistoryPoss;
import com.myself.vo.TranQueryParam;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface TranDao {

    /**
     * 添加交易
     * @param tran
     * @return
     */
    int insertTran(Tran tran);

    /**
     * 创建交易历史
     * @param history
     * @return
     */
    int insertTranHistory(TranHistory history);

    /**
     * 获取总条数
     * @param param
     * @return
     */
    int selectTotalSize(TranQueryParam param);

    /**
     * 获取分页列表
     * @param param
     * @return
     */
    List<Tran> selectTranLists(TranQueryParam param);

    /**
     * 跳转详情页，并将市场活动等id转换成名称
     * @param id
     * @return
     */
    Tran selectTranForName(String id);

    /**
     * 根据交易id查询所有交易历史列表（可能性为空）
     * @param tranId
     * @return
     */
    List<TranHistoryPoss> selectHistoryPossById(String tranId);

    /**
     * 更改交易状态
     * @param tranId
     * @param stage
     * @return
     */
    int changeStage(@Param("tranId")String tranId,
                    @Param("stage")String stage,
                    @Param("editBy")String editBy,
                    @Param("editTime")String editTime);

    /**
     * 无条件获取所有交易数量
     * @return
     */
    int selectAllTranCount();

    /**
     * 无条件按照阶段分组查询交易
     * @return
     */
    List<Map<String,Integer>> selectTranGroupByStage();
}

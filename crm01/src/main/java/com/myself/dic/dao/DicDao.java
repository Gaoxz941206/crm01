package com.myself.dic.dao;

import com.myself.dic.entity.DicType;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DicDao {
    /**
     * 分组查询tbl_dic_type中的所有code类型
     * @return
     */
    List<String> selectDicCodeTypes();
}

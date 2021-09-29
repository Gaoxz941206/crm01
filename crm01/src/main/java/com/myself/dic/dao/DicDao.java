package com.myself.dic.dao;

import com.myself.dic.entity.DicType;
import com.myself.dic.entity.DicValue;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DicDao {
    /**
     * 分组查询tbl_dic_type中的所有code类型
     * @return
     */
    List<String> selectDicCodeTypes();

    /**
     * 通过code类型分别查询所有value值，并存放在list中
     * @param typeCode
     * @return
     */
    List<DicValue> selectValuesByTypeCode(String typeCode);


}

package com.myself.dic.service;

import com.myself.dic.entity.DicValue;

import java.util.List;
import java.util.Map;

public interface DicService {
    Map<String,List<DicValue>> selectDicCodeTypes();
}

package com.sist.mapper;
import org.apache.ibatis.annotations.Select;
import java.util.*;
import com.sist.vo.*;
public interface CommunityMapper {
	@Select("SELECT * FROM faq WHERE cate=#{cate}")
	public List<FaqVO> faqListData(String cate);
}

package com.sist.vo;

import java.util.*;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeVO {
    private int no, type, hit, filecount;
    private String subject, content, dbday, filename, filesize;
    private String nickname, userId; 
    private Date regdate;
    private List<MultipartFile> files;
}

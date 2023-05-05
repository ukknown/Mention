package com.ssafy.teamservice.service;

import com.ssafy.teamservice.utils.S3Uploader;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

@Service
public class TeamServiceImpl implements TeamService{
    private final S3Uploader s3Uploader;

    public TeamServiceImpl(S3Uploader s3Uploader) {
        this.s3Uploader = s3Uploader;
    }

    @Override
    @Transactional
    public void createTeam(String name, MultipartFile file) {
        String url = "";
        if(file != null)  url = s3Uploader.uploadFileToS3(file, "static/team-image");
    }
}

package com.ssafy.teamservice.service;

가import org.springframework.web.multipart.MultipartFile;

public interface TeamService {
    void createTeam(String name, MultipartFile file);
}

package com.ssafy.notificationservice.controller;

import com.ssafy.notificationservice.service.NotificationService;
import com.ssafy.notificationservice.utils.error.ErrorCode;
import com.ssafy.notificationservice.utils.exception.CustomException;
import com.ssafy.notificationservice.vo.NotificationVO;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/notification-service")
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    /**
     * 클라이언트에서 질문 공모 알림
     * @param request
     * @return
     */
    @PostMapping("/notifications")
    public ResponseEntity createNotifications(HttpServletRequest request){
        Long loginMemberId = Long.valueOf(convertRequestToVO(request));
        notificationService.createTopicOpenNotification(loginMemberId);
        return ResponseEntity.status(HttpStatus.OK).body("[질문 공모] 알림 전송 완료 ~ 🔥");
    }

    /**
     * MSA 에서 요청한 알림 등록
     * @return
     */
    @GetMapping("/notifications/{memberid}/{type}/{routingId}/{gender}")
    public ResponseEntity createMSANotifications(){

        return ResponseEntity.status(HttpStatus.OK).body("[질문 공모] 알림 전송 완료 ~ 🔥");
    }

    /**
     * 회원의 알림 리스트 조회
     * @param request
     * @return
     */
    @GetMapping("/notifications")
    public ResponseEntity<List<NotificationVO>> getNotifications(HttpServletRequest request){
        Long loginMemberId = Long.valueOf(convertRequestToVO(request));

        return ResponseEntity.status(HttpStatus.OK).body(null);
    }



    public int convertRequestToVO(HttpServletRequest request){
        if(request.getHeader("member") == null){
            throw new CustomException(ErrorCode.INVALID_TOKEN);
        }
        JSONObject loginMember = new JSONObject(request.getHeader("member"));
        return loginMember.getInt("id");
    }
}

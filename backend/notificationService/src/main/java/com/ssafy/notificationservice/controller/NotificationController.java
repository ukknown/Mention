package com.ssafy.notificationservice.controller;

import com.ssafy.notificationservice.jpa.Gender;
import com.ssafy.notificationservice.service.NotificationService;
import com.ssafy.notificationservice.utils.error.ErrorCode;
import com.ssafy.notificationservice.utils.exception.CustomException;
import com.ssafy.notificationservice.vo.NotificationVO;
import lombok.RequiredArgsConstructor;
import org.json.JSONObject;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@RestController
@RequestMapping("/notification-service")
@RequiredArgsConstructor
public class NotificationController {
    private final NotificationService notificationService;

    /**
     * 클라이언트에서 질문 공모 알림
     * @return
     */
    @PostMapping("/notifications")
    public ResponseEntity createNotifications(HttpServletRequest request){
        Long loginMemberId = Long.valueOf(convertRequestToVO(request));
        notificationService.createTopicOpenNotification(loginMemberId);
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
        List<NotificationVO> result = notificationService.getNotificationList(loginMemberId);
        return ResponseEntity.status(HttpStatus.OK).body(result);
    }

    /**
     * 멘션 알림 등록
     * @return
     */
    @GetMapping("/mention/{memberid}/{mentionid}/{gender}")
    public ResponseEntity createMentionNotification(
            @PathVariable("memberid") Long memberId,
            @PathVariable("mentionid") Long mentionId,
            @PathVariable("gender") String gender
    ){
        NotificationVO notificationVO = new NotificationVO();
        notificationVO.setMemberId(memberId);
        notificationVO.setRoutingId(mentionId);
        notificationVO.setGender(Gender.valueOf(gender));
        notificationService.createMentionNotification(notificationVO);
        return ResponseEntity.status(HttpStatus.OK).body("[멘션 알림] 멘션 전송 완료 ~ 🔥");
    }

    /**
     * 토픽 응모 당첨
     * @param memberId
     * @return
     */
    @GetMapping("/topic-winner/{memberid}/{topicid}")
    public ResponseEntity createTopicWinnerNotification(
            @PathVariable("memberid") Long memberId,
            @PathVariable("topicid") Long topicId
    ){
        NotificationVO notificationVO = new NotificationVO();
        notificationVO.setMemberId(memberId);
        notificationVO.setRoutingId(topicId);
        notificationService.createTopicWinnerNotification(notificationVO);

        return ResponseEntity.status(HttpStatus.OK).body("[토픽 응모] 토픽 응모 당첨 전송 완료 ~ 🔥");
    }

    /**
     * 그룹 투표 오픈 알림
     * @param memberId
     * @return
     */
    @GetMapping("/vote-open/{memberid}/{voteid}")
    public ResponseEntity createVoteOpenNotification(
            @PathVariable("memberid") Long memberId,
            @PathVariable("voteid") Long voteId
    ){
        NotificationVO notificationVO = new NotificationVO();
        notificationVO.setMemberId(memberId);
        notificationVO.setRoutingId(voteId);
        notificationService.createTeamVoteNotification(notificationVO);
        return ResponseEntity.status(HttpStatus.OK).body("[그룹 투표] 그룹 투표 전송 완료 ~ 🔥");
    }


    public int convertRequestToVO(HttpServletRequest request){
        if(request.getHeader("member") == null){
            throw new CustomException(ErrorCode.INVALID_TOKEN);
        }
        JSONObject loginMember = new JSONObject(request.getHeader("member"));
        return loginMember.getInt("id");
    }
}

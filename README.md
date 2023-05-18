# MENTION

<br/>
<br/>

## Mention

> #### **익명 칭찬 메세지 어플<br/>**
>
> <b style="color:#555555">프로젝트 기간 : 2023.04.10 ~ 2023.05.19</b>

<br/>

_Mention은 본인 소속 그룹에서 주어진 토픽에 맞는 사람을 선택해 익명의 멘션을 보내는 서비스 입니다.

<br/>
<br/>

---

<br/>
<br/>

##"Development Environment"

#### **Backend**
+ intellij IDEA - v2022.03
+ JDK - v11.0.18
+ SpringBoot - 2.7.11
+ Gradle - v11.0.18
+ JWT - v0.11.5
+ MariaDB - 10.11.2
+ Radis - v7.0.10
+ Erlang - v25.3.1
+ RabbitMQ - 3.11.15
+ Firebase Cloud Message -


#### **Frontend**
+ VSCode IDE - v1.77.0
+ Chocolatey - v1.3.1
+ dart 3.1.0-107.0.dev
+ Flutter 3.11.0-6.0.pre.55
+ Android 13.0 Google Apls
+Firebase - v2.12.0

#### *CI/CD*
+ AWS EC2
+ Docker
+ Jenkins
+ Gitlab
+ Github

#### "Comunication"
+ Jira
+ notion
+ Discord
+ MatterMost


## 주요 기능

> ### 멘션

참여한 그룹에서 올라온 토픽에 어울리는 사람을 선택하는 기능

> ### 토픽 생성

내가 생각하는 토픽을 생성하는 기능

> ### 힌트 확인

나를 멘션한 사람을 알아보기 위한 총 3단계의 힌트


<br/>
<br/>

## 기대효과
<br/>

>###

<br/>

## 프로젝트 파일 구조
### Backend
#### config-service
```
┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂configservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜ConfigServiceApplication.java
```
#### discovery-service
```
 ┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂discoveryservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜DiscoveryServiceApplication.java
```
#### gateway-service
```
 ┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂gatewayservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂config
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜RedisConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜InfoDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜Role.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂filter
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜AuthorizationHeaderFilter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CustomFilter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜GlobalFilter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜LoggingFilter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜GatewayServiceApplication.java
```
#### member-service
```
┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂memberservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂config
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜JwtSecurityConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜RedisConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜SecurityConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MemberController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂exception
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂auth
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜AuthExceptionEnum.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜AuthRuntimeException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂member
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberExceptionEnum.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberRuntimeException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TimeoutException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜ExceptionAdvice.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜ExceptionResponseEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂jpa
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MemberRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂jwt
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CustomUserDetails.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜JwtAccessDeniedHandler.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜JwtAuthenticationEntryPoint.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜JwtTokenFilter.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜JwtTokenProvider.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜UserDetailsServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂FeignClient
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionServiceFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamServiceFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MemberServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂vo
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂common
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜KakaoTokenResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜KakaoUserInfoResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂request
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜RequestJoin.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂response
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberInfoDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MyPageVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TokenResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TopTopicDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MemberDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜Gender.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜Role.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MemberServiceApplication.java
```
#### mention-service
```
┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂mentionservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂config
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜SwaggerConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TopicController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂elastic
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜AbstractElasticSearchConfiguration.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜ElasticSearchConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicDocument.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TopicSearchRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂exception
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜ExceptionAdvice.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜ExceptionResponseEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionServiceExceptionEnum.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MentionServiceRuntimeException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂feignclient
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberServiceFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜NotificationServiceFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamServiceFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂jpa
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜ApproveStatus.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜VoteEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜VoteRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜DataSaveService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜VoteService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜VoteServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂vo
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CreateMentionRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CreateVoteRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberInfoDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberVo.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionDetailResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicIdRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicNaverRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicResoponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopicTitleRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TopTopicVo.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜VoteVo.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MentionServiceApplication.java
```
#### notification-service
```
 ┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂notificationservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂client
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MentionFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamFeignClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜FCMController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜NotificationController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂jpa
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜Gender.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜NotificationEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜NotificationRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜Type.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜FCMService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜FCMServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜NotificationService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜NotificationServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂utils
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂error
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜ErrorCode.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📂exception
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CustomException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜GlobalExceptionHandler.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂vo
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜FCMRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜NotificationRequestDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜FCMMessage.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜NotificationVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜NotificationServiceApplication.java
```
#### notification-service
```
 ┣ 📂src
 ┃ ┣ 📂main
 ┃ ┃ ┣ 📂java
 ┃ ┃ ┃ ┗ 📂com
 ┃ ┃ ┃ ┃ ┗ 📂ssafy
 ┃ ┃ ┃ ┃ ┃ ┗ 📂teamservice
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂client
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberServiceClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜MentionServiceClient.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂config
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MapperConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜S3Config.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜SwaggerConfig.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂controller
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamController.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂jpa
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamMemberEntity.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamMemberRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamRepository.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂service
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamMemberService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamMemberServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamService.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamServiceImpl.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂utils
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂error
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜ErrorCode.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂exception
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜CustomException.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜GlobalExceptionHandler.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜RandomCodeGenerator.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜S3Uploader.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂vo
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📂dto
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamDetailsResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamResponseDto.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜MemberVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamDetailVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamMemberVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┣ 📜TeamVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜VoteVO.java
 ┃ ┃ ┃ ┃ ┃ ┃ ┗ 📜TeamServiceApplication.java
```

### Frontend


## 아키텍처 설계도


<br/>
<br/>
<br/>
<br/>

## ERD

<br/>
<br/>
<br/>
<br/>


## 프로젝트 결과물
<br/>
<br/>
<br/>

## 팀원 소개

<br/>
<br/>

---

# MENTION
<img src = "exec/mentionLogo.png" width ="300px">

<br/>
<br/>

## Mention

> #### **익명 칭찬 메세지 어플<br/>**
>
> <b style="color:#555555">프로젝트 기간 : 2023.04.10 ~ 2023.05.19</b>

<br/>

+ Mention은 본인 소속 그룹에서 주어진 토픽에 맞는 사람을 선택해 익명의 멘션을 보내는 서비스 입니다.

<br/>
<br/>

---

<br/>
<br/>

## *Development Environment*

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
+ Firebase Cloud Message


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

#### *Comunication*
+ Jira
+ notion
+ Discord
+ MatterMost


## 주요 기능 및 서비스 화면

> ### 멘션

참여한 그룹에서 올라온 토픽에 어울리는 사람을 선택하는 기능

> ### 토픽 생성

내가 멘션하고 싶은 토픽을 생성하는 기능

> ### 힌트 확인

나를 멘션한 사람을 알아보기 위한 총 3단계의 힌트


<br/>
<br/>



## 기대효과

+ 긍정적인 토픽들을 통해 멘션 받는 당사자에게 웃음, 설렘, 행복 등의 감정을 불러일으킬 수 있다.

+ 본인이 몰랐던 다른 사람들이 생각하는 나의 긍정적인 면을 알 수 있다.

+ 그룹 내 소통의 증가


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
![아키텍처설계도](exec/%EB%A9%98%EC%85%98%20%EC%8B%9C%EC%8A%A4%ED%85%9C%20%EC%95%84%ED%82%A4%ED%85%8D%EC%B2%98.png)

<br/>
<br/>
<br/>
<br/>

## ERD
![멘션 ERD](exec/%EB%A9%98%EC%85%98%20ERD.png)

<br/>
<br/>
<br/>
<br/>

## API 설계

|요청 서비스 | 방식 | MSA | 요청 URI | 요청 내용 | 담당자 | Status|
|--- | --- | --- | --- | --- | --- | ---|
|TeamService | POST | No | /team-service/teams | 팀 생성 | 세은 | 테스트 완료|
|TeamService | POST | No | /team-service/teams/code/{code} | 팀 입장 | 세은 | 테스트 완료|
|TeamService | GET | No | /team-service/teams | 회원이 속한 그룹 리스트 조회 | 세은 | 테스트 완료|
|TeamService | GET | No | /team-service/teams/{teamid} | 그룹 상세 정보 | 세은 | 테스트 완료|
|TeamService | GET | Yes | /team-service/teams/count/{memberid} | [MSA] 해당 회원이 가입된 그룹 목록 조회 | 세은 | 테스트 완료|
|TeamService | DELETE | No | /team-service/teams/{teamid}/{memberid} | 그룹에서 나가기 | 세은 | 테스트 완료|
|MentionService | POST | No | /mention-service/votes | 투표 생성 | 승현 조 | 테스트 완료|
|MentionService | GET | Yes | /mention-service/teams/{teamid}/votes/{memberid}/{type} | 그룹의 투표 리스트 조회 | 승현 조 | 테스트 완료|
|MentionService | POST | No | /mention-service/mentions | 멘션 생성 | 승현 조 | 테스트 완료|
|MentionService | GET | No | /topic-service/search | 토픽 검색 | 승현 조 | 테스트 완료|
|MentionService | POST | No | /topic-service/check/naver-api | 네이버 감정 분석 요청 | 승현 조 | 테스트 완료|
|MentionService | POST | No | /topic-service/check/similarity | 이미 있는 토픽인지 확인 | 승현 조 | 테스트 완료|
|MentionService | GET | No | /topic-service/topics/random/{teamId} | 랜덤한 한 개의 토픽 | 승현 조 | 테스트 완료|
|MentionService | GET | Yes | /topic-service/top-topic/{memberId} | 멘션 많이 당한 토픽 3개 | 승현 조 | 테스트 완료|
|MentionService | GET | Yes | /mention-service/mention-count/{memberid} | 멘션 받은 수 | 승현 조 | 테스트 완료|
|MentionService | GET | No | /mention-service/mentions | 받은 멘션 | 승현 조 | 테스트 완료|
|MentionService | GET | No | /mention-service/mentions/{mentionId} | 멘션 디테일(힌트 3개 있는 페이지) | 승현 조 | 테스트 완료|
|MentionService | PUT | No | /mention-service/mentions/{mentionsId} | 힌트 status 업데이트 | 승현 조 | 테스트 완료|
|MentionService | GET | No | /topic-service/topics | 관리자가 토픽 응모리스트 조회 | 승현 조 | 테스트 완료|
|MentionService | POST | No | /topic-service/topics/approve | 관리자가 토픽 승인 | 승현 조 | 테스트 완료|
|MentionService | POST | No | /topic-service/topics/reject | 관리자가 토픽 거절 | 승현 조 | 테스트 완료|
|MemberService | POST | No | /member-service/login | 로그인/회원가입 | 최종욱 | 테스트 완료|
|MemberService | POST | No | /member-service/bangs | 뱅 개수 업데이트 | 최종욱 | 테스트 완료|
|MemberService | GET | No | /member-service/me | 회원 상세 정보 받기 | 최종욱 | 테스트 완료|
|MemberService | GET | Yes | /member-service/feign/{memberid} | [MSA] 회원 기본 정보 | 최종욱 | 테스트 완료|
|MemberService | GET | Yes | /member-service/feign/time-out | [MSA] 타임아웃 | 최종욱 | 테스트 완료|
|MemberService | GET | No | /member-service/bang-check/{step} | 힌트단계에 따른 뱅 사용 가능 여부 | 최종욱 | 테스트 완료|
|NotificationService | POST | No | /notification-service/notifications | 토픽 응모 오픈 알림 | 세은 | 테스트 완료|
|NotificationService | GET | No | /notification-service/notifications | 토픽리스트 조회 | 세은 | 테스트 완료|
|NotificationService | POST | No | /notification-service/fcm-tokens | fcm 토큰 저장 | 승현 조 | 테스트 완료|

<br/>
<br/>
<br/>

## 프로젝트 결과물

<br/>
<br/>
<br/>


## 협업 환경
## GitLab
### Git Flow
+ 각자 맡은 기능에 맞게 ``` feature ``` 브랜치를 생성하여 개발
+ 완료된 기능은 ``` develop ``` 에 ``` merge ``` 

> ### Commit convention
> ``` FEAT ``` : 기능 추가, 프로젝트 생성, 초기 설정 
<br> ``` FIX ``` : 기능 변경, 기능 수정, 오류 수정

## Notion
+ 팀 전체가 알아야 할 공지사항이나 프로젝트를 진행하면서 나오는 각종 산출물들의 형상관리
# + [Mention Notion](https://www.notion.so/SSAFY-fece7069a49341c498d3f97a84f7d7fd)

## JIRA
+ 협업 및 일정, 업무 관리를 JIRA를 통해 관리하였습니다.
+ 매 주 월요일 한 주동안 진행되어야 할 계획을 수립하여 진행할 이슈들을 스프린트를 만들어 등록

>``` Epic ``` : BackEnd, FrontEnd, 기획, 설계
<br> ``` story ``` : 기획, 설계, 산출물 제작 등 개발외의 업무에 관한 업무 관리
<br> ``` task ``` : 코드 작성과 관련된 개발업무에 관한 업무 관리
<br/>
<br/>
<img src="exec/jira burndown.PNG">

<br/>

## 핵심 기술 소개

### MSA 설계 ( + FeingClient)

### Spring Security ( + JWT)

<br/>
<br/>

## 팀원 소개
|    <img src='exec/조승현.PNG' width='150px'>    |  <img src='exec/임세은.png' width='150px'>  |    <img src='exec/최종욱.png' width='150px'>    |     <img src='exec/노준호.png' width='150px'>     |     <img src='exec/여도현.png' width='150px'>     |    <img src='exec/김창영.png' width='150px'>    |
| :--------------------------------------------: | :-----------------------------------------: | :--------------------------------------------: | :-------------------------------------------------: | :----------------------------------------------: | :----------------------------------------------: |
| **[BE 조승현👑]** | **[BE 임세은]** | **[BE 최종욱]** | **[FE 노준호]** | **[FE 여도현]** | **[FE 김창영]** |
<br/>
<br/>

---

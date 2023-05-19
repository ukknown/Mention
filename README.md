# 멘션
<img src = "exec/mentionLogo.png" width ="300px">


<br/>
<br/>

## 멘션

> #### **익명 칭찬 메세지 어플<br/>**
>
> <b style="color:#555555">프로젝트 기간 : 2023.04.10 ~ 2023.05.19</b>

<br/>

+ 멘션은 본인 소속 그룹에서 주어진 토픽에 맞는 사람을 선택해 익명의 멘션을 보내는 서비스 입니다.

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

### 멘션
참여한 그룹에서 올라온 토픽에 어울리는 사람을 선택하는 기능

### 토픽 생성
내가 멘션하고 싶은 토픽을 생성하는 기능

### 힌트 확인
나를 멘션한 사람을 알아보기 위한 총 3단계의 힌트

<br/>
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
```
📦app
 ┣ 📂.vscode
 ┃ ┗ 📜settings.json
 ┣ 📂android
 ┃ ┣ 📂app
 ┃ ┃ ┣ 📂src
 ┃ ┃ ┃ ┣ 📂debug
 ┃ ┃ ┃ ┣ 📂main
 ┃ ┃ ┃ ┃ ┗ 📜AndroidManifest.xml
 ┃ ┃ ┃ ┗ 📂profile
 ┃ ┃ ┣ 📜build.gradle
 ┃ ┣ 📂gradle
 ┃ ┣ 📜build.gradle
 ┣ 📂assets
 ┃ ┣ 📂animations
 ┃ ┗ 📂images
 ┣ 📂ios
 ┣ 📂lib
 ┃ ┣ 📂api
 ┃ ┃ ┣ 📜group_api.dart
 ┃ ┃ ┣ 📜group_model.dart
 ┃ ┃ ┣ 📜member.json
 ┃ ┃ ┣ 📜notice_api.dart
 ┃ ┃ ┣ 📜notice_model.dart
 ┃ ┃ ┣ 📜pedometer_manager.dart
 ┃ ┃ ┣ 📜profile_api.dart
 ┃ ┃ ┣ 📜profile_model.dart
 ┃ ┃ ┣ 📜topic_api.dart
 ┃ ┃ ┗ 📜topic_model.dart
 ┃ ┣ 📂Screens
 ┃ ┃ ┣ 📂profile
 ┃ ┃ ┃ ┣ 📜group_list.dart
 ┃ ┃ ┃ ┣ 📜profile_page.dart
 ┃ ┃ ┃ ┗ 📜received_mentions.dart
 ┃ ┃ ┣ 📜group_member.dart
 ┃ ┃ ┣ 📜group_screen.dart
 ┃ ┃ ┣ 📜Hint.dart
 ┃ ┃ ┣ 📜home_screen.dart
 ┃ ┃ ┣ 📜lastHint.dart
 ┃ ┃ ┣ 📜mainPage.dart
 ┃ ┃ ┣ 📜notice_page.dart
 ┃ ┃ ┣ 📜vote_after.dart
 ┃ ┃ ┗ 📜vote_before.dart
 ┃ ┣ 📂widgets
 ┃ ┃ ┣ 📂profile
 ┃ ┃ ┃ ┣ 📂profile_box
 ┃ ┃ ┃ ┃ ┣ 📜mention_box.dart
 ┃ ┃ ┃ ┃ ┣ 📜my_group.dart
 ┃ ┃ ┃ ┃ ┣ 📜notice_box.dart
 ┃ ┃ ┃ ┃ ┣ 📜notice_group_vote.dart
 ┃ ┃ ┃ ┃ ┣ 📜notice_mention.dart
 ┃ ┃ ┃ ┃ ┣ 📜notice_topic_open.dart
 ┃ ┃ ┃ ┃ ┣ 📜notice_topic_winner.dart
 ┃ ┃ ┃ ┃ ┣ 📜pedometer.dart
 ┃ ┃ ┃ ┃ ┣ 📜profile_card.dart
 ┃ ┃ ┃ ┃ ┗ 📜rank_slot.dart
 ┃ ┃ ┃ ┗ 📂profile_buttons
 ┃ ┃ ┃ ┃ ┣ 📜coin_button.dart
 ┃ ┃ ┃ ┃ ┣ 📜group_button.dart
 ┃ ┃ ┃ ┃ ┣ 📜mention_button.dart
 ┃ ┃ ┃ ┃ ┗ 📜setting_button.dart
 ┃ ┃ ┣ 📜bg_img.dart
 ┃ ┃ ┣ 📜bottom_nav.dart
 ┃ ┃ ┣ 📜dailymissonswiper.dart
 ┃ ┃ ┣ 📜group_detail.dart
 ┃ ┃ ┣ 📜login_platform.dart
 ┃ ┃ ┣ 📜maingroupcard.dart
 ┃ ┃ ┗ 📜push_alarm.dart
 ┃ ┗ 📜main.dart
 ┣ 📂linux
 ┣ 📂macos
 ┣ 📂test
 ┣ 📂web
 ┣ 📂windows
 ┣ 📜pubspec.yaml
 ┗ 📜README.md
```


## 아키텍처 설계도
![아키텍처설계도](exec/architecture/system architecture.png)

<br/>
<br/>
<br/>
<br/>

## ERD
![멘션 ERD](exec/architecture/%EB%A9%98%EC%85%98%20ERD.png)

<br/>
<br/>
<br/>
<br/>

## API 설계
<img src = "exec/architecture/API.png">

<br/>
<br/>
<br/>

## 프로젝트 결과물

그룹 생성<br/>
<img src = "exec/photo/create-group.gif">

멘션하기<br/>
<img src = "exec/photo/mention.gif">

토픽 생성 - 토픽 직접 선택, 토픽 랜덤 생성<br/>
<img src = "exec/photo/create-vote(random).gif">
<img src = "exec/photo/create-vote.gif">

힌트 확인<br/>
<img src = "exec/photo/hint.gif">

마이페이지<br/>
- 내가 참여한 그룹
- 멘션 당한 토픽들
<img src = "exec/photo/my-page.gif">

앱 알람<br/>
<img src = "exec/photo/notification.gif">



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

<br/>
<br/>
<br/>

## Notion
+ 팀 전체가 알아야 할 공지사항이나 프로젝트를 진행하면서 나오는 각종 산출물들의 형상관리
<br/>
![Mention Notion](https://www.notion.so/SSAFY-fece7069a49341c498d3f97a84f7d7fd)

<br/>
<br/>
<br/>

## JIRA
+ 협업 및 일정, 업무 관리를 JIRA를 통해 관리하였습니다.
+ 매 주 월요일 한 주동안 진행되어야 할 계획을 수립하여 진행할 이슈들을 스프린트를 만들어 등록

>``` Epic ``` : BackEnd, FrontEnd, 기획, 설계
<br> ``` story ``` : 기획, 설계, 산출물 제작 등 개발외의 업무에 관한 업무 관리
<br> ``` task ``` : 코드 작성과 관련된 개발업무에 관한 업무 관리
<br/>
<br/>
<br/>
<img src="exec/photo/jira burndown.PNG">

<br/>

## 핵심 기술 소개

## DDD 기반 MSA 설계
### 이벤트 스토밍
<img src = "exec/architecture/bounded-context.png">
<br/>
<img src = "exec/architecture/member-service-ddd.jpg" width="300px">
<img src = "exec/architecture/team-service-ddd.jpg" width="300px">
<img src = "exec/architecture/topic-service-ddd.jpg" width="300px">
<img src = "exec/architecture/notification-service-ddd.jpg" width="300px">
<img src = "exec/architecture/mention-service-ddd.jpg" width="300px">

<br/>
<br/>
<br/>
<br/>

### Spring Security ( + JWT)
<br/>
사용자가 로그인을 하게 되면, 서버는 JWT 토큰을 생성하고 클라이언트에게 반환합니다. 
클라이언트는 이 JWT 토큰을 저장하고, 서버에 요청할 때마다 헤더에 포함하여 서버에 전송합니다. 서버는 JWT 토큰을 검증하여 사용자를 인증하고, 필요한 권한을 확인하여 해당 작업을 수행합니다. 
이 JWT 토큰은 클라이언트가 자원 서버에 접근할 때 Access Token으로 사용합니다. 자원 서버는 Access Token을 검증하여 클라이언트의 권한을 확인하고, 요청을 처리할 수 있습니다.
<br/>
<img src = "exec/photo/jwt login.png">
<br/>
<img src = "exec/photo/Access.png">

<br/>
<br/>

## Elastic Search(토픽 검색)
<br/>

```
//topic-mapping.json
{
  "properties": {
    "id": {
      "type": "keyword"
    },
    "title": {
      "type": "text",
      "fields": {
        "kor": {
          "type": "text",
          "analyzer": "korean"
        }
      }
    }
  }
}
```

</br>

```
//topic-setting.json
{
  "index" : {
    "max_ngram_diff": 5
  },
  "analysis": {
    "analyzer": {
      "korean": {
        "type": "nori"
      },
      "my_ngram_analyzer": {
        "tokenizer": "my_ngram_tokenizer"
      }
    },
    "tokenizer": {
      "my_ngram_tokenizer": {
        "type": "ngram",
        "min_gram": "2",
        "max_gram": "5"
      }
    }
  }
}
```


</br>


### 생성된 인덱스(by KIBANA)

</br>

<img src = "exec/kibana.png">

<br/>


## 팀원 소개
<img src = "exec/role.png">


<br/>
<br/>

---

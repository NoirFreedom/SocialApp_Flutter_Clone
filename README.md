
# Social App

TikTok을 벤치마킹하며, 그 플랫폼의 핵심 기능들을 재현하며 Flutter 개발에 대한 깊은 이해와 함께 기술적 능숙도의 상승을 목표로 본 프로젝트를 시작하였고, 기술적인 원리를 이해하려고 노력하며, 끊임없는 질문을 통해 개발을 진행했습니다.

현재, UI구현을 마치고, Firebase의 여러 서비스를 통합하여 이메일과 깃허브 계정을 통한 인증 시스템, 사용자 정보 실시간 수정, 영상 업로드 및 자동 썸네일 생성 등의 다양한 동적 기능을 구현하였습니다. 이를 통해 사용자들에게 안정적이고 직관적인 사용 경험을 제공함과 동시에, 서버리스(serverless) 아키텍처의 장점을 활용할 수 있도록 구현했습니다.

또한, 코드 관리 측면에서는 '관심사 분리(Separation of Concerns)'를 고려하여 MVVM 디자인 패턴을 적용하였고, 이를 통해 각 부분을 독립적으로 관리하고 테스트 하여 유지보수와 확장성을 향상시킬 수 있도록 작성했습니다.

<br>


### 기술 스택

### *`Flutter` `Firebase`*

<br>
<br>

## Login Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/login_screen1.png" alt="" width="230">
  <img src="tiktokApp_mock/assets/images/login_screen2.png" alt="" width="231">

</p>

*이메일 로그인과 깃허브 로그인이 구현된 상태이며, 정규표현식을 통해 이메일과 패스워드 검증 과정을 적용했습니다.*

<br>

## Sign up Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/sign_up_screen.png" alt="" width="230">
  <img src="tiktokApp_mock/assets/images/sign_up_email_screen.png" alt="" width="232">
  <img src="tiktokApp_mock/assets/images/birthday_screen.png" alt="" width="234">
  
</p> 

*"마찬가지로, 회원가입에서도 유저가 정규표현식을 통해 이메일 형식에 맞추도록 하였습니다."*

<br>

## Onboarding Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/interest_screen.png" alt="" width="226">
  <img src="tiktokApp_mock/assets/images/onboarding_screen1.png" alt="" width="226">
  <img src="tiktokApp_mock/assets/images/onboarding_screen2.png" alt="" width="226">

</p>


<br>

## Home Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/video_timeline_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/video_comments_screen.png" alt="" width="235">
</p>


<br>

## Discover Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/discover_screen.png" alt="" width="230">
</p>


<br>

## Inbox Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/inbox_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/notification_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/message_screen.png" alt="" width="235">
</p>


<br>

## User Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/user_profile_screen.png" alt="" width="234">
  <img src="tiktokApp_mock/assets/images/user_info_screen.png" alt="" width="235">

</p>

*유저의 프로필 정보는 Firestore database와 연결되어 있으며, 우측 상단에 편집 아이콘을 눌러 정보를 수정하고 'Done'을 누르면 변경된 정보가 각각에 해당하는 `StateProvider`에 저장되고, 이후, 유저 프로필 관련 비즈니스 로직을 처리하는 UserViewModel을 통해 Firestore database에 전달되고 업데이트되며, UI에도 반영되어 표시됩니다.*

<br>

## Setting Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/setting_screen.png" alt="" width="230">
</p>

*'Mute Video'와 'Auto Play' 모두 영상 재생과 관련되는 비즈니스 로직을 처리하는 PlaybackConfigViewModel의 메소드를 호출하여, 새로운 상태를 관리하는데, 이를 통해 '음소거'와 '자동재생' 기능이 동작합니다. 또한, 'Log out' 버튼으로 인증관련 로직을 처리하는 AuthenticationRepository의 함수를 실행하고, FirebaseAuth의 `signOut()`메소드를 통해 로그아웃 됩니다.*

<br>

## Chat Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/chat_screen.png" alt="" width="700">
  <img src="tiktokApp_mock/assets/images/chat_detail_screen.png" alt="" width="700">
</p>

*Firebase로 주요 채팅 기능을 구현하고 통합했으며, 주요 기능에는 사용자 이미지, 이름, 최근 대화 내용 불러오기, 실시간 채팅 등이 포함됩니다. 위 스크린샷은 Android Studio에서 실행한 Android 에뮬레이터와 Visual Studio Code에서 실행한 iOS 시뮬레이터를 보여주며, 플랫폼 간의 상호 운용성을 확인 할 수 있습니다.*

<br>
<br>
<br>
<br>
<br>


# Dark Mode

## Login Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_login_screen1.png" alt="" width="230">
  <img src="tiktokApp_mock/assets/images/dk_login_screen2.png" alt="" width="231">

</p>


<br>

## Sign up Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_sign_up_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/dk_sign_up_email_screen.png" alt="" width="230">
  <img src="tiktokApp_mock/assets/images/dk_birthday_screen.png" alt="" width="233">
  
</p>


<br>


## Onboarding Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_interest_screen.png" alt="" width="231">
  <img src="tiktokApp_mock/assets/images/dk_onboarding_screen1.png" alt="" width="230">
  <img src="tiktokApp_mock/assets/images/dk_onboarding_screen2.png" alt="" width="228">

</p>


<br>

## Home Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_video_timeline_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/dk_video_comments_screen.png" alt="" width="233">
</p>


<br>

## Discover Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_discover_screen.png" alt="" width="230">
</p>


<br>

## Inbox Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_inbox_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/dk_notification_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/dk_message_screen.png" alt="" width="235">
</p>


<br>

## User Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_user_profile_screen.png" alt="" width="235">
  <img src="tiktokApp_mock/assets/images/dk_user_info_screen.png" alt="" width="234">

</p>


<br>

## Setting Screen

<p float="left">
  <img src="tiktokApp_mock/assets/images/dk_setting_screen.png" alt="" width="230">
</p>


<br>
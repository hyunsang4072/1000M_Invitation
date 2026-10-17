# LG Electronics 10 Million Production Ceremony: Project Overview & Architecture Guide
# LG전자 테네시 클락스빌 1000만대 생산 기념식 초대 웹앱: 종합 기술 개요 및 아키텍처 가이드

---

## 1. Project Purpose & Executive Summary (프로젝트 목적 및 개요)

### [English]
This application is a **high-precision, mobile-first VIP digital invitation and live ceremony operations web app** developed for the milestone event: **"10 MILLION PRODUCTION CEREMONY - A New Milestone in Laundry Innovation"** at the LG Electronics manufacturing plant in **Clarksville, Tennessee (LGETN)**.

The primary objectives of this project are:
1. **VIP Invitation & Event Information Delivery**: Provide key ceremony information including date, time, venue, site history, and the 11 sequential program sessions in an elegant, executive-level interface.
2. **Real-time Event Synchronization**: Automatically track and highlight the currently active session during the ceremony based on the local time in Clarksville, TN (`America/Chicago` Central Time), showing live badges (`LIVE`) and status transitions without requiring page reloads.
3. **Brand Dignity & Visual Excellence**: Uphold LG's official brand guidelines (Pantone 207C Heritage Red, exact 25×25 geometry symbol mark) while incorporating Silicon Valley design aesthetics (Google Gemini fluid ambient mesh, iOS-grade glassmorphism, JetBrains Mono typography).
4. **Flawless Mobile Experience (Zero Lag / Zero Blank)**: Guarantee instantaneous first paint, zero layout shift, and smooth 60fps animations even under high-density factory Wi-Fi or cellular constraints.
5. **Interactive Delight (Secret Easter Eggs)**: Subtle, hidden interactions designed to delight internal stakeholders and attendees (interactive LG logo wink, 10M milestone jackpot roller, and washing machine 1,300 RPM spin-cycle vibration simulation).

---

### [한국어]
본 웹 애플리케이션은 미국 테네시주 클락스빌에 위치한 LG전자 생산법인(LGETN)의 기념비적 이정표인 **"10 MILLION PRODUCTION CEREMONY (세탁기 1,000만 대 생산 기념식)"**을 위해 개발된 **모바일 퍼스트 VIP 디지털 초청장 및 실시간 식순 안내 대시보드**입니다.

주요 구축 목적은 다음과 같습니다:
1. **VIP 초청 및 행사 안내**: 기념식 일시, 장소(테네시 클락스빌), 법인 역사 및 11개 세부 식순 일정을 품격 있고 직관적인 인터페이스로 전달.
2. **실시간 현지 시간 동기화**: 테네시 클락스빌 현지 시각(`America/Chicago`, 미국 중부 표준시)을 1초 주기로 추적하여, 행사 당일 진행 중인 세션에 실시간 깜빡임 `LIVE` 뱃지와 활성 테두리 글로우 효과를 자동으로 표시.
3. **브랜드 정체성 및 비주얼 완성도**: LG 공식 가이드라인(헤리티지 레드 #A50034, 25×25 공식 그리드 심볼 마크)을 철저히 준수함과 동시에, 실리콘밸리 감성의 유체 앰비언트 메시 라이팅과 iOS 스타일 글래스모피즘 디자인 구축.
4. **모바일 퍼포먼스 극대화 (초고속 첫 화면 & 무지연)**: 공장 내 혼잡한 무선 네트워크 환경에서도 스크롤 시 화면 빈 곳이 생기지 않도록 즉시 렌더링(Zero Layout Shift & Fast First Paint)을 보장하고, 60fps 네이티브 캔버스 애니메이션 구현.
5. **감성적 이스터에그**: 참석자들의 즐거움을 위해 UI를 해치지 않는 3가지 시크릿 인터랙션(LG 로고 윙크, 10M 잭팟 카운터 롤러, 세탁기 1,300 RPM 탈수 진동 모드) 내장.

---

## 2. Technical Stack & Architecture (기술 스택 및 아키텍처)

| Layer (계층) | Technologies (기술 스택) | Rationale & Characteristics (선정 이유 및 특징) |
|---|---|---|
| **Core Architecture** | Vanilla HTML5, Vanilla JavaScript (ES6+), CSS3 | **Zero Build Dependency & Zero CDN Risk**: 빌드 도구(Webpack/Vite)나 무거운 프레임워크 런타임 없이 단일 파일(`index.html`)로 서빙 가능하여 극대화된 로딩 속도와 유지보수성 제공. |
| **Styling Framework** | Tailwind CSS (CDN, Class-based Dark Mode) | 유틸리티 클래스 기반의 빠른 스타일링과 일관된 간격, 다크/라이트 테마 제어. |
| **Typography** | Google Fonts: `Inter` (UI/본문) & `JetBrains Mono` (시간/수치) | 숫자 폭이 일정한 `tabular-nums`를 활용하여 실시간 카운트다운 및 타임코드의 레이아웃 흔들림(Jitter) 원천 차단. |
| **Graphics Engine** | HTML5 Canvas (Hardware-Accelerated 2D Context) | 외부 서드파티 라이브러리 없이 순수 JS로 구현된 60fps 대칭 듀얼 캐논 Confetti(폭죽) 엔진. |
| **Hardware Integration** | Web Vibration API (`navigator.vibrate`) | 모바일 기기 터치 시 햅틱 진동 피드백 연동. |
| **Deployment & Ops** | Docker, Nginx Alpine, Docker Compose | 15MB 경량 컨테이너 이미지로 어디서든 즉시 배포 가능. |

---

## 3. UI/UX Design System & Layout Structure (디자인 시스템 및 레이아웃 구조)

### [English]
The interface adopts a **420px max-width viewport container**, calibrated specifically for modern mobile devices (iPhone, Galaxy, Pixel), while maintaining centered elegance on tablet and desktop screens.

1. **Fluid Ambient Mesh Lighting**:
   - Four floating multi-layer blur orbs (`.orb-primary`, `.orb-secondary`, `.orb-tertiary`, `.orb-quaternary`) animate continuously in the background, infusing LG Heritage Red (`#A50034`), Active Red (`#ED1C24`), Amber Gold, and Rose Glow with GPU-accelerated transforms.
2. **Glassmorphism & High-Contrast Readability**:
   - Backdrop-filter blur (`backdrop-filter: blur(20px)`) with ultra-thin translucent borders (`rgba(255, 255, 255, 0.08)` / `rgba(0, 0, 0, 0.06)`).
   - High-precision dark mode (`dark:bg-[#09090b]`) and clean light mode (`bg-[#fafafa]`).
3. **Hero Keynote Visual Anchor**:
   - Large gradient typography: **"10 MILLION PRODUCTION CEREMONY"**.
   - Decorated with four micro-sparkle starburst particles that twinkle and glow for 2.2 seconds.
4. **Precision Timeline Track**:
   - A single-pixel continuous vertical path (`#timelineTrack`) that dynamically measures the exact pixel positions of the 11 session nodes (`indicator-dot`) via `getBoundingClientRect()`.
   - Starts at the center of the first dot and terminates at the center of the final dot for flawless alignment across all device sizes.
5. **Main Event Highlighting**:
   - The pivotal 13:05 session ("10 Millionth Unit Reveal Ceremony") is wrapped in an illuminated `.shimmer-card` featuring active pulse badges and distinct keynote styling.

---

### [한국어]
본 디자인은 모바일 디스플레이(iPhone, Galaxy 등)에 최적화된 **420px 정밀 폭 제한 레이아웃**을 채택하였으며, 데스크톱/태블릿에서도 화면 중앙에 우아하게 배치됩니다.

1. **유체 앰비언트 메시 조명**:
   - 4개의 블러 오브(`.ambient-orb`)가 백그라운드에서 유기적으로 움직이며 LG 고유의 색상(헤리티지 레드, 액티브 레드, 웜 앰버, 로즈 글로우)을 은은하게 뿜어냅니다.
2. **글래스모피즘 및 시각적 대비**:
   - 20px 블러 효과와 미세 테두리를 적용한 유리 카드 디자인(`glass-card`)으로 내용에 대한 가독성을 극대화.
   - 직관적인 라이트 모드/다크 모드 실시간 토글 지원 (로컬스토리지 영구 기억).
3. **히어로 영역 비주얼**:
   - 그라디언트 볼드 타이포그래피 **"10 MILLION PRODUCTION CEREMONY"**와 그 주변을 2.2초간 부드럽게 반짝이는 4개의 샴페인 골드/화이트 스타 파티클 마이크로 인터랙션.
4. **정밀 타임라인 트랙 라인**:
   - 11개 식순 카드의 인디케이터 점(`indicator-dot`)의 물리적 좌표를 JS(`getBoundingClientRect`)로 측정하여 첫 번째 점의 정중앙에서 마지막 점의 정중앙까지 오차 없이 1px 실선(`timelineTrack`)을 연결.
5. **핵심 메인 이벤트 카드 강조**:
   - 오후 1시 5분 "10 Millionth Unit Reveal Ceremony(1,000만 번째 세탁기 공개식)" 카드는 전용 `.shimmer-card`로 강조되어 참석자의 시선을 집중시킵니다.

---

## 4. Key Functional Features (핵심 기능 명세)

### 4.1 Real-Time Clarksville Schedule Synchronization (실시간 일정 동기화)
- **Timezone Anchor**: `America/Chicago` (CST/CDT, UTC-6 / UTC-5).
- **D-Day Countdown**:
  - 행사일(`2026-11-10`)까지 남은 일수를 실시간 계산하여 헤더 뱃지에 `D-24`, `D-DAY`, `D+1` 형태로 표시.
- **Session State Machine (세션 3단계 상태 변화)**:
  - **Upcoming (진행 예정)**: 기본 카드 형태 유지.
  - **Active / LIVE (현재 진행 중)**: 실시간 펄스 뱃지(`LIVE`) 점등, 카드 테두리가 LG Red로 강조 발광.
  - **Past (종료됨)**: 시각적 위계를 위해 카드가 부드럽게 딤(dim) 처리.

### 4.2 High-Performance Canvas Confetti Engine (경량 캔버스 축하 폭죽)
- 외부 CDN 없이 100% 네이티브 HTML5 캔버스로 자체 제작된 듀얼 캐논 엔진.
- 화면 좌/우 하단에서 화면 중심 상단을 향해 완벽한 대칭 각도로 발사.
- **모바일 적응형 파티클 스케일링**: 모바일(`width < 768px`) 환경에서는 55개, 데스크톱에서는 120개로 최적화.
- **Fast Memory Release**: 200틱(약 3.3초) 내에 가속 페이드아웃 후 캔버스 DOM 자동 제거.
- **Idle State Execution**: `requestIdleCallback`을 통해 초기 렌더링이 완전히 끝난 1초 뒤 브라우저 유휴 상태에서 부드럽게 폭죽 발사.
- `sessionStorage`를 활용하여 첫 방문 시 1회 축하 후 과도한 반복 발사를 방지하며, 타이틀 터치 시 언제든 재실행 가능.

### 4.3 Creative Easter Eggs & Micro-Delights (3종 시크릿 이스터에그)

```
+-----------------------------------------------------------------------------------+
| 1. LG Logo Wink & Smile (헤더 좌측 상단 LG 심볼 탭)                                  |
|   - 트리거: 헤더의 LG 심볼 마크 클릭                                                  |
|   - 동작: 눈 도트(36, 36)가 0.42초간 찡긋 감겼다 떠지는 Wink 모션 + 로고 팝          |
|   - 피드백: 햅틱 진동([35, 40]ms) + 플로팅 하트(❤️) 솟아오름                         |
|   - 토스트: "Life's Good at Clarksville! ❤️" (화면 하단 글래스모피즘 토스트)          |
+-----------------------------------------------------------------------------------+
| 2. 10 MILLION Jackpot (히어로 타이틀 5회 연타)                                     |
|   - 트리거: "10 MILLION" 텍스트를 2.5초 내에 5회 연속 탭                               |
|   - 동작: 0.85초간 숫자가 9,999,990부터 10,000,000까지 고속 카운트업 롤링              |
|   - 피드백: 잭팟 햅틱 리듬 진동 + 골드 글리치 글로우 셰이크                           |
|   - 피날레: 10,000,000 달성 순간 화면 전체 대규모 컨페티 폭죽 및 골드 스타 폭발      |
|   - 토스트: "🎉 Historic Milestone Unlocked: Unit #10,000,000 Produced! Life's Good."|
+-----------------------------------------------------------------------------------+
| 3. Washer Spin Cycle Shake (세탁기 1,300 RPM 고속 탈수 모드)                        |
|   - 트리거: "A New Milestone in Laundry Innovation" 문구 더블탭 또는 0.75초 롱프레스    |
|   - 동작: 전체 웹페이지 래퍼가 고속 탈수기처럼 1.25초간 좌우/상하로 미세하고 격렬하게 진동 |
|   - 피드백: 탈수 박자 햅틱 진동([80, 50, 80, 50, 150]ms)                               |
|   - 토스트: "🌀 Spin Cycle Complete (1,300 RPM)"                                      |
+-----------------------------------------------------------------------------------+
```

---

## 5. Event Schedule Flow (전체 행사 진행 순서 및 타임라인)

행사는 **2026년 11월 10일(화요일)** 점심부터 오후까지 총 11개 세션(총 170분)으로 구성되어 있습니다:

| No. | Time (CST) | Duration | Session Name (세션명) | Location (장소) | Details (세부 내용) |
|:---:|:---:|:---:|---|---|---|
| **01** | 12:20 &ndash; 12:50 | 30 min | **Lunch & Warm Up Session** | Cafeteria / Dining Hall | 환영 및 캐주얼 네트워킹 오찬 |
| **02** | 12:50 &ndash; 13:00 | 10 min | **Opening Video & Music** | Main Stage | 기념식 오프닝 쇼케이스 영상 및 음악 |
| **03** | 13:00 &ndash; 13:05 | 5 min | **Clarksville Site History** | Main Stage | LGETN 테네시 공장 1000만 대 달성 여정 영상 |
| **04** | 13:05 &ndash; 13:10 | 5 min | **10 Millionth Unit Reveal Ceremony (KEYNOTE)** | Production Line 1 &middot; Special Deck | **[핵심 메인 이벤트]** 역사적인 1,000만 번째 세탁기 공개식 |
| **05** | 13:10 &ndash; 13:25 | 15 min | **Congratulatory Videos & Remarks** | Main Stage | 글로벌 경영진 축하 영상 및 주요 외빈 축사 |
| **06** | 13:25 &ndash; 13:35 | 10 min | **Signing Ceremony** | Ceremony Deck | 기념 생산 협약 및 서명식 |
| **07** | 13:35 &ndash; 13:45 | 10 min | **Cake-Cutting Ceremony** | Main Stage | 경영진 및 임직원 합동 축하 케이크 커팅식 |
| **08** | 13:45 &ndash; 13:55 | 10 min | **Contributor Recognition Awards** | Main Stage | 1,000만 대 생산 달성 유공자 표창 수여 |
| **09** | 13:55 &ndash; 14:05 | 10 min | **Commemorative Photo Session** | Grand Photo Backdrop | 경영진, 내외빈, 현장 임직원 기념 촬영 |
| **10** | 14:05 &ndash; 14:10 | 5 min | **Final Announcements** | Main Stage | 폐회 공지 및 감사 인사 |
| **11** | 14:10 &ndash; 15:10 | 60 min | **VIP Send-Off & Teardown** | Main Entrance | VIP 환송 및 행사 마무리 정리 |

---

## 6. Official Brand Guideline Compliance (공식 브랜드 규격 준수)

본 웹앱의 좌측 상단 헤더 로고는 **LG 코퍼레이트 브랜드 가이드라인(Basic Logo Elements - 1.2.1 Symbol Mark 25×25 Grid 규격)**을 100% 벡터 수식으로 정밀 구현했습니다:

- **색상**: Official LG Heritage Red (`#A50034`, Pantone 207C) 원형 디스크.
- **기본 모듈 ($X = 4$)**: 전체 직경 100 기준 1그리드 단위 $X = 4$.
- **외곽 원 테두리 여백**: 상하좌우 정확히 $2X$ (8) 간격 유지.
- **선 굵기**: 정확히 $1X$ (`stroke-width="4"`).
- **'G' 호 & 수평 바**: 중심 $(50, 50)$, 반지름 38에서 회전 후 $X=64$까지 수평 진입 ($3.5X$ 갭 유지).
- **'L' 코 & 입**: 코 시작점 $(50, 30)$에서 하단 $Y=68$까지 내려온 후 $X=64$까지 뻗어 상단 'G' 바와 완벽한 수직 일직선 정렬.
- **눈 도트**: 중심 $(36, 36)$에 직경 $3X$ (반지름 $r=6$) 원형 배치.

---

## 7. Performance & Mobile Optimization Strategy (성능 및 모바일 최적화)

1. **Zero-Layout-Shift & Fast First Paint**:
   - 모든 세션 카드는 `opacity: 1 !important`, `content-visibility: visible`로 초기 HTML 로드 시점에 즉시 화면에 그려져 스크롤 시 빈 공간(blank screen)이 발생하지 않습니다.
2. **GPU 가속 및 스크롤 보호**:
   - Confetti Canvas에 `will-change: transform` 및 `pointer-events: none`을 부여하여 폭죽 파티클이 재생되는 도중에도 사용자 스크롤 터치가 60fps로 매끄럽게 동작합니다.
3. **Safe Area & 뷰포트 클램핑**:
   - 토스트 팝업은 `max-width: min(calc(100vw - 32px), 380px)` 및 `bottom: max(20px, env(safe-area-inset-bottom, 20px))`로 iOS 홈 바나 노치 디스플레이에 가려지거나 화면 밖으로 넘치지 않습니다.
4. **터치 지연 제거**:
   - 모든 인터랙티브 트리거에 `touch-action: manipulation` 및 `-webkit-touch-callout: none`을 적용하여 300ms 탭 딜레이와 불필요한 확대 모션을 차단했습니다.

---

## 8. Deployment & Run Instructions (실행 및 배포 가이드)

### 로컬 실행 (Local Execution)
단일 HTML 파일이므로 웹 서버 없이 브라우저로 직접 열거나, 로컬 정적 서버로 즉시 구동 가능합니다:
```bash
# 옵션 1: Python 로컬 서버
python -m http.server 8080

# 옵션 2: Node npx serve
npx serve .
```

### Docker 실행 (Docker Deployment)
제공된 `Dockerfile`과 `docker-compose.yml`을 통해 어디서든 컨테이너로 실행할 수 있습니다:
```bash
# Docker Compose 빌드 및 백그라운드 실행
docker compose up -d --build
```
브라우저에서 `http://localhost:80`으로 접속하여 즉시 확인할 수 있습니다.

## 9. Document Maintenance & Synchronous Update Policy (문서 유지보수 및 동기화 원칙)

### [English]
- **Mandatory Synchronous Update**: Whenever any functional improvements, schedule changes, UI adjustments, Easter egg tweaks, or bug fixes are made to the codebase (e.g., `index.html`), this document (`PROJECT_OVERVIEW.md`) **MUST** be updated in tandem to reflect the latest state.
- **Revision Tracking**: Increment version numbers and record changes in the revision history below.

### [한국어]
- **코드-문서 필수 동기화 원칙**: 향후 기능 개선, 일정/세션 변경, UI/디자인 수정, 이스터에그 조정, 성능 최적화 등 코드베이스(예: `index.html`)에 변경 사항이 발생할 때마다 본 문서(`PROJECT_OVERVIEW.md`)를 **반드시 함께 업데이트**하여 최신 상태를 유지합니다.
- **이력 관리**: 변경 사항 발생 시 문서 버전 및 개정 이력을 아래에 기록합니다.

---

## 10. Revision History (개정 이력)

| Version | Date | Changes & Description (변경 내용 및 설명) |
|:---:|:---:|---|
| **v1.0.0** | 2026-10-17 | Initial comprehensive bilingual project overview, architecture, and interaction guide created. |

---
*Document Version: 1.0.0 (Production Release)*  
*Target Event: LG Electronics Clarksville, TN - 10 Million Production Ceremony (Nov 10, 2026)*

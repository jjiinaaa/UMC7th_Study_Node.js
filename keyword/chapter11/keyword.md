# CI/CD (Continuous Integration/Continuous Deployment)

**정의**

- **CI/CD**는 소프트웨어 개발 파이프라인을 자동화하여 개발, 테스트, 배포 과정을 효율적으로 수행하도록 돕는 방법론.

### **Continuous Integration (CI)**:

개발자들이 작성한 코드를 중앙 저장소에 자주 병합하여, 자동으로 빌드 및 테스트를 실행합니다.

- **목표**: 코드 변경 사항의 품질을 빠르게 검증.
- **장점**:
  - 코드 충돌 조기 발견.
  - 품질 유지.
  - 개발 속도 향상.

### **Continuous Deployment (CD)**:

테스트를 통과한 코드를 자동으로 프로덕션 환경에 배포합니다.

- **목표**: 사용자에게 신속하게 업데이트 제공.
- **장점**:
  - 신속한 배포.
  - 사람의 개입 최소화.
  - 더 나은 피드백 루프 형성.

### **Pipeline 예시**:

1. 코드 푸시(Git Push).
2. CI 도구가 빌드, 테스트 실행.
3. 테스트 성공 시 CD 도구가 프로덕션 배포.

# GitHub Actions

**정의**

- GitHub에서 제공하는 **CI/CD 자동화 도구**로, GitHub 저장소에서 **워크플로(Workflow)**를 설정해 이벤트 기반 작업을 실행합니다.

### **특징**:

- **이벤트 기반**: 코드 푸시, PR 생성, Issue 열기 등의 이벤트를 트리거로 사용.
- **YAML 파일로 설정**: `.github/workflows/` 디렉토리에 YAML 파일로 작업 정의.
- **확장성**: 다양한 커뮤니티 액션(Action)을 재사용 가능.
- **통합성**: GitHub 환경과 완벽하게 통합.

### **예시 워크플로**:

```yaml
name: CI Pipeline

on:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Install Dependencies
        run: npm install

      - name: Run Tests
        run: npm test
```

# Reverse Proxy (리버스 프록시)

**정의**

- **Reverse Proxy**는 클라이언트 요청을 백엔드 서버로 전달하고, 백엔드 서버의 응답을 클라이언트로 다시 전달하는 **중간 서버**.

### **주요 역할**:

1. **로드 밸런싱**: 다수의 백엔드 서버로 요청을 분산하여 성능 향상.
2. **캐싱**: 정적 콘텐츠를 캐싱해 요청 속도 증가.
3. **보안 강화**: 실제 백엔드 서버의 IP 주소를 숨기고 방화벽 역할 수행.
4. **SSL 종료**: HTTPS 요청을 처리하고 백엔드와 HTTP로 통신.

### **대표적인 Reverse Proxy 소프트웨어**:

- **NGINX**: 고성능 웹 서버 및 리버스 프록시.
- **Apache**: 오래된 전통의 리버스 프록시.
- **HAProxy**: 로드 밸런싱에 특화된 도구.
- **Traefik**: 클라우드 네이티브 환경에 적합.

# HTTPS

**정의**

- **HTTPS**는 HTTP에 **SSL/TLS** 암호화 계층을 추가하여 데이터의 기밀성과 무결성을 보장하는 프로토콜입니다.

### **HTTPS의 특징**:

1. **암호화**: 클라이언트와 서버 간의 데이터를 암호화해 도청 방지.
2. **인증**: 서버의 신원을 인증(SSL 인증서 사용)하여 신뢰성 제공.
3. **데이터 무결성**: 데이터가 전송 중에 변경되지 않도록 보호.

### **HTTPS 작동 방식**:

1. 클라이언트가 서버에 HTTPS 요청을 보냄.
2. 서버가 SSL 인증서를 클라이언트에 전달.
3. 클라이언트는 인증서를 검증 후 대칭 키를 생성하고 서버와 공유.
4. 암호화된 통신이 시작됨.

### **SSL 인증서 종류**:

- **DV (Domain Validation)**: 도메인 소유권만 인증.
- **OV (Organization Validation)**: 조직 정보와 도메인 소유권 인증.
- **EV (Extended Validation)**: 가장 높은 수준의 인증.

### **HTTPS의 장점**:

- 사용자 데이터 보호.
- SEO 개선(검색 엔진은 HTTPS를 선호).
- 사용자 신뢰도 증가(브라우저는 HTTPS를 권장).

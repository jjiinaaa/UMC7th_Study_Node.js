- 미들웨어

  - 광범위한 의미
    - 사전적 정의
      - 양 쪽을 연결하여 데이터를 주고 받을 수 있도록, 중간에서 매개 역할을 하는 소프트웨어, 네트워크를 통해서 연결된 여러 개의 컴퓨터에 있는 많은 프로세스들에게 어떤 서비스를 사용할 수 있도록 연결해 주는 소프트웨어.
      - 3계층 클라이언트/서버 구조에서 미들웨어가 존재함. 웹 브라우저에서 데이터베이스로부터 데이터를 저장하거나 읽어올 수 있게 중간에 미들웨어가 존재.
    - 실질적 의미
      1. 양쪽을 연결
      2. 중간에서의 매개 역할
      - 큰 범위로 보면 매개체 간 연결해주는 레이어로써, 매개체는 **클라이언트(사용자) - 서버**, **서버 - 서버 간의 통신**
      - 통상적으로 기업에서 말하는 **미들웨어 환경은 웹/어플리케이션 서버**를 의미한다.
    - 미들웨어 생성 배경 (feat. 3-Tier)
      - 기존 웹 어플리케이션 운영 환경에서 사용자가 요청을 한 순간부터 비즈니스 로직 처리, 데이터 처리 등을 **모두 한 곳의 물리적 환경(서버)에서 통합 제공함**. 운영자의 입장에서 하나의 서버만 운영하면 되기에 **관리 포인트가 1개**라는 장점
      - 그러나 1개의 관리 포인트의 단점이 부각
      - **1개의 통합 서버에 문제가 생겼을 때 전체 서비스 장애로 이어지고, 어느 포인트에서 장애를 일으켰는 지 분석이 쉽지 않음. (**1-Tier 구조 일때)
      - (2-Tier 구조) 데이터 처리 분리를 하고 DBMS 만큼은 분리된 환경에서 제공하니 서비스 안정성이 증가
      - 그러나, **1) 사용자의 요청이 유입되는 순간, 2) 비즈니스 로직 처리** 만큼은 통합된 서비스에서 제공
      - ex. 우리가 네이버에 접속을 했을 때, 메인 페이지가 띄워지는 건 불과 5초 이내지만, 사실은 무수히 많은 파일 호출, 네트워크 통신 등 우리 눈에 보이지 않는 곳에서 서버는 바쁨. (www.naver.com을 입력하고 Enter를 치자마자, 단 2초만에 약 170개의 File Open이 발생.)
        !https://velog.velcdn.com/images%2Funyoi%2Fpost%2F0e4bfe3c-3e8c-479c-8dd9-f81471c5e52c%2F%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202021-03-23%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2011.20.39.png
      - 동시다발적인 사용자의 호출이 쌓이게 되면 통합된 서비스에서도 부하. 따라서, 효율적인 서비스 처리를 위해 아래 기준대로 서비스를 나눔.
      - (3 Tier 구조)
      - 1️⃣ **WEB Server:** 사용자의 요청이 유입되는 순간 호출되는 앞**단(Front-end)의 정적 페이지(html, css, js, png 등)를 전용으로 처리하는 서버**
      - 2️⃣ **WAS**: 로그인, 검색 등 데이터를 가공하고 처리하는 **뒷단(Back-end)의 동적 페이지(jsp, servlet 등)를 전용으로 처리하는 서버**
      - 미들웨어 담당자는 아래 그림에서의 Client - Database 사이에 위치한 WEB Server / WAS를 관리
        !https://velog.velcdn.com/images%2Funyoi%2Fpost%2Fae449ba8-a2ff-4795-bf49-c557cf318361%2Fimage.png
    - 미들웨어 관리자의 필요성?
      - 어플리케이션 개발 및 운영은 개발팀에서 하는데 미들웨어 관리자의 필요성 의문?
      - 그러나 두 가지 관점에서 바라볼 때 **레거시 환경**에서 운영을 하고 있다면 **미들웨어 담당자의 필요성**
      - 개발 조직에서의 관점
        - **비즈니스 로직을 구상하여 개발하기 바쁘다.**
        - 클라이언트의 요구사항이 중요한 SI/SM업체의 경우 개발의 효율성보다는 _끼워맞추는 식으로라도_ 로직을 처리하는데 시간이 많이 듬. (특히 금융, 커머스, 포털 등 이용자가 많을 수록 서비스의 중요성 대두)
        - 해당 상황에서 개발한 소스가 정상적으로 작동되게끔 만들고 거기에 성능 퍼포먼스 신경
        - 또한, **장애 상황에서 문제 범위가 광범위**
        - 서비스를 운영하다가 접속자가 과도하게 몰려 페이지가 안 열리는 장애가 발생 시 ,실 서버의 자원 사용률은 여유가 있지만 WEB/WAS에 설정된 동시 사용자 수 제한을 초과하거나, DB Connection Pool 부족 등의 소스 내부에서 검출할 수 있는 범위 밖 문제.
        - 개발 조직에서 광범위한 시야를 가지고 이런 문제를 직면한다면 기존 신경써야할 어려움에 직면 (서비스 복구, 원인 분석)
        - **⇒ 소스 개발/운영에 집중하고 사용자를 고려한 서버 튜닝과 분석에 집중**
    - 인프라 조직에서의 관점
      - 어떤 서비스가 유입되고 호출되는 지 모름.
      - 인프라 조직 내부에서도 NW, HW, Hypervisor, OS, DB, MW로 나뉠 만큼 레이어별로 쪼개져 있어, 원인 파악에 어려움이 있음.
      - **⇒ 실제 유입되는 서비스를 알아채고 특정 로직이 수행되면서 인프라 영역에 문제를 알려줄 수 있음.**
  - Express 미들웨어 사용

    - Express는 자체적인 최소한의 기능을 갖춘 라우팅 및 미들웨어 웹 프레임워크, Express 애플리케이션은 기본적으로 일련의 미들웨어 함수 호출.
    - 미들웨어 함수의 기능
      - 모든 코드를 실행.
      - 요청 및 응답 오브젝트에 대한 변경을 실행.  [요청 오브젝트](https://expressjs.com/ko/4x/api.html#req)(`req`), [응답 오브젝트](https://expressjs.com/ko/4x/api.html#res) (`res`)
      - 요청-응답 주기를 종료.
      - 스택 내의 그 다음 미들웨어 함수를 호출.
        - 애플리케이션의 요청-응답 주기 중 **그 다음의 미들웨어 함수 대한 액세스 권한**을 갖음. 그 다음의 미들웨어 함수는 일반적으로 `next`라는 이름의 변수로 표시
        - **현재의 미들웨어 함수가 요청-응답 주기를 종료하지 않는 경우에**는 `next()`를 호출하여 그 다음 미들웨어 함수에 제어를 전달해야 함 그렇지 않으면 해당 요청은 정지된 채로 방치.
    - 애플리케이션 레벨 및 라우터 레벨 미들웨어는 라우트를 설정하여 로드할 수 있음. 일련의 미들웨어 함수를 함께 로드할 수도 있으며, 이를 통해 라우트한 위치에 미들웨어 시스템의 하위 스택을 작성 가능

    ### 애플리케이션 레벨 미들웨어

    `app.use()` 및 `app.METHOD()` 함수를 이용해 애플리케이션 미들웨어를 [앱 오브젝트](https://expressjs.com/ko/4x/api.html#app)의 인스턴스에 바인드하십시오.

    - 이때 `METHOD`는 미들웨어 함수가 처리하는 요청(GET, PUT 또는 POST 등)의 소문자로 된 HTTP 메소드.
    - 앱 오브젝트 인스턴스
      - Express 애플리케이션의 한 개체. `const app = express();`에서 `express()` 함수에 의해 `app`이라는 변수에 할당된 **Express 애플리케이션 인스턴스**
      - ex. `const app = express();`라고 작성할 때 생성되는 `app`이 바로 앱 오브젝트 인스턴스. 이 `app` 오브젝트를 사용해 미들웨어나 라우트를 정의하고, 서버의 여러 설정
    - 바인드(bind)

      - 특정 함수나 미들웨어가 **앱 오브젝트에 연결되도록** 설정.
      - ex. **`app.use()`로 미들웨어를 추가하거나, `app.get()`과 같은 메서드로 특정 경로와 핸들러를 정의할 때 이 함수들이 `app` 오브젝트에 바인드 되는 것.** 바인딩을 하면 Express가 요청을 처리할 때 이 설정을 따라 실행하게 됩니다.
      - ex. 아래 코드에서 로그 미들웨어와 `GET` 요청 핸들러는 `app` 오브젝트에 바인딩된 상태.

        ````jsx
        const express = require("express");
        const app = express();

            // 미들웨어 바인딩
            app.use((req, res, next) => {
              console.log(`${req.method} ${req.url}`);
              next();
            });

            // 라우트 핸들러 바인딩
            app.get("/", (req, res) => {
              res.send("Hello World!");
            });
            ```

        작동 방식
        ````

    ```jsx
    // 마운트 경로가 없는 미들웨어 함수가 표시.
    // 이 함수는 앱이 요청을 수신할 때마다 실행.

    var app = express();

    app.use(function (req, res, next) {
      console.log('Time:', Date.now());
      next();
    });

    // /user/:id 경로에 마운트되는 미들웨어 함수가 표시
    // 이 함수는 /user/:id 경로에 대한 모든 유형의 HTTP 요청에 대해 실행

    app.use('/user/:id', function (req, res, next) {
      console.log('Request Type:', req.method);
      next();
    });

    // 라우트 및 해당 라우트의 핸들러 함수(미들웨어 시스템)이 표시.
    // 이 함수는 /user/:id 경로에 대한 GET 요청을 처리

    app.get('/user/:id', function (req, res, next) {
      res.send('USER');
    });

    // 하나의 마운트 경로를 통해 일련의 미들웨어 함수를 하나의 마운트 위치에 로드.
    // 이 예는 /user/:id 경로에 대한 모든 유형의 HTTP 요청에 대한 요청 정보를 인쇄하는 미들웨어 하위 스택을 표시.

    app.use('/user/:id', function(req, res, next) {
      console.log('Request URL:', req.originalUrl);
      next();
    }, function (req, res, next) {
      console.log('Request Type:', req.method);
      next();
    });

    // 라우트 핸들러를 이용하면 하나의 경로에 대해 여러 라우트를 정의 가능.
    // 아래의 예에서는 `/user/:id` 경로에 대한 GET 요청에 대해 2개의 라우트를 정의.
    **// 두 번째 라우트는 어떠한 문제도 발생키지 않지만, 첫 번째 라우트가 요청-응답 주기를 종료시키므로 두 번째 라우트는 호출되지 않음.**
    // `/user/:id` 경로에 대한 GET 요청을 처리하는 미들웨어 하위 스택이 표시.

    app.get('/user/:id', function (req, res, next) {
      console.log('ID:', req.params.id);
      next();
    }, function (req, res, next) {
      res.send('User Info');
    });

    // handler for the /user/:id path, which prints the user ID
    app.get('/user/:id', function (req, res, next) {
      res.end(req.params.id);
    });

    // 라우터 미들웨어 스택의 나머지 미들웨어 함수들을 건너뛰려면 `next('route')`를 호출하여 제어를 그 다음 라우트로 전달. 
    // 참고: **`next('route')`는 `app.METHOD()` 또는 `router.METHOD()` 함수를 이용해 로드된 미들웨어 함수에서만 작동**
    // `/user/:id` 경로에 대한 GET 요청을 처리하는 미들웨어 하위 스택이 표시.

    app.get('/user/:id', function (req, res, next) {
      // if the user ID is 0, skip to the next route
      if (req.params.id == 0) next('route');
      // otherwise pass the control to the next middleware function in this stack
      else next(); //
    }, function (req, res, next) {
      // render a regular page
      res.render('regular');
    });

    // handler for the /user/:id path, which renders a special page
    app.get('/user/:id', function (req, res, next) {
      res.render('special');
    });
    ```

    ### 오류 처리 미들웨어

    오류 처리 미들웨어는 동일한 방법으로 오류 처리 미들웨어 함수를 정의할 수 있지만, 항상 **4개**의 인수가 필요.

    - `(err, req, res, next)`
    - `next` 오브젝트를 사용할 필요는 없지만, 구조를 유지하기 위해 해당 오브젝트를 지정해야 함. 그렇지 않으면 `next` 오브젝트는 일반적인 미들웨어로 해석되어 오류 처리에 실패.

    ```jsx
    app.use(function (err, req, res, next) {
      console.error(err.stack);
      res.status(500).send("Something broke!");
    });
    ```

    - 오류 처리 미들웨어는 다른 `app.use()` 및 라우트 호출을 정의한 후에 **마지막으로 정의**

    ```jsx
    var bodyParser = require("body-parser");
    var methodOverride = require("method-override");

    app.use(bodyParser());
    app.use(methodOverride());
    app.use(function (err, req, res, next) {
      // Error logic
    });
    ```

    - 미들웨어 함수 내부로부터의 응답은 HTML 오류 페이지, 단순한 메시지 또는 JSON 문자열 등 모든 형식 가능
    - 일반 미들웨어 함수와 구조 동일. ex. `XHR`를 이용한 요청 및 그렇지 않은 요청에 대한 오류 처리를 정의하는 경우, 아래와 같은 명령 사용 가능.

    ```jsx
    var bodyParser = require("body-parser");
    var methodOverride = require("method-override");

    app.use(bodyParser());
    app.use(methodOverride());
    app.use(logErrors);
    app.use(clientErrorHandler);
    app.use(errorHandler);
    ```

    - `logErrors`는 요청 및 오류 정보를 `stderr`에 기록할 수 있음.

    ```jsx
    function logErrors(err, req, res, next) {
      console.error(err.stack);
      next(err);
    }
    ```

    - `clientErrorHandler`는 명시적으로 그 다음 항목으로 전달.

    ```jsx
    function clientErrorHandler(err, req, res, next) {
      if (req.xhr) {
        res.status(500).send({ error: "Something failed!" });
      } else {
        next(err);
      }
    }
    ```

    - `errorHandler` 함수 : 모든 오류를 처리하는(catch-all)

    ```jsx
    function errorHandler(err, req, res, next) {
      res.status(500);
      res.render("error", { error: err });
    }
    ```

    - `next()` 함수로 어떠한 내용을 전달하는 경우 (`next('route')` 제외), Express는 현재의 요청에 오류가 있는 것으로 간주
    - 오류 처리와 관련되지 않은 나머지 라우팅 및 미들웨어 함수를 건너뜀.
    - 이러한 오류를 어떻게든 처리하기 원하는 경우, 다음 섹션에 설명된 것과 같이 오류 처리 라우트를 작성해야 함.
    - 여러 콜백 함수를 갖는 라우트 핸들러가 있는 경우에는 `route` 매개변수를 사용하여 그 다음의 라우트 핸들러로 건너뛸 수 있음.

    ```jsx
    // getPaidContent 핸들러의 실행은 건너뛰지만, /a_route_behind_paywall에 대한 app 내의 나머지 핸들러는 계속하여 실행
    app.get(
      "/a_route_behind_paywall",
      function checkIfPaidSubscriber(req, res, next) {
        if (!req.user.hasPaid) {
          // continue handling this request
          next("route");
        }
      },
      function getPaidContent(req, res, next) {
        PaidContent.find(function (err, doc) {
          if (err) return next(err);
          res.json(doc);
        });
      }
    );
    ```

    - **`next()` 및 `next(err)`에 대한 호출은 현재의 핸들러가 완료되었다는 것과 해당 핸들러의 상태를 표시**.
    - **`next(err)`는 오류를 처리하도록 설정된 핸들러를 제외한 체인 내의 나머지 모든 핸들러를 건너뜀.**

    ### 기본 오류 핸들러

    - Express는 내장된 오류 핸들러와 함께 제공되며, 내장 오류 핸들러는 앱에서 발생할 수 있는 모든 오류를 처리.
    - 이러한 기본 오류 처리 미들웨어 함수는 미들웨어 함수 스택의 끝에 추가됨.
    - **`next()`로 오류를 전달하지만 오류 핸들러에서 해당 오류를 처리하지 않는 경우, 기본 제공 오류 핸들러가 해당 오류를 처리하며, 해당 오류는 클라이언트에 스택 추적과 함께 기록됨.**
    - 스택 추적은 프로덕션 환경에 포함되어 있지 않습니다.
    - 프로덕션 모드에서 앱을 실행하려면 환경 변수 `NODE_ENV`를 `production`으로 설정하십시오.
    - 응답의 기록을 시작한 후에 오류가 있는 `next()`를 호출하는 경우(예: 응답을 클라이언트로 스트리밍하는 중에 오류가 발생하는 경우), Express의 기본 오류 핸들러는 해당 연결을 닫고 해당 요청을 처리 X
    - 따라서 사용자 정의 오류 핸들러를 추가할 때, 헤더가 이미 클라이언트로 전송된 경우에는 다음과 같이 Express 내의 기본 오류 처리 메커니즘에 위임

    ```jsx
    function errorHandler(err, req, res, next) {
      if (res.headersSent) {
        return next(err);
      }
      res.status(500);
      res.render("error", { error: err });
    }
    ```

    - 만약 `next()`를 코드에서 여러 번 호출한다면, 사용자 정의 오류 핸들러가 있음에도 불구하고 기본 오류 핸들러가 발동될 수 있음에 주의

- HTTP 상태 코드
  - 포괄적 상태코드
    | 상태코드 | 포괄적 의미 | 서버 측면의 의미 |
    | -------- | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------- |
    | **1XX** | **Informational(정보 제공)** | 임시 응답으로 현재 클라이언트의 요청까지는 처리되었으니 계속 진행하라는 의미. |
    | **2XX** | **Success(성공)** | 클라이언트의 요청이 서버에서 성공적으로 처리 |
    | **3XX** | **Redirection(리다이렉션)** | 완전한 처리를 위해서 추가 동작이 필요한 경우. 주로 서버의 주소 또는 요청한 URI의 웹 문서가 이동되었으니 그 주소로 다시 시도하라는 의미 |
    | **4XX** | **Client Error(클라이언트 에러)** | 없는 페이지를 요청하는 등 클라이언트의 요청 메시지 내용이 잘못된 경우를 의미 |
    | **5XX** | **Server Error(서버 에러)** | 서버 사정으로 메시지 처리에 문제가 발생한 경우. 서버의 부하, DB 처리 과정 오류, 서버에서 익셉션이 발생하는 경우를 의미 |
  - 자주 쓰이는 상태코드
    | 상태 코드 | 상태 텍스트 | 한국어 뜻 | 서버 측면의 의미 |
    | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------- | --------------- | ---------------------------------------------------------------------------------- |
    | 200 | OK | 성공 | 서버 요청 성공 처리 |
    | 201 | Created | 생성됨 | 요청이 처리되어 새 리소스 생성 |
    | 202 | Accepted | 허용됨 | 요청 접수했지만, 처리 완료 X |
    | (응답 헤더의 Location, Retry-After를 참고하여 클라이언트는 다시 요청) |
    | 301 | Moved Permanently | 영구 이동 | 지정한 리소스가 새로운 URI로 이동 (이동할 곳의 새로운 URI는 응답 헤더 Location에 기록) |
    | 303 | See Other | 다른 위치 보기 | 다른 위치로 요청. |
    | (요청에 대한 처리 결과를 응답 헤더 Location에 표시된 URI에서 GET으로 취득할 수 있습니다. 브라우저의 폼 요청을 POST로 처리하고 그 결과 화면으로 리다이렉트시킬 때 자주 사용하는 응답 코드) |
    | 307 | Temporary Redirect | 임시 리다이렉션 | 임시로 리다이렉션 요청이 필요. |
    | (요청한 URI가 없으므로 클라이언트 메소드를 그대로 유지한 채 응답 헤더 Location에 표시된 다른 URI로 요청을 재송신할 필요가 있음. 클라이언트는 향후 요청 시 원래 위치를 계속 사용) |
    | 400 | Bad Request | 잘못된 요청 | 요청의 구문이 잘못 |
    | 401 | Unauthorized | 권한 없음 | 지정한 리소스에 대한 액세스 권한이 없음. |
    | (응답 헤더 WWW-Authenticate에 필요한 인증 방식을 지정) |
    | 403 | Forbidden | 금지됨 | 지정한 리소스에 대한 액세스가 금지. |
    | (401 인증 처리 이외의 사유로 리소스에 대한 액세스가 금지되었음을 의미. 리소스의 존재 자체를 은폐하고 싶은 경우는 404 응답 코드를 사용.) |
    | 404 | Not Found | 찾을 수 없음 | 지정한 리소스를 찾을 수 없음. |
    | 500 | Internal Server Error | 내부 서버 오류 | 서버에 에러가 발생 |
    | 501 | Not Implemented | 구현되지 않음 | 요청한 URI의 메소드에 대해 서버가 구현하고 있지 않음. |
    | 502 | Bad Gateway | 불량 게이트웨이 | 게이트웨이 또는 프록시 역할을 하는 서버가 그 뒷단의 서버로부터 잘못된 응답을 받음. |

- ES
  - 정의 : JavaScript의 표준규격
  - 역사 : 넷스케이프 사에서 개발한 JS가 인기를 끌고, MS 사에서 개발한 IE 3(인터넷 익스플로어)에 JSscript로 JS를 탑재했지만, 두 내용이 매우 달랐음. 지속적인 기능 추가로 두 언어가 매우 달라지면서 ECMA에서 JS 표준을 정함. ECMA에서는 다른 표준안도 정하기에 숫자를 붙였고 ECMA 262가 JS 표준 규격으로, ECMA Script가 ES로 불리기 시작함.
  - ES6 : ECMA Script 6으로 대폭적인 갱신을 한 2015년을 기준으로, 이후에는 조그만 변화로 버전이 업데이트되기에 통칭하여 ES6이라 불림.
- ES6
  - ES6의 주요 변화 및 특징
    1. Class
       - 정의 : OOP의 핵심 기능. 객체를 생성하기 위한 템플릿.
       - 특징
         - 코드를 더욱 안전하게 캡슐화할 수 있음.
         - 유지보수 쉬움.
         - 함수로 호출 X
         - 블록 스코프
         - 호이스팅 안됨. ⇒ 정의 후 사
       - 방법
         - class 선언: `class` 키워드와 함께 클래스 이름 작성.
         - `new` 키워드 : class 매서드와 속성에 액세스
         - 다른 class에서 상속 :  `extends` 키워드 다음에 상속할 class의 이름을 사용
           ```jsx
           class myClass {
           	**constructor**(name, age) {
           		this.name = name;
           		this.age = age;
           	}

           	sayHello() {
           		console.log(`안녕 ${this.name} 너의 나이는 ${this.age}살이다`);
           	}
           }

           // myClass 메서드 및 속성 상속
           class UserProfile **extends** myClass {
           	userName() {
           		console.log(this.name);
           	}
           }

           const profile = **new** UserProfile('영희', 22); // class

           profile.sayHello(); // 안녕 영희 너의 나이는 22살이다.
           profile.userName(); // 영희
           ```
         - class의 메소드 안에서 `super` 키워드 사용
         - 정적 메소드 : `static`
         - Getter : `get` / Setter : `set`
         - 클래스에서 일반적인 방식으로 프로퍼티를 선언하고 할당하면 **Public Property(공개 프로퍼티)** → 외부에서 프로퍼티에 접근하여 값을 사용하거나 수정이 가능
         - 클래스에서 프로퍼티 앞에 `#` 키워드를 작성하여 선언하면 **Private Property (비공개 프로퍼티)** → 오직 클래스 안에서만 사용, 변경이 가능. 외부 접근 불가
           ```jsx
           class Person {
             constructor(name, age) {
               this.name = name;
               this.age = age;
             }
             nextYearAge() {
               // 메서드 생성
               return Number(this.age) + 1;
             }
           }

           // 클래스 상속
           class introducePerson extends Person {
             constructor(name, age, city, futureHope) {
               // super 키워드를 이용해서 자식 class에서 부모 메서드를 호출
               super(name, age, city);
               this.futureHope = futureHope;
             }
             introduce() {
               return `저는 ${this.city}에 사는 ${this.name} 입니다.
           	내년엔 ${super.nextYearAge()}살이며,
           	장래희망은 ${this.futureHope} 입니다.`;
             }
           }

           let kim = new introducePerson("kim", "23", "seoul", "개발자");
           console.log(kim.introduce());
           ```
    2. let & const
       1. var
          - 재정의, 재선언 모두 가능
          - 문제점
            ① 재선언이 가능하여 예기치 못한 값을 반환 가능성.
            ② 사용 위치와 사용 용도 파악에 어려움.
            ③ 함수 레벨 스코프로 인해 함수 외부에서 선언한 변수는 모두 전역 변수로 됨.
            ④ 변수 선언문 이전에 변수를 참조하면 언제나 undefined를 반환한다. (호이스팅 발생)
       2. let
          - 재정의 가능
          - 재선언 불가능
          - 블록 스코프
       3. const
          - 재정의, 재선언 모두 불가 (객체와 사용할 때는 예외)
          - 블록 스코프
       - Hoisting
         - 정의 : 일반적으로 위에서 아래로 코드가 실행되지만, **변수와 함수의 메모리 공간을 선언 시 미리 할당하는 것**
         - 예시: var 선언한 변수의 경우 호이스팅 시 undefined로 변수 초기화 / let, co로 선언한 변수의 경우 호이스팅 시 변수 초기화 X
         - 원인 : JS 엔진이 전체 코드를 스캔 후, 실행 컨텍스트에 미리 기록하기 때문.
         - 함수 호이스팅 : 선언, 초기화, 할당 모두 가능
           ```jsx
           test("배고파"); // 호이스팅 대상

           function test(e) {
             document.writeln(e);
           }

           test();
           ```
         - var 호이스팅 : 선언, 초기화 가능 / 할당 불가
         - let, const 호이스팅 : 호이스팅되지만 그 전에는 접근 불가능.
           ```jsx
           console.log(name1); // undefined
           var name1 = "James";
           console.log(name1); //James

           console.log(name2); // ReferenceError
           const name2 = "James";

           console.log(name3); // ReferenceError
           let name3 = "James";
           ```
         - TDZ(Temporal Dead Zone) : let, const로 선언된 변수는 호이스팅이 되었지만 접근을 하지 못함. 그래서 `console.log(name2)`, `console.log(name3)` 는 **일시적으로 죽은 구역. name2와 name3 선언문이 나오기 전까지 접근 불가능 영역**
    3. Arrow Function

       - 정의 : 함수 표현식의 간결성, 단순성 높이는 문법

       ```jsx
       // 기본 함수 형식
       let sum = function (a, b) {
         return a + b;
       };

       // 화살표 함수 형식, 중괄호 생략
       let sum = (a, b) => a + b;

       // 인수가 하나일 때
       let sum = (a) => a + 3;

       // 인수가 없을 때
       let sum = () => 3 + 5;

       // 본문이 여러줄일 때
       let sum = (a, b) => {
         a += 2;
         b -= 3;
         return a * b;
       };
       ```

       ```jsx
       // ES6
       let arr2 = myArrary.map((item) => item);

       console.log(arr2); // ["진수", "영철", "영희", 5]
       ```

       - 특징
         - 인수가 하나밖에 없다면 인수를 감싸는 괄호를 생략할 수 있다.
         - 인수가 하나도 없을 땐 괄호를 비워놓으면 된다. 괄호 생략 불가
         - 본문이 한 줄 밖에 없다면 중괄호를 생략할 수 있다.
         - 중괄호는 본문 여러 줄로 구성, 중괄호를 사용했다면 return으로 결괏값을 반환

    4. Promises
       - 정의 : 비동기 코드를 쓰는 방식
       - 예시 : API에서 데이터를 가져오거나 실행하는데 시간이 걸리는 함수를 가지고 있을 때 사용
         ```jsx
         const myPromise = () => {
           return new Promise((resolve, reject) => {
             resolve("안녕하세요 Promise가 성공적으로 실행했습니다");
           });
         };

         cosole.log(myPromise());
         // Promise {<resolved>: "안녕하세요 Promise가 성공적으로 실행했습니다"}

         // 콘솔을 기록하면 Promise가 반환. **따라서 데이터를 가져온 후 함수를 실행하려면 Promise를 사용해야 함.** P**romise는 두 개의 매개 변수를 사용하며 resolve및 reject 예상 오류를 처리 가**
         ```
       - fetch 함수는 Promise 자체를 반환
         ```jsx
         const url = "https://jsonplaceholder.typicode.com/posts";
         const getData = (url) => {
           return fetch(url);
         };

         getData(url)
           .then((data) => data.json())
           .then((result) => console.log(result));
         ```
    5. 비구조화 할당
    - 정의 : 배열 또는 객체의 값을 새 변수에 더 쉽게 할당 / ES5에서는 각 변수에 객체의 속성들을 일일이 할당해야하지만, ES6에서는 객체의 속성을 얻기 위해 값을 중괄호 내에 넣음.
    - 특징
      - 속성 이름과 동일한 변수 이름 지정 - 아닐 시 undefined
      - 다른 이름을 지정할 시에는 : 사용
    ```jsx
    // ES5 문법
    const contacts = {
      famillyName: "이",
      name: "영희",
      age: 22,
    };

    let famillyName = contacts.famillyName;
    let name = contacts.name;
    let myAge = contacts.age;

    console.log(famillyName); // 이
    console.log(name); // 영희
    console.log(age); // 22
    ```
    ```jsx
    // ES6 문법
    const contacts = {
      famillyName: "이",
      name: "영희",
      age: 22,
    };

    let { famillyName, name: ontherName, age } = contacts;

    console.log(famillyName); // 이
    console.log(ontherName); // 영희
    console.log(age); // 22

    // 배열 시
    const arr = ["광희", "지수", "영철", 20];

    let [value1, value2, value3] = arr;

    console.log(value1);
    console.log(value2);
    console.log(value3);
    ```
    1. Template Literals

       ```jsx
       let a = 5;

       // 기존 코드
       console.log("이 수는 " + a * 10 + "입니다."); // 이 수는 50입니다.

       // 템플릿 리터럴 방식
       console.log(`이 수는 ${a * 10}입니다.`); // 이 수는 50입니다.
       ```

       - 특징
         - 문자열 생성시 백틱(`) 사용
         - 백틱 내에서 줄바꿈 반영
         - 변수, 연산 모두 가능

    2. Default parameter

       ```jsx
       // 기본 매개변수 적용 X
       const myFunc = (name, age) => {
         return `안녕 ${name} 너의 나이는 ${age}살 이니?`;
       };

       console.log(myFunc1("영희"));
       // 출력 => 안녕 영희 너의 나이는 undefined살 이니?
       ```

       ```jsx
       const myFunc = (name, age = 22) => {
         return `안녕 ${name} 너의 나이는 ${age}살 이니?`;
       };

       console.log(myFunc1("영희"));
       // 출력 => 안녕 영희 너의 나이는 22살 이니?
       ```

    3. Rest parameter(나머지 매개 변수) & Spread operator(확산 연산자)
       - Rest parameter : 배열의 인수를 가져오고 새 배열을 반환
         ```jsx
         const arr = ['영희', 20, '열성적인 자바스크립트', '안녕', '지수', '어떻게 지내니?'];

         // 비구조화를 이용한 값을 얻기
         const [ val1, val2, val3, **...rest** ] = arr;

         const Func = (restOfArr) => {
         	return restOfArr.filter((item) => {return item}).join(" ");
         }; // 각 개체에 공백

         console.log(Func(rest)); // 안녕 지수 어떻게 지내니?
         ```
       - Spread operator : 인수뿐만 아니라 배열 자체를 가짐.
         ```jsx
         const arr = [
           "영희",
           20,
           "열성적인 자바스크립트",
           "안녕",
           "지수",
           "어떻게 지내니?",
         ];

         const Func = (...anArray) => {
           return anArray;
         };

         console.log(Func(arr));
         // 출력 => ["영희", 20, "열성적인 자바스크립트", "안녕", "지수", "어떻게 지내니?"]
         ```
  - ES6를 중요시 하는 이유
    ES6 전의 버전에서의 다양한 문제점을 토대로 큰 변화가 일어났기 때문. 여러 JS 언어의 한계점을 해결함.
    - 화살표 함수는 기존의 함수 표현식보다 간결
    - this 바인딩과 관련한 혼돈을 줄여줌.
    - 클래스와 모듈 시스템은 대규모 애플리케이션의 개발과 유지보수 용이 (코드의 구조화와 의존성 파악 용이하기 때문)
- ES Modules
  - 정의 : `import`, `export` 를 사용해 분리된 자바스크립트 파일끼리 서로 접근할 수 있는 시스템
  - 생긴 원인 : JQuery가 생겨나고 어플리케이션 규모가 커지는 결과로 script 파일을 나누기 시작하면서, 파일 간의 변수, 함수 등을 전달하는 방법이 필요해짐. ⇒ ESM 이전에는 전역 스코프로 각 script 파일을 사용했지만, 파일 순서나 전역 오염 (하위 script가 상위 script 값 쉽게 변경) 등등 **유지보수의 어려움**이 생김.
  - 특징
    - 모듈은 함수와 변수를 **모듈 스코프**에 넣고, 각 함수는 함수 스코프를 가짐.
    - `export` 로 해당 변수, 함수를 다른 모듈에서 `import`를 통해 의존할 수 있도록 설계됨. ⇒ 의존성 파악 용이 (A 파일이 B 파일을 `import`하고 있을 때, B 파일이 사라지면 `Error : not found B`)
    - 코드들이 각각 독립적으로 사용되어 모듈 재사용화 가능
    - 관계되지 않은 모듈간의 오염 발생 X
  - **Node.js 특징**
    - node.js는 brower보다 모듈화를 위한 대책이 쉬움.
      - CommonJS(require), AMD, Webpack-Babel 등
  - **동작 과정: 구성 ⇒ 인스턴스화 ⇒ 평가**
    - 브라우저의 JS는 파일 자체를 사용 불가하기 때문에 **모듈 레코드**라고 하는 데이터 구조로 변환. 이 과정에서 해당 파일의 모든 구문을 분석할 필요성
    - 파일 불러오는 **로더(loader)**, 이는 ES 모듈 명세서가 아닌 **HTML 명세서**를 따른다. 그래서 `script` 태그에 `type=”module”`을 적어 entry 파일로 지정
    1. 구성
       - **loader**가 entry 파일부터 `import`문을 찾아가며 필요한 모든 파일의 **모듈 레코드**로 구문 분석
         1. 모듈이 들어있는 파일을 어디서 다운로드하는지
         2. 파일을 가져옴 (URL or 파일 시스템)
         3. 파일을 모듈 레코드로 구문 분석
    2. 인스턴스화
       1. `export`된 모든 값을 배치하기 위한 **메모리 공간**을 찾는다.
       2. **`export`와 `import`들이 각각 해당 메모리 공간을 가리키도록** 한다. ⇒ **linking(연결)** (실제 값을 채우지는 않음)
    3. 평가
       - 코드를 실행하여 메모리를 변수의 **실제 값으로 채움.**
  - ESM과 CommomJS 차이점
    - CommomJS
      - 파일 시스템에서 파일 로드
      - **파일을 불러오는 동안 주 스레드\***(하나의 프로세스 내에서 여러 개의 실행 흐름(단일, 동시적, 병렬적)을 두어 작업을 효율적으로 처리하기 위한 모델)**\*를 차단**
      - 이는, 파일 로드 ⇒ 구문 분석 ⇒ 인스턴스화 ⇒ 평가가 각 파일마다 바로 실행
      - 모듈 지정자에 변수 지정 가능
      - export 객체에 값을 복사해서 넣음.
    - ES Module
      - entry 파일의 구문 분석 후 의존성(import)을 확인하여 해당 의존성 파일을 찾아 다시 구문 분석 (반복)
      - **파일을 불러오는 동안 주 스레드를 차단하지 않음**.
      - **이는, 인스턴스화, 평가는 구문 분석할 의존성(import)이 발견되지 않으면 실행 X**
      - 모듈 지정자에 변수 지정 불가능 (**동적 `import`**를 사용하면 가능)
      - `export`는 **참조**를 반환하는 함수 정의
      - 동적 `import`는 별개의 entry 파일로 취급되어 새로운 그래프를 만듬.
    - **차이점 결과**
      - **`export`하는 파일에서 비동기 처리로 값이 바뀐다면**, CommonJS에서는 반영이 되지 않지만, **ESM은 반영**될 수 있음. (방법 : **비동기로 다시 호출**)
      - 순환 참조의 경우, CommonJS는 빈 객체를. ESM은 ReferenceError 발생
        - [https://yoeubi28.medium.com/commonjs-esm-모듈-순환-참조-차이-e5cd1047deaf](https://yoeubi28.medium.com/commonjs-esm-%EB%AA%A8%EB%93%88-%EC%88%9C%ED%99%98-%EC%B0%B8%EC%A1%B0-%EC%B0%A8%EC%9D%B4-e5cd1047deaf)
  - **사용 방법**
    - export
      - named export : 한 파일에서 여러 개를 export할 때 사용 가능
        - `export`한 이름과 **동일한 이름**으로 `import`해야 하며, 중괄호에 묶어서 `import` 해야 한다.
        ```jsx
        // named export 기본 형식
        export { 모듈명1, 모듈명2 };
        import { 모듈명1, 모듈명2 } from "js 파일 경로";
        ```
        1. 내보내고자 하는 변수, 함수 앞에 export 붙이기

           ```jsx
           export const a = 1; // 변수
           export function 함수명() {} // 함수
           export class 클래스명 {} // Class
           ```

        2. 묶어서 내보내기
           `export { a, 함수명, 클래스명 }`
      - default export : 하나의 파일에서 단 하나의 변수 또는 클래스 등등만 `export` 가능
        - 또한 `import` 할 때 아무 이름으로나 자유롭게 `import` 가능하며, 중괄호에 묶지 않아도 된다.
        ```jsx
        // default export 기본 형식
        export default 모듈명;
        import 모듈명 from "js 파일 경로";
        ```
        1. 선언 및 내보내기 동시에 함. 변수, 함수 앞에 export default 붙이기

           ```jsx
           // 변수값은 default로 선언, 내보내기가 동시에 되지 않는다
           export default const a = 1 // 안됨.

           // 파일명.js
           export default function 함수명(){}

           // 파일명.js
           export default class 클래스명{}
           ```

        2. 선언 후 내보내기.

           ```jsx
           //파일명.js
           const a = 1
           export default a

           // 파일명.js
           function 함수명(){}
           export default 함수명

           // 파일명.js
           class 클래스명{}
           export default 클래스명
           ```
    - import
      - named export를 import
        ```jsx
        import { a } from "파일명.js";
        import { fn } from "파일명.js";
        import { Class } from "파일명.js";
        ```
      - default export를 import
        ```jsx
        import a from "파일명.js";
        import 함수명 from "파일명.js";
        import 클래스명 from "파일명.js";

        // default의 경우 변수명은 원하는대로 바꿔도 된다.
        ```
    - as : 다른 이름으로 import 하려면 `as`를 사용하고, 한 파일에 있는 클래스나 변수들을 한 번에 import 하려면 `* as`를 사용한다.
      ```jsx
      // named export는 중괄호 포함 import
      import { named1, named2 } from './example.js';

      // named export에서 as를 사용하여 다른 이름으로 import
      import { named1 **as** myExport, named2 } from './example.js';

      // 한 파일에 있는 **모든 클래스나 변수를 * as를 사용하여 한 번에 import**
      import *** as Hello** from './example.js';
      ```
    - 예시
      ```jsx
      // detailComponent.js - detail 함수 export
      export default function detail(name, age) {
        return `안녕 ${name}, 너의 나이는 ${age}살 이다!`;
      }

      // homeComponent.js - detail 함수 import
      import detail from "./detailComponent";

      console.log(detail("영희", 20));
      // 출력 => 안녕 영희, 너의 나이는 20살 이다!

      // 둘 이상의 모듈을 가져오는 경우 중괄호 {}
      import { detail, userProfile, getPosts } from "./detailComponent";

      console.log(detail("영희", 20));
      console.log(userProfile);
      console.log(getPosts);
      ```
- 프로젝트 아키텍처
  - 정의 : 시스템을 구성하는 각 요소 간의 관계를 정의하는 기본 구조
    ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/be529c40-bd56-451c-ba01-84f0a39b6ba2/image.png)
  - 프로젝트 아키텍처가 중요한 이유
    - 시스템의 구조를 정의하고, 각 구성 요소 간의 관계를 명확성을 높임. ⇒ **프로젝트의 확장성과 유지보수성** (프로젝트의 요구사항을 명확히 이해)
    - 고려해야 할 요소
      - 시스템의 확장성
      - 성능
      - 보안
      - 유지보수성
    - 기술적 요소 + 비즈니스 요구사항도 반영
  - Service-Oriented Architecture(Service Layer Pattern)
    - 정의 : **서비스**라는 소프트웨어 구성 요소를 사용해 비즈니스 애플리케이션을 생성하는 소프트웨어 개발 방식
      - 예시 : 조직 내의 여러 비즈니스 프로세스에서 사용자 인증 기능이 필요할 경우, 모든 비즈니스 프로세스에 대해 인증 코드를 재작성하는 대신에 **단일 인증 서비스를 생성해서 모든 애플리케이션에 재사용**
    - **전체 시스템에 대해 컴포넌트 들을 모아서 서비스 단위로 모듈화** 한 것. 이런 서비스가 기본 구성요소로 비즈니스 기능을 제공하며 **서비스들 간에 결합을 통해 기능을 제공.** 이렇게 함으로써 **각 서비스는 다른 애플리케이션에서 재사용**할 수 있는 장점
    !https://blog.kakaocdn.net/dn/pbdE9/btsGeKPx5d3/djDdhM4XKYBXY3kKv9wY51/img.png
    - 장점 (모든 프로세스가 단일 단위로 실행되는 기존의 모놀리식 아키텍처에 비해)
      1. 출시 기간 단축
         - 개발자는 시간과 비용을 절약하기 위해 다양한 비즈니스 프로세스에서 서비스를 재사용. 새로 코드를 작성하고 통합을 수행하는 것보다 SOA를 사용하여 훨씬 빠르게 애플리케이션을 모을 수 있음.
      2. 효율적인 유지 보수
         - 모놀리식 애플리케이션의 큰 코드 블록보다 **작은 서비스를 생성, 업데이트 및 디버그하는 것**이 더 쉽움. SOA에서 서비스를 수정해도 비즈니스 프로세스의 전체 기능에는 영향 없음.
      3. 높은 적응성
         - SOA는 기술 발전에 더 잘 적응하기에 효율적이고 **경제적으로 애플리케이션을 현대화**할 수 있음. 예를 들어 의료 기관은 최신 클라우드 기반 애플리케이션에서 기존 전자 건강 기록 시스템의 기능을 사용 가능.
      ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/b5164ebf-f314-42a0-8e0c-8f649a9b975d/image.png)
  - MVC 패턴 (모델-뷰-컨트롤러)
    - 정의 : 사용자 인터페이스, 데이터 및 논리 제어를 구현하는데 널리 사용되는 소프트웨어 디자인 패턴. **소프트웨어의 비즈니스 로직과 화면을 구분하는데 중점**
      ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/f7fb0d06-b028-4278-a7a4-e2eab14121e8/image.png)
    - ex. 쇼핑 리스트 앱 (이번 주에 사야할 각 항목의 이름, 개수, 가격의 목록)
      ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/8d7dedd5-fb0d-4735-97c3-7b60e0733eff/image.png)
    - **모델**: 데이터와 비즈니스 로직을 관리
      - 앱이 포함해야할 데이터가 무엇인지를 정의
      - **데이터의 상태가 변경**되면, 모델을 일반적으로 **뷰**에게 알리며(따라서 필요한 대로 화면을 변경 가능) 가끔 **컨트롤러**에게 알리기도 함. (업데이트 된 뷰를 조절하기 위해 다른 로직이 필요한 경우).
      - 이후 쇼핑 리스트 앱에서, **모델은 리스트 항목이 포함해야 하는 데이터(품목, 가격 등)와 이미 존재하는 리스트 항목이 무엇**인지를 지정.
    - **뷰**: 레이아웃과 화면을 처리
      - 앱의 데이터를 보여주는 방식 정의
      - 쇼핑 리스트 앱에서, **뷰는 항목이 사용자에게 보여지는 방식을 정의하며 표시할 데이터를 모델로부터 받음.**
    - **컨트롤러**: 모델과 뷰로 명령을 전달
      - 앱의 사용자로부터의 **입력에 대한 응답으로 모델 및 뷰를 업데이트하는 로직**을 포함
      - 쇼핑 리스트는 항목을 추가하거나 제거할 수 있게 해주는 입력 폼과 버튼을 갖음. 이러한 액션들은 **모델이 업데이트**되는 것이므로, **입력이 컨트롤러에게 전송**되고, **모델을 적당하게 처리한** 다음, **업데이트된 데이터를 뷰로 전송**
      - 단순히 데이터를 다른 형태로 나타내기 위해 뷰를 업데이트 하는 경*(예를 들면, 항목을 알파벳 순서로 정렬, 가격이 낮은 순서 또는 높은 순서로 정렬).* 이런 경우에 컨트롤러는 모델을 업데이트할 필요 없이 바로 처리 가능
  - 그 외 다른 패턴 종류
    참조 : https://mingrammer.com/translation-10-common-software-architectural-patterns-in-a-nutshell/
    1. 계층화 패턴 (Layered pattern)
    2. 클라이언트-서버 패턴 (Client-server pattern)
    3. 마스터-슬레이브 패턴 (Master-slave pattern)
    4. 파이프-필터 패턴 (Pipe-filter pattern)
    5. 브로커 패턴 (Broker pattern)
    6. 피어 투 피어 패턴 (Peer-to-peer pattern)
    7. 이벤트-버스 패턴 (Event-bus pattern)
    8. 블랙보드 패턴 (Blackboard- pattern)
    9. 인터프리터 패턴 (Interpreter pattern**)**
  - 그 외 다른 프로젝트 구조
    - 모노리스 아키텍처
      - 전체 애플리케이션을 한 덩어리인 결과물. 즉, 배포할 때에 결과물도 하나인 경우
      - 과거에 많이 사용된 아키텍처
      - 성능 상 문제 : 여러 모노리스 애플리케이션을 배치해 **수평 확장**하는 구조이기에 구조가 쉽게 망가짐.
      - 또, 운영 측면에서 단일 큰 바이너리이기 때문에 배포할 때에 더 많은 자원이 필요.
      - 장점: 초기 개발적인 측면에서는 아주 빠르게 개발을 시작할 수 있고, 리팩토링을 통해 내부구조를 개선 용이.
    - 계층형(Layered) 아키텍처
      - 가장 단순하고 전통적인 아키텍처
      - **수평으로 계층 분할 (**같은 계층 내에서 여러 영역으로 구분)
        !https://blog.kakaocdn.net/dn/pbdE9/btsGeKPx5d3/djDdhM4XKYBXY3kKv9wY51/img.png
      - 패턴
        - 프레젠테이션
        - 비즈니스 로직
        - 데이터 엑세스 계층
      - 제약사항
        - 계층은 바로 아래 계층에만 의존.
        - 의존하는 방향은 위에서 아래 방향만 (느슨한 경우 여러 계층은 뛰어 넘은 아래 계층을 의존)
        - 하위 계층의 구현체에 의존하기 보다는 **인터페이스에 의존하는 게 유리**. (유연한 구조.
    - CBD(Component Based Development)
    - 헥사고날(Hexagonal) 아키텍처
    - 클린 아키텍처
    - 마이크로서비스(Microservice) 아키텍처
    - https://ospace.tistory.com/977
- 비즈니스 로직 (도메인 로직)
  - 비즈니스, 도메인 (소프트웨어 공학적) : 소프트웨어가 해결하고자하는 현실 문제. 소프트웨어가 존재하는 이유, 목적
    - 예시: 은행 앱 - (도메인) 금융 및 은행 업무 / SNS - (도메인) 동영상 촬영, 감상, 댓글, 공유
  - 비즈니스 로직과 어플리케이션 서비스 로직의 구분 척도 : **비즈니스에 대한 의사결정**
    - 입력 값을 보여주거나, 결과물 해석 및 전파 → 어플리케이션 서비스 로직
  - 예시: 홈페이지 회원가입 ⇒ **도메인**
    - _회원가입 이라는 현실 문제에 대한 의사결정을 하는가?_
    사용자는 회원가입 양식 폼에 회원정보를 작성하고, 회원가입 버튼을 누르면 회원가입이 진행되지만, 프로그래머는 이 과정 중 **아이디 중복 검사, 본인 인증, 비밀번호 재검사 등 유저가 통과해야 할 것을 설계**
    - **비즈니스 로직 : 하나는 중복 아이디가 있는지 없는지를 검사하기 위한 일련의 과정. 데이터 가공을 담당하는것** (**Logic 영역, Model 영역)**
      1. 회원이 작성한 아이디 값 저장하기 - _어플리케이션 서비스 로직_
      2. 회원정보가 있는 데이터베이스 연결 - _어플리케이션 서비스 로직 (Persistence)_
      3. 데이터베이스에 회원이 작성한 아이디 값이 있는지 `Select` - _비즈니스 로직_
      4. 회원의 아이디가 이미 있는지 없는지 여부를 데이터화 하여 저장 - 비즈니스 로직
      5. 데이터베이스 연결 끊기 - _어플리케이션 서비스 로직 (Persistence)_
      6. View 영역에게 가공된 데이터 전달하여 맞는 메세지 띄우기 - 어플리케이션 서비스 로직 (UI)
    - **어플리케이션 서비스 로직 : 유저에게 단순히 텍스트나 다이얼로그로 알려주는 것.** (**가공된 데이터를 단순히 표시만 해주는 것.**) (**Presentation 영역 혹은 View 영역)**,
      - **“아이디가 중복됬습니다.”, “비밀번호 재검사를 실패했습니다.” 표시**
- DTO (Data Transfer Object)
  - 정의 : 데이터를 옮기는 객체. **계층 사이사이 간 데이터를 전송할 때 사용**. **클라이언트로부터 전송 받은 데이터를 객체로 변환할 때도 사용**
  - 사용 이유
    - **클라리언트에서 데이터를 담아 요청을 할 때, 데이터가 부분적으로 없어지는 경우나 원하는 형태로 전달되지 않을 경우를 대비하여, 유효성 검사(데이터 유무, 형태 확인)**
    - 클라이언트의 데이터가 달라질 경우, DTO의 내용만 수정하면 Service를 수정하지 않아도 되어 편리
  - ex. **Service에서 `req.body`의 json 객체를 바로 사용하는 대신, Controller에서 `req.body`를 dto 형태로 받아 service에게 dto로 값을 전달**
  1. **Service에서 DTO 생성 시**
     - DB에서 DB 테이블을 repositoty가 받아 넘겨 줄 때, Service → Controller로 넘겨줌. 이 때 DB 테이블을 DTO로 생성. Controller는 DTO를 받아 사용
     - 장점: DTO로 데이터를 걸러 Controller로 전달하여 Controller에서 작업할 때 DB의 일부 민감한 정보를 숨김.
  **2. Controller에서 DTO 생성**
  - 클라이언트에게 res.body에 json 객체에 데이터를 받았을 때, Controller → Service로 넘겨줌. 이때, 데이터를 DTO로 생성. Service는 DTO를 받아 사용
  - 장점: 서비스 함수의 범용성 증가 ⇒ 유지 보수에 용이

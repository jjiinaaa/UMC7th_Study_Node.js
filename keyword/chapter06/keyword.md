- ORM
  - 객체와 관계형 데이터베이스의 데이터를 자동으로 매핑해주는 것
    - 객체 지향 프로그래밍은 **클래스**를 사용하고, 관계형 데이터베이스는 **테이블**을 사용
    - **객체 모델과 관계형 모델 간에 불일치가 존재하는 데, ORM을 통해 객체 간의 관계를 바탕으로 SQL을 자동으로 생성하여 불일치를 해결해줍니다.**
  - **데이터베이스 데이터 ← 매핑 → Object 필드**
    - 객체를 통해 간접적으로 데이터베이스 데이터 조작
  - Persistant API라고도 부름.
    - Ex) JPA, Hibernate
- Prisma 문서 살펴보기
  - ex. Prisma의 Connection Pool 관리 방법
    - Connection Pooling : 데이터베이스와의 연결을 일정 개수만큼 유지해 필요할 때마다 이를 재사용하고, 요청이 끝나면 연결을 다시 풀에 반환하는 방식
    `PrismaClient` 인스턴스가 데이터베이스와 연결할 때 이루어지며, 이때, Prisma는 자동으로 연결 풀을 관리해줌.
    1. 기본적인 Connection Pool 관리
    - `PrismaClient` 인스턴스를 사용할 때 자동으로 연결 풀을 생성하여, **필요한 경우 새 연결을 추가하고 사용하지 않는 연결을 해제하는 방식**으로 동작. **특히 데이터베이스 연결을 유지하면서 필요한 연결만 사용할 수 있게 하여 성능 최적화**
    2. Connection Pool 크기 설정
    - 직접적으로 Connection Pool을 관리하기보다는 사용 중인 데이터베이스 드라이버 (MySQL 등등)의 Connection Pool 설정을 사용.
    - 각 데이터베이스 드라이버는 환경 변수를 통해 연결 수와 관련된 설정을 조정할 수 있으며, Prisma가 이를 활용해 풀 크기 등을 설정
    - 특정 환경 변수나 설정을 통해 연결 풀의 크기 조정 가능
      - ex. `DATABASE_URL`에 연결 문자열과 함께 `pool_size` 매개변수를 설정 가능
      - PostgreSQL, MySQL, SQL Server 등 대부분의 관계형 데이터베이스는 `DATABASE_URL`에서 연결 풀 크기를 정의.
      - 기본적으로, Prisma는 **5~10개**의 연결을 사용하지만, 아래와 같이 `connection_limit` 매개변수를 통해 조정 가능.
      ```
      // .env 파일
      DATABASE_URL="postgresql://user:password@localhost:5432/dbname?connection_limit=10"
      ```
    3. Connection Pool 설정 옵션
    - 다양한 연결 풀 **옵션**을 지원하며, DB마다 약간의 차이 존재
      - `connection_limit` or `pool_size`: 최대 연결 수를 설정하여 동시에 사용할 수 있는 연결의 수를 제한
      - `timeout`: 각 연결의 타임아웃 시간을 설정하여 비활성 연결이 일정 시간 이후 해제
      - `pool_min`, `pool_max` : 연결 풀의 최소, 최대 설
    4. 서버리스 환경에서의 연결 관리
    - **서버리스 환경**(AWS Lambda, Vercel 등)에서는 데이터베이스 연결을 짧은 시간 내에 빈번히 생성하고 닫기 때문에 **연결 풀이 과부하될 가능성 존재**. Prisma에서는 이를 방지하기 위해 `@prisma/client`를 **서버리스 함수 밖에서 생성하고 재사용**하거나, **Prisma Data Proxy**를 사용하는 것 권장
    - **`@prisma/client`, `prisma` 객체를 전역으로 선언**
      ```jsx
      import { PrismaClient } from "@prisma/client";

      const prisma = new PrismaClient();

      export default async function handler(req, res) {
        const data = await prisma.user.findMany();
        res.json(data);
      }
      ```
    5.  `disconnect`와 `connect` 메서드
    - `prisma.$disconnect()`와 `prisma.$connect()` 메서드를 제공해 명시적으로 연결을 열거나 닫을 수 있음.
    - 서버리스 환경에서는 작업 후 `disconnect`를 호출해 불필요한 연결이 유지되지 않도록 관리
      ```jsx
      // 연결을 닫을 때
      await prisma.$disconnect();
      ```
  - ex. Prisma의 Migration 관리 방법
    - 데이터베이스 마이그레이션(Database Migration) : 데이터베이스의 구조나 스키마(테이블, 컬럼, 인덱스, 관계 등)를 변경하는 과정.
      - 마이그레이션은 일반적으로 애플리케이션이 진화하면서 데이터베이스의 구조를 지속적으로 수정해야 하는 경우에 사용.
      - ex. 새로운 기능을 추가하거나 기존 기능을 수정할 때 데이터베이스에 새로운 테이블이 필요하거나 기존 컬럼의 데이터 타입을 바꾸는 경우.
    - Prisma에서 Migration(데이터베이스 마이그레이션) 관리는 `Prisma Migrate`라는 도구를 사용해 수행.
    - `Prisma Migrate`는 Prisma 스키마 파일을 기반으로 데**이터베이스 구조를 생성, 수정, 삭제하는 작업을 자동화**하며, **데이터베이스와 스키마의 상태를 일관되게 유지**
    1. Prisma Migrate 초기화
    - 마이그레이션을 시작하려면 프로젝트에 `Prisma`를 초기화하고 스키마 파일을 생성
      ```bash
      // schema.prisma 파일 및 기본적 prisma 디렉토리 구조 생성
      npx prisma init
      ```
    2. 스키마 파일 설정
    - `schema.prisma` 파일에서 모델, 필드, 관계 등을 정의. 이 파일은 데이터베이스 구조의 핵심으로, 이를 변경하면 마이그레이션이 생성됨.
      ```jsx
      model User {
        id    Int     @id @default(autoincrement())
        name  String
        email String  @unique
        posts Post[]
      }

      model Post {
        id        Int      @id @default(autoincrement())
        title     String
        content   String?
        published Boolean  @default(false)
        authorId  Int
        author    User     @relation(fields: [authorId], references: [id])
      }
      ```
    3. 마이그레이션 생성
    - 스키마 파일을 수정한 후 마이그레이션을 생성
      ```bash
      npx prisma migrate dev --name <migration_name>
      ```
    - `-name`: 마이그레이션의 이름을 지정하여 변경의 내용을 쉽게 구분
    - `dev`: 개발 환경에서 사용하는 옵션으로, 데이터베이스에 즉시 변경 사항을 적용.
    - 해당 명령을 실행하면 `prisma/migrations` 폴더에 각 마이그레이션의 SQL 파일이 생성
    4. 마이그레이션 적용
    - 배포 환경에서는 `prisma migrate deploy` 명령을 통해 누적된 마이그레이션을 데이터베이스에 적용.
      ```bash
      npx prisma migrate deploy
      ```
    - 해당 명령은 미적용 마이그레이션을 순서대로 실행하며, 배포 환경에서도 데이터베이스 구조가 최신 상태로 유지되도록 함.
    5. 마이그레이션 상태 확인
    - 현재 마이그레이션의 상태를 확인하려면 다음 명령어를 사용.
      ```bash
      npx prisma migrate status
      ```
    - 해당 명령은 데이터베이스의 마이그레이션 상태를 검사해 어떤 마이그레이션이 적용되었고, 누락된 것이 있는지 확인.
    6. 마이그레이션 리셋
    - 개발 중 데이터베이스를 초기화하고 싶다면 마이그레이션을 리셋할 수 있음. 해당 **명령은 데이터베이스의 모든 데이터가 삭제**되므로, 개발 환경에서만 사용.
    ```bash
    bash
    코드 복사
    npx prisma migrate reset

    ```
    7. 마이그레이션 관리 및 주의 사항
    - **데이터 손실 방지**: 마이그레이션은 데이터베이스 구조를 변경하기 때문에 기존 데이터가 손실될 수 있음. `migrate dev` 명령은 데이터 손실 가능성이 있을 때 경고를 표시하며, 스키마 변경 전에 검토 필요.
    - **버전 관리**: `prisma/migrations` 디렉토리에 생성된 각 마이그레이션 파일은 코드처럼 버전 관리 시스템(git 등)으로 관리하는 것 지향.
    - **프로덕션 환경**에서는 `migrate dev` 대신 `migrate deploy`를 사용해 데이터를 안전하게 유지
- ORM(Prisma)을 사용하여 좋은 점과 나쁜 점
  - 장점
    - 객체 지향적인 코드로 인해 더 직관적이고, 비즈니스 로직에 더 집중 가능
      - ORM을 이용하면 SQL 쿼리가 아닌 **직관적인 코드로 데이터를 조작 가능**
      - 선언문, 할당, 종료 같은 **부수적인 코드가 없거나 감소**
      - 각종 객체에 대한 코드를 별도록 작성하기 때문에 **코드의 가독성 증가**
      - SQL의 절차적이고 순차적인 접근이 아닌 **객체 지향적인 접근으로 인해 생산성이 증가**
    - 재사용성 및 유지보수의 편리성 증가
      - **ORM은 독립적으로 작성되어있고, 해당 객체들을 재활용 가능**
      - **매핑정보가 명확하여 ERD를 보는 것에 대한 의존도 감소**
    - DBMS에 대한 종속성 감소
      - 대부분 ORM 솔루션은 DB에 종속적이지 않음. ( **= 구현 방법 뿐만 아니라 많은 솔루션에서 자료형 타입까지 유효하다는 것.**)
      - 개발자는 Object에 집중함으로써 극단적으로 DBMS를 교체하는 거대한 작업에도 비교적 적은 리스크와 시간 감소
  - 단점
    - ORM으로만 서비스 구현 어려움.
      - 설계의 신중함.
      - 프로젝트가 복잡할수록 난이도 증가.
      - 잘못 구현된 경우에 속도 저하 및 심각할 경우 일관성이 없어짐.
    - 프로시저가 많은 시스템에서는 ORM의 객체 지향적인 장점을 활용하기 어려움.
      - 프로시저 : DB에 대한 일련의 작업을 정리한 절차를 관계형 데이터베이스 관리 시스템에 저장한 것
      - 이미 프로시저가 많은 시스템에서는 다시 객체로 바꿔야함, 그 과정에서 생산성 저하나 리스크 다수 발생
  - Prisma 장점
    - 안전한 쿼리 작성: SQL Injection 공격을 방지할 수 있도록 안전한 쿼리 작성 보장
    - 확장성: 다양한 데이터베이스를 지원하며, 데이터베이스 변화 대응
    - 타입 안정성: TypeScript를 지원하며, 타입 안정성 보장
    - 간편한 관계 설정: 다양한 관계 설정을 지원하며, 간편하게 관계 설정
- 다양한 ORM 라이브러리 살펴보기

  - ex. Sequelize
    https://velog.io/@cadenzah/series/Sequelize-API-Document
    1. 설치 및 초기화

       ```
       // 패키지 설
       yarn init -y
       yarn add mysql2 sequelize
       yarn add global sequelize-cli

       // 초기화
       sequelize init

       // 초기화 진행 후 해당 폴더 구조 출력
       .
       |-- README.md
       |-- config // 데이터베이스 설정 파일, 사용자 이름, DB 이름, 비밀번호 등의 정보
       |   `-- config.json
       |-- migrations // git과 비슷하게, 데이터베이스 변화하는 과정들을 추적해나가는 정보로, 실제 데이터베이스에 반영할 수도 있고 변화를 취소 가능
       |-- models // 데이터베이스 각 테이블의 정보 및 필드타입을 정의하고 하나의 객체로 모음.
       |   `-- index.js
       |-- package.json
       |-- seeders // 테이블에 기본 데이터를 넣고 싶은 경우에 사용
       `-- yarn.lock
       ```

    2. 설정
       - 터미널에서 _instargram DB 생성_
         ```
         mysql -uroot -p # 입력하고 비밀번호 입력

         create database instagram;
         use instagram;
         ```
       - `config.json`
         ```jsx
         "development": {
           "username": "root",
           "password": "root",
           "database": "instagram",
           "host": "127.0.0.1",
           "dialect": "mysql",
           "operatorsAliases": false
         }

         "test" : {

         }

         "prodiction" : {

         }
         ```
    3. 모델 생성 후 DB 반영
       - Sequelize CLI를 통해서 모델을 생성할 수 있고 마이그레이션을 통해 실제 데이터베이스에 반영 가능. `User` 라는 모델을 생성해서 이 작업
         ```
         sequelize model:generate --name User --attributes user_id:integer,user_name:string
         ```
       - `model/user.js`
         ```jsx
         "use strict";
         module.exports = (sequelize, DataTypes) => {
           const User = sequelize.define(
             "User",
             {
               user_id: DataTypes.INTEGER,
               user_name: DataTypes.STRING,
             },
             {}
           );

           User.associate = function (models) {
             // associations can be defined here
             // 모델에 있는 필드들의 타입을 정의
             // 각 모델간의 관계를 설정하는 associate
           };

           return User;
         };
         ```
       - `migrations/[타임스탬프]-create-user.js`
         - 마이그레이션 파일이 타임스탬프 접미사와 같이 생성되고, `id` , `createdAt` , `updatedAt` 필드가 자동으로 생성.
         - `up` 프로퍼티 : 실제 DB에 적용되는 부분
         - `down` 프로퍼티 : 이 작업을 취소하는 부분.
         - (여기선 `user_id` 를 primary key로 사용할 것이고 `createdAt` 과 `updatedAt` 이 필요없으니 수정)
         ```jsx
         'use strict';
         module.exports = {
           up: (queryInterface, Sequelize) => {
             return queryInterface.createTable('Users', {
              /*
               id: {
                 allowNull: false,
                 autoIncrement: true,
                 primaryKey: true,
                 type: Sequelize.INTEGER
               },
              */
               user_id: {
                 type: Sequelize.INTEGER
                 primaryKey: true
               },
               user_name: {
                 type: Sequelize.STRING
               },
               /*
               createdAt: {
                 allowNull: false,
                 type: Sequelize.DATE
               },
               updatedAt: {
                 allowNull: false,
                 type: Sequelize.DATE
               }
               */
             }, {
         	    timestamp: false
             }
             );
             User.associate = function(models) {
         		   // associations can be defined here
         		   // 모델에 있는 필드들의 타입을 정의
         		   // 각 모델간의 관계를 설정하는 associate
             }
           },
           down: (queryInterface, Sequelize) => {
             return queryInterface.dropTable('Users');
           }
         };
         ```
       - DB 반영, 터미널
         ```
         	// DB 반영
         sequelize db:migrate

         // mysql에 확인
         desc users;

         // 마이그레이션 취소
         sequelize db:migrate:undo
         ```
    4. CRUD
       - `index.js`
         ```jsx
         const models = require("./models");
         ```
       - Create
         ```jsx
         models.User.create({
           user_name: "John",
         }).then((_) => console.log("Data is created!"));
         ```
       - Read
         ```jsx
         models.User.findAll().then(console.log);
         ```
       - Update
         수정할 부분을 찾은 후에 수정 : `findOne` 을 사용하고 그 다음 `update` 를 수행
         ```
         models.User.findOne({ where: { user_name: "John" }})
         .then(user => {
           if (user) {
             user.update({ user_name: "Bob" })
             .then(r => console.log("Data is updated!"));
           }
         });
         ```
       - Delete
         ```jsx
         models.User.destroy({ where: { user_name: "Bob" } }).then((_) =>
           console.log("Data was deleted!")
         );
         ```
    5. 기존 DB에서 모델 추출
       - mysql에서 sql로 테이블 생성
         ```sql

         create table photos(photo_id int not null auto_increment, photo_url varchar(100) not null, primary key(photo_id));
         ```
       - sequelize-auto 로 추출
         - `-o` 는 결과물 경로, `-d` 는 DB 이름, `-h` 는 호스트 이름, `-u` 는 사용자, `-p` 는 포트, `-x` 는 비밀번호, `-e` 는 데이터베이스 종류. 실행하면 `users` , `photos` 테이블에 대한 모델이 추출
         ```
         sequelize-auto -o "./models" -d instagram -h localhost -u root -p 3306 -x 0000 -e mysql
         ```
  - ex. TypeORM
    [https://gkqlgkql.tistory.com/entry/TypeORM-간단-사용법](https://gkqlgkql.tistory.com/entry/TypeORM-%EA%B0%84%EB%8B%A8-%EC%82%AC%EC%9A%A9%EB%B2%95)
    https://aonee.tistory.com/77
    1. 설치

       ```
       $ npm i typeorm -g

       $ typeorm init --name 프로젝트이름 --database 데이터베이스
       ```

       ![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/f1912130-0409-4e90-a90f-6091ae253e73/6a9424ee-601e-4198-9f83-3e6874441a92/image.png)

    2. ORM 설정
       - `ormconfig,json`
         ```jsx
         {
            "name": "default",
            "type": "mysql",
            "host": "localhost",
            "port": 3306,
            "username": "root",
            "password": "0000",
            "database": "myDatabase",
            "synchronize": false,

            "entities": [
               "src/entities/*.ts"
            ]
         }
         ```
    3. 모델 생성
       - DB와 클래스를 대응.
         - 테이블 ↔클래스
         - 컬럼 ↔클래스 프로퍼티
         - 테이블 및 컬럼 속성을 데코레이터로 표기
         ```jsx
         import {
           Column,
           Entity,
           Index,
           PrimaryGeneratedColumn,
         } from "typeorm";

         @Entity("User", { schema: "myDatabase" })
         export class User extends BaseEntity {
           @PrimaryGeneratedColumn({ type: "int", name: "id" })
           id: number;

           @Column("varchar", { name: "email", length: 255 })
           email: string | null;

           @Column("varchar", { name: "name", length: 100 })
           name: string;
         }
         ```
       - 노드 모듈(typeorm-model-generator) 이용해 모델 자동 생성하기
         - https://github.com/Kononnable/typeorm-model-generator
         ```jsx
         #typeorm-model-generator 만 입력하면 각 옵션을 수동으로 입력할 수 있도록 가이드해줌

         #커맨드 한 번에 생성
         typeorm-model-generator -h localhost -u $userName -x $password -e mysql -o ./entities --ssl
         ```
    4. 쿼리

       ```jsx
       import { createConnection } from "typeorm";
       import { User } from "./entities/User";

       const main = async () => {
         try {
           await createConnection(); // typeORM db connection
           console.log("typeORM DB 커넥션 생성됨");

           //SQL : selct * from User
           const users = await User.find();

           //SQL : select * from User where User.email = 'gogogo@gmail.com'
           const userFound = await User.findOne({ email: "gogogo@gmail.com" });

           return users;
         } catch (err) {
           console.log(err);
         }
       };

       main()
         .then((text: string = "finished") => {
           console.log(text);
         })
         .catch((err) => {
           console.log(err);
         });
       ```

- 페이지네이션을 사용하는 다른 API 찾아보기
  - ex. https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api?apiVersion=2022-11-28
  - ex. https://developers.notion.com/reference/intro#pagination

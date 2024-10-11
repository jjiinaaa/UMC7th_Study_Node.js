## API 명세서

- 홈 화면 (지역별 미션 조회)
  - API Endpoint : GET /mission/area/{areaId}
  - Path Variable
    - areaId
  - Query String
    - ?sort=createdAt :생성 시간 기준으로 정렬)
  - Request Header
    - Authorization : Bearer {accessToken}
  - Request Body
    - GET 요청은 리소스 조회에 관한 메소드이기에 서버에 넣을 내용이 없음.
  - Status Code : 200 OK / 400 Bad Requset
- 마이페이지 리뷰 작성
  - API Endpoint : POST /review/{reviewId}
  - Path Variable
    - reviewId
  - Request Body
    ```json
    {
      "UserId": "Interger",
      "ShopId": "Interger",
      "Rating": "Float",
      "Content": "String",
      "Image": "String"
    }
    ```
  - Request Header
    - Authorization : Bearer {accessToken}
  - Request Body
    - GET 요청은 리소스 조회에 관한 메소드이기에 서버에 넣을 내용이 없음.
  - Status Code: 201 Created / 400 Bad Requset
- 미션 목록 조회(진행 중, 진행 완료)
  - API Endpoint : GET /mission
  - Query String
    - ? ongoing | ?completed (상태 변경)
    - ?sort=createdAt :생성 시간 기준으로 정렬)
  - Request Header
    - Authorization : Bearer {accessToken}
  - Request Body
    - GET 요청은 리소스 조회에 관한 메소드이기에 서버에 넣을 내용이 없음.
  - Status Code : 200 OK / 400 Bad Requset
- 미션 성공 누르기
  - API Endpoint : PUT /mission/{missionId}/complete
  - Path Variable
    - missionId
  - Request Header
    - Authorization : Bearer {accessToken}
  - Request Body
    ```json
    {
      "Rating": 4.5,
      "Text": "String"
    }
    ```
  - Status Code : 200 OK / 400 Bad Requset
- 회원 가입 하기
  - API Endpoint : POST /users
  - Request Body
    ```json
    {
      "Id": "String",
      "Password": "String",
      "Name": "String",
      "Gender": "String",
      "Brithday": "String",
      "Address": "String",
      "PreferFood": ["String"]
    }
    ```
  - Status Code : 201 Created / 400 Bad Requset

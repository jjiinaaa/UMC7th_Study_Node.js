## API 명세서

- 홈 화면 (지역별 미션 조회)
  - API Endpoint : GET /mission/area/{areaId}
  - Request Header
    - Authorization : accessToken
  - Status Code : 200 OK / 400 Bad Requset
- 마이페이지 리뷰 작성
  - API Endpoint : POST /review/{reviewId}
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
    - Authorization : accessToken
  - Status Code: 201 Created / 400 Bad Requset
- 미션 목록 조회(진행 중, 진행 완료)
  - API Endpoint : GET /mission
  - Qurey String
    - Status : Ongoing || Completed
  - Request Header
    - Authorization : accessToken
  - Status Code : 200 OK / 400 Bad Requset
- 미션 성공 누르기
  - API Endpoint : GET /mission/{missionId}/complete
  - Request Header
    - Authorization : accessToken
  - Status Code : 200 OK / 400 Bad Requset
- 회원 가입 하기
  - API Endpoint : GET /users
  - Request Body
    ```json
    {
      "Id": "String",
      "Password": "String",
      "Name": "String",
      "Gender": "String",
      "Brithday": "String",
      "Address": "String",
      "PreferFood": "String"
    }
    ```
  - Status Code : 201 Created / 400 Bad Requset

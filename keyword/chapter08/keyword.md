- Swagger
  - 정의: RESTful API를 설계하고 문서화하는 도구로, API의 구조를 정의하고 이를 시각적으로 표현할 수 있는 기능을 제공. OpenAPI Specification의 이전 이름으로, API의 문서화와 테스트에 용이
  - 특징
    - 자동 문서화: API의 구조를 정의하는 YAML 또는 JSON 파일을 기반으로 자동으로 문서 생성.
    - Swagger UI: API의 리소스를 시각화하고 상호작용할 수 있는 **웹 인터페이스를 제공.** 개발자와 사용자 모두 API를 쉽게 이해 및 사용 가능
    - OpenAPI Specification: Swagger는 OpenAPI Specification을 기반으로 하며, 이는 API의 구조와 동작을 정의하는 표준
- OpenAPI
  - 정의 :
    - **RESTful API를 정의하고 문서화하는 표준 규격. OpenAPI Specification(OAS)이라고도 불리며, JSON 또는 YAML 형식으로 API의 명세를 작성**
    - RESTful API의 구조를 정의하는 표준으로, **API의 요청 및 응답, 인증 방법 등을 명세**할 수 있습니다. 이전에는 **Swagger**라는 이름으로 알려져 있었으며, 현재는 **OpenAPI Initiative**에 의해 관리
  - 특징
    - 자동화된 문서화: API의 명세서를 자동으로 생성할 수 있어, 개발자와 사용자 모두 API를 쉽게 이해 가능
    - 다양한 데이터 형식 지원: OpenAPI는 JSON Schema를 기반으로 하여 다양한 데이터 형식을 지원. 이를 통해 복합 데이터 구조를 정의.
    - API 테스트 용이: OpenAPI 명세서를 사용하면 별도의 코드 작성 없이도 API의 동작을 시험할 수 있는 도구를 활용.
  - OpenAPI의 구성 요소
    - 경로(Path): 각 API의 URI와 메소드를 정의
    - 구성 요소(Components): 요청 바디, 응답 스키마 등을 정의하여 API의 세부 사항을 명시
    - 보안(Security): API 인증 방법을 정의하여 보안을 강화
  - OpenAPI의 사용 방법
    1. 명세서 작성: OpenAPI 명세서를 YAML 또는 JSON 형식으로 작성
    ```json
    {
      "openapi": "3.0.0", // Openapi 버전
      "info": {
        // API 제목과 버전 정보
        "title": "My API",
        "version": "1.0.0"
      },
      "paths": {
        // APT 엔드포인트와 HTTP 메소드 (ex. /users 경로에 get 요청)
        "/users": {
          "get": {
            "summary": "Get all users",
            "responses": {
              // 쵸엉에 대한 응답 정의 - JSON 형태
              "200": {
                "description": "A list of users",
                "content": {
                  "application/json": {
                    "schema": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "properties": {
                          "id": {
                            "type": "integer"
                          },
                          "name": {
                            "type": "string"
                          },
                          "email": {
                            "type": "string",
                            "format": "email"
                          }
                        },
                        "required": ["id", "name", "email"]
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    ```
    1. 도구 활용: OpenAPI 명세서를 기반으로 Swagger UI와 같은 도구를 사용하여 API 문서를 시각화하고 테스트
    2. 서버 및 클라이언트 생성: OpenAPI 명세서를 사용하여 서버 스텁 및 클라이언트 SDK를 자동으로 생성
- OpenAPI 버전 별 특징 및 주요 차이점
  - OpenAPI 2.0 (Swagger)와 OpenAPI 3.0의 주요 특징 및 차이점 정리
  - OpenAPI 2.0 (Swagger)
    - 기본 구조
      - swagger 필드를 사용하여 버전을 정의.
      - `info`, `paths`, `definitions`, `parameters`, `responses`, `securityDefinitions` 등의 주요 섹션으로 구성.
    - 데이터 모델 정의
      - `definitions` 섹션에서 데이터 모델을 정의.
      - 재사용 가능한 모델을 정의할 수 있지만, 구조가 다소 복잡
    - 보안 정의
      - `securityDefinitions`를 통해 API 보안을 정의.
      - API 키, OAuth2, Basic Auth 등의 보안 스킴을 지원.
    - 파일 업로드
      - 파일 업로드를 지원하지만, 다소 제한적임.
    - 지원하는 미디어 타입
      - `produces`와 `consumes` 필드를 사용하여 요청 및 응답의 미디어 타입을 정의.
  - OpenAPI 3.0
    - 기본 구조
      - `openapi` 필드를 사용하여 버전을 정의.
      - `info`, `servers`, `paths`, `components`, `security`, `tags` 등의 섹션으로 구성.
    - 데이터 모델 정의
      - `components` 섹션에서 **재사용 가능한 스키마, 파라미터, 응답** 등을 정의.
      - 더 유연하고 직관적인 구조로 개선됨.
    - 보안 정의
      - `security` 섹션을 통해 보안 스킴을 정의하며, components 내에서 보안 정의를 재사용 가능
    - 파일 업로드
      - `multipart/form-data`를 통한 파일 업로드를 더 잘 지원.
    - 지원하는 미디어 타입
      - `content` 필드를 사용하여 요청 및 응답의 미디어 타입을 세밀하게 정의 가능
      - 다양한 미디어 타입을 지원하며, 각 미디어 타입에 대한 스키마를 정의
    - 서버 정의
      - `servers` 섹션을 통해 API의 기본 서버 URL을 정의할 수 있어, 다양한 환경(개발, 테스트, 프로덕션 등)에 대한 설정이 용이.
    - 콜렉션 및 링크
      - API 간의 관계를 정의할 수 있는 **links 기능**이 추가되어, **API 호출 간의 연결성을 표현** 가능
  - 주요 차이점
    - 구조
      - OpenAPI 3.0은 `components`와 `servers` 섹션을 도입하여 더 유연하고 직관적인 구조를 제공.
    - 데이터 모델
      - OpenAPI 3.0은 **재사용 가능한 스키마를 더 쉽게 정의**할 수 있도록 개선됨.
    - 보안
      - 보안 정의가 더 간소화되고 재사용 가능해짐.
    - 미디어 타입
      - OpenAPI 3.0은 요청 및 응답의 미디어 타입을 더 세밀하게 정의할 수 있는 기능을 제공.
    - 파일 업로드
      - 파일 업로드 지원이 개선됨.
- OpenAPI Component
  - `components` 섹션
    - API 문서에서 재사용 가능한 구성 요소를 정의하는 데 사용.
    - OpenAPI 3.0에서 도입되었으며, API의 다양한 부분에서 중복을 줄이고 일관성을 유지 가능.
    - `components`는 여러 하위 섹션으로 나뉘며, 각 하위 섹션은 특정 유형의 재사용 가능한 요소를 정의
  - Components 섹션의 주요 하위 섹션
    - Schemas
      - API에서 사용되는 데이터 모델을 정의
      - JSON Schema를 기반으로 하며, 객체, 배열, 기본 데이터 타입 등을 정의
      ```json
      {
        "components": {
          **"schemas"**: {
            "User": {
              "type": "object",
              "properties": {
                "id": {
                  "type": "integer"
                },
                "name": {
                  "type": "string"
                },
                "email": {
                  "type": "string"
                }
              }
            }
          }
        }
      ```
    - Responses
      - 재사용 가능한 응답 객체를 정의
      - 특정 HTTP 상태 코드에 대한 응답을 미리 정의하여 여러 경로에서 재사용
      ```json
      {
        "components": {
          **"responses"**: {
            "NotFound": {
              "description": "The specified resource was not found."
            },
            "Unauthorized": {
              "description": "Authentication information is missing or invalid."
            }
          }
        }
      }
      ```
    - Parameters
      - API 요청에서 사용되는 재사용 가능한 파라미터를 정의
      - 쿼리 파라미터, 경로 파라미터, 헤더 파라미터 등을 정의
      ```json
      {
        "components": {
          "parameters": {
            "UserId": {
              "name": "userId",
              "in": "path",
              "required": true,
              "description": "The ID of the user to retrieve.",
              "schema": {
                "type": "integer"
              }
            }
          }
        }
      }
      ```
    - Request Bodies
      - 요청 본문에서 사용되는 재사용 가능한 요청 본문을 정의
      - 다양한 요청 형식에 대한 본문을 미리 정의하여 여러 경로에서 사용
      ```json
      {
        "components": {
          "requestBodies": {
            "UserInput": {
              "required": true,
              "content": {
                "application/json": {
                  "schema": {
                    "$ref": "#/components/schemas/User"
                  }
                }
              }
            }
          }
        }
      }
      ```
    - Headers
      - 재사용 가능한 HTTP 헤더를 정의
      - 특정 API 호출에서 자주 사용되는 헤더를 미리 정의하여 일관성을 유지
      ```json
      {
        "components": {
          "headers": {
            "X-Rate-Limit": {
              "description": "The number of allowed requests in the current period.",
              "type": "integer"
            }
          }
        }
      }
      ```
    - Security Schemes
      - API의 보안 요구 사항을 정의
      - API 키, OAuth2, HTTP Basic Auth 등 다양한 보안 스킴을 정의
      ```json
      {
        "components": {
          "securitySchemes": {
            "ApiKeyAuth": {
              "type": "apiKey",
              "in": "header",
              "name": "X-API-Key"
            }
          }
        }
      }
      ```
    - Links:
      - API 간의 관계를 정의하는 링크를 설정
      - 특정 응답에서 다른 API 호출로의 연결을 명시
      ```json
      {
        "components": {
          "links": {
            "UserProfile": {
              "description": "The user profile for the user.",
              "operationId": "getUserById",
              "parameters": {
                "userId": "$request.body#/id"
              }
            }
          }
        }
      }
      ```
  - Components 장점
    - 재사용성
    - 유지보수 용이성
    - 가독성 향상

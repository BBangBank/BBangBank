해당 API 명세서는 'BBangBank'의 REST API를 명세하고 있습니다.

- Domain : <http://localhost:4300>  


***


<h2 style='background-color: rgba(55, 55, 55, 0.2); text-align: center'>Auth 모듈</h2>

인증 및 인가와 관련된 REST API 모듈  
로그인, 휴대전화 번호 중복 확인, 인증번호전송, 인증번호 확인, 회원가입 등의 API을 구현하였습니다.  
  
- url : /bbang/auth


#### - 로그인  
  
##### 설명

클라이언트로부터 사용자 휴대폰 번호와 비밀번호를 입력받고 
휴대폰 번호와 비밀번호가 일치한다면 성공 처리가되며 access_token과 해당 토큰의 만료 기간을 반환합니다. 
데이터 유효성 검사 실패, 토큰 생성 실패, 로그인 정보 불일치, 데이터 베이스 오류가 발생할 수 있습니다.

- method : **POST**  
- URL : **/sign-in**  

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| phoneNumber | String | 사용자의 휴대전화 번호 | O |
| password | String | 사용자의 비밀번호 | O |

###### Example

```bash
curl -v -X POST "http://localhost:4300/bbang/auth/sign-in" 
 -d "phoneNumber" = "01099999999" 
 -d "password" = "1q2w3e4r!"
```

##### Response

###### Header

| name | description | required |
|---|:---:|:---:|
| Content-Type | 반환하는 Response Body의 Content Type (application/json) | O |

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 결과 코드 | O |
| message | String | 결과 메세지 | O |
| accessToken | String | 엑세스 토큰 | O |
| expires | int | 만료기간 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK
Content-Type: application/json;charset=UTF-8
{
  "code": "SU",
  "message": "Success.",
  "accessToken": "${ACCESS_TOKEN}",
  "expires": 3600
}
```

**응답 : 실패 (데이터 유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
Content-Type: application/json;charset=UTF-8
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (로그인 정보 불일치)**
```bash
HTTP/1.1 401 Unauthorized
Content-Type: application/json;charset=UTF-8
{
  "code": "SF",
  "message": "Sign in Failed."
}
```

**응답 : 실패 (토큰 생성 실패)**
```bash
HTTP/1.1 500 Internal Server Error
Content-Type: application/json;charset=UTF-8
{
  "code": "TF",
  "message": "Token creation Failed."
}
```

**응답 : 실패 (데이터베이스 오류)**
```bash
HTTP/1.1 500 Internal Server Error
Content-Type: application/json;charset=UTF-8
{
  "code": "DBE",
  "message": "Database Error."
}
```


***
#### - 휴대전화 번호 인증
  
##### 설명

클라이언트로부터 사용자 휴대폰 번호를 입력받고 
휴대폰 번호가 데이터베이스에 존재하지 않는다면 성공 처리가되며  인증번호를 전송합니다. 
데이터 유효성 검사 실패, 중복된 휴대전화 번호, SMS 전송 실패, 데이터 베이스 오류가 발생할 수 있습니다.

- method : **POST**  
- URL : **/sms-send**  

##### Request

###### Header

| name | description | required |
|---|:---:|:---:|

###### Request Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| phoneNumber | String | 사용자의 휴대전화 번호 | O |

###### Example

```bash
curl -v -X POST "http://localhost:4300/bbang/auth/sms-send" 
 -d "phoneNumber" = "01099999999" 
```

##### Response

###### Header

| name | description | required |
|---|:---:|:---:|
| Content-Type | 반환하는 Response Body의 Content Type (application/json) | O |

###### Response Body

| name | type | description | required |
|---|:---:|:---:|:---:|
| code | String | 결과 코드 | O |
| message | String | 결과 메세지 | O |

###### Example

**응답 성공**
```bash
HTTP/1.1 200 OK
Content-Type: application/json;charset=UTF-8
{
  "code": "SU",
  "message": "Success.",
  "accessToken": "${ACCESS_TOKEN}",
  "expires": 3600
}
```

**응답 : 실패 (데이터 유효성 검사 실패)**
```bash
HTTP/1.1 400 Bad Request
Content-Type: application/json;charset=UTF-8
{
  "code": "VF",
  "message": "Validation Failed."
}
```

**응답 : 실패 (중복된 휴대전화 번호)**
```bash
HTTP/1.1 400 Bad Request
Content-Type: application/json;charset=UTF-8
{
  "code": "DPN",
  "message": "Duplicated Phone Number."
}
```

**응답 : 실패 (SMS 인증번호 전송 실패)**
```bash
HTTP/1.1 400 Bad Request
Content-Type: application/json;charset=UTF-8
{
  "code": "SNF",
  "message": "Sms Number send Failed."
}
```

**응답 : 실패 (데이터베이스 오류)**
```bash
HTTP/1.1 500 Internal Server Error
Content-Type: application/json;charset=UTF-8
{
  "code": "DBE",
  "message": "Database Error."
}
```

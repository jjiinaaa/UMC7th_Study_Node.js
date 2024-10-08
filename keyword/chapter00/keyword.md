- Internet (다수의 network(다수의 sub-network))
  : Data를 전달해주는 network 망, Application에게 통신 서비스를 제공

  1. Network Core
     : Network의 핵심, End system의 정보를 실어나름. (ex. router)
  2. Aceess Network
     : End system이 Internet과 연결되는 구간 (ex. 랜선, 와이파이)
  3. Network Edge
     : 가장 마지막의 entity, End system으로 구성 (ex. web browser, email client, 스마트폰, server 등의 실제 application)

  - Packet (Datagram)
    : 인터넷상에 장치들이 서로 통신할 때 전송하는 데이터 조각, end system 간

- IP (Internet Protocol)
  : 다양한 기기에서 상대 기기를 식별 수단 (다양한 기기에 Packet을 전달 가능)

  - 과정
    (1) end system(Client)가 server에 요청을 보낼 시, Packet에 IP 주소를 담아 Access Network를 통해 전달
    (2) Packet을 받는 router가 자신의 네트워크 계층에서 IP 확인 후, 더 알맞은 router에게 전달, 반복
    (3) Network Edge에 도착 후, 도착지의 IP와 패킷의 IP가 동일 시, 전송 계층으로 전달 || 다른 곳으로 전달

  - 문제점
    1. 컴퓨터의 프로그램이 여러개가 켜진 상태 => PORT로 해결
    2. 상대 컴퓨터가 꺼져있는 상태 => TCP - 3 way-handshake
    3. 중간에 패킷이 소실된 상태 => TCP - 데이터 전달 보증
    4. 뒤에 보낸 패킷이 먼저 도착한 상태 => TCP - 순서 보증

- PORT

  > 여러 프로그램 실행 시, 네트워크 계층에서 어느 프로그램으로 Packet을 보내는가?

  : 같은 IP 내에서 프로세스를 구분하는 데 사용하는 번호 (ex. HTTP의 80, HTTPS의 443 => 생략 가능 / https://neordinary.co.kr:443)

- CIDR (Classless Inter-Domain Routing)
  : IP 주소를 할당하고 Packet을 라우팅하는 방식

  - CIDR 표기법
    ex. IPv4 주소 예시: 192.168.1.0/24 => A.B.C.D/E
    1. 구성: IP주소와 슬래시('/'), 문자, 0~32까지의 수
    2. A~D까지의는 8비트씩 끊어서 0부터 255까지의 100진수 수
    3. 슬래쉬('/') 뒤에 오는 수는 접두사 길이
       => /24의 경우: 24비트 이후에 오는 4번째 옥텟을 전부 사용 가능하다는 의미.
       => 2(0,1)^8(8bit) = 256개
       => 192.168.0.0/24일 때, 192.168.0.0~192.168.0.255 까지 사용 가능
    4. 하나의 옥텟은 8비트로 이루어짐.
    5. IPv4 주소는 4개의 옥텟으로 이루어짐.
       => CIDR은 0~32, 총 32비트까지 사용 가능

- TCP와 UDP 차이

  - TCP (Transmission Control Protocol, 전송 제어 프로토콜) - 연결 보증 역할

    - 3 way-handshake

      > 목적지 컴퓨터가 꺼져있다면?
      > 클라이언트 <=> 서버 (router 거쳐서 신호 전달)
      > syn: 받을 수 있는가의 신호
      > ack: 받을 수 있다는 신호
      > syn과 ack 신호를 주고 받으며 해당 문제 해결

    - 데이터 전달 보증

      > 중간에 데이터가 소실되었다면?
      > 패킷이 소실되었는지 도착을 안했는지 양쪽 다 모르기에 받았다는 신호 전달

    - 순서 보장
      > 보통 Packet 일정량 이상일 때 보냄. 그러나 Packet 순서가 반대로 간다면?
      > Packet에 sequence number를 붙여서, 잘못될 시 다시 보내달라는 요청 전달

  - UDP (User Datagram Protocol, 사용자 데이터그램 프로토콜)
    : TCP와는 달리 3 way-handshake, 데이터 전달 보증, 순서 보장 없이 기존의 IP에 PORT와 체크 섬(데이터가 맞는 지만 확인)만 추가한 프로토콜 \* TCP와 UDP의 차이점
    => 신뢰성은 떨이지지만, 빠르다는 장점

  # 전체 흐름 요약

  (1) 클라이언트가 서버에게 3 way-handshake를 보내고 연결 확인
  (2) 패킷에 데이터와 IP, PORT 등 여러 정보를 넣어서 Access Network를 통해 인터넷망으로 전달.
  (3) Network Core로 들어가면 router의 네트워크 계층에서 패킷의 IP 주소를 보고 다음 router로 보내기 반복
  (4) Network Edge에 도달하게 되면 물리 계층, 데이터링크 계층을 거쳐 네트워크 계층에서 IP를 확인
  (5) 전송 계층에서 PORT 번호를 확인 후 알맞은 애플리케이션으로 보내서 처리
  (그 후 응답을 해야한다면 다시 서버에서 클라이언트로 패킷 전달)

- Web Server와 WAS의 차이

  - Web Server
    : 정적 리소스(HTML, CSS, 이미지같은 정적 자원)를 처리해주는 서버
    ex. Apache, Nginx

  - WAS
    : 동적 리소스(DB조회, 다양한 로직 처리)를 처리해주는 서버
    => Web server가 포함되어 있기에 정적 리소스도 처리 가능
    ex. Spring Boot, Tomcat(내장 서버)

  - WAS만 사용하지 않는 이유
    : WAS는 Web server에 비해 비싸고 에러가 자주 발생
    => 정적 리소스를 많이 사용할 시에는 Web server만 늘리는 것이 효율적
    => WAS 에러 시에 Web server는 WAS에 요청을 보내는 것이 아닌, 에러 페이지를 띄울 수 있음.
    => 추가 보안 처리 가능
    > Web server를 WAS 앞에서 사용하여 정적 리소스 처리 후 WAS 사용

## 0. 참고 문서

---

[HTTPD (HyperText Transfer Protocol Daemon)란?](https://storyjava.tistory.com/m/95)

[httpd](https://ko.wikipedia.org/wiki/Httpd)

## 1. httpd 이란.

**Web Server 역할을하는 Software**를 총칭하는 단어.  `d`는 `daemon` 의 약자


> 😊 `Web Server의 background에서 작동`, 들어오는 Request 를 Listening 하고 있음.


### 1-1. 구현체

- Apache
- Nginx
- IIS
- etc..

> 전 세계적으로 가장 많이 쓰는 httpd은 apache이며, Linux 기본 httpd 이다.
>

### 1-2. 설명

- 웹서버 프로그램의 background에서 작동
- 자동으로 Request를 수신 & 응답
- 인터넷을 통해 HTML파일을 서비스

> 😊 `Web Server를 구축한다`는 의미는 httpd을 실행시킨다는 의미가 될 수 있음. [좁은 의미]

httpd 이란 HTTP를 지원하는 Server라고 보면 됨.
- ftpd : FTP를 지원하는 Server
- telnetd : telnet을 지원하는 Server


## 2. daemon?

<u>사용자가 직접 제어하지않으며</u> <u>background에서 특정 작업을 수행</u>하는 프로그램
## 0. 참고 문서

[Busybox란?](https://brownbears.tistory.com/76)

## 1. BusyBox

BusyBox 란 Linux의 `Standard Utility 모음집`으로, 맥가이버 칼 같은 느낌임.


> 😊 `BusyBox`는 **Linux에서 자주 사용하는 명령어를 한데 모아 경량화**한 “명령어 압축 파일”이다.

일반적인 Linux에서 사용되는 명령어를 모아두는 것만으로도 차지하는 용량이 크므로,
***각 명령어를 최소사이즈로 구현***했다.


## 2. 사용처

디바이스에 들어가는 `임베디드 리눅스` 및 `docker image 의 기본 Layer`에 사용된다.

=> <u>기본적인 Linux 명령이 필요하지만 용량이 부담스러운 경우 채용한다.</u>

## 3. 사용

```bash
busybox --list # 설치된 명령어 조회
```

- busybox에 등록된 명령 사용법

    ```bash
    #busybox [command~]
    
    busybox echo "busybox" > index.html
    busybox cat index.html
    # busybox
    
    busybox httpd -f -p 8080
    # busybox에 있는 httpd + -f + -p
    # busybox에 있는 httpd 명령 : 현재 폴더기준으로 실행하고 8080으로 Listen
    ```
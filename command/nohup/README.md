### 참고 문서

[쉽게 설명한 nohup 과 &(백그라운드) 명령어 사용법](https://joonyon.tistory.com/entry/쉽게-설명한-nohup-과-백그라운드-명령어-사용법)

### 설명

> `nohup` 명령 : logout 같이 **터미널 세션이 종료되어도 실행한 프로세스를 유지**시키는 명령입니다.
> 
> 😊 일반적으로 터미널 세션 연결이 끊기면 `Linux`는 **해당 세션에서 실행된 프로세스**들에게 `HUP 시그널`을 전달하여 프로세스를 종료시킨다.
>
> ⇒ `*HUP*` , Hang Up의 약자. 프로세스 종료 신호


`nohup`명령은 “`터미널 세션이 끊겨도 해당 프로세스에 HUP 신호를 전달하지마라` 라는 명령이다.”



## 1. 사용법

```bash
nohup [command]
```

> 주의!  `nohup` 명령에 사용할 **스크립트는 반드시 755 이상!** [rwx-r-x-r-x]
>

```bash
chmod 755 test.sh
```

- bash script 작성

    ```bash
    #!/bin/bash
    
    for i in {0..4}
    do
    	sleep 5
    done
    # 5초 쉬는 과정을 5번, 25초 중지 후 스크립트 종료
    ```

- script 실행

    ```bash
    nohup ./test.sh
    # nohup: ignoring input and appending output to 'nohup.out'
    # ==> ./test.sh &>nohup.out
    ```

- `nohup` 명령 실행 후 세션 끊고 접속 후 확인

    ```bash
    nohup ./test.sh 
    exit
    
    # 접속 후 조회
    ps -ef | grep test.sh
    #admin 3537451       1  0 20:58 ?        00:00:00 /bin/bash ./test.sh
    ```


## 2. & , background

`&`을 **명령 맨 끝에 붙여주면**, 해당 명령은 `background로 실행됩니다`.

```bash
echo 'hello' 1> hello.out &
# [1] 3537642

cat hello.out 
# hello
# [1]+  Done                    echo 'hello' > hello.out
```

## 3. nohup 와 & 의 차이점


1. `nohup`는 명령을 **`daemon` 으로 실행시키는 것**이기 때문에, `세션이 종료되더라도 HUP 신호를 보내지 않음`
2. `&`는 명령을 background로 실행할 뿐 **실행한 명령이 세션에 종속되어 있음**

> 😊 `터미널 세션이 끊겨도 HUP 신호를 보내지않는` 옵션이 `default`가 되어 헷갈릴 수 있습니다.
>

```bash
# 세션 종료 시 HUP 시그널 전송 여부 확인
shopt | grep huponexit
# huponexit       off => 세션 만료 시 HUP 신호를 보내지않는다.
```

- `shopt` : shell option, 쉘 옵션 조회 명령
    - `huponexit` : hup-on-exit, 세션 종료 시 HUP 시그널 전송 여부


> 😊 즉, shell-option [shopt] 에 `huponexit = off` 라면, 터미널 세션이 종료되어도 실행한 프로세스에 HUP 시그널을 보내지않음.



## 4. File Descriptor , Redirection , &


`nohup` 명령의 ***stdout*** 내용은 기본적으로 ***nohup.out*** 파일에 덮어씌워집니다.

> 출력 값을 다른 곳에 저장하거나, stderr(2) 내용을 같은 파일에 저장하고 싶을 때는 ***File Descriptor*** 와 ***Redirection***을 사용하면 됩니다.
>

- 실습 스크립트

    ```bash
    #!/bin/bash
    
    for i in {0..7}
    	do
    		sleep 5
    	done
    ```

- nohup + 명령을 background 로 실행하고, stdout 과 stderr 를 다른 곳에 덮어씌우고 싶다.

    ```bash
    #nohup [command]
    nohup ./test.sh 1>test.out 2>test.err & 
    # [1] 3537891
    
    ps -ef |grep test.sh
    #admin 3537891 3537568  0 21:29 pts/0    00:00:00 /bin/bash ./test.sh
    
    cat test.out 
    # 없음
    cat test.err 
    # nohup: ignoring input
    ```

- nohup + 명령을 background 로 실행하고, stdout 과 stderr를 같은 곳에 덮어씌우고 싶다.

    ```bash
    nohup ./test.sh 1>test.log 2>&1 &
    nohup ./test.sh &> test.log &
    #[1] 3537974
    
    ps -ef | grep test.sh 
    #[1]+  Done                    nohup ./test.sh &> test.log
    
    cat test.log 
    #nohup: ignoring input ==> stderr 내용
    ```


## 5. 프로세스 종료


프로세스 종료는 해당 명령이 작동하는 PID 를 알아내어 `kill` 명령을 사용합니다.

```bash
nohup ./test.sh 1>test.log 2>&1 &
#[1] 3538044

kill -9 3538044

ps -ef | grep test.sh
#[1]+  Killed                  nohup ./test.sh > test.log 2>&1
```
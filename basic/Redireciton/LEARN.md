## 0. 참고문서

---

https://bio-info.tistory.com/87

## 1. Linux, Redirection

---

***Redireciton*** 은 방향을 변경한다는 의미로, Linux에서 사용하는 **표준 입력**[`stdin`] 및 **표준 출력**[`stdout`]을 키보드로 할 필요 없이 `file`로 표준 입력 값을 넣고 표준 출력 값을 `file`로 보내는 기능 입니다.

| 기호 | 형태 | 뜻 |
| --- | --- | --- |
| < | 명령어 < 파일 | 파일 내용을 표준 입력으로 받겠다 |
| \> | 명령어 > 파일 | 명령어에서 나온 stdout 값을 파일에 덮어쓰겠다 |
| \>> | 명령어 >> 파일 | 명령어 결과를 파일에 추가하겠다 |

## 2. basic usage

---

*Linux file descriptor* [`stdin` & `stdout` & `stderr`] 와 *Redirection* 을 같이 사용할 수 있습니다.

| 형태 | 뜻 |
| --- | --- |
| 명령어 1> 파일 | 1 -> 표준 출력 값을 파일에 덮어씀 |
| 명령어 2> 파일 | 2 -> 명령 실행 시 에러가 일어나면 에러 내용을 파일에 덮어씀 |
| 명령어 1> 파일a 2> 파일b | 1, 2 -> 명령 실행 시 표준 출력 값을 파일a 에 덮어쓰고 표준 에러 값을 파일b에 덮어씀 |
| 명령어 1> 파일a 2>파일a | 1, 2 -> 명령 실행 시 표준 출력 값 및 표준 에러 값을 파일a에 덮어씀 |

## 3. 활용

---

| 형태  | 뜻 |
| --- | --- |
| 명령어 1>파일 2>/dev/null | 1, 2 -> 명령 실행 시 표준 출력 값을 파일에 덮어쓰고, 표준 에러 값을 버림 [/dev/null] |
| 명령어 >파일 2>&1 | 1, 2 -> 명령 실행 시 표준 출력 값 및 표준 에러 값을 파일에 덮어씀 |
| 명령어 &>파일 or 명령어 >& 파일 | 1, 2 -> 명령 실행 시 표준 출력 값 및 표준 에러 값을 파일에 덮어씀 |

> ***/dev/null*** 은 리눅스에서 `휴지통`입니다. 리눅스에서는 휴지통에 들어가는 순간 파일이 완전 삭제되니 유의합시다.
>

1. `명령어 >파일 2>&1` : 표준 출력은 파일, 표준 에러(2)는 `&1`로 보내라는 명령입니다.

   > 1 은 표준 출력, & 는 background를 의미합니다.
   >
   > 즉, 2> &1 : background로 stdout에 보내라는 의미입니다.
   > ⇒ stdout 값 + stderr ⇒ 파일

## 4. 활용

---

- 테스트 스크립트

    ```bash
    #!/bin/bash
    
    echo "1st arg = $1"
    
    # Variable
    sum=0
    
    for i in {0..9}
    	do
    		sum=$(($sum+$i))
    		echo Current Number is $sum
    	done
    ```


1. 명령 1>파일

    ```bash
    ./test.sh 1 1>example-stdout.log
    
    cat example-stdout.log
   # 1st arg = 0 .. [stdout]
    ```

2. 명령 2>파일

    ```bash
    ./test.sh 2>example-stderr.err
    # 1st arg = 0 .. [stdout은 그대로 출력!]
    
    cat example-stderr.err
    # 아무것도 없음!
    ```

3. 명령 1>파일a 2>파일b

    ```bash
    ./test.sh 0 1>example-stdout.out 2>example-staderr.err
    
    cat example-stdout.out
    # 1st arg = 0 ..
    cat example-staderr.err
    # 아무것도 없음!
    ```

4. 명령 1>파일a 2>파일a

    ```bash
    ./test.sh 1 1>example-std.log 2>example-std.log
    
    cat example-std.log 
    # 1st arg = 1 ..
    ```

5. 명령 1>/dev/null 2>파일

    ```bash
    ./test.sh 0 1>/dev/null 2>example-stderr.err
    
    cat example-stderr.err
    # 아무것도 없음!
    ```

6. 명령 1>파일 2>&1

    ```bash
    ./test.sh 3 1>example-std.log 2>&1
    
    cat example-stdout.log
    # 1st arg = 1 ..
    ```
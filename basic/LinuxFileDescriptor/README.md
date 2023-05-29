## 0. 참고 문서

---

https://bio-info.tistory.com/86

## 1. 표준 입/출력 (Standard I/O)

### 1-1. 표준 입력, stdin

키보드로 명령을 작성 → Enter 로 입력하는 방식을 의미. `File Descriptor 0번으로 고정`되어 있습니다.

### 1-2. 표준 출력, stdout

키보드로 명령을 실행 후 정상 종료 시 출력되는 내용을 의미. `File Descriptor 1번으로 고정`되어 있습니다.

### 1-3. 표준 에러, stderr

명령을 실행 후 발생한 에러 메시지 내용을 의미, `File Descriptor 2번으로 고정`되어 있습니다.

## 2. File Descriptor

`*File Descriptor*`[파일 기술자] 란, `**Linux OS 가 특정 파일에 접근할 때 사용되는 값**`.

> Linux System 에서 모든 것은 File 로 관리 됨.
> 
>이 때, stdin & stdout & stderr 은 고정으로 0 & 1 & 2 의 파일번호를 가짐.


> 😊 Linux OS 가 명령어를 실행할 때 **각 명령어에 특정 파일 번호를 부여 후 그에 맞게 실행 함**. 
> 
> stdin & stdout & stderr 은 고정으로 0 & 1 & 2 의 파일번호를 가짐


| File Descriptor | File Descriptor 이름 | 뜻 |
| --- | --- | --- |
| 0 | stdin | Linux OS 가 0번 파일에 접근 , 표준 입력 파일 |
| 1 | stdout | Linux OS 가 1번 파일에 접근 , 표준 출력 파일 |
| 2 | stderr | Linux OS 가 2번 파일에 접근 , 표준 에러 파일 |
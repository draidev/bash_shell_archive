# BASH SHELL ARCHIVE
**쉘 스크립트 저장소**

## .sh  
- ```which_containers_jupyter.sh```
	-  host 환경에서 사용   
	-  어떤 docker container에서 어떤 jupyter process를 실행하고 있는지 확인하기 위한 스크립트
	
- ```gpu_process_check.sh (which_containers_jupyter.sh upgrade version)```
	- nvidia-smi 명령어와 pid를 사용하여 어떤 jupyter process가 gpu를 점유하고 있는지 확인하는 부분을 추가  
- ```compare_rpm.sh```   
	- jenkins Build History에서 각 build번호의 full log에 있는 sha1sum의 해쉬값을 참고하여, 최신 패키지목록에서 수정된 패키지를 보여주는 스크립트   
	- 사용법 : ```./compare_rpm.sh [빌드 번호] [빌드 번호]```

<br>

## shell script 명령어/문법
### 명령행 인자   
- ```$#```   
- ```$0, 1, ...```   
- ```$@```, ```&*```   
<br>   

### `/dev/null 2>&1  ` 
- `/dev/null`은 기록된 모든 데이터를 버리는 특수 파일이다.
- 원하지 않는 출력을 화면에 표시하는 대신 /dev/null 파일로 리디렉션함으로써 원하지 않는 출력을 화면에 띄우지 않게 한다.
- `2>&1` 은 표준 오류(stderr) 스트림을 표준 출력(stdout) 스트림과 동일한 위치로 리디렉션하는 데 사용한다.
- `/dev/null 2>&1`을 함께 사용하면 일반 출력과 오류 메시지가 모두 `/dev/null`로 전송되어 둘 다 효과적으로 삭제됨
- 스크립트가 사용자에게 중요하지 않은 많은 출력이나 오류를 생성하고 화면을 복잡하게 만드는 경우에 유용할 수 있다.
- Ex)
    
    ```bash
    ./my_script.sh > /dev/null 2>&1
    ```
    
    이렇게 하면 표준 출력과 표준 오류가 모두 /dev/null로 리디렉션되어 스크립트에서 생성된 모든 출력과 오류가 효과적으로 삭제됩니다.
    
    ```bash
    ./my_script.sh > /dev/null 2> /dev/null
    ```
    
    이렇게 하면 표준 출력 스트림은 그대로 두고 표준 오류 스트림만 /dev/null로 리디렉션합니다.
    
- ```>&```
    - 한 파일 디스크립터를 다른 파일 디스크립터로 리디렉션하는 데 사용되는 표기   

<br>   

### `[]`, `[[]]` : 대괄호 1개와 2개의 차이점   
- `[ ]`는 sh기반 `[[ ]]` 는 bash기반으로 동작한다.
- 대괄호 두개를 사용하는 것이 좀 더 직관적이고 개선된 버전이다.
    - 대괄호 안에 `&&` `||` 를 같이 쓸 수 있다.
    - 쌍따옴표(`”`)를 넣지 않아도 된다.
    - 패턴매칭이 가능하다. 

<br>  

### `‘ ’`, `“ ”` : 따옴표와 쌍따옴표의 차이   
- 따옴표`’ ’`로 감싸진 문자열은 문자열 그대로 유지되어 출력된다. (Bash 변수 사용 불가능)
- 쌍따옴표`” ”`로 감싸진 문자열 내에서는 Bash에서 선언한 변수 사용이 가능하다.
- 따옴표에서는 특수기호 이스케이핑을 해주지 않아도 문자 그 자체로 출력이 가능하다.

<br>    

### /dev/null 2>&1
- `/dev/null`은 기록된 모든 데이터를 버리는 특수 파일이다.
- 원하지 않는 출력을 화면에 표시하는 대신 /dev/null 파일로 리디렉션함으로써 원하지 않는 출력을 화면에 띄우지 않게 한다.
- `2>&1` 은 표준 오류(stderr) 스트림을 표준 출력(stdout) 스트림과 동일한 위치로 리디렉션하는 데 사용한다.
- `/dev/null 2>&1`을 함께 사용하면 일반 출력과 오류 메시지가 모두 `/dev/null`로 전송되어 둘 다 효과적으로 삭제됨
- 스크립트가 사용자에게 중요하지 않은 많은 출력이나 오류를 생성하고 화면을 복잡하게 만드는 경우에 유용할 수 있다.
- Ex)
    
    ```bash
    ./my_script.sh > /dev/null 2>&1
    ```
    
    이렇게 하면 표준 출력과 표준 오류가 모두 /dev/null로 리디렉션되어 스크립트에서 생성된 모든 출력과 오류가 효과적으로 삭제됩니다.
    
    ```bash
    ./my_script.sh > /dev/null 2> /dev/null
    ```
    
    이렇게 하면 표준 출력 스트림은 그대로 두고 표준 오류 스트림만 /dev/null로 리디렉션합니다.
    
- `>&`
    - 한 파일 디스크립터를 다른 파일 디스크립터로 리디렉션하는 데 사용되는 표기   

<br>   

### `cut, rev`

- `cut`
    - `-d` 옵션을 사용하여 특정 구분자를 기준으로 앞에서부터 특정 위치(`-f`옵션)의 문자열을 가져올 수 있다.
    
		```bash
		echo "abc def:ghi jk l" | cut -d' ' -f2
		
		def:ghi (출력 결과)
		```
    
    - 구분자를 이용하여 n번째, m번째 라인 출력
        
        사용법 : `cut -d [구분자] -f [n],[m] [파일이름]`
        
    - 구분자를 이용하여 n번째  이후 출력
    사용법 : `cut -d [구분자] -f [n-]`

- `rev`
    - rev(reverse) 명령어는 역순으로 재배열한다.
    
		```bash
		echo "abcd" | rev
		
		dcba (abcd의 역순 재배열)
		```
    
    - cut을 이용해서 뒤에서 부터 문자를 세서 특정 문자열을 얻고싶다면 rev를 이용해서 뒤집고 문자를 추출한 다음 다시 뒤집으면 된다.
    
		```bash
		echo "abc def:ghi jk l" | rev | cut -d' ' -f2 | rev
		
		jk 
		```

<br>  

## 문자열 비교

---

### 두 문자열이 같은지 확인

- `**==**`
    
    ```bash
    #!/bin/bash
    
    read -p "Enter first string: " VAR1
    read -p "Enter second string: " VAR2
    
    if [[ "$VAR1" == "$VAR2" ]]; then
        echo "Strings are equal."
    else
        echo "Strings are not equal."
    fi
    ```
    

### 문자열에 하위 문자열이 포함되어 있는지 확인

- `***`**
    
    ```bash
    echo -e "\033[31m<< display docker container jupyter process >>\033[0m"
    while read container_name || [ -n "$container_name" ]; do
        container_hash=$(docker exec $container_name ps aux | grep jupyter/runtime/kernel | rev | cut -d '/' -f1 | re
        if [[ $container_hash == ***.json*** ]]; then
            echo -e "\033[32m$container_name\033[0m"
            echo -e "$container_hash\n"
        fi  
    done < docker_container_name_list.txt
    echo -e "\n"
    ```
    

### 문자열이 비어 있는지 확인

- -z
    - 공백 문자열이면 TRUE
    
    ```bash
    #!/bin/bash
    
    VAR=''
    if [[ -z $VAR ]]; then
      echo "String is empty."
    fi
    
    # String is empty.
    ```
    
- -n
    - 공백 문자열이 아니면 TRUE
    
    ```bash
    #!/bin/bash
    
    VAR='Linuxize'
    if [[ -n $VAR ]]; then
      echo "String is not empty."
    fi
    
    # String is not empty.
    ```
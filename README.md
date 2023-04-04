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

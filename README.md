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

## shell script 명령어   
### 명령행 인자   
- ```$#```   
- ```$0, 1, ...```   
- ```$@```, ```&*```   

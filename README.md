# BASH SHELL ARCHIVE
**쉘 스크립트 저장소**

## .sh  
- which_containers_jupyter.sh
	-  host에서 어떤 docker container에서 어느 jupyter process를 실행하고 있는지 확인하기 위한 스크립트
	
- gpu_process_check.sh (which_containers_jupyter.sh upgrade version)
	- nvidia-smi 명령어와 pid를 사용하여 어떤 jupyter process가 gpu를 점유하고 있는지 확인하는 부분을 추가

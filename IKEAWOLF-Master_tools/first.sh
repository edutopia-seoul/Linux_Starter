#!/usr/bin/env bash

set -e

confirm() {
    while true; do
        read -r -p "이 단계를 실행할까요? [y/n]: " answer </dev/tty

        case "$answer" in
            y|Y)
                return 0
                ;;
            n|N)
                echo "이 단계를 건너뜁니다."
                return 1
                ;;
            *)
                echo "y 또는 n을 입력해주세요."
                ;;
        esac
    done
}

echo "=================================================="
echo " Ubuntu 첫 설정을 시작합니다."
echo " y: 실행 / n: 건너뛰기"
echo "=================================================="


# 1. 패키지 목록 업데이트
echo
echo "[1/8] Ubuntu 패키지 목록 업데이트"
echo "실행 명령: sudo apt update -y"

if confirm; then
    sudo apt update -y
fi


# 2. 패키지 업그레이드
echo
echo "[2/8] 설치된 패키지 업그레이드"
echo "실행 명령: sudo apt upgrade -y"
echo "업그레이드는 시간이 걸릴 수 있습니다."

if confirm; then
    sudo apt upgrade -y
fi


# 3. Node.js 및 npm 설치
echo
echo "[3/8] Node.js 및 npm 설치"
echo "실행 명령: sudo apt install nodejs npm -y"

if confirm; then
    sudo apt install nodejs npm -y

    echo
    echo "Node.js 버전:"
    node -v

    echo
    echo "npm 버전:"
    npm -v
fi


# 4-1. OpenAI Codex CLI 설치
echo
echo "[4-1/3] OpenAI Codex CLI 설치"
echo "실행 명령: sudo npm install -g @openai/codex"

if confirm; then
    sudo npm install -g @openai/codex
fi


# 4-2. Anthropic Claude Code CLI 설치
echo
echo "[4-2/3] Anthropic Claude Code CLI 설치"
echo "실행 명령: sudo npm install -g @anthropic-ai/claude-code"

if confirm; then
    sudo npm install -g @anthropic-ai/claude-code
fi


# 4-3. Google Antigravity CLI 설치
echo
echo "[4-3/3] Google Antigravity CLI 설치"
echo "설치 후 실행 명령: agy"

if confirm; then
    wget -qO- "https://antigravity.google/cli/install.sh" | bash
fi


# 5. OpenSSH Server 설치
echo
echo "[5/8] OpenSSH Server 설치"
echo "외부 컴퓨터에서 SSH로 접속할 수 있게 합니다."
echo "실행 명령: sudo apt install openssh-server -y"

if confirm; then
    sudo apt install openssh-server -y
fi


# 6. SSH 서비스 활성화
echo
echo "[6/8] SSH 서비스 활성화 및 시작"
echo "부팅할 때 SSH가 자동으로 실행되도록 설정합니다."

if confirm; then
    sudo systemctl enable ssh
    sudo systemctl start ssh

    echo
    echo "현재 SSH 서비스 상태:"
    sudo systemctl status ssh --no-pager
fi


# 7. UFW 방화벽 설정
echo
echo "[7/8] UFW 방화벽 설정"
echo "SSH 접속을 허용하고 방화벽을 활성화합니다."

if confirm; then
    sudo ufw allow ssh
    sudo ufw --force enable
fi


# 8. IP 주소 확인
echo
echo "[8/8] 현재 IP 주소 출력"
echo "다른 컴퓨터에서 SSH로 접속할 때 사용할 주소를 확인합니다."

if confirm; then
    ip a
fi


echo
echo "=================================================="
echo " Ubuntu 첫 설정 스크립트가 종료되었습니다."
echo "=================================================="

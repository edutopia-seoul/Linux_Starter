#!/bin/bash

echo "=========================================="
echo "🛰️  어서오세요! SSH를 이용한 파일 전송 스크립트 입니다!"
echo "=========================================="

echo "1번 : 내 서버 → 다른 서버 (보내기)"
echo "2번 : 다른 서버 → 내 서버 (가져오기)"
echo -n "입력▶ "
read -r how

echo ""
echo "📦 전송할 항목을 선택하세요:"
echo "1번 : 파일"
echo "2번 : 폴더 (디렉토리)"
echo -n "입력▶ "
read -r what_doc

if [ "$how" = "1" ]; then
    if [ "$what_doc" = "1" ]; then
        echo "📂 보낼 파일의 경로:"
        echo -n ">>>> "
        read -r mysrc
        mysrc="${mysrc/#\~/$HOME}"

        echo "👤 상대방 user_name:"
        echo -n ">>>> "
        read -r overname

        echo "🌐 상대방 IP 주소:"
        echo -n ">>>> "
        read -r overip

        echo "📁 상대방이 받을 경로:"
        echo -n ">>>> "
        read -r oversrc

        if scp "$mysrc" "$overname@$overip:$oversrc"; then
            echo "✅ 명령 성공"
        else
            echo "❌ 명령 실패"
        fi

    elif [ "$what_doc" = "2" ]; then
        echo "📂 보낼 디렉토리의 경로:"
        echo -n ">>>> "
        read -r mydir
        mydir="${mydir/#\~/$HOME}"

        echo "👤 상대방 user_name:"
        echo -n ">>>> "
        read -r overname

        echo "🌐 상대방 IP 주소:"
        echo -n ">>>> "
        read -r overip

        echo "📁 상대방이 받을 경로:"
        echo -n ">>>> "
        read -r overdir

        if scp -r "$mydir" "$overname@$overip:$overdir"; then
            echo "✅ 명령 성공"
        else
            echo "❌ 명령 실패"
        fi
    else
        echo "⚠️ 잘못된 입력입니다. (파일/폴더 선택)"
    fi

elif [ "$how" = "2" ]; then
    if [ "$what_doc" = "1" ]; then
        echo "👤 상대방 user_name:"
        echo -n ">>>> "
        read -r overname

        echo "🌐 상대방 IP 주소:"
        echo -n ">>>> "
        read -r overip

        echo "📂 가져올 파일의 경로:"
        echo -n ">>>> "
        read -r oversrc

        echo "📁 내가 저장할 경로:"
        echo -n ">>>> "
        read -r mysrc
        mysrc="${mysrc/#\~/$HOME}"

        if scp "$overname@$overip:$oversrc" "$mysrc"; then
            echo "✅ 명령 성공"
        else
            echo "❌ 명령 실패"
        fi

    elif [ "$what_doc" = "2" ]; then
        echo "👤 상대방 user_name:"
        echo -n ">>>> "
        read -r overname

        echo "🌐 상대방 IP 주소:"
        echo -n ">>>> "
        read -r overip

        echo "📂 가져올 디렉토리의 경로:"
        echo -n ">>>> "
        read -r overdir

        echo "📁 내가 저장할 경로:"
        echo -n ">>>> "
        read -r mydir
        mydir="${mydir/#\~/$HOME}"

        if scp -r "$overname@$overip:$overdir" "$mydir"; then
            echo "✅ 명령 성공"
        else
            echo "❌ 명령 실패"
        fi
    else
        echo "⚠️ 잘못된 입력입니다. (파일/폴더 선택)"
    fi
else
    echo "⚠️ 잘못된 입력입니다. (전송 방향 선택)"
fi

echo ""
echo "=========================="
echo "✅ 스크립트가 종료되었습니다."
echo "=========================="

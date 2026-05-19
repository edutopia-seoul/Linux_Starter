#!/bin/bash

echo "🔍 정리 가능한 사용자 설정 파일/캐시 목록:"

FILES=(
  "$HOME/.sudo_as_admin_successful"
  "$HOME/.bash_history"
  "$HOME/.lesshst"
  "$HOME/.local/share/recently-used.xbel"
)

DIRS=(
  "$HOME/.cache"
)

# 삭제 전 확인 함수
confirm_delete() {
  local target="$1"
  if [ -e "$target" ]; then
    echo -n "🗑️ '$target' 을(를) 삭제하시겠습니까? [y/N]: "
    read -r answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      rm -rf "$target"
      echo "✅ 삭제 완료: $target"
    else
      echo "❌ 삭제 건너뜸: $target"
    fi
  fi
}

# 파일 처리
for file in "${FILES[@]}"; do
  confirm_delete "$file"
done

# 디렉토리 처리
for dir in "${DIRS[@]}"; do
  confirm_delete "$dir"
done

echo "🎉 정리 작업 완료!"

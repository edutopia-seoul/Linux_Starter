이 시스템의 기존 JupyterLab 설치와 설정을 먼저 조사한 뒤, 아래 사양으로 설정해줘.

  작업 범위는 JupyterLab 설치·사용자 설정·웹폰트·Jupyter 터미널뿐이다.
  Caddy, Nginx, 방화벽, 도메인, TLS, 시스템 로그인 셸 등은 변경하지 마라.
  기존 설정이 있으면 수정 전에 백업하고, 관련 없는 설정은 보존해라.

  목표 환경
  - JupyterLab 4.x 사용
  - 가능하면 JupyterLab 4.6.1
  - 한국어 언어팩 설치 및 UI locale을 ko_KR로 설정
  - 테마는 JupyterLab Dark
  - 영문·숫자·코드는 JetBrains Mono NL
  - 한글은 D2Coding
  - 최종 폰트 순서:
    'JetBrains Mono NL', 'D2Coding', ui-monospace, monospace
  - 원격 브라우저에서도 폰트가 보이도록 Jupyter custom.css에서 웹폰트로 제공
  - JetBrains Mono와 D2Coding은 반드시 공식 배포처에서 받아라
  - D2Coding은 일반 버전 Regular/Bold를 사용하고 리거처 버전은 사용하지 마라
  - Jupyter 파일 루트와 터미널 시작 위치는 현재 사용자의 홈 디렉터리로 설정
  - Jupyter 터미널은 zsh가 이미 설치돼 있으면 /usr/bin/zsh -l을 사용하고, 없으면 현재 로그인 셸을 사용해라
  - 네트워크 주소, 포트, base_url, Origin, 인증 설정은 기존 값을 유지해라
  - 특히 기존 인증을 확인하지 않고 Jupyter 토큰이나 비밀번호를 끄지 마라

  필요 패키지
  - jupyterlab
  - jupyterlab-language-pack-ko-KR
  - ipykernel
  - jupyterlab-pygments

  Python 커널은 존재하지 않는 "python" 명령을 사용하지 않도록 현재 Python 3 실행 파일의 절대 경로로 다시 등록해라.

  웹폰트 구성
  - ~/.jupyter/custom/ 아래에 다음 파일을 배치해라:
    - JetBrainsMonoNL-Regular.ttf
    - D2Coding-Regular.ttf
    - D2Coding-Bold.ttf
    - custom.css
  - Jupyter 설정에서 c.LabApp.custom_css = True를 활성화해라
  - custom.css에는 다음과 같은 @font-face를 넣어라:

  @font-face {
    font-family: "JetBrains Mono NL";
    src: url("./JetBrainsMonoNL-Regular.ttf") format("truetype");
    font-style: normal;
    font-weight: normal;
    font-display: swap;
  }

  @font-face {
    font-family: "D2Coding";
    src: url("./D2Coding-Regular.ttf") format("truetype");
    font-style: normal;
    font-weight: normal;
    font-display: swap;
  }

  @font-face {
    font-family: "D2Coding";
    src: url("./D2Coding-Bold.ttf") format("truetype");
    font-style: normal;
    font-weight: bold;
    font-display: swap;
  }

  아래 JupyterLab 사용자 설정을 적용해라.

  1. Theme
  설정 ID: @jupyterlab/apputils-extension:themes

  {
    "theme": "JupyterLab Dark",
    "overrides": {
      "code-font-family": "'JetBrains Mono NL', 'D2Coding', ui-monospace, monospace",
      "content-font-family": "'JetBrains Mono NL', 'D2Coding', ui-monospace, monospace",
      "ui-font-family": "'JetBrains Mono NL', 'D2Coding', ui-monospace, monospace"
    }
  }

  2. Language
  설정 ID: @jupyterlab/translation-extension:plugin

  {
    "locale": "ko_KR"
  }

  3. Terminal
  설정 ID: @jupyterlab/terminal-extension:plugin

  {
    "cursorBlink": true,
    "fontFamily": "'JetBrains Mono NL', 'D2Coding', ui-monospace, monospace",
    "fontSize": 13,
    "lineHeight": 1,
    "pasteWithCtrlV": true,
    "scrollback": 10000,
    "theme": "dark",
    "screenReaderMode": false,
    "shutdownOnClose": true,
    "closeOnExit": true,
    "macOptionIsMeta": false,
    "showStatusBarItem": "if-any"
  }

  4. Document Manager
  설정 ID: @jupyterlab/docmanager-extension:plugin

  {
    "autosave": true,
    "autosaveInterval": 40,
    "confirmClosingDocument": false,
    "lastModifiedCheckMargin": 500,
    "defaultViewers": {},
    "renameUntitledFileOnSave": true,
    "maxNumberRecents": 10
  }

  5. Document Search
  설정 ID: @jupyterlab/documentsearch-extension:plugin

  {
    "searchDebounceTime": 10,
    "autoSearchInSelection": "never"
  }

  6. File Browser
  설정 ID: @jupyterlab/filebrowser-extension:browser

  {
    "navigateToCurrentDirectory": false,
    "useFuzzyFilter": true,
    "filterDirectories": true,
    "showLastModifiedColumn": true,
    "showDateCreatedColumn": false,
    "showFileSizeColumn": true,
    "showHiddenFiles": true,
    "showFileCheckboxes": true,
    "showFullPath": true,
    "sortNotebooksFirst": false,
    "sortFileNamesNaturally": true,
    "singleClickNavigation": false,
    "autoOpenUploads": true,
    "maxAutoOpenSizeMB": 50,
    "allowFileUploads": true,
    "breadcrumbs": {
      "minimumLeftItems": 0,
      "minimumRightItems": 2
    },
    "showFileFilter": false,
    "clearFilterOnNavigation": true
  }

  7. Notebook
  설정 ID: @jupyterlab/notebook-extension:tracker

  {
    "enableKernelInitNotification": false,
    "codeCellConfig": {
      "lineNumbers": true
    },
    "defaultCell": "code",
    "autoStartDefaultKernel": false,
    "showInputPlaceholder": true,
    "inputHistoryScope": "global",
    "kernelShutdown": false,
    "markdownCellConfig": {
      "lineNumbers": true
    },
    "autoRenderMarkdownCells": false,
    "rawCellConfig": {
      "lineNumbers": false,
      "matchBrackets": false
    },
    "scrollPastEnd": true,
    "recordTiming": false,
    "overscanCount": 1,
    "maxNumberOutputs": 50,
    "scrollHeadingToTop": true,
    "showEditorForReadOnlyMarkdown": true,
    "kernelStatus": {
      "showOnStatusBar": false,
      "showProgress": true,
      "showJumpToRecentExecutionButton": false
    },
    "documentWideUndoRedo": false,
    "showHiddenCellsButton": true,
    "renderingLayout": "default",
    "sideBySideLeftMarginOverride": "10px",
    "sideBySideRightMarginOverride": "10px",
    "sideBySideOutputRatio": 1,
    "windowingMode": "contentVisibility",
    "accessKernelHistory": false,
    "addExtraLineOnCellMerge": true,
    "showMinimap": false,
    "useSystemClipboardForCells": false,
    "pasteCodeCellsWithoutOutput": false
  }

  8. Table of Contents
  설정 ID: @jupyterlab/toc-extension:registry

  {
    "maximalDepth": 4,
    "numberingH1": true,
    "numberHeaders": true,
    "includeOutput": true,
    "syncCollapseState": false,
    "baseNumbering": 1
  }

  9. Notification
  설정 ID: @jupyterlab/apputils-extension:notification

  {
    "fetchNews": "true"
  }

  10. Extension Manager
  설정 ID: @jupyterlab/extensionmanager-extension:plugin

  {
    "disclaimed": true
  }

  설정 파일 경로와 스키마는 대상 JupyterLab 버전에서 직접 확인하고 올바른 위치에 작성해라. 구버전 설정 키를 억지로 사용하지 마라.

  검증
  - 모든 설정 API에 warning이 없는지 확인
  - JetBrains Mono NL, D2Coding Regular/Bold 웹폰트 URL이 HTTP 200과 올바른 font MIME type을 반환하는지 확인
  - UI·Notebook·Text Editor·Console·Terminal의 폰트 설정을 확인
  - 한국어 UI 적용 확인
  - Python 커널을 하나 실행해 간단한 코드가 정상 동작하는지 확인
  - 새 Jupyter 터미널의 셸과 시작 디렉터리를 확인
  - 재시작이 필요하면 활성 커널과 터미널을 먼저 확인하고 안전하게 재시작
  - 완료 후 변경한 파일, 설치 버전, 최종 경로, 검증 결과를 보고해라

  이 프롬프트는 현재 시스템 고유의 Caddy·도메인·포트·인증값은 제외하고 JupyterLab 설정과 꾸미기만 재현합니다.

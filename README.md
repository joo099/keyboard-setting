# Keyboard settings

개인 키보드 설정 백업입니다. macOS Karabiner-Elements 설정과 기존 Windows 설정을 보관합니다.

## 파일

- `mac/mini_key.json`: 2026-11-07 기준 실제 사용 중인 전체 Karabiner 설정
- `window/`: 기존 Windows 설정

## macOS 단축키

### Ctrl + Cmd: 미디어

| 추가 키 | 기능 |
| --- | --- |
| 1 / 2 | 화면 밝기 낮추기 / 높이기 |
| 7 | 이전 곡 |
| 8 | 재생 / 일시 정지 |
| 9 | 다음 곡 |
| 0 | 음소거 |
| - / = | 음량 줄이기 / 키우기 |

밝기 조절은 디스플레이 지원 여부에 따라 달라집니다. 이전/다음 곡은 곡 내 되감기/빨리 감기와 다릅니다. 오른쪽 Shift 레이어를 누르는 동안에는 이 미디어 매핑이 적용되지 않습니다.

### Ctrl + Cmd: 마우스와 데스크톱

| 추가 키 | 기능 |
| --- | --- |
| O / K / L / ; | 포인터 위 / 왼쪽 / 아래 / 오른쪽 |
| A / D | 왼쪽 / 오른쪽 클릭 |
| S | 누르는 동안 포인터 속도 2.5배 |
| I / P | 위 / 아래 스크롤 |
| J / 작은따옴표 | Ctrl+왼쪽 / 오른쪽 화살표 전송 (데스크톱 전환) |
| [ / ] | 화면 0의 왼쪽 / 오른쪽 절반 중앙으로 포인터 이동 |

### 오른쪽 Shift를 누르는 동안

| 추가 키 | 기능 |
| --- | --- |
| 1~9 / 0 / - / = | F1~F9 / F10 / F11 / F12 |
| W / A / S / D | 위 / 왼쪽 / 아래 / 오른쪽 화살표 |
| Q / E | Option+왼쪽 / 오른쪽 화살표 |
| Z / C | Cmd+왼쪽 / 오른쪽 화살표 |
| R / F | Cmd+위 / 아래 화살표 |
| T / G | Page Up / Page Down |
| X | Backspace |
| O | Mission Control |
| 백틱 | Escape |
| V | Ctrl+L |
| / / . | 아래 / 위 스크롤 |

이 레이어에서는 Cmd+C/V/X/Z/A를 유지하며, 등록하지 않은 일반 키는 차단합니다.

### 기타

- Ctrl+역슬래시: 백틱, Shift를 함께 누르면 물결표
- Caps Lock: 왼쪽 Control
- 일부 키보드의 왼쪽 Command/Option 교환 등 장치별 설정도 전체 백업에 포함됩니다.

## 복원

Karabiner-Elements를 설치하고 필요한 권한을 허용한 뒤, 저장소 루트에서 실행합니다.

```sh
mkdir -p ~/.config/karabiner
if [ -f ~/.config/karabiner/karabiner.json ]; then
  cp ~/.config/karabiner/karabiner.json ~/.config/karabiner/karabiner.json.backup-$(date +%Y%m%d-%H%M%S)
fi
cp mac/mini_key.json ~/.config/karabiner/karabiner.json
```

현재 전체 설정을 교체합니다. 설정이 즉시 반영되지 않으면 Karabiner-Elements를 다시 실행하세요. 다른 키보드에서는 장치별 설정을 확인하세요.

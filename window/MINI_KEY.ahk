#Requires AutoHotkey v2.0
#SingleInstance Force

; 마우스 및 키보드 입력 주사율 최적화 세팅
SetKeyDelay(-1)
SetMouseDelay(-1)

global caps_lock_held := false

; [★ 추가됨] Ctrl + Space를 누르면 한영 변환(가상 키 VK15)을 수행합니다.
^Space::Send("{VK15}")

; 1. Caps Lock 가상 레이어 상태 관리
*CapsLock:: {
    global caps_lock_held := true
}

*CapsLock up:: {
    global caps_lock_held := false
}

; 2. Caps Lock이 눌려있을 때의 마우스 이동 (WASD 글자 유입 차단)
#HotIf caps_lock_held

*w:: StartMouseTimer()
*s:: StartMouseTimer()
*a:: StartMouseTimer()
*d:: StartMouseTimer()
*w up:: StartMouseTimer()
*s up:: StartMouseTimer()
*a up:: StartMouseTimer()
*d up:: CheckMouseRelease()

; 3. Caps Lock 레이어 일반 단축키 및 IJKL 방향키 맵핑
*`::Send("{Blind}{Esc}")
*1::Send("{Blind}{F1}")
*2::Send("{Blind}{F2}")
*3::Send("{Blind}{F3}")
*4::Send("{Blind}{F4}")
*5::Send("{Blind}{F5}")
*6::Send("{Blind}{F6}")
*7::Send("{Blind}{F7}")
*8::Send("{Blind}{F8}")
*9::Send("{Blind}{F9}")
*0::Send("{Blind}{F10}")
*-::Send("{Blind}{F11}")
*=::Send("{Blind}{F12}")

*i::Send("{Blind}{Up}")
*j::Send("{Blind}{Left}")
*k::Send("{Blind}{Down}")
*l::Send("{Blind}{Right}")

*Space::Send("{Blind}{LButton}")
*q::Send("{Blind}{RButton}")

; 가상 데스크톱 및 페이지 이동
*u::Send("{Blind}{PgUp}")
*o::Send("{Blind}{PgDn}")

; [★ 수정됨] 윈도우 키 이벤트가 씹히지 않도록 SendEvent 모드로 변경하여 확실하게 작업 보기창 호출
*$p:: {
    SendEvent "{LWin Down}{Tab}{LWin Up}"
}

*[::Send("^#{Left}")
*]::Send("^#{Right}")

#HotIf

; 4. 마우스 실시간 방향 계산 및 타이머 구동 엔진
StartMouseTimer() {
    global caps_lock_held
    static is_timer_active := false
    
    w_p := GetKeyState("w", "P")
    s_p := GetKeyState("s", "P")
    a_p := GetKeyState("a", "P")
    d_p := GetKeyState("d", "P")
    
    if (caps_lock_held && (w_p || s_p || a_p || d_p)) {
        if (!is_timer_active) {
            is_timer_active := true
            SetTimer(SmoothMouseMoveEngine, 10)
        }
    } else {
        if (is_timer_active) {
            SetTimer(SmoothMouseMoveEngine, 0)
            is_timer_active := false
            SmoothMouseMoveEngine(true) 
        }
    }
}

CheckMouseRelease() {
    StartMouseTimer()
}

; 5. 부드러운 가속 곡선을 그리는 실제 가속도 물리 엔진
SmoothMouseMoveEngine(force_reset := false) {
    global caps_lock_held
    
    static base_speed := 1.2       
    static max_speed := 22.0       
    static acceleration := 1.07    
    static current_speed := base_speed
    
    if (force_reset) {
        current_speed := base_speed
        return
    }
    
    w_p := GetKeyState("w", "P") ? 1 : 0
    s_p := GetKeyState("s", "P") ? 1 : 0
    a_p := GetKeyState("a", "P") ? 1 : 0
    d_p := GetKeyState("d", "P") ? 1 : 0
    
    if (!caps_lock_held || (w_p = 0 && s_p = 0 && a_p = 0 && d_p = 0)) {
        current_speed := base_speed
        SetTimer(SmoothMouseMoveEngine, 0)
        return
    }
    
    vx := d_p - a_p
    vy := s_p - w_p
    
    current_speed := current_speed * acceleration
    if (current_speed > max_speed)
        current_speed := max_speed
        
    dx := Round(vx * current_speed)
    dy := Round(vy * current_speed)
    
    if (vx != 0 && vy != 0) {
        dx := Round(dx * 0.7071)
        dy := Round(dy * 0.7071)
    }
    
    DllCall("mouse_event", "UInt", 0x0001, "Int", dx, "Int", dy, "UInt", 0, "UPtr", 0)
}
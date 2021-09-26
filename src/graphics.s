; ------------------------------------------------------------------------------
; graphics.s
; ------------------------------------------------------------------------------
                    mx        %00


; GraphicsOn
; ------------------------------------------------------------------------------
GraphicsOn          sep       #$30
                    lda       #$c1
                    stal      $00c029
                    rep       #$30
                    rts


; GraphicsOff
; ------------------------------------------------------------------------------
GraphicsOff         sep       #$30
                    lda       #$01
                    stal      $00c029
                    rep       #$30
                    rts


; ShadowOn
; ------------------------------------------------------------------------------
ShadowOn            sep       #$20
                    ldal      >$e0c035
;                    and       #$f7                 ; 1111 0111
                    and       #$e0                 ; 1110 0000
                    stal      >$e0c035
                    rep       #$20
                    rts


; ShadowOff
; ------------------------------------------------------------------------------
ShadowOff           lda       #$0000
                    sep       #$20
                    ldal      >$e0c035
;                    ora       #$08                 ; 0000 1000
                    ora       #$1f                 ; 0001 1111
                    stal      >$e0c035
                    rep       #$20
                    rts


; ClearToColor
;   A = palette color entry
; ------------------------------------------------------------------------------
ClearToColor        ldx       #$7d00
]loop               dex
                    dex
                    stal      $e12000,x
                    bne       ]loop
                    rts


; SetPaletteColor
;   A = XRGB color
;   X = palette color entry
; ------------------------------------------------------------------------------
SetPaletteColor     pha
                    txa
                    asl
                    tax
                    pla
                    stal      $e19e00,x
                    rts


; VerticalBlank
; ------------------------------------------------------------------------------
VerticalBlank

                    sep       #$30
]waitRaster         lda       $c019
                    bpl       ]waitRaster
]waitVBL            lda       $c019
                    bmi       ]waitVBL
                    rep       #$30
                    rts


; ShadowedUpdate
; ------------------------------------------------------------------------------
ShadowedUpdate

                    jsr       VerticalBlank
                    jsr       ShadowOn

addrjslPEISlam      jsl       PEISlam

                    jsr       ShadowOff
                    rts


; LocatePEISlam
; ------------------------------------------------------------------------------
LocatePEISlam

                    jsr       ShadowOff

; Allocate memory for relocating PEISlam
                    PushLong  #$0400
                    jsr       NewAlloc
                    PullLong  PEISlamLoc
                    PullLong  DPPEISlamLoc

; Copy PEISlam to the new location
                    ldx       PEISlam
                    ldy       #$0000
]loop               lda       PEISlam,y
                    stal      [DPPEISlamLoc],y
                    iny
                    inx
                    cmp       PEISlamEnd
                    bne       ]loop

; Update the address for jumping to PEISlam at addrjslPEISlam
                    sep       #$20
                    lda       DPPEISlamLoc
                    sta       addrjslPEISlam+1
                    lda       DPPEISlamLoc+1
                    sta       addrjslPEISlam+2
                    lda       DPPEISlamLoc+2
                    sta       addrjslPEISlam+3
                    rep       #$20

; Get the in bank address of the new PEISlamLoop location
                    lda       #PEISlamLoop
                    sec
                    sbc       #PEISlamBase
                    clc
                    adc       DPPEISlamLoc
                    tax

; Get the in bank offset to the new addrjmpPEISlamLoop location
                    lda       #addrjmpPEISlamLoop
                    sec
                    sbc       #PEISlamBase
                    clc
                    adc       #$0001               ; skip the jmp opcode
                    tay

; X = new PEISlamLoop location
; Y = offset to new addrjmpPEISlamLoop location
; Set the address for jumping to PEISlamLoop
                    txa
                    stal      [DPPEISlamLoc],y

                    rts


PEISlamLoc          ds        4


; PEISlam
; ------------------------------------------------------------------------------
PEISlam
PEISlamBase

; Disable interrupts and save original stack and original direct page pointers

                    sei
                    tdc
                    stal      EntryDP
                    tsc
                    stal      EntryStack

; Move stack and direct page pointers to bank $01
                    sep       #$20
                    stal      >$00c005
                    stal      >$00c003
                    rep       #$20

                    ldx       #$2000

PEISlamLoop

; Move direct page pointer to start of the SHR memory page
                    txa
                    tcd

; Move stack pointer to top of first page of SHR memory page
                    clc
                    adc       #$00ff
                    tcs

; PEI the 256 bytes
                    pei       $fe
                    pei       $fc
                    pei       $fa
                    pei       $f8
                    pei       $f6
                    pei       $f4
                    pei       $f2
                    pei       $f0
                    nop
                    pei       $ee
                    pei       $ec
                    pei       $ea
                    pei       $e8
                    pei       $e6
                    pei       $e4
                    pei       $e2
                    pei       $e0
                    nop
                    pei       $de
                    pei       $dc
                    pei       $da
                    pei       $d8
                    pei       $d6
                    pei       $d4
                    pei       $d2
                    pei       $d0
                    nop
                    pei       $ce
                    pei       $cc
                    pei       $ca
                    pei       $c8
                    pei       $c6
                    pei       $c4
                    pei       $c2
                    pei       $c0
                    nop
                    pei       $be
                    pei       $bc
                    pei       $ba
                    pei       $b8
                    pei       $b6
                    pei       $b4
                    pei       $b2
                    pei       $b0
                    nop
                    pei       $ae
                    pei       $ac
                    pei       $aa
                    pei       $a8
                    pei       $a6
                    pei       $a4
                    pei       $a2
                    pei       $a0
                    nop
                    pei       $9e
                    pei       $9c
                    pei       $9a
                    pei       $98
                    pei       $96
                    pei       $94
                    pei       $92
                    pei       $90
                    nop
                    pei       $8e
                    pei       $8c
                    pei       $8a
                    pei       $88
                    pei       $86
                    pei       $84
                    pei       $82
                    pei       $80
                    nop
                    pei       $7e
                    pei       $7c
                    pei       $7a
                    pei       $78
                    pei       $76
                    pei       $74
                    pei       $72
                    pei       $70
                    nop
                    pei       $6e
                    pei       $6c
                    pei       $6a
                    pei       $68
                    pei       $66
                    pei       $64
                    pei       $62
                    pei       $60
                    nop
                    pei       $5e
                    pei       $5c
                    pei       $5a
                    pei       $58
                    pei       $56
                    pei       $54
                    pei       $52
                    pei       $50
                    nop
                    pei       $4e
                    pei       $4c
                    pei       $4a
                    pei       $48
                    pei       $46
                    pei       $44
                    pei       $42
                    pei       $40
                    nop
                    pei       $3e
                    pei       $3c
                    pei       $3a
                    pei       $38
                    pei       $36
                    pei       $34
                    pei       $32
                    pei       $30
                    nop
                    pei       $2e
                    pei       $2c
                    pei       $2a
                    pei       $28
                    pei       $26
                    pei       $24
                    pei       $22
                    pei       $20
                    nop
                    pei       $1e
                    pei       $1c
                    pei       $1a
                    pei       $18
                    pei       $16
                    pei       $14
                    pei       $12
                    pei       $10
                    nop
                    pei       $0e
                    pei       $0c
                    pei       $0a
                    pei       $08
                    pei       $06
                    pei       $04
                    pei       $02
                    pei       $00
                    nop

; Restore original stack and original direct page pointers and enable interrupts
                    sep       #$20
                    stal      >$00c004
                    stal      >$00c002
                    rep       #$20
                    ldal      EntryStack
                    tcs
                    ldal      EntryDP
                    tcd
                    cli

; Disable interrupts and move stack and direct page pointers to bank $01
                    sei
                    sep       #$20
                    stal      >$00c005
                    stal      >$00c003
                    rep       #$20

                    txa
                    clc
                    adc       #$0100
                    tax
                    cmp       #$9d00

                    bcc       addrjmpPEISlamLoop
                    bra       :finish
addrjmpPEISlamLoop  jmp       PEISlamLoop
:finish

; Restore original stack and original direct page pointers and enable interrupts
                    sep       #$20
                    stal      >$00c004
                    stal      >$00c002
                    rep       #$20
                    ldal      EntryStack
                    tcs
                    ldal      EntryDP
                    tcd
                    cli

                    rtl

PEISlamEnd          nop

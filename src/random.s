; ------------------------------------------------------------------------------
; random.s
; ------------------------------------------------------------------------------
            mx    %00


; InitSeed
; ------------------------------------------------------------------------------
InitSeed
; Use the current value in VertCnt and HorizCnt
            lda   $c02e
            sta   RandSeed
            rts


; SetSeed
; A = Random seed
; ------------------------------------------------------------------------------
SetSeed
            sta   RandSeed
            rts


; RandNumToA
; Return: A = Random number
; ------------------------------------------------------------------------------
RandNumToA
; 16-bit xorshift
            lda   RandSeed
            rol
            rol
            rol
            rol
            rol
            rol
            rol
            eor   RandSeed    ; RandSeed ^= RandSeed << 7
            ror
            ror
            ror
            ror
            ror
            ror
            ror
            ror
            ror
            eor   RandSeed    ; RandSeed ^= RandSeed >> 9
            rol
            rol
            rol
            rol
            rol
            rol
            rol
            rol
            eor   RandSeed    ; RandSeed ^= RandSeed << 8
            sta   RandSeed
            rts


RandSeed    ds    2

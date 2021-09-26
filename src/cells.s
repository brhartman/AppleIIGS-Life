; ------------------------------------------------------------------------------
; cells.s
; ------------------------------------------------------------------------------
                mx          %00


; LoadCellsCrnNW
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsCrnNW
                phy

                stz         CellNW
                stz         CellN
                stz         CellNE
                stz         CellW
                stz         CellSW

                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                IncrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellS
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellSE

                ply
                rts


; LoadCellsCrnNE
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsCrnNE
                phy

                stz         CellNW
                stz         CellN
                stz         CellNE
                stz         CellE
                stz         CellSE

                lda         [DPUpdateSrc],y
                sta         CellX
                dey
                dey
                lda         [DPUpdateSrc],y
                sta         CellW

                IncrementY  #162
                lda         [DPUpdateSrc],y
                sta         CellS
                dey
                dey
                lda         [DPUpdateSrc],y
                sta         CellSW

                ply
                rts


; LoadCellsCrnSW
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsCrnSW
                phy

                stz         CellNW
                stz         CellW
                stz         CellSW
                stz         CellS
                stz         CellSE

                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                DecrementY  #162
                lda         [DPUpdateSrc],y
                sta         CellN
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellNE

                ply
                rts


; LoadCellsCrnSE
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsCrnSE
                phy

                stz         CellNE
                stz         CellE
                stz         CellSW
                stz         CellS
                stz         CellSE

                lda         [DPUpdateSrc],y
                sta         CellX
                dey
                dey
                lda         [DPUpdateSrc],y
                sta         CellW

                DecrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellS
                dey
                dey
                lda         [DPUpdateSrc],y
                sta         CellSW

                ply
                rts


; LoadCellsN
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsN
                phy

                stz         CellNW
                stz         CellN
                stz         CellNE

                DecrementY  #2
                lda         [DPUpdateSrc],y
                sta         CellW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                IncrementY  #156
                lda         [DPUpdateSrc],y
                sta         CellSW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellS
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellSE

                ply
                rts


; LoadCellsS
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsS
                phy

                stz         CellSW
                stz         CellS
                stz         CellSE

                DecrementY  #162
                lda         [DPUpdateSrc],y
                sta         CellNW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellN
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellNE

                IncrementY  #156
                lda         [DPUpdateSrc],y
                sta         CellW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                ply
                rts


; LoadCellsW
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsW
                phy

                stz         CellNW
                stz         CellW
                stz         CellSW

                DecrementY  #160
                lda         [DPUpdateSrc],y
                sta         CellN
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellNE

                IncrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                IncrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellS
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellSE

                ply
                rts


; LoadCellsE
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsE
                phy

                stz         CellNE
                stz         CellE
                stz         CellSE

                DecrementY  #162
                lda         [DPUpdateSrc],y
                sta         CellNW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellN

                IncrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellX

                IncrementY  #158
                lda         [DPUpdateSrc],y
                sta         CellSW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellS

                ply
                rts


; LoadCellsIn
; Y = Cell index
; ------------------------------------------------------------------------------
LoadCellsIn
                phy

                DecrementY  #162
                lda         [DPUpdateSrc],y
                sta         CellNW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellN
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellNE

                IncrementY  #156
                lda         [DPUpdateSrc],y
                sta         CellW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellX
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellE

                IncrementY  #156
                lda         [DPUpdateSrc],y
                sta         CellSW
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellS
                iny
                iny
                lda         [DPUpdateSrc],y
                sta         CellSE

                ply
                rts


CellNW          ds          2
CellN           ds          2
CellNE          ds          2
CellW           ds          2
CellX           ds          2
CellE           ds          2
CellSW          ds          2
CellS           ds          2
CellSE          ds          2


; ComputeCell
; Return: A = Color for cell
; ------------------------------------------------------------------------------
ComputeCell

; xxxx|xxxx|xxxx
; xxxx|ABCD|xxxx
; xxxx|xxxx|xxxx

; ...a|aa..|....    ....|bbb.|....    ....|.ccc|....    ....|..dd|d...
; ...a|Aa..|....    ....|bBb.|....    ....|.cCc|....    ....|..dD|d...
; ...a|aa..|....    ....|bbb.|....    ....|.ccc|....    ....|..dd|d...

                jsr         ComputeCellA
                sta         CellOutA

                jsr         ComputeCellB
                sta         CellOutB

                jsr         ComputeCellC
                sta         CellOutC

                jsr         ComputeCellD
                sta         CellOutD

                lda         #$0000
                clc
                adc         CellOutA
                clc
                adc         CellOutB
                clc
                adc         CellOutC
                clc
                adc         CellOutD

                rts


CellOutA        ds          2
CellOutB        ds          2
CellOutC        ds          2
CellOutD        ds          2


; ComputeCellA
; Return: A = Color for cell
; ------------------------------------------------------------------------------
ComputeCellA

                phx

; Count the number of neighbours that are populated

                ldx         #$0000

; ...0|35..|....    ->    .0..|..35|....
; ...1|A6..|....    ->    .1..|..A6|....
; ...2|47..|....    ->    .2..|..47|....

                lda         #$0F00

                bit         CellNW
                beq         :no0
                inx
:no0
                bit         CellW
                beq         :no1
                inx
:no1
                bit         CellSW
                beq         :no2
                inx
:no2

                lda         #$00F0

                bit         CellN
                beq         :no3
                inx
:no3
                bit         CellS
                beq         :no4
                inx
:no4

                lda         #$000F

                bit         CellN
                beq         :no5
                inx
:no5
                bit         CellX
                beq         :no6
                inx
:no6
                bit         CellS
                beq         :no7
                inx
:no7

                lda         #$00F0
                jsr         ComputeLife
                and         #$00F0

                plx

                rts


; ComputeCellB
; Return: A = Color for cell
; ------------------------------------------------------------------------------
ComputeCellB

                phx

; Count the number of neighbours that are populated

                ldx         #$0000

; ....|035.|....    ->    ....|5.03|....
; ....|1B6.|....    ->    ....|6.1B|....
; ....|247.|....    ->    ....|7.24|....

                lda         #$00F0

                bit         CellN
                beq         :no0
                inx
:no0
                bit         CellX
                beq         :no1
                inx
:no1
                bit         CellS
                beq         :no2
                inx
:no2

                lda         #$000F

                bit         CellN
                beq         :no3
                inx
:no3
                bit         CellS
                beq         :no4
                inx
:no4

                lda         #$F000

                bit         CellN
                beq         :no5
                inx
:no5
                bit         CellX
                beq         :no6
                inx
:no6
                bit         CellS
                beq         :no7
                inx
:no7

                lda         #$000F
                jsr         ComputeLife
                and         #$000F

                plx

                rts


; ComputeCellC
; Return: A = Color for cell
; ------------------------------------------------------------------------------
ComputeCellC

                phx

; Count the number of neighbours that are populated

                ldx         #$0000

; ....|.035|....    ->    ....|35.0|....
; ....|.1C6|....    ->    ....|C6.1|....
; ....|.247|....    ->    ....|47.2|....

                lda         #$000F

                bit         CellN
                beq         :no0
                inx
:no0
                bit         CellX
                beq         :no1
                inx
:no1
                bit         CellS
                beq         :no2
                inx
:no2

                lda         #$F000

                bit         CellN
                beq         :no3
                inx
:no3
                bit         CellS
                beq         :no4
                inx
:no4

                lda         #$0F00

                bit         CellN
                beq         :no5
                inx
:no5
                bit         CellX
                beq         :no6
                inx
:no6
                bit         CellS
                beq         :no7
                inx
:no7

                lda         #$F000
                jsr         ComputeLife
                and         #$F000

                plx

                rts


; ComputeCellD
; Return: A = Color for cell
; ------------------------------------------------------------------------------
ComputeCellD

                phx

; Count the number of neighbours that are populated

                ldx         #$0000

; ....|..03|5...    ->    ....|03..|..5.
; ....|..1D|6...    ->    ....|1D..|..6.
; ....|..24|7...    ->    ....|24..|..7.

                lda         #$F000

                bit         CellN
                beq         :no0
                inx
:no0
                bit         CellX
                beq         :no1
                inx
:no1
                bit         CellS
                beq         :no2
                inx
:no2

                lda         #$0F00

                bit         CellN
                beq         :no3
                inx
:no3
                bit         CellS
                beq         :no4
                inx
:no4

                lda         #$00F0

                bit         CellNE
                beq         :no5
                inx
:no5
                bit         CellE
                beq         :no6
                inx
:no6
                bit         CellSE
                beq         :no7
                inx
:no7

                lda         #$0F00
                jsr         ComputeLife
                and         #$0F00

                plx

                rts


; ComputeLife
; A = Cell bit mask
; X = Neighbor count
; Return: A = Color for cell
; ------------------------------------------------------------------------------

ComputeLife

; 1. Any live cell with two or three live neighbours survives.
; 2. Any dead cell with three live neighbours becomes a live cell.
; 3. All other live cells die in the next generation. Similarly, all other dead cells stay dead.

                bit         CellX
                beq         :noCellX

; Current cell is populated

                cpx         #2
                beq         :live2
                cpx         #3
                beq         :live3
                lda         #$0000
                rts

:live2
                lda         #$2222
                rts

:live3
                lda         #$3333
                rts

; Current cell is not populated

:noCellX
                cpx         #3
                beq         :birth3
                lda         #$0000
                rts

:birth3
                lda         #$4444
                rts

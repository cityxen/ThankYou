/////////////////////////////////////////////////////
// CityXen 1024 Subscribers Special Video by Deadline
// Title: 1024 Yard Stare
// Thank You!

.segment Code []
.file [name="prg_files/1024YS.prg",segments="Code"]
.disk [filename="prg_files/1024YS.d64", name="1024 SUBSCRIBERS!", id="CXN20" ] {
    [name="1024YS", type="prg",  segments="Code"]
}

*=$2ff0 "constants"
#import "../../Commodore64_Programming/include/Constants.asm"
// #import "../../Commodore64_Programming/include/Macros.asm"
#import "../../Commodore64_Programming/include/DrawPetMateScreen.asm"

*=$2000 "Sprites"
#import "1024-sprites.asm"

*=$3000 "Character Data"
#import "characters-charset.asm"

*=$4000 "Screen Data"
#import "screen-yt.asm"

.var music = LoadSid("sids/o.sid");

*=music.location "Music"
.fill music.size, music.getData(i)

.print ""
.print "SID Data"
.print "--------"
.print "location=$"+toHexString(music.location)
.print "init=$"+toHexString(music.init)
.print "play=$"+toHexString(music.play)
.print "songs="+music.songs
.print "startSong="+music.startSong
.print "size=$"+toHexString(music.size)
.print "name="+music.name
.print "author="+music.author
.print "copyright="+music.copyright
.print ""
.print "Additional tech data"
.print "--------------------"
.print "header="+music.header
.print "header version="+music.version
.print "flags="+toBinaryString(music.flags)
.print "speed="+toBinaryString(music.speed)
.print "startpage="+music.startpage
.print "pagelength="+music.pagelength

.const SCREEN_BOTTOM_LEFT  = $7C0
.const SCREEN_BOTTOM_RIGHT = $7E7
.const COLORS_BOTTOM_LEFT  = $DBC0

//////////////////////////////////////////////////////////
// START OF PROGRAM
*=$0801 "BASIC"
    BasicUpstart2($0810)
*=$0810 "Program"

start:

    lda #<hello_message
    sta zp_tmp_lo
    lda #>hello_message
    sta zp_tmp_hi

    lda #$00
    sta count_var_high
    sta count_var_low
    sta timer_var
    sta $d020
    sta $d021
    ldx #0
    ldy #0
    lda #00
    jsr music.init
    sei
    lda #<irq1
    sta $0314
    lda #>irq1
    sta $0315
    asl $d019
    lda #$7b
    sta $dc0d
    lda #$81
    sta $d01a
    lda #$1b
    sta $d011
    lda #$80
    sta $d012
    cli
    
    lda VIC_MEM_POINTERS // point to the new characters
    ora #$0c
    sta VIC_MEM_POINTERS

    DrawPetMateScreen(screen_001)
    lda #$00
    sta COLORS_BOTTOM_LEFT-1

    ldx #$00
color_cycle_fill_loop:
    lda color_table,x
    sta COLORS_BOTTOM_LEFT,x
    sta COLORS_BOTTOM_LEFT+8,x
    sta COLORS_BOTTOM_LEFT+16,x
    sta COLORS_BOTTOM_LEFT+24,x
    sta COLORS_BOTTOM_LEFT+32,x
    inx
    cpx #$08
    bne color_cycle_fill_loop

    lda #$ff
    sta SPRITE_ENABLE

    lda yin_yang_anim
    sta SPRITE_0_POINTER // SPRITE 0: YIN YANG 1
    sta SPRITE_1_POINTER // SPRITE 1: YIN YANG 2

    lda eagle_anim       // SPRITE 2: EAGLE
    sta SPRITE_2_POINTER

    lda nauga_anim
    sta SPRITE_3_POINTER // SPRITE 3: NAUGA

    lda helm_anim
    sta SPRITE_4_POINTER // SPRITE 4: HELM

    lda #$98
    sta SPRITE_5_POINTER // SPRITE 5: YOUTUBE TRIANGLE
    sta SPRITE_7_POINTER // SPRITE 7: YOUTUBE TRIANGLE SHADOW

    lda clicky_anim
    sta SPRITE_6_POINTER // SPRITE 6: CLICKY
    
    ldx #$00 // LOCATIONS
    ldy #$00
sprite_locations_loop:
    lda sprite_loc_table,x // msb
    cmp #$ff
    beq sprite_locations_exit
    ora SPRITE_LOCATIONS_MSB
    sta SPRITE_LOCATIONS_MSB
    inx
    lda sprite_loc_table,x // sprite x loc
    sta SPRITE_LOCATIONS,y
    inx
    iny
    lda sprite_loc_table,x // sprite y loc
    sta SPRITE_LOCATIONS,y
    iny
    inx
    jmp sprite_locations_loop
sprite_locations_exit:

    lda #$05
    sta SPRITE_MULTICOLOR_0
    lda #$07 
    sta SPRITE_MULTICOLOR_1

    ldx #$00 // COLORS
sprite_colors_loop:
    lda sprite_color_table,x
    sta SPRITE_COLORS,x
    inx
    cpx #$08
    bne sprite_colors_loop


    lda #64+16+8+4 // 00111100
    sta SPRITE_MULTICOLOR

    lda #ORANGE
    sta SPRITE_MULTICOLOR_0
    lda #BLACK
    sta SPRITE_MULTICOLOR_1

    lda #$08
    sta SPRITE_EXPAND_Y
    sta SPRITE_EXPAND_X

loop256:
    
loop1b:

    inc vars+11
    lda vars+11
    cmp #$9b
    bne loop1c
    lda #$00
    sta vars+11
    inc vars+10
    ldx vars+10
    lda sinetable,x
    adc #$1a
    sta SPRITE_0_X
    inc vars+12
    ldx vars+12
    lda sinetable,x
    adc #$1a
    sta SPRITE_1_X

loop1c:
       
loop1d:
    lda #$f2         // Wait for raster line $f2
    cmp VIC_RASTER_COUNTER
    bne loop256      // if not at $f2, goto loop1
    
varlabel:
    lda #$00 // go into 38 column mode and set scroll bits
    and #$07 // varlabel+1 will be changed with self modifying code
    sta VIC_CONTROL_REG_2

loop2:
    lda #$ff // wait for raster line $ff
    cmp VIC_RASTER_COUNTER
    bne loop2

    lda #$c8 // reset the borders to 40 column mode
    sta VIC_CONTROL_REG_2

    dec varlabel+1
    lda varlabel+1
    and #$07
    cmp #$07
    bne skipmove

    

    // Move scroller characters
    ldx #$00
mvlp1:
    lda SCREEN_BOTTOM_LEFT+1,x
    sta SCREEN_BOTTOM_LEFT,x
    inx
    cpx #39
    bne mvlp1

mvlp2: // put character from scroller message onto bottom right

mvlp22:

    ldx #$00
    lda (zp_tmp,x)
    sta SCREEN_BOTTOM_RIGHT
    iny
    lda (zp_tmp,x)
    cmp #$ff
    bne mvover1

    lda #<hello_message
    sta zp_tmp_lo
    lda #>hello_message
    sta zp_tmp_hi

mvover1:
    inc zp_tmp_lo
    bne mvlp223
    inc zp_tmp_hi

mvlp223:

    

skipmove:
    // color cycling

    inc vars
    lda vars
    cmp #$05
    beq more_color
    jmp animate_sprites

more_color:
    lda #$00  // reset color timer
    sta vars

    // move colors
    ldx #39
cycle_colors:
    lda COLORS_BOTTOM_LEFT-1,x
    sta COLORS_BOTTOM_LEFT,x
    dex
    cpx #$ff
    bne cycle_colors

    inc vars+1
    ldx vars+1
    lda color_table,x
    cmp #$ff
    beq reset_colors
    sta COLORS_BOTTOM_LEFT
    jmp loop256

reset_colors:
    lda #$ff
    sta vars+1

animate_sprites:

animate_yin_yang:
    // animate yin_yang
    inc vars+2
    lda vars+2
    cmp #$03
    beq more_yin_yang
    jmp animate_sprites_2
more_yin_yang:
    lda #$00  // reset timer
    sta vars+2
    clc
    inc sprite_anim_index_table
    ldx sprite_anim_index_table
    lda yin_yang_anim,x
    bne yy1
    ldx #$00
yy1:
    stx sprite_anim_index_table    
    lda yin_yang_anim,x
    sta SPRITE_0_POINTER
    sta SPRITE_1_POINTER
    
animate_sprites_2:

animate_eagle:
    // animate eagle
    inc vars+3
    lda vars+3
    cmp #$25
    beq more_eagle
    jmp animate_sprites_3
more_eagle:
    lda #$00  // reset timer
    sta vars+3
    clc
    inc sprite_anim_index_table+2
    ldx sprite_anim_index_table+2
    lda eagle_anim,x
    bne eag1
    ldx #$00
eag1:
    stx sprite_anim_index_table+2
    lda eagle_anim,x
    sta SPRITE_2_POINTER

animate_sprites_3:

animate_nauga:
    // animate nauga
    inc vars+4
    lda vars+4
    cmp #$45
    beq more_nauga
    jmp animate_sprites_4
more_nauga:
    lda #$00  // reset timer
    sta vars+4
    clc
    inc sprite_anim_index_table+3
    ldx sprite_anim_index_table+3
    lda eagle_anim,x
    bne naug1
    ldx #$00
naug1:
    stx sprite_anim_index_table+3
    lda nauga_anim,x
    sta SPRITE_3_POINTER

animate_sprites_4:

animate_clicky:
    // animate clicky
    inc vars+5
    lda vars+5
    cmp #$02
    beq more_clicky
    jmp animate_sprites_5
more_clicky:
    lda #$00  // reset timer
    sta vars+5
    clc
    inc sprite_anim_index_table+4
    ldx sprite_anim_index_table+4
    lda clicky_anim,x
    bne click1
    ldx #$00
click1:
    stx sprite_anim_index_table+4
    lda clicky_anim,x
    sta SPRITE_6_POINTER

animate_sprites_5:

animate_helm:
    // animate helm
    inc vars+6
    lda vars+6
    cmp #$12
    beq more_helm
    jmp animate_sprites_6
more_helm:
    lda #$00  // reset timer
    sta vars+6
    clc
    inc sprite_anim_index_table+5
    ldx sprite_anim_index_table+5
    lda helm_anim,x
    bne helm1
    ldx #$00
helm1:
    stx sprite_anim_index_table+5
    lda helm_anim,x
    sta SPRITE_4_POINTER

animate_sprites_6:

binary_counter: // update binary counter
    inc timer_var
    lda timer_var
    // sta $0400
    cmp #$05
    beq more_binary_counter_0
    jmp exit_binary_counter

more_binary_counter_0:
    lda #$00  // reset timer
    sta timer_var
    lda count_var_low
    clc
    adc #$01
    sta count_var_low
    bcc !mbc+
    inc count_var_high
!mbc:
    lda count_var_low
    // sta $0401
    lda count_var_high
    // sta $0402

more_binary_counter_1:
    lda count_var_high // msb (ie 1024)
    and #$04
    cmp #$04
    beq !mbccc+
    jmp !mbccc++
!mbccc:
    inc $d020
    DrawBinaryChar(binary_1_char,9,21)
    DrawBinaryChar(binary_0_char,11,21)
    DrawBinaryChar(binary_0_char,13,21)
    DrawBinaryChar(binary_0_char,15,21)
    DrawBinaryChar(binary_0_char,17,21)
    DrawBinaryChar(binary_0_char,19,21)
    DrawBinaryChar(binary_0_char,21,21)
    DrawBinaryChar(binary_0_char,23,21)
    DrawBinaryChar(binary_0_char,25,21)
    DrawBinaryChar(binary_0_char,27,21)
    DrawBinaryChar(binary_0_char,29,21)
    
    jmp exit_binary_counter
!mbccc:
    DrawBinaryChar(binary_0_char,9,21)
    lda count_var_high
    and #$02
    cmp #$02
    bne !mbccc+
    DrawBinaryChar(binary_1_char,11,21)
    jmp !mbccc++
!mbccc:
    DrawBinaryChar(binary_0_char,11,21)
!mbccc:

    lda count_var_high
    and #$01
    cmp #$01
    bne !mbccc+
    DrawBinaryChar(binary_1_char,13,21)
    jmp !mbccc++
!mbccc:
    DrawBinaryChar(binary_0_char,13,21)
!mbccc:
  
    lda count_var_low
    clc
    ror
    pha
    bcc db0_1
    DrawBinaryChar(binary_1_char,29,21)
    jmp db0_2
db0_1:
    DrawBinaryChar(binary_0_char,29,21)
db0_2:

mbc22:
    pla
    clc
    ror
    pha
    bcc db1_1
    DrawBinaryChar(binary_1_char,27,21)
    jmp db1_2
db1_1:
    DrawBinaryChar(binary_0_char,27,21)
db1_2:

    pla
    clc
    ror
    pha
    bcc db2_1
    DrawBinaryChar(binary_1_char,25,21)
    jmp db2_2
db2_1:
    DrawBinaryChar(binary_0_char,25,21)
db2_2:

    pla
    clc
    ror
    pha
    bcc db3_1
    DrawBinaryChar(binary_1_char,23,21)
    jmp db3_2
db3_1:
    DrawBinaryChar(binary_0_char,23,21)
db3_2:

    pla
    clc
    ror
    pha 
    bcc db4_1
    DrawBinaryChar(binary_1_char,21,21)
    jmp db4_2
db4_1:
    DrawBinaryChar(binary_0_char,21,21)
db4_2:

    pla
    clc
    ror
    pha
    bcc db5_1
    DrawBinaryChar(binary_1_char,19,21)
    jmp db5_2
db5_1:
    DrawBinaryChar(binary_0_char,19,21)
db5_2:
 
    pla
    clc
    ror
    pha
    bcc db6_1
    DrawBinaryChar(binary_1_char,17,21)
    jmp db6_2
db6_1:
    DrawBinaryChar(binary_0_char,17,21)
db6_2:

    pla
    clc
    ror
    
    bcc db7_1
    DrawBinaryChar(binary_1_char,15,21)
    jmp db7_2
db7_1:
    DrawBinaryChar(binary_0_char,15,21)
db7_2:

exit_binary_counter:
    jmp loop256

.macro DrawBinaryChar(which,column,row) {
    ldx #$00
    lda which,x
    sta 1024+column+row*40
    inx
    lda which,x
    sta 1024+column+row*40+1
    inx
    lda which,x
    sta 1024+column+row*40+40
    inx
    lda which,x
    sta 1024+column+row*40+40+1
}

hello_message:
.encoding "screencode_upper"
.text " 1,024 SUBSCRIBERZ!                            "
.text " ALL RIGHT!                                    "
.text " PATRONS:                                      "
.text " -=*(SUTHEK)*=-                                "
.text " -=*(OLAV HOPE)*=-                             "
.text " -=*(PETZEL)*=-                                "
.text " -=*(CREATE INVENT PODCAST)*=-                 "
.text " -=*(8 BIT SHOW & TELL)*=-                     "
.text " -=*(JXYZN SXYZYXN!)*=-                        "
.text " (THANK YOU PATRONS!) "
.text "WE'VE PUT THIS CODE ON OUR GITHUB SO YOU CAN DOWNLOAD IT. "
.text "GFX/CODE BY DEADLINE - SID FEEL THE BASS BY GASTON... "
.text "THIS SCROLLER HAS MORE THAN 256 BYTES IN IT. IN FACT, "
.text "IT IS CODED IN SUCH A WAY THAT IT WILL KEEP SCROLLING "
.text "THROUGH MEMORY UNTIL IT ENCOUNTERS $FF, WHICH IS WHAT "
.text "I CODED IT TO LOOK FOR TO END THE SCROLL. "
.text "THIS WILL BE IN THE THANK YOU SECTION OF OUR GITHUB. "
.text "I WILL DO A DEDICATED COMMODORE PROGRAMMING VIDEO EXPLAINING "
.text "HOW I DID THIS. "
.text " MORE COMMODORE PROGRAMMING AND OTHER GOODNESS COMING IN 2024, SO STAY TUNED! "
.text "                          -=*(DEADLINE/CXN)*=-      "
.byte $ff

color_table:
.byte BLACK, BLUE, LIGHT_BLUE, WHITE, WHITE, WHITE, WHITE, LIGHT_BLUE, BLUE, BLACK
.byte $ff

sprite_color_table:
.byte WHITE,WHITE,WHITE,YELLOW,DARK_GRAY,WHITE,GREEN,BLACK

sprite_multicolor_table:
.byte 0,0,0
.byte 0,0,0
.byte 1,9,0
.byte 1,9,0
.byte 1,12,0
.byte 1,6,0
.byte 0,0,0
.byte 0,0,0

sprite_loc_table:
.byte $00,$13,$d8 // yinyang left
.byte $02,$43,$d8 // yinyang right
.byte $00,$00,$00 // eagle
.byte $00,$00,$00 // nauga
.byte $00,$00,$00 // helm .byte $10,$2f,$87 // helm
.byte $00,$4F,$98 // youtube triangle
.byte $00,$00,$00 // clicky .byte $00,$87,$c4 // clicky
.byte $00,$51,$9a // youtube triangle shadow
.byte $ff

sprite_anim_index_table:
.byte 0,0,0,0,0,0,0,0

nauga_anim: 
.byte $8a,$8b,$00

yin_yang_anim:
.byte $8c,$8d,$8e,$8f,$90,$91,$92,$93,$00

helm_anim:
.byte $94,$95,$00

eagle_anim:
.byte $96,$97,$00

clicky_anim:
.byte $99,$9a,$9b,$9c,$00

binary_0_char:
.byte 85,73
.byte 74,75

binary_1_char:
.byte 77,78
.byte 109,110

tmps:
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0

vars:
.byte 0 // color timer
.byte 0 // color cycle index
.byte 0 // yinyang sprite anim timer
.byte 0 // eagle sprite anim timer
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0   // sinetable yinyang sprite 1 offset
.byte 128 // sinetable yinyang sprite 2 offset
.byte 0   // color cycle on words timer
.byte 0   // scroll speed



irq1:
    asl $d019
    jsr music.play
    pla
    tay
    pla
    tax
    pla
    rti

sinetable:
.byte $11,$11,$11,$12,$12,$12,$13,$13,$14,$14,$14,$15,$15,$16,$16,$16
.byte $17,$17,$17,$18,$18,$18,$19,$19,$19,$1a,$1a,$1a,$1b,$1b,$1b,$1c
.byte $1c,$1c,$1c,$1d,$1d,$1d,$1d,$1e,$1e,$1e,$1e,$1e,$1f,$1f,$1f,$1f
.byte $1f,$1f,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$1f
.byte $1f,$1f,$1f,$1f,$1f,$1e,$1e,$1e,$1e,$1e,$1d,$1d,$1d,$1d,$1c,$1c
.byte $1c,$1b,$1b,$1b,$1b,$1a,$1a,$1a,$19,$19,$19,$18,$18,$18,$17,$17
.byte $16,$16,$16,$15,$15,$15,$14,$14,$13,$13,$13,$12,$12,$11,$11,$11
.byte $10,$10,$10,$0f,$0f,$0e,$0e,$0e,$0d,$0d,$0c,$0c,$0c,$0b,$0b,$0b
.byte $0a,$0a,$09,$09,$09,$08,$08,$08,$07,$07,$07,$06,$06,$06,$06,$05
.byte $05,$05,$04,$04,$04,$04,$03,$03,$03,$03,$03,$02,$02,$02,$02,$02
.byte $02,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01
.byte $01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$01,$02,$02
.byte $02,$02,$02,$02,$03,$03,$03,$03,$03,$04,$04,$04,$04,$05,$05,$05
.byte $05,$06,$06,$06,$07,$07,$07,$08,$08,$08,$09,$09,$09,$0a,$0a,$0a
.byte $0b,$0b,$0b,$0c,$0c,$0d,$0d,$0d,$0e,$0e,$0f,$0f,$0f,$10,$10,$10


*=$2740
count_var_low:
.byte 0
count_var_high:
.byte 0
timer_var:
.byte 0

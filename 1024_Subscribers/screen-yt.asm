

// PETSCII memory layout (example for a 40x25 screen)'
// byte  0         = border color'
// byte  1         = background color'
// bytes 2-1001    = screencodes'
// bytes 1002-2001 = color

screen_001:
.byte 0,0
.byte 254,236,226,226,226,226,251,160,226,226,251,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,252
.byte 236,126,160,160,160,160,124,251,225,160,225,226,226,251,160,160,160,160,160,160,236,226,226,251,236,226,226,251,160,160,160,160,160,160,160,160,160,160,160,160
.byte 126,160,160,108,123,160,160,124,32,32,124,225,160,124,226,226,226,226,226,226,126,160,160,32,32,160,160,225,236,226,226,226,251,236,226,226,226,226,226,251
.byte 245,160,108,254,252,98,98,123,160,160,32,160,160,160,32,160,160,32,160,160,32,160,160,160,118,160,160,124,126,160,160,160,124,126,160,160,160,160,160,124
.byte 245,160,225,160,160,160,160,252,225,160,108,225,160,108,123,160,160,32,160,160,108,123,32,160,160,226,108,123,160,160,32,225,160,32,160,160,160,32,160,246
.byte 245,160,124,251,236,226,226,251,225,160,225,225,160,225,97,160,160,32,160,160,124,126,160,160,160,160,124,126,160,160,160,160,160,32,160,160,108,123,160,246
.byte 123,160,160,124,126,160,160,225,225,160,225,225,160,124,126,160,160,160,160,160,32,160,160,160,118,160,160,160,160,160,97,160,32,123,160,160,225,97,160,246
.byte 252,123,160,160,160,160,108,254,225,160,225,32,160,160,32,32,160,160,160,160,32,160,160,160,160,160,160,32,32,160,160,160,97,97,160,160,225,97,160,246
.byte 160,252,98,98,98,98,254,160,98,98,254,252,98,98,254,97,32,32,160,160,108,98,98,254,252,98,98,254,252,98,98,98,98,252,98,98,254,252,98,98
.byte 160,160,236,226,226,226,226,226,226,226,226,226,226,160,160,97,160,160,160,108,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,236,108,160,160,160,160,160,160,160,160,160,160,123,160,252,98,98,98,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,97,160,160,160,160,160,160,160,160,160,160,160,160,225,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,252,124,160,160,160,160,160,160,160,160,160,160,126,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 160,160,252,98,98,98,98,98,98,98,98,98,98,254,160,160,160,160,160,160,160,160,160,160,160,160,160,160,148,136,129,142,139,160,153,143,149,161,160,160
.byte 160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160,160
.byte 124,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,226,126
.byte 99,99,99,99,99,99,99,99,79,74,75,74,75,74,75,74,75,74,75,74,75,74,75,74,75,74,75,74,75,74,75,80,99,99,99,99,99,99,99,99
.byte 100,100,100,100,100,100,100,100,76,100,160,100,160,100,160,100,160,100,160,100,160,100,160,100,160,100,160,100,160,100,160,122,100,100,100,100,100,100,100,100
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32,32
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,1,7,7,7,12,12,1,7,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,7,7,12,12,7,7,12,7,13,12,1,7,12,12,12,12,12,12,12,12,1,7,7,1,1,7,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 7,7,12,12,12,12,12,12,7,7,7,7,7,7,7,1,7,7,1,7,7,7,7,7,7,7,7,12,12,1,7,7,12,12,1,7,7,7,7,12
.byte 7,7,12,12,12,12,12,12,7,7,12,7,7,12,12,7,7,14,7,7,12,12,7,7,7,7,12,12,1,7,7,7,7,8,7,7,7,7,7,7
.byte 7,7,12,12,12,12,12,12,7,7,12,7,7,12,12,7,7,7,7,7,12,12,7,7,7,7,12,12,7,7,7,7,7,8,7,7,12,12,7,7
.byte 12,7,7,12,12,7,7,12,7,7,12,7,7,12,12,7,7,0,7,7,11,7,7,7,7,7,7,0,7,7,7,0,11,12,7,7,12,12,7,7
.byte 12,12,7,7,7,7,12,12,7,7,12,7,7,7,7,7,7,7,7,7,11,7,7,0,0,7,7,8,7,7,7,7,7,12,7,7,12,12,7,7
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,8,8,7,7,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,7,7,7,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,1,11,12,12,12,1,1,11,12,1,1,11,12,1,11,1,11,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,1,1,11,12,12,1,11,12,1,11,12,12,1,11,1,11,1,11,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,1,11,12,12,1,11,12,1,11,12,1,11,12,1,1,1,1,11,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,1,11,12,12,1,11,12,1,11,1,11,12,12,12,12,1,11,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,1,11,12,12,1,11,12,1,11,1,11,12,12,12,12,1,11,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,1,11,1,11,12,1,1,11,12,1,1,1,11,12,12,1,11,12,12,12,12,12,12
.byte 12,12,2,2,2,2,2,2,2,2,2,2,2,2,12,12,12,12,12,1,11,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12
.byte 14,14,14,14,14,14,14,14,14,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,12,11,14,14,14,14,14,14,14,14,14
.byte 6,6,6,6,6,6,6,6,6,13,14,13,14,13,14,13,14,13,14,13,14,13,14,13,14,13,14,13,14,13,14,6,6,6,6,6,6,6,6,6
.byte 14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14
.byte 0,0,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,14,0

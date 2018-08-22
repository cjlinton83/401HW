IDENTIFICATION DIVISION.
PROGRAM-ID. TSel.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 m    PIC 9 VALUE 1.
01 n    PIC 9 VALUE 2.
01 o    PIC 9 VALUE 3.
01 p    PIC 9 VALUE 4.
01 q    PIC 9 VALUE 5.
01 r    PIC 9 VALUE 6.
PROCEDURE DIVISION.
    IF p > m THEN
        DISPLAY "p > m".
    IF q IS LESS THAN n
        DISPLAY "q < n"
    ELSE
        DISPLAY "q >= n".
    IF m IS NOT EQUAL TO n AND o >= n THEN
        COMPUTE r = m + n
        DISPLAY "r = ", r
    ELSE
        COMPUTE r = m - n
        COMPUTE r = r * o + 3
        IF p = q OR q NOT = r
            COMPUTE r = r / 2
            DISPLAY "r = ", r.
    STOP RUN.

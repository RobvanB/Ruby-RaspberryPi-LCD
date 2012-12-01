%module liquidcrystal

extern void init (int fourbitmode, int rs, int rw, int enable, int d0,
		  int d1, int d2, int d3, int d4, int d5, int d6, int d7);

extern void cbegin (int cols, int rows, int charsize);

extern void clear(void);
extern void home(void);
extern void noDisplay(void);
extern void display(void);
extern void noBlink(void);
extern void blink(void);
extern void noCursor(void);
extern void cursor(void);

%{
#include "LiquidCrystal.cpp"
%}


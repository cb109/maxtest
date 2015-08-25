(
	struct ScintillaConstants
	(
		--detailed informaion about the command can be found here: http://www.scintilla.org/ScintillaDoc.html

		public _INVALID_POSITION 					= -1,
		public _SCI_START 							= 2000,
		public _SCI_OPTIONAL_START 					= 3000,
		public _SCI_LEXER_START 					= 4000,
		public _SCI_ADDTEXT 						= 2001,
		public _SCI_ADDSTYLEDTEXT 					= 2002,
		public _SCI_INSERTTEXT 						= 2003,
		public _SCI_CLEARALL 						= 2004,
		public _SCI_CLEARDOCUMENTSTYLE 				= 2005,
		public _SCI_GETLENGTH 						= 2006,
		public _SCI_GETCHARAT 						= 2007,
		public _SCI_GETCURRENTPOS 					= 2008,
		public _SCI_GETANCHOR 						= 2009,
		public _SCI_GETSTYLEAT 						= 2010,
		public _SCI_REDO 							= 2011,
		public _SCI_SETUNDOCOLLECTION 				= 2012,
		public _SCI_SELECTALL 						= 2013,
		public _SCI_SETSAVEPOINT 					= 2014,
		public _SCI_GETSTYLEDTEXT 					= 2015,
		public _SCI_CANREDO 						= 2016,
		public _SCI_MARKERLINEFROMHANDLE 			= 2017,
		public _SCI_MARKERDELETEHANDLE 				= 2018,
		public _SCI_GETUNDOCOLLECTION 				= 2019,
		public _SCWS_INVISIBLE 						= 0,
		public _SCWS_VISIBLEALWAYS 					= 1,
		public _SCWS_VISIBLEAFTERINDENT 			= 2,
		public _SCI_GETVIEWWS 						= 2020,
		public _SCI_SETVIEWWS 						= 2021,
		public _SCI_POSITIONFROMPOINT 				= 2022,
		public _SCI_POSITIONFROMPOINTCLOSE 			= 2023,
		public _SCI_GOTOLINE 						= 2024,
		public _SCI_GOTOPOS 						= 2025,
		public _SCI_SETANCHOR 						= 2026,
		public _SCI_GETCURLINE 						= 2027,
		public _SCI_GETENDSTYLED 					= 2028,
		public _SC_EOL_CRLF 						= 0,
		public _SC_EOL_CR 							= 1,
		public _SC_EOL_LF 							= 2,
		public _SCI_CONVERTEOLS 					= 2029,
		public _SCI_GETEOLMODE 						= 2030,
		public _SCI_SETEOLMODE 						= 2031,
		public _SCI_STARTSTYLING 					= 2032,
		public _SCI_SETSTYLING 						= 2033,
		public _SCI_GETBUFFEREDDRAW 				= 2034,
		public _SCI_SETBUFFEREDDRAW 				= 2035,
		public _SCI_SETTABWIDTH 					= 2036,
		public _SCI_GETTABWIDTH 					= 2121,
		public _SC_CP_UTF8 							= 65001,
		public _SC_CP_DBCS 							= 1,
		public _SCI_SETCODEPAGE 					= 2037,
		public _SCI_SETUSEPALETTE 					= 2039,
		public _MARKER_MAX 							= 31,
		public _SC_MARK_CIRCLE 						= 0,
		public _SC_MARK_ROUNDRECT 					= 1,
		public _SC_MARK_ARROW 						= 2,
		public _SC_MARK_SMALLRECT 					= 3,
		public _SC_MARK_SHORTARROW 					= 4,
		public _SC_MARK_EMPTY 						= 5,
		public _SC_MARK_ARROWDOWN 					= 6,
		public _SC_MARK_MINUS 						= 7,
		public _SC_MARK_PLUS 						= 8,
		public _SC_MARK_VLINE 						= 9,
		public _SC_MARK_LCORNER 					= 10,
		public _SC_MARK_TCORNER 					= 11,
		public _SC_MARK_BOXPLUS 					= 12,
		public _SC_MARK_BOXPLUSCONNECTED 			= 13,
		public _SC_MARK_BOXMINUS 					= 14,
		public _SC_MARK_BOXMINUSCONNECTED 			= 15,
		public _SC_MARK_LCORNERCURVE 				= 16,
		public _SC_MARK_TCORNERCURVE 				= 17,
		public _SC_MARK_CIRCLEPLUS 					= 18,
		public _SC_MARK_CIRCLEPLUSCONNECTED 		= 19,
		public _SC_MARK_CIRCLEMINUS 				= 20,
		public _SC_MARK_CIRCLEMINUSCONNECTED 		= 21,
		public _SC_MARK_BACKGROUND 					= 22,
		public _SC_MARK_DOTDOTDOT 					= 23,
		public _SC_MARK_ARROWS 						= 24,
		public _SC_MARK_PIXMAP 						= 25,
		public _SC_MARK_FULLRECT 					= 26,
		public _SC_MARK_CHARACTER 					= 10000,
		public _SC_MARKNUM_FOLDEREND 				= 25,
		public _SC_MARKNUM_FOLDEROPENMID 			= 26,
		public _SC_MARKNUM_FOLDERMIDTAIL 			= 27,
		public _SC_MARKNUM_FOLDERTAIL 				= 28,
		public _SC_MARKNUM_FOLDERSUB 				= 29,
		public _SC_MARKNUM_FOLDER 					= 30,
		public _SC_MARKNUM_FOLDEROPEN 				= 31,
		public _SC_MASK_FOLDERS 					= 0xFE000000,
		public _SCI_MARKERDEFINE 					= 2040,
		public _SCI_MARKERSETFORE 					= 2041,
		public _SCI_MARKERSETBACK 					= 2042,
		public _SCI_MARKERADD 						= 2043,
		public _SCI_MARKERDELETE 					= 2044,
		public _SCI_MARKERDELETEALL 				= 2045,
		public _SCI_MARKERGET 						= 2046,
		public _SCI_MARKERNEXT 						= 2047,
		public _SCI_MARKERPREVIOUS 					= 2048,
		public _SCI_MARKERDEFINEPIXMAP 				= 2049,
		public _SCI_MARKERADDSET 					= 2466,
		public _SCI_MARKERSETALPHA 					= 2476,
		public _SC_MARGIN_SYMBOL 					= 0,
		public _SC_MARGIN_NUMBER 					= 1,
		public _SCI_SETMARGINTYPEN 					= 2240,
		public _SCI_GETMARGINTYPEN 					= 2241,
		public _SCI_SETMARGINWIDTHN 				= 2242,
		public _SCI_GETMARGINWIDTHN 				= 2243,
		public _SCI_SETMARGINMASKN 					= 2244,
		public _SCI_GETMARGINMASKN 					= 2245,
		public _SCI_SETMARGINSENSITIVEN 			= 2246,
		public _SCI_GETMARGINSENSITIVEN 			= 2247,
		public _STYLE_DEFAULT 						= 32,
		public _STYLE_LINENUMBER 					= 33,
		public _STYLE_BRACELIGHT 					= 34,
		public _STYLE_BRACEBAD 						= 35,
		public _STYLE_CONTROLCHAR 					= 36,
		public _STYLE_INDENTGUIDE 					= 37,
		public _STYLE_CALLTIP 						= 38,
		public _STYLE_LASTPREDEFINED 				= 39,
		public _STYLE_MAX 							= 127,
		public _SC_CHARSET_ANSI 					= 0,
		public _SC_CHARSET_DEFAULT 					= 1,
		public _SC_CHARSET_BALTIC 					= 186,
		public _SC_CHARSET_CHINESEBIG5 				= 136,
		public _SC_CHARSET_EASTEUROPE 				= 238,
		public _SC_CHARSET_GB2312 					= 134,
		public _SC_CHARSET_GREEK 					= 161,
		public _SC_CHARSET_HANGUL 					= 129,
		public _SC_CHARSET_MAC 						= 77,
		public _SC_CHARSET_OEM 						= 255,
		public _SC_CHARSET_RUSSIAN 					= 204,
		public _SC_CHARSET_CYRILLIC 				= 1251,
		public _SC_CHARSET_SHIFTJIS 				= 128,
		public _SC_CHARSET_SYMBOL 					= 2,
		public _SC_CHARSET_TURKISH 					= 162,
		public _SC_CHARSET_JOHAB 					= 130,
		public _SC_CHARSET_HEBREW 					= 177,
		public _SC_CHARSET_ARABIC 					= 178,
		public _SC_CHARSET_VIETNAMESE 				= 163,
		public _SC_CHARSET_THAI 					= 222,
		public _SC_CHARSET_8859_15 					= 1000,
		public _SCI_STYLECLEARALL 					= 2050,
		public _SCI_STYLESETFORE 					= 2051,
		public _SCI_STYLESETBACK 					= 2052,
		public _SCI_STYLESETBOLD 					= 2053,
		public _SCI_STYLESETITALIC 					= 2054,
		public _SCI_STYLESETSIZE 					= 2055,
		public _SCI_STYLESETFONT 					= 2056,
		public _SCI_STYLESETEOLFILLED 				= 2057,
		public _SCI_STYLERESETDEFAULT 				= 2058,
		public _SCI_STYLESETUNDERLINE 				= 2059,
		public _SC_CASE_MIXED 						= 0,
		public _SC_CASE_UPPER 						= 1,
		public _SC_CASE_LOWER 						= 2,
		public _SCI_STYLESETCASE 					= 2060,
		public _SCI_STYLESETCHARACTERSET 			= 2066,
		public _SCI_STYLESETHOTSPOT 				= 2409,
		public _SCI_SETSELFORE 						= 2067,
		public _SCI_SETSELBACK 						= 2068,
		public _SCI_GETSELALPHA 					= 2477,
		public _SCI_SETSELALPHA 					= 2478,
		public _SCI_SETCARETFORE 					= 2069,
		public _SCI_ASSIGNCMDKEY 					= 2070,
		public _SCI_CLEARCMDKEY 					= 2071,
		public _SCI_CLEARALLCMDKEYS 				= 2072,
		public _SCI_SETSTYLINGEX 					= 2073,
		public _SCI_STYLESETVISIBLE 				= 2074,
		public _SCI_GETCARETPERIOD 					= 2075,
		public _SCI_SETCARETPERIOD 					= 2076,
		public _SCI_SETWORDCHARS 					= 2077,
		public _SCI_BEGINUNDOACTION 				= 2078,
		public _SCI_ENDUNDOACTION 					= 2079,
		public _INDIC_MAX 							= 7,
		public _INDIC_PLAIN 						= 0,
		public _INDIC_SQUIGGLE 						= 1,
		public _INDIC_TT 							= 2,
		public _INDIC_DIAGONAL 						= 3,
		public _INDIC_STRIKE 						= 4,
		public _INDIC_HIDDEN 						= 5,
		public _INDIC_BOX 							= 6,
		public _INDIC_ROUNDBOX 						= 7,
		public _INDIC0_MASK 						= 0x20,
		public _INDIC1_MASK 						= 0x40,
		public _INDIC2_MASK 						= 0x80,
		public _INDICS_MASK 						= 0xE0,
		public _SCI_INDICSETSTYLE 					= 2080,
		public _SCI_INDICGETSTYLE 					= 2081,
		public _SCI_INDICSETFORE 					= 2082,
		public _SCI_INDICGETFORE 					= 2083,
		public _SCI_SETWHITESPACEFORE 				= 2084,
		public _SCI_SETWHITESPACEBACK 				= 2085,
		public _SCI_SETSTYLEBITS 					= 2090,
		public _SCI_GETSTYLEBITS 					= 2091,
		public _SCI_SETLINESTATE 					= 2092,
		public _SCI_GETLINESTATE 					= 2093,
		public _SCI_GETMAXLINESTATE 				= 2094,
		public _SCI_GETCARETLINEVISIBLE 			= 2095,
		public _SCI_SETCARETLINEVISIBLE 			= 2096,
		public _SCI_GETCARETLINEBACK 				= 2097,
		public _SCI_SETCARETLINEBACK 				= 2098,
		public _SCI_STYLESETCHANGEABLE 				= 2099,
		public _SCI_AUTOCSHOW 						= 2100,
		public _SCI_AUTOCCANCEL 					= 2101,
		public _SCI_AUTOCACTIVE 					= 2102,
		public _SCI_AUTOCPOSSTART 					= 2103,
		public _SCI_AUTOCCOMPLETE 					= 2104,
		public _SCI_AUTOCSTOPS 						= 2105,
		public _SCI_AUTOCSETSEPARATOR 				= 2106,
		public _SCI_AUTOCGETSEPARATOR 				= 2107,
		public _SCI_AUTOCSELECT 					= 2108,
		public _SCI_AUTOCSETCANCELATSTART 			= 2110,
		public _SCI_AUTOCGETCANCELATSTART 			= 2111,
		public _SCI_AUTOCSETFILLUPS 				= 2112,
		public _SCI_AUTOCSETCHOOSESINGLE 			= 2113,
		public _SCI_AUTOCGETCHOOSESINGLE 			= 2114,
		public _SCI_AUTOCSETIGNORECASE 				= 2115,
		public _SCI_AUTOCGETIGNORECASE 				= 2116,
		public _SCI_USERLISTSHOW 					= 2117,
		public _SCI_AUTOCSETAUTOHIDE 				= 2118,
		public _SCI_AUTOCGETAUTOHIDE 				= 2119,
		public _SCI_AUTOCSETDROPRESTOFWORD 			= 2270,
		public _SCI_AUTOCGETDROPRESTOFWORD 			= 2271,
		public _SCI_REGISTERIMAGE 					= 2405,
		public _SCI_CLEARREGISTEREDIMAGES 			= 2408,
		public _SCI_AUTOCGETTYPESEPARATOR 			= 2285,
		public _SCI_AUTOCSETTYPESEPARATOR 			= 2286,
		public _SCI_AUTOCSETMAXWIDTH 				= 2208,
		public _SCI_AUTOCGETMAXWIDTH 				= 2209,
		public _SCI_AUTOCSETMAXHEIGHT 				= 2210,
		public _SCI_AUTOCGETMAXHEIGHT 				= 2211,
		public _SCI_SETINDENT 						= 2122,
		public _SCI_GETINDENT 						= 2123,
		public _SCI_SETUSETABS 						= 2124,
		public _SCI_GETUSETABS 						= 2125,
		public _SCI_SETLINEINDENTATION 				= 2126,
		public _SCI_GETLINEINDENTATION 				= 2127,
		public _SCI_GETLINEINDENTPOSITION 			= 2128,
		public _SCI_GETCOLUMN 						= 2129,
		public _SCI_SETHSCROLLBAR 					= 2130,
		public _SCI_GETHSCROLLBAR 					= 2131,
		public _SCI_SETINDENTATIONGUIDES 			= 2132,
		public _SCI_GETINDENTATIONGUIDES 			= 2133,
		public _SCI_SETHIGHLIGHTGUIDE 				= 2134,
		public _SCI_GETHIGHLIGHTGUIDE 				= 2135,
		public _SCI_GETLINEENDPOSITION 				= 2136,
		public _SCI_GETCODEPAGE 					= 2137,
		public _SCI_GETCARETFORE 					= 2138,
		public _SCI_GETUSEPALETTE 					= 2139,
		public _SCI_GETREADONLY 					= 2140,
		public _SCI_SETCURRENTPOS 					= 2141,
		public _SCI_SETSELECTIONSTART 				= 2142,
		public _SCI_GETSELECTIONSTART 				= 2143,
		public _SCI_SETSELECTIONEND 				= 2144,
		public _SCI_GETSELECTIONEND 				= 2145,
		public _SCI_SETPRINTMAGNIFICATION 			= 2146,
		public _SCI_GETPRINTMAGNIFICATION 			= 2147,
		public _SC_PRINT_NORMAL 					= 0,
		public _SC_PRINT_INVERTLIGHT 				= 1,
		public _SC_PRINT_BLACKONWHITE 				= 2,
		public _SC_PRINT_COLOURONWHITE 				= 3,
		public _SC_PRINT_COLOURONWHITEDEFAULTBG 	= 4,
		public _SCI_SETPRINTCOLOURMODE 				= 2148,
		public _SCI_GETPRINTCOLOURMODE 				= 2149,
		public _SCFIND_DOWN 						= 1,
		public _SCFIND_WHOLEWORD 					= 2,
		public _SCFIND_MATCHCASE 					= 4,
		public _SCFIND_WORDSTART 					= 0x00100000,
		public _SCFIND_REGEXP 						= 0x00200000,
		public _SCFIND_POSIX 						= 0x00400000,
		public _SCI_FINDTEXT 						= 2150,
		public _SCI_FORMATRANGE 					= 2151,
		public _SCI_GETFIRSTVISIBLELINE 			= 2152,
		public _SCI_GETLINE 						= 2153,
		public _SCI_GETLINECOUNT 					= 2154,
		public _SCI_SETMARGINLEFT 					= 2155,
		public _SCI_GETMARGINLEFT 					= 2156,
		public _SCI_SETMARGINRIGHT 					= 2157,
		public _SCI_GETMARGINRIGHT 					= 2158,
		public _SCI_GETMODIFY 						= 2159,
		public _SCI_SETSEL 							= 2160,
		public _SCI_GETSELTEXT 						= 2161,
		public _SCI_GETTEXTRANGE 					= 2162,
		public _SCI_HIDESELECTION 					= 2163,
		public _SCI_POINTXFROMPOSITION 				= 2164,
		public _SCI_POINTYFROMPOSITION 				= 2165,
		public _SCI_LINEFROMPOSITION 				= 2166,
		public _SCI_POSITIONFROMLINE 				= 2167,
		public _SCI_LINESCROLL 						= 2168,
		public _SCI_SCROLLCARET 					= 2169,
		public _SCI_REPLACESEL 						= 2170,
		public _SCI_SETREADONLY 					= 2171,
		public _SCI_NULL 							= 2172,
		public _SCI_CANPASTE 						= 2173,
		public _SCI_CANUNDO 						= 2174,
		public _SCI_EMPTYUNDOBUFFER 				= 2175,
		public _SCI_UNDO 							= 2176,
		public _SCI_CUT 							= 2177,
		public _SCI_COPY 							= 2178,
		public _SCI_PASTE 							= 2179,
		public _SCI_CLEAR 							= 2180,
		public _SCI_SETTEXT 						= 2181,
		public _SCI_GETTEXT 						= 2182,
		public _SCI_GETTEXTLENGTH 					= 2183,
		public _SCI_GETDIRECTFUNCTION 				= 2184,
		public _SCI_GETDIRECTPOINTER 				= 2185,
		public _SCI_SETOVERTYPE 					= 2186,
		public _SCI_GETOVERTYPE 					= 2187,
		public _SCI_SETCARETWIDTH 					= 2188,
		public _SCI_GETCARETWIDTH 					= 2189,
		public _SCI_SETTARGETSTART 					= 2190,
		public _SCI_GETTARGETSTART 					= 2191,
		public _SCI_SETTARGETEND 					= 2192,
		public _SCI_GETTARGETEND 					= 2193,
		public _SCI_REPLACETARGET 					= 2194,
		public _SCI_REPLACETARGETRE 				= 2195,
		public _SCI_SEARCHINTARGET 					= 2197,
		public _SCI_SETSEARCHFLAGS 					= 2198,
		public _SCI_GETSEARCHFLAGS 					= 2199,
		public _SCI_CALLTIPSHOW 					= 2200,
		public _SCI_CALLTIPCANCEL 					= 2201,
		public _SCI_CALLTIPACTIVE 					= 2202,
		public _SCI_CALLTIPPOSSTART 				= 2203,
		public _SCI_CALLTIPSETHLT 					= 2204,
		public _SCI_CALLTIPSETBACK 					= 2205,
		public _SCI_CALLTIPSETFORE 					= 2206,
		public _SCI_CALLTIPSETFOREHLT 				= 2207,
		public _SCI_CALLTIPUSESTYLE 				= 2212,
		public _SCI_VISIBLEFROMDOCLINE 				= 2220,
		public _SCI_DOCLINEFROMVISIBLE 				= 2221,
		public _SCI_WRAPCOUNT 						= 2235,
		public _SC_FOLDLEVELBASE 					= 0x400,
		public _SC_FOLDLEVELWHITEFLAG 				= 0x1000,
		public _SC_FOLDLEVELHEADERFLAG 				= 0x2000,
		public _SC_FOLDLEVELBOXHEADERFLAG 			= 0x4000,
		public _SC_FOLDLEVELBOXFOOTERFLAG 			= 0x8000,
		public _SC_FOLDLEVELCONTRACTED 				= 0x10000,
		public _SC_FOLDLEVELUNINDENT 				= 0x20000,
		public _SC_FOLDLEVELNUMBERMASK 				= 0x0FFF,
		public _SCI_SETFOLDLEVEL 					= 2222,
		public _SCI_GETFOLDLEVEL 					= 2223,
		public _SCI_GETLASTCHILD 					= 2224,
		public _SCI_GETFOLDPARENT 					= 2225,
		public _SCI_SHOWLINES 						= 2226,
		public _SCI_HIDELINES 						= 2227,
		public _SCI_GETLINEVISIBLE 					= 2228,
		public _SCI_SETFOLDEXPANDED 				= 2229,
		public _SCI_GETFOLDEXPANDED 				= 2230,
		public _SCI_TOGGLEFOLD 						= 2231,
		public _SCI_ENSUREVISIBLE 					= 2232,
		public _SC_FOLDFLAG_LINEBEFORE_EXPANDED 	= 0x0002,
		public _SC_FOLDFLAG_LINEBEFORE_CONTRACTED 	= 0x0004,
		public _SC_FOLDFLAG_LINEAFTER_EXPANDED 		= 0x0008,
		public _SC_FOLDFLAG_LINEAFTER_CONTRACTED 	= 0x0010,
		public _SC_FOLDFLAG_LEVELNUMBERS 			= 0x0040,
		public _SC_FOLDFLAG_BOX 					= 0x0001,
		public _SCI_SETFOLDFLAGS 					= 2233,
		public _SCI_ENSUREVISIBLEENFORCEPOLICY  	= 2234,
		public _SCI_SETTABINDENTS 					= 2260,
		public _SCI_GETTABINDENTS 					= 2261,
		public _SCI_SETBACKSPACEUNINDENTS 			= 2262,
		public _SCI_GETBACKSPACEUNINDENTS 			= 2263,
		public _SC_TIME_FOREVER 					= 10000000,
		public _SCI_SETMOUSEDWELLTIME 				= 2264,
		public _SCI_GETMOUSEDWELLTIME 				= 2265,
		public _SCI_WORDSTARTPOSITION 				= 2266,
		public _SCI_WORDENDPOSITION 				= 2267,
		public _SC_WRAP_NONE 						= 0,
		public _SC_WRAP_WORD 						= 1,
		public _SC_WRAP_CHAR 						= 2,
		public _SCI_SETWRAPMODE 					= 2268,
		public _SCI_GETWRAPMODE 					= 2269,
		public _SC_WRAPVISUALFLAG_NONE 				= 0x0000,
		public _SC_WRAPVISUALFLAG_END 				= 0x0001,
		public _SC_WRAPVISUALFLAG_START 			= 0x0002,
		public _SCI_SETWRAPVISUALFLAGS 				= 2460,
		public _SCI_GETWRAPVISUALFLAGS 				= 2461,
		public _SC_WRAPVISUALFLAGLOC_DEFAULT 		= 0x0000,
		public _SC_WRAPVISUALFLAGLOC_END_BY_TEXT 	= 0x0001,
		public _SC_WRAPVISUALFLAGLOC_START_BY_TEXT 	= 0x0002,
		public _SCI_SETWRAPVISUALFLAGSLOCATION 		= 2462,
		public _SCI_GETWRAPVISUALFLAGSLOCATION 		= 2463,
		public _SCI_SETWRAPSTARTINDENT 				= 2464,
		public _SCI_GETWRAPSTARTINDENT 				= 2465,
		public _SC_CACHE_NONE 						= 0,
		public _SC_CACHE_CARET 						= 1,
		public _SC_CACHE_PAGE 						= 2,
		public _SC_CACHE_DOCUMENT 					= 3,
		public _SCI_SETLAYOUTCACHE 					= 2272,
		public _SCI_GETLAYOUTCACHE 					= 2273,
		public _SCI_SETSCROLLWIDTH 					= 2274,
		public _SCI_GETSCROLLWIDTH 					= 2275,
		public _SCI_TEXTWIDTH 						= 2276,
		public _SCI_SETENDATLASTLINE 				= 2277,
		public _SCI_GETENDATLASTLINE 				= 2278,
		public _SCI_TEXTHEIGHT 						= 2279,
		public _SCI_SETVSCROLLBAR 					= 2280,
		public _SCI_GETVSCROLLBAR 					= 2281,
		public _SCI_APPENDTEXT 						= 2282,
		public _SCI_GETTWOPHASEDRAW 				= 2283,
		public _SCI_SETTWOPHASEDRAW 				= 2284,
		public _SCI_TARGETFROMSELECTION 			= 2287,
		public _SCI_LINESJOIN 						= 2288,
		public _SCI_LINESSPLIT 						= 2289,
		public _SCI_SETFOLDMARGINCOLOUR 			= 2290,
		public _SCI_SETFOLDMARGINHICOLOUR 			= 2291,
		public _SCI_LINEDOWN 						= 2300,
		public _SCI_LINEDOWNEXTEND 					= 2301,
		public _SCI_LINEUP 							= 2302,
		public _SCI_LINEUPEXTEND 					= 2303,
		public _SCI_CHARLEFT 						= 2304,
		public _SCI_CHARLEFTEXTEND 					= 2305,
		public _SCI_CHARRIGHT 						= 2306,
		public _SCI_CHARRIGHTEXTEND 				= 2307,
		public _SCI_WORDLEFT 						= 2308,
		public _SCI_WORDLEFTEXTEND 					= 2309,
		public _SCI_WORDRIGHT 						= 2310,
		public _SCI_WORDRIGHTEXTEND 				= 2311,
		public _SCI_HOME 							= 2312,
		public _SCI_HOMEEXTEND 						= 2313,
		public _SCI_LINEEND 						= 2314,
		public _SCI_LINEENDEXTEND 					= 2315,
		public _SCI_DOCUMENTSTART 					= 2316,
		public _SCI_DOCUMENTSTARTEXTEND 			= 2317,
		public _SCI_DOCUMENTEND 					= 2318,
		public _SCI_DOCUMENTENDEXTEND 				= 2319,
		public _SCI_PAGEUP 							= 2320,
		public _SCI_PAGEUPEXTEND 					= 2321,
		public _SCI_PAGEDOWN 						= 2322,
		public _SCI_PAGEDOWNEXTEND 					= 2323,
		public _SCI_EDITTOGGLEOVERTYPE 				= 2324,
		public _SCI_CANCEL 							= 2325,
		public _SCI_DELETEBACK 						= 2326,
		public _SCI_TAB 							= 2327,
		public _SCI_BACKTAB 						= 2328,
		public _SCI_NEWLINE 						= 2329,
		public _SCI_FORMFEED 						= 2330,
		public _SCI_VCHOME 							= 2331,
		public _SCI_VCHOMEEXTEND 					= 2332,
		public _SCI_ZOOMIN 							= 2333,
		public _SCI_ZOOMOUT 						= 2334,
		public _SCI_DELWORDLEFT 					= 2335,
		public _SCI_DELWORDRIGHT 					= 2336,
		public _SCI_LINECUT 						= 2337,
		public _SCI_LINEDELETE 						= 2338,
		public _SCI_LINETRANSPOSE 					= 2339,
		public _SCI_LINEDUPLICATE 					= 2404,
		public _SCI_LOWERCASE 						= 2340,
		public _SCI_UPPERCASE 						= 2341,
		public _SCI_LINESCROLLDOWN 					= 2342,
		public _SCI_LINESCROLLUP 					= 2343,
		public _SCI_DELETEBACKNOTLINE 				= 2344,
		public _SCI_HOMEDISPLAY 					= 2345,
		public _SCI_HOMEDISPLAYEXTEND 				= 2346,
		public _SCI_LINEENDDISPLAY 					= 2347,
		public _SCI_LINEENDDISPLAYEXTEND 			= 2348,
		public _SCI_HOMEWRAP 						= 2349,
		public _SCI_HOMEWRAPEXTEND 					= 2450,
		public _SCI_LINEENDWRAP 					= 2451,
		public _SCI_LINEENDWRAPEXTEND 				= 2452,
		public _SCI_VCHOMEWRAP 						= 2453,
		public _SCI_VCHOMEWRAPEXTEND 				= 2454,
		public _SCI_LINECOPY 						= 2455,
		public _SCI_MOVECARETINSIDEVIEW 			= 2401,
		public _SCI_LINELENGTH 						= 2350,
		public _SCI_BRACEHIGHLIGHT 					= 2351,
		public _SCI_BRACEBADLIGHT 					= 2352,
		public _SCI_BRACEMATCH 						= 2353,
		public _SCI_GETVIEWEOL 						= 2355,
		public _SCI_SETVIEWEOL 						= 2356,
		public _SCI_GETDOCPOINTER 					= 2357,
		public _SCI_SETDOCPOINTER 					= 2358,
		public _SCI_SETMODEVENTMASK 				= 2359,
		public _EDGE_NONE 							= 0,
		public _EDGE_LINE 							= 1,
		public _EDGE_BACKGROUND 					= 2,
		public _SCI_GETEDGECOLUMN 					= 2360,
		public _SCI_SETEDGECOLUMN 					= 2361,
		public _SCI_GETEDGEMODE 					= 2362,
		public _SCI_SETEDGEMODE 					= 2363,
		public _SCI_GETEDGECOLOUR 					= 2364,
		public _SCI_SETEDGECOLOUR 					= 2365,
		public _SCI_SEARCHANCHOR 					= 2366,
		public _SCI_SEARCHNEXT 						= 2367,
		public _SCI_SEARCHPREV 						= 2368,
		public _SCI_LINESONSCREEN 					= 2370,
		public _SCI_USEPOPUP 						= 2371,
		public _SCI_SELECTIONISRECTANGLE 			= 2372,
		public _SCI_SETZOOM 						= 2373,
		public _SCI_GETZOOM 						= 2374,
		public _SCI_CREATEDOCUMENT 					= 2375,
		public _SCI_ADDREFDOCUMENT 					= 2376,
		public _SCI_RELEASEDOCUMENT 				= 2377,
		public _SCI_GETMODEVENTMASK 				= 2378,
		public _SCI_SETFOCUS 						= 2380,
		public _SCI_GETFOCUS 						= 2381,
		public _SCI_SETSTATUS 						= 2382,
		public _SCI_GETSTATUS 						= 2383,
		public _SCI_SETMOUSEDOWNCAPTURES 			= 2384,
		public _SCI_GETMOUSEDOWNCAPTURES 			= 2385,
		public _SC_CURSORNORMAL 					= -1,
		public _SC_CURSORWAIT 						= 4,
		public _SCI_SETCURSOR 						= 2386,
		public _SCI_GETCURSOR 						= 2387,
		public _SCI_SETCONTROLCHARSYMBOL 			= 2388,
		public _SCI_GETCONTROLCHARSYMBOL 			= 2389,
		public _SCI_WORDPARTLEFT 					= 2390,
		public _SCI_WORDPARTLEFTEXTEND 				= 2391,
		public _SCI_WORDPARTRIGHT 					= 2392,
		public _SCI_WORDPARTRIGHTEXTEND 			= 2393,
		public _VISIBLE_SLOP 						= 0x01,
		public _VISIBLE_STRICT 						= 0x04,
		public _SCI_SETVISIBLEPOLICY 				= 2394,
		public _SCI_DELLINELEFT 					= 2395,
		public _SCI_DELLINERIGHT 					= 2396,
		public _SCI_SETXOFFSET 						= 2397,
		public _SCI_GETXOFFSET 						= 2398,
		public _SCI_CHOOSECARETX 					= 2399,
		public _SCI_GRABFOCUS 						= 2400,
		public _CARET_SLOP 							= 0x01,
		public _CARET_STRICT 						= 0x04,
		public _CARET_JUMPS 						= 0x10,
		public _CARET_EVEN 							= 0x08,
		public _SCI_SETXCARETPOLICY 				= 2402,
		public _SCI_SETYCARETPOLICY 				= 2403,
		public _SCI_SETPRINTWRAPMODE 				= 2406,
		public _SCI_GETPRINTWRAPMODE 				= 2407,
		public _SCI_SETHOTSPOTACTIVEFORE 			= 2410,
		public _SCI_SETHOTSPOTACTIVEBACK 			= 2411,
		public _SCI_SETHOTSPOTACTIVEUNDERLINE 		= 2412,
		public _SCI_SETHOTSPOTSINGLELINE 			= 2421,
		public _SCI_PARADOWN 						= 2413,
		public _SCI_PARADOWNEXTEND 					= 2414,
		public _SCI_PARAUP 							= 2415,
		public _SCI_PARAUPEXTEND 					= 2416,
		public _SCI_POSITIONBEFORE 					= 2417,
		public _SCI_POSITIONAFTER 					= 2418,
		public _SCI_COPYRANGE 						= 2419,
		public _SCI_COPYTEXT 						= 2420,
		public _SC_SEL_STREAM 						= 0,
		public _SC_SEL_RECTANGLE 					= 1,
		public _SC_SEL_LINES 						= 2,
		public _SCI_SETSELECTIONMODE 				= 2422,
		public _SCI_GETSELECTIONMODE 				= 2423,
		public _SCI_GETLINESELSTARTPOSITION 		= 2424,
		public _SCI_GETLINESELENDPOSITION 			= 2425,
		public _SCI_LINEDOWNRECTEXTEND 				= 2426,
		public _SCI_LINEUPRECTEXTEND 				= 2427,
		public _SCI_CHARLEFTRECTEXTEND 				= 2428,
		public _SCI_CHARRIGHTRECTEXTEND 			= 2429,
		public _SCI_HOMERECTEXTEND 					= 2430,
		public _SCI_VCHOMERECTEXTEND 				= 2431,
		public _SCI_LINEENDRECTEXTEND 				= 2432,
		public _SCI_PAGEUPRECTEXTEND 				= 2433,
		public _SCI_PAGEDOWNRECTEXTEND 				= 2434,
		public _SCI_STUTTEREDPAGEUP 				= 2435,
		public _SCI_STUTTEREDPAGEUPEXTEND 			= 2436,
		public _SCI_STUTTEREDPAGEDOWN 				= 2437,
		public _SCI_STUTTEREDPAGEDOWNEXTEND 		= 2438,
		public _SCI_WORDLEFTEND 					= 2439,
		public _SCI_WORDLEFTENDEXTEND 				= 2440,
		public _SCI_WORDRIGHTEND 					= 2441,
		public _SCI_WORDRIGHTENDEXTEND 				= 2442,
		public _SCI_SETWHITESPACECHARS 				= 2443,
		public _SCI_SETCHARSDEFAULT 				= 2444,
		public _SCI_AUTOCGETCURRENT 				= 2445,
		public _SCI_ALLOCATE 						= 2446,
		public _SCI_TARGETASUTF8 					= 2447,
		public _SCI_SETLENGTHFORENCODE 				= 2448,
		public _SCI_ENCODEDFROMUTF8 				= 2449,
		public _SCI_FINDCOLUMN 						= 2456,
		public _SCI_GETCARETSTICKY 					= 2457,
		public _SCI_SETCARETSTICKY 					= 2458,
		public _SCI_TOGGLECARETSTICKY 				= 2459,
		public _SCI_SETPASTECONVERTENDINGS 			= 2467,
		public _SCI_GETPASTECONVERTENDINGS 			= 2468,
		public _SCI_SELECTIONDUPLICATE 				= 2469,
		public _SC_ALPHA_TRANSPARENT 				= 0,
		public _SC_ALPHA_OPAQUE 					= 255,
		public _SC_ALPHA_NOALPHA 					= 256,
		public _SCI_SETCARETLINEBACKALPHA 			= 2470,
		public _SCI_GETCARETLINEBACKALPHA 			= 2471,
		public _SCI_STARTRECORD 					= 3001,
		public _SCI_STOPRECORD 						= 3002,
		public _SCI_SETLEXER 						= 4001,
		public _SCI_GETLEXER 						= 4002,
		public _SCI_COLOURISE 						= 4003,
		public _SCI_SETPROPERTY 					= 4004,
		public _KEYWORDSET_MAX 						= 8,
		public _SCI_SETKEYWORDS 					= 4005,
		public _SCI_SETLEXERLANGUAGE 				= 4006,
		public _SCI_LOADLEXERLIBRARY 				= 4007,
		public _SCI_GETPROPERTY 					= 4008,
		public _SCI_GETPROPERTYEXPANDED 			= 4009,
		public _SCI_GETPROPERTYINT 					= 4010,
		public _SCI_GETSTYLEBITSNEEDED 				= 4011,
		public _SC_MOD_INSERTTEXT 					= 0x1,
		public _SC_MOD_DELETETEXT 					= 0x2,
		public _SC_MOD_CHANGESTYLE 					= 0x4,
		public _SC_MOD_CHANGEFOLD 					= 0x8,
		public _SC_PERFORMED_USER 					= 0x10,
		public _SC_PERFORMED_UNDO 					= 0x20,
		public _SC_PERFORMED_REDO 					= 0x40,
		public _SC_MULTISTEPUNDOREDO 				= 0x80,
		public _SC_LASTSTEPINUNDOREDO 				= 0x100,
		public _SC_MOD_CHANGEMARKER 				= 0x200,
		public _SC_MOD_BEFOREINSERT 				= 0x400,
		public _SC_MOD_BEFOREDELETE 				= 0x800,
		public _SC_MULTILINEUNDOREDO 				= 0x1000,
		public _SC_MODEVENTMASKALL 					= 0x1FFF,
		public _SCEN_CHANGE 						= 768,
		public _SCEN_SETFOCUS 						= 512,
		public _SCEN_KILLFOCUS 						= 256,
		public _SCK_DOWN 							= 300,
		public _SCK_UP 								= 301,
		public _SCK_LEFT 							= 302,
		public _SCK_RIGHT 							= 303,
		public _SCK_HOME 							= 304,
		public _SCK_END 							= 305,
		public _SCK_PRIOR 							= 306,
		public _SCK_NEXT 							= 307,
		public _SCK_DELETE 							= 308,
		public _SCK_INSERT 							= 309,
		public _SCK_ESCAPE 							= 7,
		public _SCK_BACK 							= 8,
		public _SCK_TAB 							= 9,
		public _SCK_RETURN 							= 13,
		public _SCK_ADD 							= 310,
		public _SCK_SUBTRACT 						= 311,
		public _SCK_DIVIDE 							= 312,
		public _SCMOD_NORM 							= 0,
		public _SCMOD_SHIFT 						= 1,
		public _SCMOD_CTRL 							= 2,
		public _SCMOD_ALT 							= 4,
		public _SCN_STYLENEEDED 					= 2000,
		public _SCN_CHARADDED 						= 2001,
		public _SCN_SAVEPOINTREACHED 				= 2002,
		public _SCN_SAVEPOINTLEFT 					= 2003,
		public _SCN_MODIFYATTEMPTRO 				= 2004,
		public _SCN_KEY 							= 2005,
		public _SCN_DOUBLECLICK 					= 2006,
		public _SCN_UPDATEUI 						= 2007,
		public _SCN_MODIFIED 						= 2008,
		public _SCN_MACRORECORD 					= 2009,
		public _SCN_MARGINCLICK 					= 2010,
		public _SCN_NEEDSHOWN 						= 2011,
		public _SCN_PAINTED 						= 2013,
		public _SCN_USERLISTSELECTION 				= 2014,
		public _SCN_URIDROPPED 						= 2015,
		public _SCN_DWELLSTART 						= 2016,
		public _SCN_DWELLEND 						= 2017,
		public _SCN_ZOOM 							= 2018,
		public _SCN_HOTSPOTCLICK 					= 2019,
		public _SCN_HOTSPOTDOUBLECLICK 				= 2020,
		public _SCN_CALLTIPCLICK 					= 2021,
		public _SCN_AUTOCSELECTION 					= 2022
	)


	struct MxsEditorControl
	(
		private _MXSSciTEWindowHwnd = undefined,
		private _MXSScintillaHwnd = undefined,

		private _sciConsts = ScintillaConstants(),


		private
		function toDotNetPointer val =
		(
			return (dotNetObject "System.IntPtr" val)
		),


		private
		function getMXSSciTEWindowHwnd =
		(
			if _MXSSciTEWindowHwnd == undefined then
			(
				local desktopChildren = windows.getChildrenHWND (windows.getDesktopHWND())
				local hwnd = undefined
				for desktopChildOn in desktopChildren while hwnd == undefined do
				(
					if desktopChildOn[4] == "MXS_SciTEWindow" then
						hwnd = desktopChildOn[1]
				)
				_MXSSciTEWindowHwnd = hwnd
			)
			return _MXSSciTEWindowHwnd
		),

		private
		function getMXSScintillaHwnd =
		(
			if _MXSScintillaHwnd == undefined then
			(
				local MXSSciTEWindowHwnd = getMXSSciTEWindowHwnd()
				if MXSSciTEWindowHwnd != undefined then
				(
					local editorChildren = windows.getChildrenHWND MXSSciTEWindowHwnd
					local hwnd = undefined
					for editorChildrOn in editorChildren while hwnd == undefined do
					(
						if editorChildrOn[4] == "MXS_Scintilla" then
							hwnd = editorChildrOn[1]
					)
					_MXSScintillaHwnd = hwnd
				)
				else
					_MXSScintillaHwnd = undefined
			)
			return _MXSScintillaHwnd
		),



		private
		function sendCommandToScintilla inCommand inLParam inWParam =
		(
			local hwnd = getMXSScintillaHwnd()
			windows.sendMessage hwnd inCommand inLParam inWParam
		),



		public
		function gotoLine inLineNumber =
		(
			return (sendCommandToScintilla _sciConsts._SCI_GOTOLINE (inLineNumber - 1) 0)
		),

		public
		function gotoPos inPos =
		(
			return (sendCommandToScintilla _sciConsts._SCI_GOTOPOS inPos 0)
		),

		public
		function getTextLength =
		(
			return (sendCommandToScintilla _sciConsts._SCI_GETTEXTLENGTH 0 0)
		),


		public
		function getCodePage =
		(
			return (sendCommandToScintilla _sciConsts._SCI_GETCODEPAGE 0 0)
		),


		public
		function getFocus =
		(
			return (sendCommandToScintilla _sciConsts._SCI_GETFOCUS 0 0)
		),

		public
		function setFocus inFocus =
		(
			local focus = if inFocus == true then 1 else 0
			return (sendCommandToScintilla _sciConsts._SCI_SETFOCUS focus 0)
		),


		public
		function findText inText rangeStart: rangeEnd: down:true wholeWord:false matchCase:false wordStart:false regexp:false posix:false =
		(
			local searchFlags = 0
			if down then 		searchFlags += _sciConsts._SCFIND_DOWN
			if wholeWord then 	searchFlags += _sciConsts._SCFIND_WHOLEWORD
			if matchCase then 	searchFlags += _sciConsts._SCFIND_MATCHCASE
			if wordStart then 	searchFlags += _sciConsts._SCFIND_WORDSTART
			if regexp then 		searchFlags += _sciConsts._SCFIND_REGEXP
			if posix then 		searchFlags += _sciConsts._SCFIND_POSIX

			-- Convert the search string to a byte array.
			inText = inText as string
			local str = dotNetObject "System.String" inText

			if not isKindOf rangeStart integer then
				rangeStart = 0
			if not isKindOf rangeEnd integer then
				rangeEnd = getTextLength()

			local marshal = dotNetClass "System.Runtime.InteropServices.Marshal"
			local longSize = 4 -- 4 bytes
			local ptrSize = marshal.SizeOf (dotNetObject "System.IntPtr" 0)

			-- Since max 2013 (max version 15) the
			if (maxVersion())[1] < 15000 then
				local strPtr = toDotNetPointer (marshal.StringToHGlobalAnsi str)
			else
				local strPtr = toDotNetPointer (marshal.StringToHGlobalUni str)

			-- The struct that scintilla needs is:
			-- Search range start - long (4 bytes)
			-- Search range end - long (4 bytes)
			-- A pointer to the search string (the search string must be ascii) - pointer (pointer length)
			-- Match start pos (will be written to by scintilla) - long (4 bytes)
			-- Match end pos (will be written to by scintilla) - long (4 bytes)
			local numberOfLongsInStruct = 4
			local ptr = marshal.AllocCoTaskMem  ((numberOfLongsInStruct * longSize) + ptrSize)
			local p = copy ptr

			marshal.WriteInt32 (toDotNetPointer p) rangeStart
			p += longSize
			marshal.WriteInt32 (toDotNetPointer p) rangeEnd
			p += longSize
			marshal.WriteIntPtr (toDotNetPointer p) strPtr
			p += ptrSize
			marshal.WriteInt32 (toDotNetPointer p) 0
			p += longSize
			marshal.WriteInt32 (toDotNetPointer p) 0

			-- Call the scintilla findText command
			sendCommandToScintilla _sciConsts._SCI_FINDTEXT searchFlags ptr

			local p = copy ptr
			p += (2 * longSize) + ptrSize
			local resultStart = marshal.ReadInt32 (toDotNetPointer p)
			p += longSize
			local resultEnd = marshal.ReadInt32 (toDotNetPointer p)

		 	Marshal.FreeHGlobal strPtr
		 	Marshal.FreeCoTaskMem (toDotNetPointer ptr)
			return (dataPair findStart:resultStart findEnd:resultEnd)
		)


	)
-- 	global ed = MxsEditorControl()
-- 	ed.findText "inText\s=" regexp:true

	global MxsEditorControl
)


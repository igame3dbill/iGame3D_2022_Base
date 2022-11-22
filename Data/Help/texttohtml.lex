	int infunc=0;
	int anchor=1;
	FILE *fp;
	char contentFrameURL[1024]="";
	
	#include <string.h>

%%
\/\/Chapter\:\ [^\n]+\n printf("</p><p><b><font size =\"6\">%s</font></b><br><br>", &yytext[11]);
\/\/Section\:\ [^\n]+\n printf("</p><p><b><font size =\"5\">%s</font></b><br><br>", &yytext[11]);
\/\/CodeBeg\: printf("<font size =\"2\"");
\/\/CodeEnd\: printf("</font>");
func\:\ [^\(]+ printf("<a name = \"anch%d\"></a><b>%s</b>", anchor, &yytext[6]);fprintf(fp, "<a href=\"%s#anch%d\" target=\"contentFrame\">%s</a><br>", contentFrameURL, anchor++, &yytext[6]);infunc=1;
fun2\:\ [^\(]+ printf("<b>%s</b>",&yytext[6]);infunc=1;
docs\:\  infunc=0;
\[[^\]0123456789][^\]]*\] yytext[strlen(yytext)-1]='\0';printf("<i>%s</i>", &yytext[1]);
\([^\n\[]+\n if (infunc){printf(" <i>%s</i><br>",yytext);}else{printf("%s<br>", yytext);}
\n printf("<br>");
OBSOLETE\ REV\ EXTERNAL\ FEATURE\!\!\!  printf("<font COLOR=\"#FF0000\">%s</font>", yytext);
%%

main( int argc, char **argv )
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;
	
	//stdout=fopen(argv[2], "w");

	sprintf(contentFrameURL, argv[2]);

	FILE *frameset=fopen(argv[1], "w");
	fprintf(frameset, "<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Frameset//EN\"><html><head><meta http-equiv=\"content-type\" content=\"text/html;charset=iso-8859-1\"><meta name=\"generator\" content=\"Tobis cool scanner\"><title>iGame3D Reference</title></head><frameset cols=\"%d,*\"><frame name=\"leftFrame\" src=\"%s\" noresize><frame name=\"contentFrame\" src=\"%s\" noresize><noframes><body bgcolor=\"#ffffff\"><p></p></body></noframes></frameset></html>", atoi(argv[4]), argv[3], argv[2]);
	fclose(frameset);
	

	fp=fopen(argv[3],"w");
	fprintf(fp,"<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\n<html>\n<head>\n<title>iGame 3D Reference</title>\n</head>\n<body bgcolor=\"#ffffff\">\n<p>\n<font size=-1>\n");
	
	
	
	printf("<!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01 Transitional//EN\">\n<html>\n<head>\n<title>iGame 3D Reference</title>\n</head>\n<body bgcolor=\"#ffffff\">\n<p>\n");
	yylex();
    printf("\n</p>\n</body>\n</html>");
    
    
    
    
    fprintf(fp, "\n</font>\n</p>\n</body>\n</html>");
    fclose(fp);
    }
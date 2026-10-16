/* Compare CWRegexEngine with the C library regexec() on random patterns.
   gcc -I<dir with Pantomime/ -> Framework/Pantomime> regex-diff.c CWRegexEngine.c -o regex-diff
   Patterns avoid ^ inside repeated groups and empty alternatives before a
   repeat, where glibc and POSIX disagree or leave the result undefined. */
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <Pantomime/CWRegexEngine.h>
static const char *atoms[] = {"a","b","c","ab",".","[ab]","[^a]","[[:space:]]","x","(a|b)","(ab|a)","()","\\(","\\[","[^][]","[a-c]"," ","re","fwd"};
static const char *posts[] = {"","","","*","+","?","{2}","{1,2}","{0,}","{2,3}"};
static unsigned long rs=12345; static int rnd(int n){rs=rs*1103515245+12345;return (rs>>16)%n;}
static void gen(char *o,int d){int k=1+rnd(3);o[0]=0;for(int i=0;i<k;i++){ if(d<2&&rnd(4)==0){char t[200];strcat(o,"(");gen(t,d+1);strcat(o,t);strcat(o,")");if(!rnd(2)){strcat(o,"x");}strcat(o,posts[rnd(10)]);} else {strcat(o,atoms[rnd(19)]);strcat(o,posts[rnd(10)]);} } if(d==0&&rnd(6)==0){char t[1]; (void)t; char tmp[300]; strcpy(tmp,"^");strcat(tmp,o);strcpy(o,tmp);} if(rnd(6)==0)strcat(o,"$"); if(d==0&&rnd(8)==0)strcat(o,"|b*");}
int main(){ long bad=0,tot=0,cmpfail=0; char pat[800],str[40];
 for(int it=0;it<200000;it++){ gen(pat,0); int icase=rnd(2); regex_t r; cwre_t c; int e1=regcomp(&r,pat,REG_EXTENDED|(icase?REG_ICASE:0)); int e2=cwre_comp(&c,pat,CWRE_EXTENDED|(icase?CWRE_ICASE:0)); if(e1||e2){ if(!!e1!=!!e2){cmpfail++; if(cmpfail<8)printf("compile differs: %s glibc=%d mine=%d\n",pat,e1,e2);} if(!e1)regfree(&r); if(!e2)cwre_free(&c); continue;}
  for(int j=0;j<6;j++){ int L=rnd(14); for(int i=0;i<L;i++){ const char *al="abcx ()[]Ab"; str[i]=al[rnd(12)];} str[L]=0; int nb=rnd(4)==0;
   regmatch_t m; cwre_match_t m2; int s1=regexec(&r,str,1,&m,nb?REG_NOTBOL:0); int s2=cwre_exec(&c,str,&m2,nb?CWRE_NOTBOL:0); tot++;
   if((s1==0)!=(s2==0) || (s1==0&&(m.rm_so!=m2.rm_so||m.rm_eo!=m2.rm_eo))){bad++; if(bad<15)printf("DIFF /%s/ icase=%d notbol=%d on [%s]: glibc %d (%d,%d) mine %d (%d,%d)\n",pat,icase,nb,str,s1,(int)m.rm_so,(int)m.rm_eo,s2,m2.rm_so,m2.rm_eo);} }
  regfree(&r); cwre_free(&c);} printf("%ld matches compared, %ld differ, %ld compile mismatches\n",tot,bad,cmpfail); return 0;}

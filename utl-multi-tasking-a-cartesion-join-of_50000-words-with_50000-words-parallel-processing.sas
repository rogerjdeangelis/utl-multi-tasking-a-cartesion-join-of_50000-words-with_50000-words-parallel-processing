Multi-Tasking a cartesion join of 50,000 words with 50,000 words                                                                        
                                                                                                                                        
Input is a column with over 50,000 words. We want to fuzzy match words within a column                                                  
                                                                                                                                        
github                                                                                                                                  
https://tinyurl.com/y298bqox                                                                                                            
https://github.com/rogerjdeangelis/utl-multi-tasking-a-cartesion-join-of_50000-words-with_50000-words-parallel-processing               
                                                                                                                                        
SAS Forum                                                                                                                               
https://tinyurl.com/y27htypv                                                                                                            
https://communities.sas.com/t5/SAS-Programming/Found-Matching-Values-in-single-variable/m-p/682126                                      
                                                                                                                                        
Benchmarks                                                                                                                              
                                                                                                                                        
      625  seconds for a cartesion join of 50,000 words with 50,000 words                                                               
       36  seconds if we run 25 parallel tasks comparing 50,000 words with 25 consecutive                                               
           sets of 2,000 records                                                                                                        
                                                                                                                                        
 We will join the list with itself where 'spedis(l.word, r.word) < 13'                                                                  
                                                                                                                                        
 Methodology                                                                                                                            
                                                                                                                                        
      This problem can be multi-tasked                                                                                                  
                                                                                                                                        
      It is not necessary to do a cartesion join of 50,000 words with 50,000 words.                                                     
      We can sucessively do 25 separate cartesion joins of the orginal 50,000 recprds with each of 25                                   
      mutuallly exclusive sucessive ranges of 2,000 reocors.                                                                            
                                                                                                                                        
      1.  You need to create a macro with two arguments                                                                                 
                                                                                                                                        
          utl_matwrd(first,last)                                                                                                        
                                                                                                                                        
          where first is the first record and last is the last record you will join to the                                              
          50,000 words.                                                                                                                 
                                                                                                                                        
      2.  You need to create the ommand line invocation                                                                                 
          %let _s=%qsysfunc(compbl(c:\PROGRA~1\SASHome\SASFoundation\9.4\sas.exe -sysin nul -log nul -work f\wrk                        
                  -rsasuser -nosplash -sasautos c:\oto -config c:\cfg\cfgsas94m6.cfg));                                                 
                                                                                                                                        
      3. You need to set up your 25 tasks                                                                                               
                                                                                                                                        
      4. You need to concatenate the 25 datasets created using you tasks                                                                
                                                                                                                                        
                                                                                                                                        
We are not interested on exact matches 'proc sort non unique key'  would give us those.                                                 
                                                                                                                                        
/*                   _                                                                                                                  
(_)_ __  _ __  _   _| |_                                                                                                                
| | `_ \| `_ \| | | | __|                                                                                                               
| | | | | |_) | |_| | |_                                                                                                                
|_|_| |_| .__/ \__,_|\__|                                                                                                               
        |_|                                                                                                                             
*/                                                                                                                                      
* this is in my autoexec file;                                                                                                          
%let lettersQ =%str("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");           
data have;                                                                                                                              
  length word $5;                                                                                                                       
  call streaminit(6543);                                                                                                                
  array alp[21] $1 _temporary_ (&lettersQ);                                                                                             
     do i=1 to 51270;                                                                                                                   
       word= cats(                                                                                                                      
               alp[floor(16*rand('uniform')) + 1 ]                                                                                      
              ,alp[floor(16*rand('uniform')) + 1 ]                                                                                      
              ,alp[floor(16*rand('uniform')) + 1 ]                                                                                      
              ,alp[floor(16*rand('uniform')) + 1 ]                                                                                      
              ,alp[floor(16*rand('uniform')) + 1 ]                                                                                      
        );                                                                                                                              
         keep word;                                                                                                                     
        output;                                                                                                                         
     end;                                                                                                                               
     stop;                                                                                                                              
run;quit;                                                                                                                               
                                                                                                                                        
libname nvme1 "f:/nvme";                                                                                                                
proc sort data=have out=nvme1.havunq nodupkey;                                                                                          
by word;                                                                                                                                
run;quit;                                                                                                                               
                                                                                                                                        
NVME1.HAVUNQ total obs=50,282                                                                                                           
                                                                                                                                        
  WORD                                                                                                                                  
                                                                                                                                        
  BEBUY                                                                                                                                 
  DARUS                                                                                                                                 
  DEVAS                                                                                                                                 
  DIWEW                                                                                                                                 
  DOXAY                                                                                                                                 
  DUYOS                                                                                                                                 
  GIFAC                                                                                                                                 
  GOGAH                                                                                                                                 
  HIMAD                                                                                                                                 
  HUNUM                                                                                                                                 
  JAROL                                                                                                                                 
  LIHEM                                                                                                                                 
  LOHIV                                                                                                                                 
  LUHOY                                                                                                                                 
  MAJOK                                                                                                                                 
  MILIK                                                                                                                                 
  MOLOT                                                                                                                                 
  NANUH                                                                                                                                 
  NEQAW                                                                                                                                 
  NIRAC                                                                                                                                 
  NOTOP                                                                                                                                 
  POVUR                                                                                                                                 
  QIZAC                                                                                                                                 
  QOZUK                                                                                                                                 
 ...                                                                                                                                    
                                                                                                                                        
/*           _               _                                                                                                          
  ___  _   _| |_ _ __  _   _| |_                                                                                                        
 / _ \| | | | __| `_ \| | | | __|                                                                                                       
| (_) | |_| | |_| |_) | |_| | |_                                                                                                        
 \___/ \__,_|\__| .__/ \__,_|\__|                                                                                                       
                |_|                                                                                                                     
*/                                                                                                                                      
                                                                                                                                        
WANT total obs=8,966                                                                                                                    
                                                                                                                                        
   BASE_                                                                                                                                
   WORD     MAT_WORD                                                                                                                    
                                                                                                                                        
   BASE_                                                                                                                                
   WORD     MAT_WORD                                                                                                                    
                                                                                                                                        
   ABELF     ABLEF                                                                                                                      
   ACJAC     AJCAC                                                                                                                      
   AMKFL     AMKLF                                                                                                                      
   BABMP     BAMBP                                                                                                                      
   CBBIH     BCBIH                                                                                                                      
   BDNBP     BDNPB                                                                                                                      
   BPOFF     BOPFF                                                                                                                      
   ADFAK     DAFAK                                                                                                                      
   CMLEF     CLMEF                                                                                                                      
   COEGA     COGEA                                                                                                                      
   DADPK     DADKP                                                                                                                      
   DEGOK     DEGKO                                                                                                                      
   FDGPJ     DFGPJ                                                                                                                      
   DLEDJ     DLEJD                                                                                                                      
   DINCH     DNICH                                                                                                                      
   EBDJJ     EBJDJ                                                                                                                      
   EDODL     EDDOL                                                                                                                      
   EEELM     EELEM                                                                                                                      
   FDONJ     FDOJN                                                                                                                      
   GMPCC     GMCPC                                                                                                                      
   GODPK     GODKP                                                                                                                      
   HCOMB     HCMOB                                                                                                                      
/*                         _        _                                                                                                   
 ___  __ _ _ __ ___  _ __ | | ___  | | ___   __ _                                                                                       
/ __|/ _` | `_ ` _ \| `_ \| |/ _ \ | |/ _ \ / _` |                                                                                      
\__ \ (_| | | | | | | |_) | |  __/ | | (_) | (_| |                                                                                      
|___/\__,_|_| |_| |_| .__/|_|\___| |_|\___/ \__, |                                                                                      
                    |_|                     |___/                                                                                       
*/                                                                                                                                      
                                                                                                                                        
NOTE: Libref NVME1 was successfully assigned as follows:                                                                                
      Engine:        V9                                                                                                                 
      Physical Name: f:\nvme                                                                                                            
NOTE: Libref NVME2 was successfully assigned as follows:                                                                                
      Engine:        V9                                                                                                                 
      Physical Name: m:\nvme                                                                                                            
NOTE: The file NVME1.HAVUNQ.DATA has been loaded into memory by the SASFILE statement.                                                  
NOTE: The execution of this query involves performing one or more Cartesian product joins that can not be optimized.                    
                                                                                                                                        
NOTE: Table NVME2.MAT2001 created, with 392 rows and 2 columns.                                                                         
                                                                                                                                        
NOTE: PROCEDURE SQL used (Total process time):                                                                                          
      real time           35.81 seconds                                                                                                 
      cpu time            35.75 seconds                                                                                                 
                                                                                                                                        
                                                                                                                                        
NOTE: The file NVME1.HAVUNQ.DATA has been closed by the SASFILE statement.                                                              
                                                                                                                                        
NOTE: SAS Institute Inc., SAS Campus Drive, Cary, NC USA 27513-2414                                                                     
NOTE: The SAS System used:                                                                                                              
      real time           36.07 seconds                                                                                                 
      cpu time            35.95 seconds                                                                                                 
                                                                                                                                        
/*                                                                                                                                      
 _ __  _ __ ___   ___ ___  ___ ___                                                                                                      
| `_ \| `__/ _ \ / __/ _ \/ __/ __|                                                                                                     
| |_) | | | (_) | (_|  __/\__ \__ \                                                                                                     
| .__/|_|  \___/ \___\___||___/___/                                                                                                     
|_|                                                                                                                                     
*/                                                                                                                                      
                                                                                                                                        
* load into autocall library;                                                                                                           
filename ft15f001 "c:\oto\utl_matwrd.sas";                                                                                              
parmcards4;                                                                                                                             
%macro utl_matwrd(first,last);                                                                                                          
                                                                                                                                        
    /*   %let first=201; %let last=300;  */                                                                                             
                                                                                                                                        
    libname nvme1 "f:/nvme";                                                                                                            
    libname nvme2 "m:/nvme";                                                                                                            
                                                                                                                                        
    sasfile nvme1.havunq load;                                                                                                          
                                                                                                                                        
    proc sql;                                                                                                                           
      create                                                                                                                            
        table nvme2.mat&first as                                                                                                        
      select                                                                                                                            
        l.word as base_word                                                                                                             
       ,r.word as mat_word                                                                                                              
      from                                                                                                                              
        nvme1.havunq as l, nvme1.havunq(firstobs=&first obs=&last) as r                                                                 
      where                                                                                                                             
        l.word ne r.word and                                                                                                            
        spedis(l.word, r.word) < 13                                                                                                     
    ;quit;                                                                                                                              
                                                                                                                                        
    sasfile nvme1.havunq close;                                                                                                         
                                                                                                                                        
%mend utl_matwrd;                                                                                                                       
;;;;                                                                                                                                    
run;quit;                                                                                                                               
                                                                                                                                        
*Tets interactively;                                                                                                                    
%*utl_matwrd(1001,2000);                                                                                                                
                                                                                                                                        
                                                                                                                                        
%let _s=%qsysfunc(compbl(c:\PROGRA~1\SASHome\SASFoundation\9.4\sas.exe -sysin nul -log nul -work f\wrk                                  
        -rsasuser -nosplash -sasautos c:\oto -config c:\cfg\cfgsas94m6.cfg));                                                           
                                                                                                                                        
options xwait xsync;                                                                                                                    
%let tym=%sysfunc(time());                                                                                                              
systask kill sys02 sys04 sys06 sys08 sys10 sys12 sys14 sys16 sys18 sys20 sys22 sys24 sys26                                              
sys28 sys30 sys32 sys34 sys36 sys38 sys40 sys42 sys44 sys46 sys48 sys50;                                                                
                                                                                                                                        
systask command "&_s -termstmt %nrstr(%utl_matwrd(1,2000);) -log d:\log\a02.log" taskname=sys02;                                        
systask command "&_s -termstmt %nrstr(%utl_matwrd(2001,4000);) -log d:\log\a04.log" taskname=sys04;                                     
systask command "&_s -termstmt %nrstr(%utl_matwrd(4001,6000);) -log d:\log\a06.log" taskname=sys06;                                     
systask command "&_s -termstmt %nrstr(%utl_matwrd(6001,8000);) -log d:\log\a08.log" taskname=sys08;                                     
systask command "&_s -termstmt %nrstr(%utl_matwrd(8001,10000);) -log d:\log\a10.log" taskname=sys10;                                    
systask command "&_s -termstmt %nrstr(%utl_matwrd(10001,12000);) -log d:\log\a12.log" taskname=sys12;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(12001,14000);) -log d:\log\a14.log" taskname=sys14;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(14001,16000);) -log d:\log\a16.log" taskname=sys16;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(16001,18000);) -log d:\log\a18.log" taskname=sys18;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(18001,20000);) -log d:\log\a20.log" taskname=sys20;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(20001,22000);) -log d:\log\a22.log" taskname=sys22;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(22001,24000);) -log d:\log\a24.log" taskname=sys24;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(24001,26000);) -log d:\log\a26.log" taskname=sys26;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(26001,28000);) -log d:\log\a28.log" taskname=sys28;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(28001,30000);) -log d:\log\a30.log" taskname=sys30;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(30001,32000);) -log d:\log\a32.log" taskname=sys32;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(32001,34000);) -log d:\log\a34.log" taskname=sys34;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(34001,36000);) -log d:\log\a36.log" taskname=sys36;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(36001,38000);) -log d:\log\a38.log" taskname=sys38;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(38001,40000);) -log d:\log\a40.log" taskname=sys40;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(40001,42000);) -log d:\log\a42.log" taskname=sys42;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(42001,44000);) -log d:\log\a44.log" taskname=sys44;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(44001,46000);) -log d:\log\a46.log" taskname=sys46;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(46001,48000);) -log d:\log\a48.log" taskname=sys48;                                   
systask command "&_s -termstmt %nrstr(%utl_matwrd(48001,51000);) -log d:\log\a50.log" taskname=sys50;                                   
                                                                                                                                        
waitfor sys02 sys04 sys06 sys08 sys10 sys12 sys14 sys16 sys18 sys20 sys22 sys24 sys26                                                   
sys28 sys30 sys32 sys34 sys36 sys38 sys40 sys42 sys44 sys46 sys48 sys50;                                                                
                                                                                                                                        
%put %sysevalf( %sysfunc(time()) - &tym);                                                                                               
                                                                                                                                        
                                                                                                                                        
libname nvme2 "m:/nvme";                                                                                                                
data want;                                                                                                                              
  set                                                                                                                                   
     nvme2.mat1                                                                                                                         
     nvme2.mat2001                                                                                                                      
     nvme2.mat4001                                                                                                                      
     nvme2.mat6001                                                                                                                      
     nvme2.mat8001                                                                                                                      
     nvme2.mat10001                                                                                                                     
     nvme2.mat12001                                                                                                                     
     nvme2.mat14001                                                                                                                     
     nvme2.mat16001                                                                                                                     
     nvme2.mat18001                                                                                                                     
     nvme2.mat20001                                                                                                                     
     nvme2.mat22001                                                                                                                     
     nvme2.mat24001                                                                                                                     
     nvme2.mat26001                                                                                                                     
     nvme2.mat28001                                                                                                                     
     nvme2.mat30001                                                                                                                     
     nvme2.mat32001                                                                                                                     
     nvme2.mat34001                                                                                                                     
     nvme2.mat36001                                                                                                                     
     nvme2.mat38001                                                                                                                     
     nvme2.mat40001                                                                                                                     
     nvme2.mat42001                                                                                                                     
     nvme2.mat44001                                                                                                                     
     nvme2.mat46001                                                                                                                     
     nvme2.mat48001                                                                                                                     
 ;                                                                                                                                      
run;quit;                                                                                                                               
                                                                                                                                        
                                                                                                                                        
                                                                                                                                        
NOTE: There were 286 observations read from the data set NVME2.MAT1.                                                                    
NOTE: There were 101 observations read from the data set NVME2.MAT2001.                                                                 
NOTE: There were 99 observations read from the data set NVME2.MAT4001.                                                                  
NOTE: There were 156 observations read from the data set NVME2.MAT6001.                                                                 
NOTE: There were 250 observations read from the data set NVME2.MAT8001.                                                                 
NOTE: There were 90 observations read from the data set NVME2.MAT10001.                                                                 
NOTE: There were 116 observations read from the data set NVME2.MAT12001.                                                                
NOTE: There were 186 observations read from the data set NVME2.MAT14001.                                                                
NOTE: There were 201 observations read from the data set NVME2.MAT16001.                                                                
NOTE: There were 96 observations read from the data set NVME2.MAT18001.                                                                 
NOTE: There were 77 observations read from the data set NVME2.MAT20001.                                                                 
NOTE: There were 110 observations read from the data set NVME2.MAT22001.                                                                
NOTE: There were 78 observations read from the data set NVME2.MAT24001.                                                                 
NOTE: There were 245 observations read from the data set NVME2.MAT26001.                                                                
NOTE: There were 130 observations read from the data set NVME2.MAT28001.                                                                
NOTE: There were 88 observations read from the data set NVME2.MAT30001.                                                                 
NOTE: There were 94 observations read from the data set NVME2.MAT32001.                                                                 
NOTE: There were 119 observations read from the data set NVME2.MAT34001.                                                                
NOTE: There were 152 observations read from the data set NVME2.MAT36001.                                                                
NOTE: There were 282 observations read from the data set NVME2.MAT38001.                                                                
NOTE: There were 104 observations read from the data set NVME2.MAT40001.                                                                
NOTE: There were 102 observations read from the data set NVME2.MAT42001.                                                                
NOTE: There were 111 observations read from the data set NVME2.MAT44001.                                                                
NOTE: There were 129 observations read from the data set NVME2.MAT46001.                                                                
NOTE: There were 124 observations read from the data set NVME2.MAT48001.                                                                
NOTE: The data set WORK.WANT has 3526 observations and 2 variables.                                                                     
NOTE: DATA statement used (Total process time):                                                                                         
      real time           0.06 seconds                                                                                                  
      user cpu time       0.01 seconds                                                                                                  
      system cpu time     0.01 seconds                                                                                                  
      memory              5354.87k                                                                                                      
      OS Memory           51748.00k                                                                                                     
      Timestamp           09/08/2020 09:22:23 PM                                                                                        
      Step Count                        36305  Switch Count  0                                                                          
                                                                                                                                        

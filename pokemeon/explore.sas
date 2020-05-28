/* Create a new lib for all pokemon tables */
libname Pokemon '/folders/myfolders/Pokemon/lib/';


/* Import the data */
options validvarname=v7;
proc import datafile="/folders/myfolders/Pokemon/data/Pokemon.csv" 
			dbms=csv out=Pokemon.Base;
run;


/* Print out variable and table details */
/* proc contents data = pokemon.base; */
/* run; */


/* Print out the first few rows of the data */
/* proc print data=Pokemon.Base; */
/* run; */


/* Add extra cols to the data and make a new table */
data Pokemon.detailed;
	set Pokemon.Base;
	DefenceScore = Defense + Sp__Def;
	AttackScore = Attack + Sp__Atk;
	AverageAttack  = AttackScore/2;
run;


/* Make a table with only Grass Pokemon */
/* data Pokemon.detailedgrass; */
/* 	set Pokemon.detailed; */
/* 	where (Type_1 = "Grass" OR Type_2 = "Grass"); */
/* run; */


/* Print out the grass pokemone table */
/* title "Grass Pokemon"; */
/* proc print data = pokemon.detailedgrass; */
/* run; */


/* Print out a more detailed list of pokemon */
/* title "Pokemon with high attack scores"; */
/* proc print data=pokemon.detailed; */
/* 	var Name attackscore defencescore generation; */
/* 	where attackscore > 300; */
/* run; */


/* More detailed print statements */
/* between is inclusive */
/* % is wild for any number of char */
/* _ is wild for a single char */
/* proc print data = pokemon.detailed; */
/* 	where Type_2 is missing; */
/* 	where Type_2 is not missing; */
/* 	where attackScore between 100 and 150; */
/* 	where Type_1 like "G%"; */
/* run; */


/* Example of using macros with print and where statements */
/* %let stat=attack; */
/* %let Min=50; */
/* %let Max=60; */
/* Title "Pokemon with &stat between &min and &max"; */
/* proc print data = pokemon.detailed; */
/* 	where &stat between &Min and &Max; */
/* 	var Name attack; */
/* run; */


/* freq will display the freq of data in each vars */
/* Using tables we can select vars */
/* Can also use the where command to select a subset of data  */
/* proc freq data=pokemon.detailed; */
/* 	where attack > 100; */
/* 	tables Type_1 Type_2; */
/* run; */


/* Example of using formating to round to nearest whole number */
/* proc print data = pokemon.detailed(obs=10); */
/* 	format averageattack 3.; */
/* 	var name averageattack; */
/* run; */


/* Sort data by variable */
/* proc sort data=pokemon.detailed out=pokemon.sortedAttack; */
/* 	by DESCENDING attack; */
/* run; */


/* example of keep/drop variables to make new table */
/* data Pokemon.summary; */
/* 	set Pokemon.detailed; */
/* 	keep id name type_1 total; */
/* run; */


/* Using if then do else do statments to assign new values to a var */
/* data Pokemon.statCompare; */
/* 	set pokemon.detailed; */
/* 	if abs(AttackScore - DefenceScore) < 10 then combatGroup = 1; */
/* 	else if abs(AttackScore - DefenceScore) < 50 then combatGroup = 2; */
/* 	else if abs(AttackScore - DefenceScore) < 100 then combatGroup = 3; */
/* 	else combatGroup = 4; */
/* 	keep name Type_1 AttackScore DefenceScore combatGroup; */
/* run; */

/* proc freq data=Pokemon.statCompare; */
/* 	tables combatGroup; */
/* run; */


/* How to use lables in means/freq/others */
/* proc means data = pokemon.base; */
/* 	var Sp__Atk Sp__Def; */
/* 	label Sp__Atk="special attack" Sp__Def="special defence"; */
/* run; */


/* How to use lables in the print statement */
/* proc print data=pokemon.base label; */
/* 	var name Sp__Atk Sp__Def; */
/* 	label Sp__Atk="special attack" Sp__Def="special defence"; */
/* run; */


/* Segmenting reports */
/* Get more detailed reports by sorting first then getting freqs */
/* proc sort data=pokemon.detailed out=pokemon.sortedType; */
/* 	by Type_1; */
/* run; */
/*  */
/* proc freq data=pokemon.sortedType; */
/* 	by type_1; */
/* 	tables Type_2; */
/* run; */


/* More detailed printing */
/* proc sort data = pokemon.statCompare out=pokemon.subsetSort; */
/* 	by type_1 descending attackscore; */
/* 	where combatgroup = 1; */
/* run; */
/*  */
/* title "Strong Pokemon"; */
/* proc print data = pokemon.subsetSort noobs; */
/* 	var name attackscore; */
/* 	by type_1; */
/* run; */


/* Freq report options */
/* ods graphics on; */
/* ods noproctitle; */
/* title "Freq Reports"; */
/* proc freq data = pokemon.detailed order=freq nlevels; */
/* 	table type_1 / nocum plots=freqplot(orient=horizontal scale=PERCENT); */
/* run; */


/* Two way frequency reports */
/* proc freq data=pokemon.detailed noprint; */
/* 	tables type_1*generation / norow nocol nopercent out=pokemon.gentypecount; */
/* run; */


/* Using class and ways to get stats with means proc */
/* proc means data=pokemon.detailed mean median min max maxdec=0 noobs; */
/* 	var AttackScore; */
/* 	class Legendary Type_1; */
/* 	ways 0 1 2; */
/* run; */


/* Export to CSV */
/* proc export data = pokemon.detailed  */
/* 			outfile="/folders/myfolders/Pokemon/export/detailed.csv"  */
/* 			dbms=csv */
/* 			replace; */
/* run; */


/* Export to XLSX using libname */
/* libname xlout xlsx "/folders/myfolders/Pokemon/export/detailed.xlsx"; */
/* data xlout.detailed; */
/* 	set pokemon.detailed; */
/* run; */
/*  */
/* libname xlout clear; */



/* ods pdf file="/folders/myfolders/Pokemon/export/detailed.pdf" startpage=no style=journal pdftoc=1; */
/*  */
/* Freq report options */
/* ods graphics on; */
/* ods noproctitle; */
/* title "Freq Reports"; */
/* proc freq data = pokemon.detailed order=freq nlevels; */
/* 	table type_1 / nocum plots=freqplot(orient=horizontal scale=PERCENT); */
/* run; */
/*  */
/*  */
/* Two way frequency reports */
/* proc freq data=pokemon.detailed noprint; */
/* 	tables type_1*generation / norow nocol nopercent out=pokemon.gentypecount; */
/* run; */
/*  */
/* ods pdf close; */

/* Sample SQL Statements */
/* proc sql; */
/* select propcase(name) as Name, attackscore, generation */
/* 	from pokemon.detailed */
/* 	where attackscore > 200 */
/* 	order by generation desc, attackscore desc; */
/* quit; */

/* Reset Title */
title;


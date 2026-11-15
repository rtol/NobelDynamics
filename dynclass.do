clear all

cd "C:\Users\rtol\OneDrive\MATLAB\Nobel\"

import delimited "dynclass.csv"

label var cumaward "Number of previous Nobel prizes in field"
label var number "Number of candidates in field"
label var maxcite "Citations to most cited paper in field"
label var totcite "Total number of citations in field"
label var proximity "Proximity to Nobel committee"
label var proxcorr "Smoothed proximity to Nobel committee"
label var neverwon "Field has not yet won the Nobel Prize"
label var wonlastyear "Field won Nobel in the previous year"
label var yearssincewin "Years since field last won"
label var buggins "Transition matrix between fields"
label var bayesann "Transition matrix, updated annually"
label var bayesf "Transition matrix, final year"
label var bayes3 "Transition matrix, 3 year rolling windows"
label var bayes5 "Transition matrix, 5 year rolling windows"
label var bayes7 "Transition matrix, 7 year rolling windows"
label var bayes9 "Transition matrix, 9 year rolling windows"
label var bayes11 "Transition matrix, 11 year rolling windows"
label var bayeslb "Transition matrix, with and without Lindbeck"
label var frustration "Member-years since field last won"
label var size "Cumulative number of publications in field"
label var size1 "Number of publications in field in last year"
label var size5 "Number of publications in field in last 5 years"
label var size10 "Number of publications in field in last 10 years"

rename award awardf
rename maxcite maxcitef
rename totcite totcitef

save dynclass, replace

logit awardf number maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size year
stepwise, pr(0.1): logit awardf number maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size year
*only number and wonlastyear survived

*create lagged variables by hand
logit awardf number wonlastyear
logit awardf number awardf_01
logit awardf number awardf_01 awardf_02
logit awardf number awardf_01 awardf_02 awardf_03
logit awardf number awardf_01 awardf_02 awardf_03 awardf_04
keep in 1/812

*choose sizes
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size year
*Log likelihood = -152.2994
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -151.48051
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 year
*Log likelihood = -152.22043     
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size10 year
*Log likelihood =  -152.3078 
*LL flat but size1 works best

*choose proximity
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood = -151.48051 
logit awardf number buggins maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood = -151.96583   
*LL flat but proximity works best

*choose transition
logit awardf number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -151.48051
logit awardf number bayesf maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood = -155.96679 
logit awardf number bayesann maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood = -199.04249 
logit awardf number bayes11 maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -110.7881
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -136.93685 
*rolling windows work best, because they contain the actual winner
*LL not flat: the Lindbeck split works the best by far

*recheck size
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size year
*Log likelihood = -137.5443  
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -136.93685
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 year
*Log likelihood = -137.45634  
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size10 year
*Log likelihood =  -137.69382   
*size1 works best

*recheck proximity
logit awardf number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood =  -137.69382 
logit awardf number bayeslb maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
*Log likelihood = -136.93636
*proxcorr works best

logit awardf number bayeslb maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size5 year
*Log likelihood = -137.45811
*size1 really works best

logit awardf number bayeslb maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store full

stepwise, pr(0.1): logit awardf number bayeslb maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store cons
predict prob
predict IMR, sc

logit awardf number maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store fullno

stepwise, pr(0.1): logit awardf number maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store consno

esttab full cons fullno consno using TableC.tex, replace label title(Which field wins?\label{tab:field}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated") stats(ll N, labels("Log Likelihood" "Observations"))

esttab cons consno using TableCtalk.tex, replace label noconstant title(Which field wins?\label{tab:field}) nonumbers mtitles("Transition" "None")

stepwise, pr(0.1): logit awardf number bayes11 maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store cons11
stepwise, pr(0.1): logit awardf number bayesann maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store consA
stepwise, pr(0.1): logit awardf number bayeslb maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store consLB
stepwise, pr(0.1): logit awardf number bayesf maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store consF
stepwise, pr(0.1): logit awardf number buggins maxcitef totcitef proxcorr cumaward neverwon yearssincewin wonlastyear size1 year
est store consEmp

esttab cons11 consLB consF consEmp consA using TableC1.tex, replace label title(Which field wins?\label{tab:field}) nonumbers mtitles("11 year" "Lindbeck" "Empirical" "Final" "Annual") stats(ll N, labels("Log Likelihood" "Observations"))

forvalues t = 1969/2026 {
logit awardf number buggins cumaward size1 if year == `t'
outreg2 using "time.doc", append
}

logit awardf number buggins cumaward size5 if year == 1969
outreg2 using "time.doc", replace
logit awardf number buggins cumaward size5 if year == 1970
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1971
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1972
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1973
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1974
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1975
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1976
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1977
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1978
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1979
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1980
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1981
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1982
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1983
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1984
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1985
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1986
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1987
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1988
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1989
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1990
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1991
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1992
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1993
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1994
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1995
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1996
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1997
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1998
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 1999
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2000
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2001
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2002
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2003
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2004
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2005
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2006
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2007
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2008
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2009
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2010
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2011
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2012
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2013
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2014
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2015
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2016
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2017
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2018
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2019
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2020
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2021
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2022
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2023
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2024
outreg2 using "time.doc", append
logit awardf number buggins cumaward size5 if year == 2025
outreg2 using "time.doc", append

drop awardf* number buggins bayes* maxcitef totcitef prox* cumaward neverwon yearssincewin wonlastyear frustration size* _est*

save dynclass2, replace
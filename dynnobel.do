cd "C:\Users\rtol\OneDrive\MATLAB\Nobel\"

clear all

import delimited "dynnobel.csv"

merge m:1 year class using dynclass2

encode country, gen(origin)
encode religion, gen(faith)
encode ethnicity, gen(race)
encode field, gen(jel)
encode class, gen(broad)
encode school, gen(alma)
encode degree, gen(highest)
encode location, gen(workplace)

gen eligible = year>born+40
gen alive = year<=died
gen notwon = year<=nobel

gen select = eligible & alive & notwon

gen age = year-born
gen agesq = age*age
gen fesage = fes-born
replace fesage = 0 if fesage < 0
gen nofes = (fes == 0)
gen nowalker = (walker == 0)
gen noclarivate = (clarivate == 0)
gen nobbva = (bbva == 0)
gen nosoderstrom = (soderstrom == 0)
gen noyrjo = (yrjo == 0)

label var age "Age"
label var agesq "Age squared"
label var gender "Gender"
label var attractiveness "Physical attractiveness"
label var maxcite "Number of citations, most-cited paper"
label var maxcitey "Number of citations, most-cited paper, normalized by annual maximum"
label var maxcitefy "Number of citations, most-cited paper, normalized by annual field maximum"
label var maxcitez "Annual z-score of citations, most-cited paper"
label var totcite "Number of citations, total"
label var totcitey "Number of citations, total, normalized by annual maximum"
label var totcitefy "Number of citations, total, normalized by annual field maximum"
label var totcitez "Annual z-score of citations, total"
label var h "Hirsch number"
label var hy "Hirsch number, normalized by annual maximum"
label var hfy "Hirsch number, normalized by annual field maximum"
label var hz "Annual z-score Hirsch number"
label var i100 "Number of papers cited 100 times or more"
label var i100y "Number of papers cited 100 times or more, normalized by annual maximum"
label var i100fy "Number of papers cited 100 times or more, normalized by annual field maximum"
label var i100z "Annual z-score of papers cited 100 times or more"
label var i1000 "Number of papers cited 1000 times or more"
label var i1000y "Number of papers cited 1000 times or more, normalized by annual maximum"
label var i1000fy "Number of papers cited 1000 times or more, normalized by annual field maximum"
label var i1000z "Annual z-score of papers cited 1000 times or more"
label var top5 "Number of Top 5 publications (cumulative)"
label var anch "Proximity to Nobelists among professors"
label var desch "Proximity to Nobelists among students"
label var siblings "Proximity to Nobelists, co-students (professor)"
label var nobelstudy "Proximity to Nobelists, co-students (alma mater)"
label var nobelwork "Proximity to Nobelists, co-workers"
label var nobelfam "Proximity to Nobelists, family"
label var ednobel "Proximity to Nobelists, co-editors"
label var coauthnobel "Proximity to Nobelists, co-authors"
label var agediff "Age difference with Nobel co-author"
label var affclass "Proximity of research to Nobel committee"
label var affclcor "Smoothed proximity of research to Nobel committee"
label var thwarted "Co-author of most-cited paper won Nobel"
label var prob "Chance Nobel awarded to candidate's field"
label var IMR "Inverse Mills' Ratio"
label var fes "Year elected Fellow Econometric Society"
label var fesage "Age elected Fellow Econometric Society"
label var nofes "Dummy if never elected Fellow Econometric Society"
label var nowalker "Dummy if never won Walker Medal"
label var noclarivate "Dummy if never elected Clarivate Citation Laureate"
label var nobbva "Dummy if never won BBVA Award"
label var nosoderstrom "Dummy if never won Soderstrom Medal"
label var noyrjo "Dummy if never given Yrjo Jahnsson Lecture"

gen npubs = year
replace npubs = 2966 if npubs == 1969
replace npubs = 3763 if npubs == 1970
replace npubs = 3342 if npubs == 1971
replace npubs = 3021 if npubs == 1972
replace npubs = 3657 if npubs == 1973
replace npubs = 4650 if npubs == 1974
replace npubs = 4582 if npubs == 1975
replace npubs = 5051 if npubs == 1976
replace npubs = 5068 if npubs == 1977
replace npubs = 4794 if npubs == 1978
replace npubs = 4915 if npubs == 1979
replace npubs = 4936 if npubs == 1980
replace npubs = 5033 if npubs == 1981
replace npubs = 5313 if npubs == 1982
replace npubs = 5593 if npubs == 1983
replace npubs = 5482 if npubs == 1984
replace npubs = 5785 if npubs == 1985
replace npubs = 5623 if npubs == 1986
replace npubs = 5705 if npubs == 1987
replace npubs = 5865 if npubs == 1988
replace npubs = 6011 if npubs == 1989
replace npubs = 6156 if npubs == 1990
replace npubs = 6439 if npubs == 1991
replace npubs = 6669 if npubs == 1992
replace npubs = 6494 if npubs == 1993
replace npubs = 6826 if npubs == 1994
replace npubs = 7289 if npubs == 1995
replace npubs = 8032 if npubs == 1996
replace npubs = 7920 if npubs == 1997
replace npubs = 8128 if npubs == 1998
replace npubs = 8091 if npubs == 1999
replace npubs = 8266 if npubs == 2000
replace npubs = 8174 if npubs == 2001
replace npubs = 8554 if npubs == 2002
replace npubs = 9732 if npubs == 2003
replace npubs = 9774 if npubs == 2004
replace npubs = 13559 if npubs == 2005
replace npubs = 16434 if npubs == 2006
replace npubs = 18933 if npubs == 2007
replace npubs = 22058 if npubs == 2008
replace npubs = 24726 if npubs == 2009
replace npubs = 26191 if npubs == 2010
replace npubs = 27937 if npubs == 2011
replace npubs = 28834 if npubs == 2012
replace npubs = 29152 if npubs == 2013
replace npubs = 28945 if npubs == 2014
replace npubs = 29390 if npubs == 2015
replace npubs = 30279 if npubs == 2016
replace npubs = 32491 if npubs == 2017
replace npubs = 33675 if npubs == 2018
replace npubs = 38039 if npubs == 2019
replace npubs = 37243 if npubs == 2020
replace npubs = 39398 if npubs == 2021
replace npubs = 37005 if npubs == 2022
replace npubs = 36849 if npubs == 2023
replace npubs = 38699 if npubs == 2024
replace npubs = 41196 if npubs == 2025
replace npubs = 31669 if npubs == 2026

gen maxcites = maxcite/npubs
gen totcites = totcite/npubs
gen hs = h/npubs
gen i1000s = i1000/npubs
gen i100s = i100/npubs
gen top5s = top5/npubs

global row = 1
global rownames

matrix Results = J(100,8,.)
matrix colnames Results = ///
    desch se ///
    coauthnobel se ///
    agediff se ///
    combined se

*citations
logit award maxcite totcite h if select == 1
*Log likelihood = -561.94838 
logit award maxcitey totcitey hy if select == 1
*Log likelihood = -562.3834    
logit award maxcitefy totcitefy hfy if select == 1
*Log likelihood = -562.13097 
logit award maxcitez totcitez hz if select == 1
*Log likelihood = -562.47656
logit award maxcites totcites hs if select == 1 
*Log likelihood = -562.39653
*use raw citation indices

*awards
logit award fesage nofes if select == 1
*Fellows of the Econometric Society are more likely to win Nobel
logit award nofes nowalker noclarivate nobbva nosoderstrom noyrjo if select == 1
*Fellows of the Econometric Society and Walker Medallists are more likely to win; Clarivate laureates are less likely to win (10%)

*personal characteristics
logit award year gender age agesq i.origin i.faith i.race if select == 1
*gender negative (10%), Cyprus and Norway positive, Hindu negative

logit award year gender age agesq if select == 1
*optimal age: 71

logit award year gender i.origin i.faith i.race attractiveness if select == 1
*attractiveness erodes significance of Cyprus and Hinduism, enhance Netherlands dummy

logit award year gender attractiveness if select == 1
*both gender and attractiveness significant at 10%

logit award year c.gender##c.attractiveness if select == 1
*attractiveness is still significant at 10%

logit award year gender age agesq attractiveness if select == 1
*attractiveness insignificant when age is controlled for

*field
logit award year i.jel if select == 1
*too many dropped
logit award year i.broad if select == 1 
*only information is significant (10%)

*class mates
logit award year study nobelstudy if select == 1
*both significant

*work mates
logit award year work nobelwork if select == 1
*neither significant

*journal mates
logit award year editor ednobel if select == 1
*ednobel significant

*paper mates
logit award year coauthcentr coauthnobel agediff if select == 1
*agediff significant

*committee
logit award year affinity affclass affclcor if select == 1
*affinity significant, affclcor at 10%

*family and friends
logit award year family nobelfam if select == 1
*family significant

*genealogy
logit award year anch desch siblings if select == 1
*students significant

*top5/npubs
logit award top5 top5s if select == 1
*top5 works slightly better

*all together now
logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1
*Log likelihood = -434.88022  

*this confirms that year does not do much
logit award i.year gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1
*Log likelihood = -403.20991
*31 points for 55 parameters

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1
*Log likelihood = -433.37222 
*pubs outperforms year

est store full

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames BaseFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1

predict outlier

est store cons

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames BaseCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1

est store fullno
summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames NoFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1

est store consno

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames NoCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

* alternative to stepwise, cross-validation for model selection
elasticnet logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1
*alpha = 1,0, lambda =  .0000638 

* reveal which variables are included
lassocoef

* run and store
logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1
est store lasso

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames CV"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

* 2nd alternative, BIC for model selection
elasticnet logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1, sel(bic)
*alpha = 1, lambda = .0034842

* reveal which variables are included
lassocoef

logit award age desch prob if select == 1
est store lasso2

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames BIC"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

esttab lasso cons lasso2 using TableS4.tex, replace label title(Which individual wins?\label{tab:lasso}) nonumbers mtitles( "Lasso (CV)" "Stepwise" "Lasso (BIC)")  stats(ll N, labels("Log Likelihood" "Observations")) long

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 & infield == 1

est store fullin

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames InFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 & infield == 1

est store consin

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames InCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

esttab full cons fullno consno fullin consin using TableI.tex, replace label noconstant title(Which individual wins?\label{tab:person}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated") stats(ll N, labels("Log Likelihood" "Observations"))

logit award affinity if select == 1 & infield == 1

bysort year: egen naward = total(award == 1)
bysort year: egen nselect = total(select == 1)
gen chance = naward / nselect
bysort year: egen tprob = total(prob)
gen prob1 = tprob / nselect
gen ipw = chance / (1-prob1)
replace ipw = chance / prob1 if infield == 1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 [pweight=ipw]

est store fullipw

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames IPWFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 [pweight=ipw]

est store consipw

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames IPWCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

esttab cons consno consin using TableItalk.tex, replace label noconstant title(Which individual wins?\label{tab:person}) nonumbers mtitles("Field" "None" "Within")

forvalues b = 1/14 {
	display "Running regression for field = `b'"
	if inlist(`b', 6, 12) continue
	logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affclcor thwarted if select == 1 & broad == `b'
}

pca maxcite totcite h i100 i1000
predict pcacit1 pcacit2, score

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness pcacit1 pcacit2 top5 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel agediff affclcor thwarted  prob if select == 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness pcacit1 pcacit2 top5 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel agediff affclcor thwarted  if select == 1 & infield == 1

logit award i.origin if select == 1
logit award i.faith if select == 1
logit award i.race if select == 1
logit award i.alma if select == 1
logit award i.workplace if select == 1

stepwise, pr(0.1): logit award i.origin if select == 1
stepwise, pr(0.1): logit award i.faith if select == 1
stepwise, pr(0.1): logit award i.race if select == 1
stepwise, pr(0.1): logit award i.alma if select == 1
stepwise, pr(0.1): logit award i.workplace if select == 1

gen Netherlands = (country == "Netherlands")
gen Norway = (country == "Norway")
gen Russia = (country == "Russia")
gen Lucia = (country == "St Lucia")

gen Christian = (religion == "Christian")
gen Hindu = (religion == "Hindu")
gen Jewish = (religion == "Jewish")

gen Clifton = (school == "Clifton C")
gen Kharkiv = (school == "Kharkiv")
gen Leningrad = (school == "Leningrad")
gen Oslo = (school == "Oslo")
gen Rutgers = (school == "Rutgers")
gen Utrecht = (school == "Utrecht")
gen Dakota = (school == "South Dakota State")

gen AZS = (location == "Arizona State")
gen CUNY = (location == "CUNY")
gen Chicago = (location == "Chicago")
gen GeorgeMason = (location == "George Mason")
gen Novosibirsk = (location == "Novosibirsk")
gen OsloW = (location == "Oslo")
gen Salzburg = (location == "Salzburg")
gen WUStL = (location == "WUStL")

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob Netherlands Norway Russia Lucia Christian Hindu Jewish Clifton Kharkiv Leningrad Oslo Rutgers Utrecht Dakota AZS CUNY Chicago GeorgeMason Novosibirsk OsloW Salzburg WUStL if select == 1

est store fulld

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames DummyFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob Netherlands Norway Russia Lucia Christian Hindu Jewish Clifton Kharkiv Leningrad Oslo Rutgers Utrecht Dakota AZS CUNY Chicago GeorgeMason Novosibirsk OsloW Salzburg WUStL if select == 1

est store consd

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames DummyCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

xtset pid year 
xtlogit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1

est store fullp

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames PanelFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

xtlogit award age agesq i1000 desch nobelstudy family agediff prob if select == 1

est store consp

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames PanelCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

xtlogit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affclcor thwarted prob if select == 1, fe
*does not converge

esttab fulld consd fullp consp using TableS1.tex, replace label title(Which individual wins?\label{tab:sens1}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated")  stats(ll N, labels("Log Likelihood" "Observations")) long

*one break
local minsize 15
local firstyear 1969
local lastyear 2026
local start = `firstyear' + `minsize'
local end = `lastyear' - `minsize'
local nsplit = `lastyear' - `firstyear' - 2*`minsize' + 1
matrix LL_Results = J(`nsplit', 4, .)
local row_counter = 1

forvalues t = `start'/`end' {

qui stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year < `t'
    local ll1 = e(ll)
    
qui stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= `t'
    local ll2 = e(ll)
    
    local total_ll = `ll1' + `ll2'
    
    matrix LL_Results[`row_counter', 1] = `t'
    matrix LL_Results[`row_counter', 2] = `ll1'
    matrix LL_Results[`row_counter', 3] = `ll2'
    matrix LL_Results[`row_counter', 4] = `total_ll'
    
    local row_counter = `row_counter' + 1
}

matrix colnames LL_Results = Split_Point LL_Period_1 LL_Period_2 Total_LL
matrix list LL_Results, format(%9.4f)
*max at r29    2005.0000    -222.3738    -191.5870    -413.9608

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year < 2005

est store fullearly

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames EarlyFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year < 2005

est store consearly

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames EarlyCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 2005

est store fulllate

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames LateFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 2005

est store conslate

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames LateCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

*two breaks
local minsize 15
local firstyear 1969
local lastyear 2026

* Number of feasible break pairs
local npairs = 0
forvalues t1 = `=`firstyear'+`minsize''/`=`lastyear'-2*`minsize'' {
    forvalues t2 = `=`t1'+`minsize''/`=`lastyear'-`minsize'' {
        local ++npairs
    }
}

matrix LL_Results = J(`npairs', 6, .)

local row = 1

forvalues t1 = `=`firstyear'+`minsize''/`=`lastyear'-2*`minsize'' {

    forvalues t2 = `=`t1'+`minsize''/`=`lastyear'-`minsize'' {

        * Period 1
        quietly stepwise, pr(0.1): ///
            logit award npubs gender age agesq attractiveness ///
            maxcite totcite h i100 i1000 top5 anch desch ///
            siblings nobelstudy nobelwork family nobelfam ///
            ednobel coauthnobel agediff affinity thwarted prob ///
            if select == 1 & year < `t1'

        local ll1 = e(ll)

        * Period 2
        quietly stepwise, pr(0.1): ///
            logit award npubs gender age agesq attractiveness ///
            maxcite totcite h i100 i1000 top5 anch desch ///
            siblings nobelstudy nobelwork family nobelfam ///
            ednobel coauthnobel agediff affinity thwarted prob ///
            if select == 1 & year >= `t1' & year < `t2'

        local ll2 = e(ll)

        * Period 3
        quietly stepwise, pr(0.1): ///
            logit award npubs gender age agesq attractiveness ///
            maxcite totcite h i100 i1000 top5 anch desch ///
            siblings nobelstudy nobelwork family nobelfam ///
            ednobel coauthnobel agediff affinity thwarted prob ///
            if select == 1 & year >= `t2'

        local ll3 = e(ll)

        local total_ll = `ll1' + `ll2' + `ll3'

        matrix LL_Results[`row',1] = `t1'
        matrix LL_Results[`row',2] = `t2'
        matrix LL_Results[`row',3] = `ll1'
        matrix LL_Results[`row',4] = `ll2'
        matrix LL_Results[`row',5] = `ll3'
        matrix LL_Results[`row',6] = `total_ll'

        local ++row
    }
}

matrix colnames LL_Results = ///
    Break1 Break2 LL1 LL2 LL3 Total_LL
matrix list LL_Results
*r79        1992        2009  -119.99366  -126.34483  -154.72476  -401.06325

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year < 1992

est store fullp1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year < 1992

est store consp1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 1992 & year < 2009

est store fullp2

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 1992 & year < 2009

est store consp2

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 2009

est store fullp3

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1 & year >= 2009

est store consp3

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted prob if select == 1

local lln = e(ll)

display "Whole sample log-likelihood: `lln'"
*Whole sample log-likelihood: -440.0788545034334

esttab fullearly consearly fulllate conslate using TableS2.tex, replace label title(Which individual wins?\label{tab:sens2}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated")  stats(ll N, labels("Log Likelihood" "Observations")) long

esttab fullp1 consp1 fullp2 consp2 fullp3 consp3 using TableS2a.tex, replace label title(Which individual wins?\label{tab:sens2}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated")  stats(ll N, labels("Log Likelihood" "Observations")) long

drop _merge

merge m:1 year class using dynclass

nlogitgen type = pid(Behavioural: 50 | 51 | 79 | 107 | 145 | 165 | 172 | 175 | 195 | 196 | 209 | 254, Development: 16 | 33 | 34 | 82 | 83 | 84 | 121 | 147 | 192 | 202 | 210 | 236 | 238 | 239 | 243 | 249 | 257 | 275 | 280 | 283 | 285 | 289 | 303, Ectrics: 1 | 2 | 7 | 18 | 27 | 45 | 46 | 52 | 53 | 68 | 69 | 88 | 89 | 95 | 101 | 122 | 148 | 153 | 156 | 157 | 164 | 166 | 178 | 179 | 181 | 182 | 186 | 187 | 189 | 217 | 228 | 278 | 291, Equilibrium: 3 | 5 | 6 | 10 | 11 | 21 | 26 | 43 | 126 | 128 | 219 | 222 | 223 | 267 | 270 | 273 | 279 | 298 | 304 | 306 | 313, Finance: 28 | 29 | 30 | 41 | 42 | 72 | 73 | 74 | 90 | 91 | 92 | 106 | 132 | 144 | 170 | 171 | 173 | 211 | 212 | 221 | 232, Games: 35 | 36 | 37 | 56 | 57 | 70 | 71 | 103 | 110 | 112 | 117 | 119 | 134 | 180 | 220 | 226 | 237 | 248 | 302 | 314, Growth: 4 | 17 | 25 | 81 | 96 | 109 | 133 | 160 | 163 | 174 | 177 | 194 | 200 | 201 | 206 | 227 | 247 | 250 | 256 | 262 | 290 | 292 | 293, Information: 20 | 39 | 40 | 47 | 48 | 49 | 59 | 60 | 61 | 77 | 78 | 85 | 86 | 102 | 115 | 125 | 151 | 214 | 235 | 258 | 266 | 299 | 317, Labour: 32 | 76 | 87 | 93 | 105 | 108 | 113 | 114 | 116 | 152 | 154 | 161 | 168 | 197 | 198 | 199 | 205 | 213 | 218 | 269 | 271 | 294 | 300 | 307 | 308 | 309 | 310, Macro: 8 | 9 | 12 | 19 | 23 | 38 | 54 | 55 | 58 | 65 | 66 | 67 | 104 | 120 | 127 | 130 | 131 | 141 | 142 | 143 | 146 | 169 | 208 | 215 | 241 | 242 | 244 | 245 | 259 | 263 | 268 | 277 | 282 | 284 | 286 | 287 | 288 | 297 | 318, Production: 15 | 63 | 75 | 98 | 99 | 138 | 139 | 159 | 162 | 176 | 183 | 184 | 185 | 193 | 230 | 231 | 240 | 251 | 272 | 296 | 301 | 315 | 316, Public: 22 | 24 | 31 | 100 | 111 | 124 | 135 | 149 | 150 | 155 | 158 | 225 | 252 | 253 | 255 | 265 | 276 | 281 | 305 | 311 | 312, Resources: 64 | 80 | 94 | 97 | 140 | 188 | 203 | 204 | 216 | 261, Trade: 13 | 14 | 44 | 62 | 118 | 123 | 129 | 136 | 137 | 167 | 190 | 191 | 207 | 224 | 229 | 233 | 234 | 246 | 260 | 264 | 274 | 295)

nlogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted || type: number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 || pid: , case(pid)
 
logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 if select == 1

est store fullincl

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames InclFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted number bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size1 if select == 1

est store consincl

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames InclCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 [pweight = prob]

est store fullwght

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames WeightFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1 [pweight = prob]

est store conswght

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames WeightCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted IMR if select == 1

est store fullimr

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames IMRFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): logit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted IMR if select == 1

est store consimr

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames IMRCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

clogit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1, group(field)

est store fullcond

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)
lincom `m_coauth'*coauthnobel + `m_agediff'*agediff

global rownames "$rownames CondFull"

matrix Results[$row,1] = _b[desch]
matrix Results[$row,2] = _se[desch]
matrix Results[$row,3] = _b[coauthnobel]
matrix Results[$row,4] = _se[coauthnobel]
matrix Results[$row,5] = _b[agediff]
matrix Results[$row,6] = _se[agediff]
matrix Results[$row,7] = r(estimate)
matrix Results[$row,8] = r(se)

global row = $row + 1

stepwise, pr(0.1): clogit award npubs gender age agesq attractiveness maxcite totcite h i100 i1000 top5 anch desch siblings nobelstudy nobelwork family nobelfam ednobel coauthnobel agediff affinity thwarted if select == 1, group(field)

est store conscond

summarize coauthnobel if e(sample), meanonly
local m_coauth = r(mean)
summarize agediff if e(sample), meanonly
local m_agediff = r(mean)

capture scalar tmp = _b[coauthnobel]
local has_coauth = (_rc == 0)
capture scalar tmp = _b[agediff]
local has_agediff = (_rc == 0)
local lin_est = .
local lin_se  = .
if `has_coauth' & `has_agediff' {
    lincom `m_coauth'*coauthnobel + ///
           `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_coauth' {
    lincom `m_coauth'*coauthnobel

    local lin_est = r(estimate)
    local lin_se  = r(se)
}
else if `has_agediff' {
    lincom `m_agediff'*agediff

    local lin_est = r(estimate)
    local lin_se  = r(se)
}

global rownames "$rownames CondCons"

local b_desch = .
capture local b_desch = _b[desch]
local se_desch = .
capture local se_desch = _se[desch]
local b_coauth = .
capture local b_coauth = _b[coauthnobel]
local se_coauth = .
capture local se_coauth = _se[coauthnobel]
local b_agediff = .
capture local b_agediff = _b[agediff]
local se_agediff = .
capture local se_agediff = _se[agediff]

matrix Results[$row,1] = `b_desch'
matrix Results[$row,2] = `se_desch'
matrix Results[$row,3] = `b_coauth'
matrix Results[$row,4] = `se_coauth'
matrix Results[$row,5] = `b_agediff'
matrix Results[$row,6] = `se_agediff'
matrix Results[$row,7] = `lin_est'
matrix Results[$row,8] = `lin_se'

global row = $row + 1

esttab fullimr consimr fullwght conswght fullipw consipw fullincl consincl fullcond conscond using TableS3.tex, replace label title(Which individual wins?\label{tab:sens3}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated")  stats(ll N, labels("Log Likelihood" "Observations")) long

matrix rownames Results = $rownames
putexcel set results.xlsx, replace
putexcel A1 = matrix(Results), names

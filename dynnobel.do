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
label var totcite "Number of citations, total"
label var h "Hirsch number"
label var i100 "Number of papers cited 100 times or more"
label var i1000 "Number of papers cited 1000 times or more"
label var anch "Proximity to Nobelists among professors"
label var desch "Proximity to Nobelists among students"
label var siblings "Proximity to Nobelists, co-students (professor)"
label var nobelstudy "Proximity to Nobelists, co-students (alma mater)"
label var nobelwork "Proximity to Nobelists, co-workers"
label var nobelfam "Proximity to Nobelists, family"
label var ednobel "Proximity to Nobelists, co-editors"
label var coauthnobel "Proximity to Nobelists, co-authors"
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

*awards
logit award fesage nofes if select == 1
logit award nofes nowalker noclarivate nobbva nosoderstrom noyrjo if select == 1

*personal characteristics
logit award year gender age agesq i.origin i.faith i.race if select == 1

logit award year gender age agesq if select == 1

logit award year gender i.origin i.faith i.race attractiveness if select == 1

logit award year gender attractiveness if select == 1

logit award year gender age agesq attractiveness if select == 1

*citations
logit award year maxcite totcite h i100 i1000 if select == 1

*field
logit award year i.jel if select == 1
logit award year i.broad if select == 1 

*education
logit award year i.alma i.highest if select == 1 

*class mates
logit award year study nobelstudy if select == 1
logit award year i.workplace if select == 1

*work mates
logit award year work nobelwork if select == 1

*journal mates
logit award year editor ednobel if select == 1

*paper mates
logit award year coauthcentr coauthnobel if select == 1

*committee
logit award year affinity affclass if select == 1

*family and friends
logit award year family nobelfam if select == 1

*genealogy
logit award year anch desch siblings if select == 1

*all together now
logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted prob if select == 1

est store full

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclor thwarted prob if select == 1

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted prob if select == 1

predict outlier

est store cons

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel agediff affclass thwarted prob if select == 1


logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted if select == 1

est store fullno

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted if select == 1

est store consno

* alternative to stepwise, cross-validation for model selection
elasticnet logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1

* reveal which variables are included
lassocoef

* run and store
logit award age h anch desch coauthnobel prob if select == 1
est store lasso

* 2nd alternative, BIC for model selection
elasticnet logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1, sel(bic)

* reveal which variables are included
lassocoef

logit award age h i100 desch coauthnobel prob if select == 1
est store lasso2

esttab cons lasso lasso2 using TableS4.tex, replace label title(Which individual wins?\label{tab:lasso}) nonumbers mtitles("Stepwise" "Lasso (CV)" "Lasso (BIC)") long

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 & infield == 1

est store fullin

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 & infield == 1

est store consin

esttab full cons fullno consno fullin consin using TableI.tex, replace label title(Which individual wins?\label{tab:person}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated") long

esttab cons consno consin using TableItalk.tex, replace label noconstant title(Which individual wins?\label{tab:person}) nonumbers mtitles("Field" "None" "Within")

forvalues b = 1/14 {
	display "Running regression for field = `b'"
	if inlist(`b', 6, 12) continue
	logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 & broad == `b'
}

pca maxcite totcite h i100 i1000
predict pcacit1 pcacit2, score

stepwise, pr(0.1): logit award year gender age agesq attractiveness pcacit1 pcacit2 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1

stepwise, pr(0.1): logit award year gender age agesq attractiveness pcacit1 pcacit2 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 & infield == 1

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

gen Norway = (country=="Norway")
gen Russia = (country=="Russia")
gen Lucia = (country=="St Lucia")

gen Christian = (religion == "Christian")
gen Hindu = (religion == "Hindu")
gen Jewish = (religion == "Jewish")

gen Clifton = (school == "Clifton C")
gen Kharkiv = (school == "Kharkiv")
gen Leningrad = (school == "Leningrad")
gen Oslo = (school == "Oslo")
gen Rutgers = (school == "Rutgers")

gen CMU = (location == "CMU")
gen GeorgeMason = (location == "George Mason")
gen Novosibirsk = (location == "Novosibirsk")
gen Salzburg = (location == "Salzburg")
gen WUStL = (location == "WUStL")
gen Harvard = (location == "Harvard")

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob Norway Russia Lucia Christian Hindu Jewish Clifton Kharkiv Leningrad Oslo Rutgers CMU GeorgeMason Novosibirsk Salzburg WUStL Harvard if select == 1

est store fulld

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob Norway Russia Lucia Christian Hindu Jewish Clifton Kharkiv Leningrad Oslo Rutgers CMU GeorgeMason Novosibirsk Salzburg WUStL Harvard if select == 1

est store consd

xtset pid year 
xtlogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted prob if select == 1

est store fullp

xtlogit award age agesq desch prob if select == 1

est store consp

xtlogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1, fe

xtlogit award anch desch siblings prob if select == 1, fe

esttab fulld consd fullp consp using TableS1.tex, replace label title(Which individual wins?\label{tab:sens1}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated") long

* Define the minimum and maximum indices for a meaningful split
* We exclude the first 10% and last 10% of the sample to ensure
* both sub-periods have sufficient observations (10 observations minimum).
local min_split = 1975
local max_split = 2020

* 2. Initialize Matrix for Storing Results
* Matrix will store: [Split Point, LL_Period1, LL_Period2, Total_LL]
matrix LL_Results = J( (`max_split' - `min_split' + 1), 4, . )
local row_counter = 1

display ""
display "Starting structural break analysis..."
display "Total observations: 57"
display "Possible split points range from: `min_split' to `max_split'"
display ""

* 3. Loop Over All Possible Split Points
* Loop variable 't' represents the time index where the sample is split.
* Period 1: time < t
* Period 2: time >= t
forvalues t = `min_split'/`max_split' {

    * --- Period 1 Estimation (Before the break) ---
stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year < `t'
    * The log-likelihood is stored in the system scalar e(ll)
    local ll1 = e(ll)
    
    * --- Period 2 Estimation (After the break) ---
stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year >= `t'
    local ll2 = e(ll)
    
    * --- Store Results in Matrix ---
    
    * Calculate the total log-likelihood for this split (LL1 + LL2)
    local total_ll = `ll1' + `ll2'
    
    * Store the split point, individual LLs, and total LL in the results matrix
    matrix LL_Results[`row_counter', 1] = `t'
    matrix LL_Results[`row_counter', 2] = `ll1'
    matrix LL_Results[`row_counter', 3] = `ll2'
    matrix LL_Results[`row_counter', 4] = `total_ll'
    
    * Update counter for the next row
    local row_counter = `row_counter' + 1
    
    * Optional: Display progress
    display "Split at t = `t' | LL1 = `ll1' | LL2 = `ll2' | Total LL = `total_ll'"
}

* 4. Final Display and Cleanup
display ""
display "----------------------------------------------------"
display "Final Results Matrix (LL_Results):"
display "----------------------------------------------------"

* Assign column names for clarity
matrix colnames LL_Results = Split_Point LL_Period_1 LL_Period_2 Total_LL

* Use 'matrix list' to view the entire result set
matrix list LL_Results, format(%9.4f)

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1

local lln = e(ll)

display "Whole sample log-likelihood: `lln'"

* Optimal break: 1997

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year < 1997

est store fullearly

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year < 1997

est store consearly

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year >= 1997

est store fulllate

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  prob if select == 1 & year >= 1997

est store conslate

esttab fullearly consearly fulllate conslate using TableS2.tex, replace label title(Which individual wins?\label{tab:sens2}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated") long

drop _merge

merge m:1 year class using dynclass

nlogitgen type = pid(Behavioural: 50 | 51 | 79 | 107 | 145 | 165 | 172 | 175 | 195 | 196 | 209 | 254, Development: 16 | 33 | 34 | 82 | 83 | 84 | 121 | 147 | 192 | 202 | 210 | 236 | 238 | 239 | 243 | 249 | 257 | 275 | 280 | 283 | 285 | 289 | 303, Ectrics: 1 | 2 | 7 | 18 | 27 | 45 | 46 | 52 | 53 | 68 | 69 | 88 | 89 | 95 | 101 | 122 | 148 | 153 | 156 | 157 | 164 | 166 | 178 | 179 | 181 | 182 | 186 | 187 | 189 | 217 | 228 | 278 | 291, Equilibrium: 3 | 5 | 6 | 10 | 11 | 21 | 26 | 43 | 126 | 128 | 219 | 222 | 223 | 267 | 270 | 273 | 279 | 298 | 304 | 306 | 313, Finance: 28 | 29 | 30 | 41 | 42 | 72 | 73 | 74 | 90 | 91 | 92 | 106 | 132 | 144 | 170 | 171 | 173 | 211 | 212 | 221 | 232, Games: 35 | 36 | 37 | 56 | 57 | 70 | 71 | 103 | 110 | 112 | 117 | 119 | 134 | 180 | 220 | 226 | 237 | 248 | 302 | 314, Growth: 4 | 17 | 25 | 81 | 96 | 109 | 133 | 160 | 163 | 174 | 177 | 194 | 200 | 201 | 206 | 227 | 247 | 250 | 256 | 262 | 290 | 292 | 293, Information: 20 | 39 | 40 | 47 | 48 | 49 | 59 | 60 | 61 | 77 | 78 | 85 | 86 | 102 | 115 | 125 | 151 | 214 | 235 | 258 | 266 | 299 | 317, Labour: 32 | 76 | 87 | 93 | 105 | 108 | 113 | 114 | 116 | 152 | 154 | 161 | 168 | 197 | 198 | 199 | 205 | 213 | 218 | 269 | 271 | 294 | 300 | 307 | 308 | 309 | 310, Macro: 8 | 9 | 12 | 19 | 23 | 38 | 54 | 55 | 58 | 65 | 66 | 67 | 104 | 120 | 127 | 130 | 131 | 141 | 142 | 143 | 146 | 169 | 208 | 215 | 241 | 242 | 244 | 245 | 259 | 263 | 268 | 277 | 282 | 284 | 286 | 287 | 288 | 297 | 318, Production: 15 | 63 | 75 | 98 | 99 | 138 | 139 | 159 | 162 | 176 | 183 | 184 | 185 | 193 | 230 | 231 | 240 | 251 | 272 | 296 | 301 | 315 | 316, Public: 22 | 24 | 31 | 100 | 111 | 124 | 135 | 149 | 150 | 155 | 158 | 225 | 252 | 253 | 255 | 265 | 276 | 281 | 305 | 311 | 312, Resources: 64 | 80 | 94 | 97 | 140 | 188 | 203 | 204 | 216 | 261, Trade: 13 | 14 | 44 | 62 | 118 | 123 | 129 | 136 | 137 | 167 | 190 | 191 | 207 | 224 | 229 | 233 | 234 | 246 | 260 | 264 | 274 | 295)

nlogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted || type: number buggins maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 || pid: , case(pid)
 

logit award number year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 if select == 1

est store fullincl

stepwise, pr(0.1): logit award gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted bayeslb maxcitef totcitef proximity cumaward neverwon yearssincewin wonlastyear size5 if select == 1

est store consincl

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 [pweight = prob]

est store fullwght

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  if select == 1 [pweight = prob]

est store conswght

logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  IMR if select == 1

est store fullimr

stepwise, pr(0.1): logit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted  IMR if select == 1

est store consimr

clogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted if select == 1, group(field)

stepwise, pr(0.1): clogit award year gender age agesq attractiveness maxcite totcite h i100 i1000 anch desch siblings nobelstudy nobelwork nobelfam ednobel coauthnobel affclass thwarted if select == 1, group(field)

esttab fullimr consimr fullwght conswght fullincl consincl using TableS3.tex, replace label title(Which individual wins?\label{tab:sens3}) nonumbers mtitles("Full" "Consolidated" "Full" "Consolidated" "Full" "Consolidated") long

// do file for analysis of paper for EPI 207// 

//Cleaning/changing variable types//
gen Binge = 1 if strpos(binge, "yes") > 0 
replace Binge = 0 if strpos(binge,"no") > 0

gen racemax = 1 if strpos(race_ethnic, "reference") > 0
replace racemax = 2 if strpos(race_ethnic, "Black") > 0 
replace racemax = 3 if race_ethnic == "Hispanic"
replace racemax = 4 if strpos(race_ethnic, "Asian") > 0
replace racemax	= 5 if strpos(race_ethnic, "American") > 0
replace racemax	= 6 if strpos(race_ethnic, "Other") > 0

gen Marital = 0 if strpos(marital, "Never") > 0 
replace Marital = 1 if strpos(marital, "reference") > 0
replace Marital = 2 if strpos(marital, "Other") > 0

gen frequency = 0 if strpos(freq_smoke, "Never") > 0
replace frequency = 2 if strpos(freq_smoke, "Daily") > 0
replace frequency = 1 if strpos(freq_smoke, "Someday") > 0

gen eversmoke = 0 if strpos(evcur_smoke, "Never") > 0 
replace eversmoke = 1 if strpos(evcur_smoke, "Ever") > 0
replace eversmoke = 2 if strpos(evcur_smoke, "Current") > 0

gen povlevel = 1 if strpos(poverty_lvl, "199") > 0 
replace povlevel = 2 if strpos(poverty_lvl, "399") > 0
replace povlevel = 3 if strpos(poverty_lvl, "reference") > 0 
replace povlevel = 4 if strpos(poverty_lvl, "400") > 0 

gen education = 1 if strpos(edu_lvl, "High-school degree") > 0
replace education = 4 if strpos(edu_lvl, "College") > 0
replace education = 2 if strpos(edu_lvl, "graduate") > 0
replace education = 3 if strpos(edu_lvl, "Some college") > 0 

gen SPDlevel = 0 if strpos(spd_lvl, "No SPD") > 0
replace SPDlevel = 1 if strpos(spd_lvl, "Acute") > 0 
replace SPDlevel = 2 if strpos(spd_lvl, "Recent") > 0

gen agecatmax = 1 if strpos(age_cat, "25") > 0 
replace agecatmax = 2 if strpos(age_cat, "26") > 0 
replace agecatmax = 3 if strpos(age_cat, "35") > 0
replace agecatmax = 4 if strpos(age_cat, "50") > 0 

//table 2 logistic regressions//

svy : logistic eversmoketotal ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge, cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)

svy : logistic currentsmoker ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge, cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)

//coming up with prevalences & confidence intervals//
// ever smoker
svy: tabulate SPD eversmoketotal if SPD == 0, percent ci
svy: tabulate SPD eversmoketotal if SPD == 1, percent ci
svy: tabulate SPD eversmoketotal if SPD == 2, percent ci
svy: tabulate SPD eversmoketotal, percent ci

// current smoker
svy: tabulate SPD currentsmoker, percent ci
svy: tabulate SPD currentsmoker if SPD == 0, percent ci
svy: tabulate SPD currentsmoker if SPD == 1, percent ci
svy: tabulate SPD currentsmoker if SPD == 2, percent ci

//table 3 logistic regressions//
svy : logistic heavy ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge if currentsmoker==1, cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)

svy : logistic dailysmoke ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge if currentsmoker==1, cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)


//table 4 linear regressions//
svy : reg some_numcig ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge, cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)

svy : reg daily_numcig ib(0).SPDlevel ib(1).agecatmax ib(1).gender ib(1).racemax ib(2).education ib(1).povlevel ib(1).emply_status ib(1).Marital ib(2).bmi_label ib(0).Binge if (currentsmoker==1 & dailysmoke == 1), cformat(%9.2f) pformat(%5.3f) sformat(%8.2f)




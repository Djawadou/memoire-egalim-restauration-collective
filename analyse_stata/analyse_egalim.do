*==============================================================================
* Mémoire de Master EcoDeVa – Université de Montpellier / Institut Agro (2024-2025)
* Restauration collective et loi EGAlim – Communauté de communes de Forez-Est
* Auteur : Djawadou DJOBO
*
* Objet : préparation des variables, tests du Chi² et régressions logistiques
*         (logit et logit pénalisé de Firth) pour tester les hypothèses H1, H2, H3.
*
* Données : enquête par questionnaire auprès de 49 structures de restauration
*           collective. Les données sont confidentielles et ne sont pas publiées.
* Prérequis : commande firthlogit  (ssc install firthlogit)
*             commande outreg2     (ssc install outreg2)
*==============================================================================

clear all 
* Indiquer ici le dossier contenant les données (non publiées)
* cd "chemin/vers/les/donnees"
import excel "Master22.xlsx", sheet("CCFE") firstrow


*DIFFICULTE D'APPROVIONNEMENT EN BIO ET LOCAUX (Y3)

drop Avezvousunerestaurationcolle Enmoyennecombienderepasser Silerepasestcuisinéparlas Leprestatairelutteilcontrel Quellessontlesactionsmisese

split dif_locaux_bio_label, parse("\") generate(dif_loc_bio_lab_)
gen n_diff = 0
replace n_diff = n_diff + 1 if !missing(dif_loc_bio_lab_1) & dif_loc_bio_lab_1 != ""
replace n_diff = n_diff + 1 if !missing(dif_loc_bio_lab_2) & dif_loc_bio_lab_2 != ""
replace n_diff = n_diff + 1 if !missing(dif_loc_bio_lab_3) & dif_loc_bio_lab_3 != ""
replace n_diff = n_diff + 1 if !missing(dif_loc_bio_lab_4) & dif_loc_bio_lab_4 != ""
gen diff_2plus = n_diff >= 2
label define diff_2plus_lbl 0 "0/1 difficulte" 1 "Plus_de_2_difficultes"
label values diff_2plus diff_2plus_lbl
*lable variable 
label variable diff_2plus "Principales difficultés pr trouver des produits locaux_bio_lab ? "
tab diff_2plus

drop dif_loc_bio_lab_1 dif_loc_bio_lab_2 dif_loc_bio_lab_3 dif_loc_bio_lab_4
drop dif_locaux_bio_label n_diff


*MISE EN PLACE DES OBJECTIFS EGALIM (Y2)

split eg_obj, parse("\") generate(deg_obj_)


gen n_eg = 0
replace n_eg = n_eg + 1 if !missing(deg_obj_1) & deg_obj_1 != ""
replace n_eg = n_eg + 1 if !missing(deg_obj_2) & deg_obj_2 != ""
replace n_eg = n_eg + 1 if !missing(deg_obj_3) & deg_obj_3 != ""
replace n_eg = n_eg + 1 if !missing(deg_obj_4) & deg_obj_4 != ""

gen nb_obj_2plus = n_eg >= 2

label define nb_obj_2plus_lbl 0 "0/1 objectif" 1 "Plus_de_2_objectifs"
label values nb_obj_2plus nb_obj_2plus_lbl

*lable variable 
label variable nb_obj_2plus " objectifs loi egaalim mise en oeuvre  "
tab nb_obj_2plus

drop deg_obj_1 deg_obj_2 deg_obj_3 deg_obj_4 
drop eg_obj n_eg

*CRITERES DE SELECTION DES FOURNISSEURS

split crit_selec_fourn, parse("\") generate(crit_sel_four_)


gen n_crit_sel = 0
replace n_crit_sel = n_crit_sel + 1 if !missing(crit_sel_four_1) & crit_sel_four_1 != ""
replace n_crit_sel = n_crit_sel + 1 if !missing(crit_sel_four_2) & crit_sel_four_2 != ""
replace n_crit_sel = n_crit_sel + 1 if !missing(crit_sel_four_3) & crit_sel_four_3 != ""
replace n_crit_sel = n_crit_sel + 1 if !missing(crit_sel_four_4) & crit_sel_four_4 != ""
replace n_crit_sel = n_crit_sel + 1 if !missing(crit_sel_four_5) & crit_sel_four_5 != ""
gen crit_sel_four_2plus = n_crit_sel >= 2

label define crit_sel_four_2plus_lbl 0 "0/1 critère" 1 "Plus_de_2_critères"
label values crit_sel_four_2plus crit_sel_four_2plus_lbl
*lable variable 
label variable crit_sel_four_2plus "critères de sélection des fournisseurs"
tab crit_sel_four_2plus

drop crit_sel_four_1 crit_sel_four_2 crit_sel_four_3 crit_sel_four_4 crit_sel_four_5
drop crit_selec_fourn n_crit_sel


* TYPES DE STRUTURE

*lable variable 
label variable typ_struct "Type de structure de restauration"
*encoder les variable type  de structure de restauration	
*notes typ_struct : Codage = 1: scolaire, 2: ehpad/maison de retraite, 3: autre
gen typ_struct_num = .
replace typ_struct_num = 1 if typ_struct == "scol"
replace typ_struct_num = 2 if typ_struct == "ehpad"
replace typ_struct_num = 3 if typ_struct == "Autre"
label define typ_struct_lbl ///
    1 "scol" ///
    2 "EHPAD" ///
    3 "autre"
drop typ_struct
	
*Associer le label a la variable
label values typ_struct_num typ_struct_lbl
*lable variable 
label variable typ_struct_num "Type de structure de restauration"
tab typ_struct_num


gen type_ehpad = 0
replace type_ehpad = 1 if typ_struct_num == 2

gen type_autre = 0
replace type_autre = 1 if typ_struct_num == 3

label variable type_ehpad "Structure = EHPAD"
label variable type_autre "Structure = Autre"


*MISE EN PLACE DU GASPILAGE ALIMENTAIRE(Y1)

rename disp_gasp disp_gasp_num
* Créer la variable
gen disp_gasp = .

* Affecter les valeurs selon ton codage
replace disp_gasp = 1 if disp_gasp_num == "Oui"
replace disp_gasp = 0 if disp_gasp_num == "Non"
drop disp_gasp_num

* Définir le label
label define disp_gasp_lbl 0 "Non" 1 "Oui"
* Appliquer le label
label values disp_gasp disp_gasp_lbl
*lable variable 
label variable disp_gasp "Dispositifs visant à réduire le gaspillage alimentaire ?"
tab disp_gasp


*STATUT JURIDIQUE DES STRUCTURES

rename statut_etab statut_etab_num
* Créer la variable
gen statut_etab = .

* Affecter les valeurs selon ton codage
replace statut_etab = 1 if statut_etab_num == "Public"
replace statut_etab = 2 if statut_etab_num == "Privé"
drop statut_etab_num
* Définir le label
label define statut_etab_lbl ///
  1 "Public" ///
  2 "Privé"
* Appliquer le label
label values statut_etab statut_etab_lbl
*lable variable 
label variable statut_etab "Statut de votre établissement"
tab statut_etab

/* Transformer la variable texte en variable numérique avec labels directement
encode statut_etab_num,gen(statut_etab) label(statut_etab_lbl)
tab statut_etab*/


*NOMBRE DE RPAS JOURNALIERE (X3)

*Générer une variable 
gen nb_repas_num = .

* Attribuer un code en fonction de la modalité texte
replace nb_repas_num = 1 if nb_repas == "Moins de 30"
replace nb_repas_num = 2 if nb_repas == "31 à 50"
replace nb_repas_num = 3 if nb_repas == "51 à 100"
replace nb_repas_num = 4 if nb_repas == "plus de 100"
drop nb_repas

* Définir et appliquer les labels pour rendre la lecture plus claire
label define nb_repas_num_lbl ///
    1 "Moins de 30" ///
    2 "31 à 50"    ///
    3 "51 à 100"   ///
    4 "plus de 100"
label values nb_repas_num nb_repas_num_lbl
tab nb_repas_num
*lable variable 
label variable nb_repas_num "Nombre de repas servis par jour "

gen volrepas_30_50 = 0
replace volrepas_30_50 = 1 if nb_repas_num == 2

gen volrepas_51_100 = 0
replace volrepas_51_100 = 1 if nb_repas_num == 3

gen volrepas_100plus = 0
replace volrepas_100plus = 1 if nb_repas_num == 4

label variable volrepas_30_50 "Volume de repas : 30 à 50"
label variable volrepas_51_100 "Volume de repas : 51 à 100"
label variable volrepas_100plus "Volume de repas : plus de 100"


*MODE DE GESTION OU DE PREPARATION DE REPAS (X1)

*Qui prepare le repas 
gen prep_repas_num = .
replace prep_repas_num = 1 if prep_repas == "interne"
replace prep_repas_num = 2 if prep_repas == "prest_ext"
replace prep_repas_num = 3 if prep_repas == "livrer"
drop prep_repas

label define prep_repas_lbl ///
    1 "interne" ///
    2 "prest_ext" ///
    3 "livrer"
label values prep_repas_num prep_repas_lbl
tab prep_repas_num
*lable variable 
label variable prep_repas_num "qui prépare les repas ? "
tab prep_repas_num


*CONNNAISSANCE DE LA LOI EGALIM (X2)

* Créer la variable
gen connaiss_egalim_num = .

* Affecter les valeurs selon ton codage
replace connaiss_egalim_num = 1 if connaiss_egalim == "Oui"
replace connaiss_egalim_num = 0 if connaiss_egalim == "Non"
drop connaiss_egalim
* Définir le label
label define connaiss_egalim_num_lbl  1 "Oui" 0 "Non" 
* Appliquer le label
label values connaiss_egalim_num  connaiss_egalim_num_lbl
tab connaiss_egalim_num
*lable variable 
label variable connaiss_egalim_num "Connaissance des principales obligations de la loi EGalim"



*CONNNAISSANCE DU SITE OFFICIEL MACANTINE

 *Créer la variable
gen connais_macantine_num = .

* Affecter les valeurs selon ton codage
replace connais_macantine_num = 1 if connais_macantine == "Oui"
replace connais_macantine_num = 0 if connais_macantine == "Non"
drop connais_macantine
* Définir le label
label define connais_macantine_num_lbl  1 "Oui" 0 "Non" 
* Appliquer le label
label values connais_macantine_num  connais_macantine_num_lbl
tab connais_macantine_num
*lable variable 
label variable connais_macantine_num "Connaissance du site MaCantine.gouv.fr "

/*
*TEST PREALABLE

tab disp_gasp prep_repas_num chi2 expected /* ou tab mode_gestion action_gaspillage, exact
tab type_structure connaissance_egalim, chi2 expectedtab_chi disp_gasp prep_repas_num
tab_chi disp_gasp prep_repas_num*/
*/
*regrouper la variable mode_de gestion en deux categorie
gen prep_simple = .
replace prep_simple = 1 if prep_repas_num == 1 // Interne
replace prep_simple = 0 if inlist(prep_repas_num, 2, 3) // Externe

label define prep 1 "Interne" 0 "Externe"
label values prep_simple prep

tab disp_gasp prep_simple, chi2

tab disp_gasp type_ehpad, chi2
tab disp_gasp type_autre, chi2

tab disp_gasp volrepas_30_50, chi2
tab disp_gasp volrepas_51_100, chi2
tab disp_gasp volrepas_100plus, chi2


reg disp_gasp prep_simple statut_etab type_ehpad type_autre
vif


tab nb_obj_2plus connaiss_egalim_num, chi2
tab nb_obj_2plus statut_etab, chi2
tab nb_obj_2plus volrepas_30_50, chi2
tab nb_obj_2plus volrepas_51_100, chi2
tab nb_obj_2plus volrepas_100plus, chi2
tab nb_obj_2plus nb_repas_num, chi2
tab nb_obj_2plus connais_macantine_num, chi2
tab nb_obj_2plus crit_sel_four_2plus, chi2
tab nb_obj_2plus

tab nb_obj_2plus disp_gasp, chi2

tab2 nb_obj_2plus connais_macantine_num, expected
tab2 nb_obj_2plus connaiss_egalim_num, expected

tab nb_obj_2plus diff_2plus, chi2

reg nb_obj_2plus connaiss_egalim_num connais_macantine_num
vif

pwcorr connaiss_egalim_num connais_macantine_num, sig


tab diff_2plus

tab diff_2plus nb_repas_num, chi2
tab diff_2plus crit_sel_four_2plus, chi2

tab volrepas_30_50
tab volrepas_51_100
tab volrepas_100plus
tab diff_2plus volrepas_30_50, chi2
tab diff_2plus volrepas_51_100, chi2
tab diff_2plus volrepas_100plus, chi2

tab diff_2plus prep_simple,chi2

logit disp_gasp prep_simple statut_etab type_ehpad type_autre, or
firthlogit disp_gasp prep_simple statut_etab type_ehpad type_autre, or

logit nb_obj_2plus connaiss_egalim_num connais_macantine_num , or
firthlogit nb_obj_2plus connaiss_egalim_num connais_macantine_num , or

logit diff_2plus volrepas_30_50 volrepas_51_100 volrepas_100plus crit_sel_four_2plus prep_simple, or
firthlogit diff_2plus volrepas_30_50 volrepas_51_100 volrepas_100plus crit_sel_four_2plus prep_simple

/*

logit disp_gasp prep_simple statut_etab type_ehpad type_autre, or
firthlogit disp_gasp prep_simple statut_etab type_ehpad type_autre, or
logit disp_gasp prep_simple statut_etab type_ehpad type_autre, or
outreg2 using resultat.doc, replace ctitle("Logit - Odds Ratios") dec(3)
logit disp_gasp prep_simple statut_etab type_ehpad type_autre, or
outreg2 using resultat.doc, replace dec(3) ctitle("Logit - OR") ///
addstat(Observations, e(N)) pvalue ci
logit nb_obj_2plus connaiss_egalim_num connais_macantine_num , or
firthlogit nb_obj_2plus connaiss_egalim_num connais_macantine_num , or
logit diff_2plus volrepas_30_50 volrepas_51_100 volrepas_100plus crit_sel_four_2plus prep_simple, or
firthlogit diff_2plus volrepas_30_50 volrepas_51_100 volrepas_100plus crit_sel_four_2plus prep_simple

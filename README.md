# Restauration collective et loi EGAlim – Diagnostic et analyse économétrique (Forez-Est)

**Mémoire de Master Économie du développement agricole, de l'environnement et de l'alimentation (EcoDeVa)**  
Université de Montpellier · Institut Agro Montpellier · 2024-2025  
Stage réalisé à la **Communauté de communes de Forez-Est (CCFE)**, dans le cadre de son Projet Alimentaire Territorial (PAT)

📄 [**Lire le mémoire (PDF)**](documents/Memoire_Restauration_Collective_EGAlim_Forez-Est_DJOBO.pdf) · 🎤 [**Voir la présentation de soutenance (PDF)**](documents/Soutenance_Memoire_DJOBO.pdf) · 💻 [**Code d'analyse Stata**](analyse_stata/analyse_egalim.do)

---

## Contexte

Les **Projets Alimentaires Territoriaux (PAT)** encouragent les collectivités à relocaliser l'alimentation, à soutenir les filières locales et à améliorer la qualité des repas servis. La **restauration collective** (écoles, crèches, EHPAD…) en est un levier majeur, encadré par la **loi EGAlim** : produits durables et biologiques, menu végétarien, lutte contre le gaspillage alimentaire.

**Question centrale :** comment les collectivités locales peuvent-elles mobiliser la restauration collective pour une alimentation accessible, saine et respectueuse de l'environnement ?

---

## Démarche

| Étape | Contenu |
|---|---|
| **Collecte** | Questionnaire administré en ligne, avec relances par e-mail et par téléphone, auprès de **122 structures** de restauration collective du territoire. **49 répondants**, soit un taux de réponse d'environ 40 %. |
| **Diagnostic descriptif** | Modes de gestion, approvisionnement en produits locaux et labellisés, gaspillage alimentaire, connaissance de la loi EGAlim et de la plateforme *ma-cantine*. Traitement sous Excel. |
| **Analyse explicative** | Tests du Chi², puis **régressions logistiques** et **logit pénalisé de Firth** (adapté aux petits échantillons), avec résultats exprimés en **odds ratios**. Traitement sous **Stata**. |
| **Recommandations** | Pistes d'action pour le PAT de Forez-Est. |

---

## Hypothèses et résultats

| Hypothèse | Variable étudiée | Résultat principal | Conclusion |
|---|---|---|---|
| **H1** – Les structures qui cuisinent elles-mêmes mènent plus d'actions anti-gaspillage | Actions de lutte contre le gaspillage | Préparation sur place : **OR = 7,03** (p = 0,019) | ✅ Validée |
| **H2** – La connaissance de la loi EGAlim favorise sa mise en œuvre | Mise en œuvre des objectifs EGAlim | Connaissance de la loi : OR = 3,70 (p = 0,087) | ❌ Non confirmée (tendance positive non significative) |
| **H3** – Un volume de repas élevé accroît les difficultés d'approvisionnement en bio/local | Difficultés d'approvisionnement | Volume de repas : non significatif. Mode de préparation : **OR = 29,3** (p = 0,002) | ⚠️ Partiellement confirmée : l'organisation interne compte plus que le volume |

**À retenir :** le **mode de préparation des repas** est le facteur déterminant. Les structures qui cuisinent sur place mènent plus d'actions anti-gaspillage, et sont aussi plus exposées aux difficultés d'approvisionnement en produits locaux et labellisés.

---

## Pistes d'action proposées

- **Faciliter l'identification des producteurs locaux** (annuaire, mise en relation producteurs / structures)
- **Accompagner les achats durables** (modèles de cahiers des charges, ateliers pratiques)
- **Renforcer les formations anti-gaspillage** et le suivi après formation
- **Valoriser les initiatives locales** des structures engagées

---

## Limites

Échantillon réduit (49 structures), données déclaratives, et faibles effectifs dans certaines modalités. Ce dernier point a justifié le recours à la correction de Firth.

---

## Contenu du dépôt

```text
memoire-egalim-restauration-collective/
├── documents/
│   ├── Memoire_Restauration_Collective_EGAlim_Forez-Est_DJOBO.pdf   # Mémoire complet
│   └── Soutenance_Memoire_DJOBO.pdf                                # Présentation de soutenance
├── analyse_stata/
│   └── analyse_egalim.do      # Préparation des variables, tests du Chi², logit et Firth
└── README.md
```

> 🔒 **Données confidentielles** : les réponses individuelles des structures enquêtées ne sont pas publiées.

---

## Compétences mobilisées

- **Économie** : politiques alimentaires territoriales, économie de l'alimentation durable, évaluation de politique publique
- **Méthodes** : conception de questionnaire, enquête de terrain, statistique descriptive, tests du Chi², régression logistique, logit de Firth
- **Outils** : Stata · Excel

---

**Auteur :** Djawadou DJOBO · [Profil GitHub](https://github.com/Djawadou)  
**Encadrement :** Marion Tillet (chargée de PAT, CCFE) · Grichka Levy (directeur du Développement durable, CCFE) · Adrien Nguyen-Huu (tuteur universitaire)

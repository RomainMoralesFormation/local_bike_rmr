{% docs mrt_production__dim_products %}
Cette dimension regroupe l'ensemble des vélos vendus par Local Bike. Elle enrichit le catalogue avec des informations sur les marques, les catégories ainsi que deux segmentations stratégiques :
- **product_market** : Identifie l'usage du vélo (Quotidien/Urbain vs Aventure/Outdoor).
- **price_segment** : Segmente la gamme de prix (Elite Range, High end, Mid-range, Entry Level) basée sur des percentiles.
{% enddocs %}

{% docs mrt_production__stock_in_stores %}
Cette table de faits opérationnelle présente l'état des stocks actuels par produit et par magasin physique (Santa Cruz, Baldwin, Rowlett). Elle inclut un statut d'alerte (`stock_status`) permettant d'anticiper les ruptures et de piloter les flux logistiques inter-magasins.
{% enddocs %}

{% docs mrt_sales__dim_customers %}
Cette dimension client consolide le comportement d'achat de chaque utilisateur (valeur vie client ou LTV, nombre d'articles, récurrence, etc.). Elle fournit des indicateurs RFM de base comme le nombre de jours écoulés depuis le dernier achat et l'éligibilité aux remises pour faciliter les segmentations marketing dans Looker.
{% enddocs %}

{% docs mrt_sales__fct_order_details %}
Il s'agit de la table de faits centrale des ventes de Local Bike à la maille ligne d'article. Elle réunit les clés de toutes les dimensions périphériques (Produits, Clients, Magasins, Équipes) et contient les métriques financières critiques (Revenu brut, montant des remises accordées, revenu net).
{% enddocs %}

{% docs mrt_sales__staffs_and_managers %}
Cette dimension modélise l'organisation interne et la force de vente de Local Bike. Grâce à l'aplatissement de la relation hiérarchique (Manager / Collaborateur), elle facilite l'analyse de la performance des équipes et l'attribution des ventes par responsable de boutique.
{% enddocs %}
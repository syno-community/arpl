# Chargeur Redpill automatisé

[[English](./README.md)]

[[中文说明](./README-Zh.md)]

Ce projet particulier a été créé pour faciliter mes tests avec Redpill et j'ai décidé de le partager avec d'autres utilisateurs.

Je suis brésilien et mon anglais n'est pas bon, donc je m'excuse pour mes traductions.

J'ai essayé de rendre le système aussi convivial que possible, pour rendre la vie plus facile. Le chargeur détecte automatiquement quel périphérique est utilisé, SATADoM ou USB, en détectant correctement son VID et son PID. redpill-lkm a été modifié pour permettre de démarrer le noyau sans définir les variables liées aux interfaces réseau afin que le chargeur (ou l'utilisateur) n'ait pas à s'en soucier. Le code Jun qui crée le patch zImage et Ramdisk est intégré, s'il y a un changement dans "zImage" ou "rd.gz" par une petite mise à jour, le chargeur réapplique les patchs. Les modules de noyau les plus importants sont intégrés à l'image du disque virtuel DSM pour la détection automatique des périphériques.

[Fabio Belavenuto](https://github.com/fbelavenuto)

Merci à toi Fabio pour tout ton travail !

# Considérations importantes

- Certains utilisateurs ont connu un temps de démarrage excessivement long. Dans ce cas, il est fortement recommandé d'utiliser un SSD pour le chargeur dans le cas de l'option via DoM ou un lecteur flash USB rapide ;

- Vous devez disposer d'au moins 4 Go de RAM, à la fois en baremetal et en VM ;

- Le noyau DSM est compatible avec les ports SATA, pas SAS/SCSI/etc. Pour les modèles d'arborescence de périphériques, seuls les ports SATA fonctionnent. Pour les autres modèles, un autre type de disques peut fonctionner ;

- Il est possible d'utiliser des cartes HBA, cependant les numéros SMART et de série ne fonctionnent que sur les modèles DS3615xs, DS3617xs et DS3622xs+.

# Utiliser

## Général

Pour utiliser ce projet, téléchargez la dernière image disponible et transférez-la sur une clé USB (avec par exemple [Rufus](https://rufus.ie/fr/) ) ou un disque SATA sur module. Configurez le PC pour qu'il démarre à partir du support créé et suivez les informations à l'écran.

Le chargeur augmentera automatiquement la taille de la dernière partition et utilisera cet espace comme cache s'il est supérieur à 2 Go.

## Accéder au chargeur

### Par borne

Appelez la commande "menu.sh" depuis l'ordinateur lui-même.

### Via Votre navigateur préféré

Depuis une autre machine dans le même réseau, tapez l'adresse fournie à l'écran `http://[IP]` dans le navigateur.

### Via ssh

Depuis une autre machine sur le même réseau, utilisez un client ssh, le nom d'utilisateur `root` et le mot de passe `rp`

## Utilisation du chargeur

Le système de menus est dynamique et j'espère qu'il est suffisamment intuitif pour que l'utilisateur puisse l'utiliser sans aucun problème.

Il n'est pas nécessaire de configurer le VID/PID (si vous utilisez une clé USB) ou de définir les adresses MAC des interfaces réseau. Si l'utilisateur veut modifier l'adresse MAC de n'importe quelle interface, utilise le menu "Change MAC" dans "cmdline".

Si un modèle est choisi qui utilise le système Device-tree pour définir les HD, il n'est pas nécessaire de configurer quoi que ce soit. Dans le cas des modèles qui n'utilisent pas l'arborescence des périphériques, les configurations doivent être effectuées manuellement et pour cela, il existe une option dans le menu "cmdline" pour afficher les contrôleurs SATA, les ports DUMMY et les ports utilisés, pour aider à la création de "SataPortMap", "DiskIdxMap" et "sata_remap" si nécessaire.

Un autre point important est que le loader détecte si le CPU possède ou non l'instruction MOVBE et n'affiche pas les modèles qui en ont besoin. Ainsi, si les modèles DS918+ et DVA3221 ne sont pas affichés, c'est à cause du manque de support du CPU pour les instructions MOVBE. Vous pouvez désactiver cette restriction et tester à vos risques et périls.

J'ai développé un patch simple pour ne plus afficher l'erreur de port DUMMY sur les modèles sans device-tree, l'utilisateur pourra l'installer sans avoir à s'en soucier.

## Guide de démarrage rapide

Après le démarrage du chargeur, l'écran suivant devrait apparaître. Tapez menu.sh et appuyez sur `<ENTER>` :

![](doc/premier-ecran.png)

Si vous préférez, vous pouvez y accéder via le Web :

![](doc/ttyd.png)

Sélectionnez l'option "modèle" et choisissez le modèle que vous préférez :

![](doc/model.png)

Sélectionnez l'option "Buildnumber" et choisissez la première option :

![](doc/buildnumber.png)

Allez dans le menu "Série" et choisissez "Générer un numéro de série aléatoire".

Sélectionnez l'option "Build" et attendez que le loader soit généré :

![](doc/making.png)

Sélectionnez l'option "Boot" et attendez que le DSM démarre :

![](doc/DSM%20boot.png)

Le noyau DSM n'affiche pas de messages à l'écran, il est donc nécessaire de poursuivre le processus de configuration de DSM via le navigateur en accédant à l'adresse `http://<ip>`.

Il existe plusieurs didacticiels sur la façon de configurer DSM sur Internet, qui ne seront pas couverts ici.

# Tutoriels

Un utilisateur ARPL (Rikkie) a créé un tutoriel pour installer ARPL sur un serveur proxmox :
https://hotstuff.asia/2023/01/03/xpenology-with-arpl-on-proxmox-the-easy-way/

# Problèmes/questions/etc

Veuillez effectuer une recherche sur les forums à l'adresse https://xpenology.com/forum si votre question/problème a été discuté et résolu. Si vous ne trouvez pas de solution, utilisez les problèmes de github.

# Merci

Tout le code d'origine est basé sur le travail de Kiler129, TTG, pocopico, jumkey et d'autres personnes impliquées dans la poursuite du projet original redpill-load de TTG.

Plus d'informations seront ajoutées à l'avenir.

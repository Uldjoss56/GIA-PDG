import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/components/notification/notification_page.dart';
import 'package:gia_pdg_partenaire/ui/partner_ui/home/partner_home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/distributeur_officiel/distributeur_off_detail.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/home/pdg_home.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/messaging_ui/chat_list.dart';
import 'package:gia_pdg_partenaire/components/profil/user_profil.dart';

const staticPath = "assets/img/africa_flag/";

List<Map<String, dynamic>> registrationData = [
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/user.png",
    "hintText": "nom complet",
  },
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/email.png",
    "hintText": "email",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "mot de passe",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "confirmer le mot de passe",
  }
];

List<Map<String, dynamic>> loginData = [
  {
    "isPassword": false,
    "prefixPath": "assets/img/icons/email.png",
    "hintText": "email",
  },
  {
    "isPassword": true,
    "prefixPath": "assets/img/icons/padlock.png",
    "hintText": "mot de passe",
  },
];

List<String> homeHeaderDatas = [
  "Distributeurs pays",
];

List<Map<String, dynamic>> otherServiceData = [
  {
    "imgPath": "assets/img/electronic_objects.jpeg",
    "title": " FABRICATION DES APPAREILS ELECTROMENAGERS",
  },
  {
    "imgPath": "assets/img/navigation_fluviale.png",
    "title": "TRANSPORT FLUVIAL DE LUXE",
  },
];

List<Map<String, dynamic>> giaData = [
  {
    "imgPath": "assets/img/electronic_objects.jpeg",
    "title": " FABRICATION DES APPAREILS ELECTROMENAGERS",
  },
  {
    "imgPath": "assets/img/navigation_fluviale.png",
    "title": "TRANSPORT FLUVIAL DE LUXE",
  },
];

List<Map<String, dynamic>> commandeData = [
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "40000",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
  {
    "imgPath": "assets/img/icons/credit-card_white.png",
    "numCmd": "0816PM-18012024-00001",
    "cusummerID": "0001",
    "dateCmd": "20-02-2024",
    "dateReception": "20-02-2024",
    "nbreDMA": "2",
    "prixUnitaire": "20000",
    "prixVente": "",
    "devise": "XOF",
    "pourcentageReduction": "0",
    "adressReception":
        "Sikècodji, rue 456, allée 82, maison 201 Cotonou, Bénin",
  },
];

List<Map<String, dynamic>> notificationData = [
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": null,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": null,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": false,
  },
  {
    "imgPath": "assets/img/icons/renewable.png",
    "title": "Expiration de DMA",
    "content": "La date d'expiration de votre DMATelephone est le"
        " 02-12-2026. Veuillez renouveller le maintenant",
    "date": "10-11-2026, 12:21",
    "alreadyReady": true,
  },
];

Map<String, dynamic> userData = {
  "imgCoverPath": "assets/img/background02.jpg",
  "profilImage": "assets/img/user_image.jpg",
  "fullname": "DJOSSOU Ulrich",
  "email": "uldjoss56@gmail.com",
  "birthday": "20-07-2004",
  "gender": "Masculin",
  "numTelephone": "+229 64548929",
  "langue": "French",
};

List<Map<String, dynamic>> pdgBottomList = [
  {
    'label': 'Accueil',
    'icon': Image.asset(
      'assets/img/icons/home.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/home_white.png',
      width: 25,
    ),
    "screen": const PDGHome(),
  },
  {
    'label': 'Chat',
    'icon': Image.asset(
      'assets/img/icons/chat.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/chat_white.png',
      width: 25,
    ),
    "screen": const ChatList(),
  },
  {
    'label': '',
    'icon': null,
    'active_icon': null,
    "screen": null,
  },
  {
    'label': 'Notifications',
    'icon': Image.asset(
      'assets/img/icons/notification01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/notification.png',
      width: 25,
    ),
    "screen": const NotificationPage(),
  },
  {
    'label': 'Profil',
    'icon': Image.asset(
      'assets/img/icons/user_01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/user_white.png',
      width: 25,
    ),
    "screen": const UserProfil(),
  },
];

List<Map<String, dynamic>> partnerBottomList = [
  {
    'label': 'Accueil',
    'icon': Image.asset(
      'assets/img/icons/home.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/home_white.png',
      width: 25,
    ),
    "screen": const PartnerHome(),
  },
  {
    'label': 'Chat',
    'icon': Image.asset(
      'assets/img/icons/distribution_01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/distribution.png',
      width: 25,
    ),
    "screen": const DistributeurOffiDetail(),
  },
  {
    'label': 'Notifications',
    'icon': Image.asset(
      'assets/img/icons/notification01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/notification.png',
      width: 25,
    ),
    "screen": const NotificationPage(),
  },
  {
    'label': 'Profil',
    'icon': Image.asset(
      'assets/img/icons/user_01.png',
      width: 25,
    ),
    'active_icon': Image.asset(
      'assets/img/icons/user_white.png',
      width: 25,
    ),
    "screen": const UserProfil(),
  },
];

List<Map<String, dynamic>> profilCardData = [
  {
    "theKey": "fullname",
    "label": "Saisissez votre nom",
    "text": "Nom & Prénom",
  },
  {
    "theKey": "birthday",
    "label": "Saisissez votre date de naissance",
    "text": "Date de naissance"
  },
];

List<String> languages = [
  "Français",
  "English",
  "España",
];

List<String> equimentList = [
  "Aucun équipement",
  "Ordinateur Portable",
  " Smartphone",
  "Poste téléviseur",
  " Climatiseur",
];

List<Map<String, dynamic>> paymentMethodData = [
  {
    "imgPath": "assets/img/icons/paypal.png",
    "title": "Paypal",
  },
  {
    "imgPath": "assets/img/icons/Visa-Logo-PNG10.png",
    "title": "Visa",
  },
  {
    "imgPath": "assets/img/icons/mastercard.png",
    "title": "Visa",
  },
];

List<Map<String, dynamic>> countriesList = [
  {
    "img": "${staticPath}algeria.png",
    "noum": "Algérie",
  },
  {
    "img": "${staticPath}angola.png",
    "noum": "Angola",
  },
  {
    "img": "${staticPath}benin.png",
    "noum": "Bénin",
  },
  {
    "img": "${staticPath}botswana.png",
    "noum": "Botswana",
  },
  {
    "img": "${staticPath}burkina-faso.png",
    "noum": "Burkina Faso",
  },
  {
    "img": "${staticPath}burundi.png",
    "noum": "Burundi",
  },
  {
    "img": "${staticPath}cape-verde.png",
    "noum": "Cap-Vert",
  },
  {
    "img": "${staticPath}cameroon.png",
    "noum": "Cameroun",
  },
  {
    "img": "${staticPath}central-african-republic.png",
    "noum": "République centrafricaine",
  },
  {
    "img": "${staticPath}chad.png",
    "noum": "Tchad",
  },
  {
    "img": "${staticPath}comoros.png",
    "noum": "Comores",
  },
  {
    "img": "${staticPath}congo-republic.png",
    "noum": "Congo",
  },
  {
    "img": "${staticPath}ivory-coast.png",
    "noum": "Côte d'Ivoire",
  },
  {
    "img": "${staticPath}dr-congo.png",
    "noum": "République démocratique du Congo",
  },
  {
    "img": "${staticPath}djibouti.png",
    "noum": "Djibouti",
  },
  {
    "img": "${staticPath}egypt.png",
    "noum": "Égypte",
  },
  {
    "img": "${staticPath}equatorial-guinea.png",
    "noum": "Guinée équatoriale",
  },
  {
    "img": "${staticPath}eritrea.png",
    "noum": "Érythrée",
  },
  {
    "img": "${staticPath}swaziland.png",
    "noum": "Swaziland",
  },
  {
    "img": "${staticPath}ethiopia.png",
    "noum": "Éthiopie",
  },
  {
    "img": "${staticPath}gabon.png",
    "noum": "Gabon",
  },
  {
    "img": "${staticPath}gambia.png",
    "noum": "Gambie",
  },
  {
    "img": "${staticPath}ghana.png",
    "noum": "Ghana",
  },
  {
    "img": "${staticPath}guinea.png",
    "noum": "Guinée",
  },
  {
    "img": "${staticPath}guinea-bissau.png",
    "noum": "Guinée-Bissau",
  },
  {
    "img": "${staticPath}kenya.png",
    "noum": "Kenya",
  },
  {
    "img": "${staticPath}lesotho.png",
    "noum": "Lesotho",
  },
  {
    "img": "${staticPath}liberia.png",
    "noum": "Libéria",
  },
  {
    "img": "${staticPath}libya.png",
    "noum": "Libye",
  },
  {
    "img": "${staticPath}madagascar.png",
    "noum": "Madagascar",
  },
  {
    "img": "${staticPath}malawi.png",
    "noum": "Malawi",
  },
  {
    "img": "${staticPath}mali.png",
    "noum": "Mali",
  },
  {
    "img": "${staticPath}mauritania.png",
    "noum": "Mauritanie",
  },
  {
    "img": "${staticPath}mauritius.png",
    "noum": "Maurice",
  },
  {
    "img": "${staticPath}morocco.png",
    "noum": "Maroc",
  },
  {
    "img": "${staticPath}mozambique.png",
    "noum": "Mozambique",
  },
  {
    "img": "${staticPath}namibia.png",
    "noum": "Namibie",
  },
  {
    "img": "${staticPath}niger.png",
    "noum": "Niger",
  },
  {
    "img": "${staticPath}nigeria.png",
    "noum": "Nigeria",
  },
  {
    "img": "${staticPath}rwanda.png",
    "noum": "Rwanda",
  },
  {
    "img": "${staticPath}sao-tome-and-principe.png",
    "noum": "Sao Tomé-et-Principe",
  },
  {
    "img": "${staticPath}senegal.png",
    "noum": "Sénégal",
  },
  {
    "img": "${staticPath}seychelles.png",
    "noum": "Seychelles",
  },
  {
    "img": "${staticPath}sierra-leone.png",
    "noum": "Sierra Leone",
  },
  {
    "img": "${staticPath}somalia.png",
    "noum": "Somalie",
  },
  {
    "img": "${staticPath}south-africa.png",
    "noum": "Afrique du Sud",
  },
  {
    "img": "${staticPath}south-sudan.png",
    "noum": "Soudan du Sud",
  },
  {
    "img": "${staticPath}sudan.png",
    "noum": "Soudan",
  },
  {
    "img": "${staticPath}tanzania.png",
    "noum": "Tanzanie",
  },
  {
    "img": "${staticPath}togo.png",
    "noum": "Togo",
  },
  {
    "img": "${staticPath}tunisia.png",
    "noum": "Tunisie",
  },
  {
    "img": "${staticPath}uganda.png",
    "noum": "Ouganda",
  },
  {
    "img": "${staticPath}zambia.png",
    "noum": "Zambie",
  },
  {
    "img": "${staticPath}zimbabwe.png",
    "noum": "Zimbabwe",
  },
];

List<Map<String, dynamic>> notifData = [
  {
    "key": "CmdNotification",
    "title": "Commande de DMA",
    "content":
        "Vous avez reçu une commande de DMA, appuyer pour en savoir plus."
  },
  {
    "key": "ValidInscription",
    "title": "Validation d'inscription",
    "content":
        "Vous avez une demande d'inscription, appuyer pour en savoir plus."
  },
  {
    "key": "MsgNotification",
    "title": "Nouveau message reçu",
    "content": "Vous avez reçu un nouveau message, appuyer pour en savoir plus."
  },
];

List<String> pdgOptions = [
  "Distributeur Officiel",
  "Liste des vendeurs",
  "Liste des distributeurs",
  "Liste des distributeurs pays",
  "Liste des assistants clientèles",
  "Commande",
];

List<String> pdgOptionsImg = [
  "assets/img/heart_phone.jpg",
  "assets/img/list.jpg",
  "assets/img/list.jpg",
  "assets/img/list.jpg",
  "assets/img/list.jpg",
  "assets/img/order.jpg",
];

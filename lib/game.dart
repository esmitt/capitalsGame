import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_progress_bar/flutter_rounded_progress_bar.dart';
import 'package:flutter_rounded_progress_bar/rounded_progress_bar_style.dart';
import 'package:audioplayers/audio_cache.dart';
import 'results.dart';

class Game extends StatefulWidget {
  Game({Key key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  Stopwatch _watch = new Stopwatch();
  Timer _timer;
  String _elapsedTime = '';

  int isSelected =
      -1; // changed bool to int and set value to -1 on first time if you don't select anything otherwise set 0 to set first one as selected.

  double _percentage = 0;

  final int _numberItems = 15;
  int _currentIndex = 0;
  int _currentItem = 0; // number of items good/bad
  int _numberCorrect = 0;

  final Color itemRegular = Color(0xff707070);
  final Color itemSelected = Color(0xff303030);
  final Color itemCorrect = Color(0xff88E1F2);
  final Color itemWrong = Color(0xffFF7C7C);
  Color itemColorSelected;
  Color colorItem;

  List countries = [
    "Afganistán",
    "Albania",
    "Alemania",
    "Andorra",
    "Angola",
    "Antigua y Barbuda",
    "Arabia Saudita",
    "Argelia",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaiyán",
    "Bahamas",
    "Bangladés",
    "Barbados",
    "Baréin",
    "Bélgica",
    "Belice",
    "Benín",
    "Bielorrusia",
    "Birmania",
    "Bolivia",
    "Bosnia y Herzegovina",
    "Botsuana",
    "Brasil",
    "Brunéi",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Bután",
    "Cabo Verde",
    "Camboya",
    "Camerún",
    "Canadá",
    "Catar",
    "Chad",
    "Chile",
    "China",
    "Chipre",
    "Ciudad del Vaticano",
    "Colombia",
    "Comoras",
    "Corea del Norte",
    "Corea del Sur",
    "Costa de Marfil",
    "Costa Rica",
    "Croacia",
    "Cuba",
    "Dinamarca",
    "Dominica",
    "Ecuador",
    "Egipto",
    "El Salvador",
    "Emiratos Árabes Unidos",
    "Eritrea",
    "Eslovaquia",
    "Eslovenia",
    "España",
    "Estados Unidos",
    "Estonia",
    "Etiopía",
    "Filipinas",
    "Finlandia",
    "Fiyi",
    "Francia",
    "Gabón",
    "Gambia",
    "Georgia",
    "Ghana",
    "Granada",
    "Grecia",
    "Guatemala",
    "Guyana",
    "Guinea",
    "Guinea-Bisáu",
    "Guinea Ecuatorial",
    "Haití",
    "Honduras",
    "Hungría",
    "India",
    "Indonesia",
    "Irak",
    "Irán",
    "Irlanda",
    "Islandia",
    "Islas Marshall",
    "Islas Salomón",
    "Israel",
    "Italia",
    "Jamaica",
    "Japón",
    "Jordania",
    "Kazajistán",
    "Kenia",
    "Kirguistán",
    "Kiribati",
    "Kuwait",
    "Laos",
    "Lesoto",
    "Letonia",
    "Líbano",
    "Liberia",
    "Libia",
    "Liechtenstein",
    "Lituania",
    "Luxemburgo",
    "Macedonia del Norte",
    "Madagascar",
    "Malasia",
    "Malaui",
    "Maldivas",
    "Malí",
    "Malta",
    "Marruecos",
    "Mauricio",
    "Mauritania",
    "México",
    "Micronesia",
    "Moldavia",
    "Mónaco",
    "Mongolia",
    "Montenegro",
    "Mozambique",
    "Namibia",
    "Nauru",
    "Nepal",
    "Nicaragua",
    "Níger",
    "Nigeria",
    "Noruega",
    "Nueva Zelanda",
    "Omán",
    "Países Bajos",
    "Pakistán",
    "Palaos",
    "Panamá",
    "Papúa Nueva Guinea",
    "Paraguay",
    "Perú",
    "Polonia",
    "Portugal",
    "Reino Unido de Gran Bretaña e Irlanda del Norte",
    "República Centroafricana",
    "República Checa",
    "República del Congo",
    "República Democrática del Congo",
    "República Dominicana",
    "República Sudafricana",
    "Ruanda",
    "Rumanía",
    "Rusia",
    "Samoa",
    "San Cristóbal y Nieves",
    "San Marino",
    "San Vicente y las Granadinas",
    "Santa Lucía",
    "Santo Tomé y Príncipe",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leona",
    "Singapur",
    "Siria",
    "Somalia",
    "Sri Lanka",
    "Suazilandia",
    "Sudán",
    "Sudán del Sur",
    "Suecia",
    "Suiza",
    "Surinam",
    "Tailandia",
    "Tanzania",
    "Tayikistán",
    "Timor Oriental",
    "Togo",
    "Tonga",
    "Trinidad y Tobago",
    "Túnez",
    "Turkmenistán",
    "Turquía",
    "Tuvalu",
    "Ucrania",
    "Uganda",
    "Uruguay",
    "Uzbekistán",
    "Vanuatu",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Yibuti",
    "Zambia",
    "Zimbabue"
  ];
  List capitals = [
    "Kabul",
    "Tirana",
    "Berlín",
    "Andorra la Vieja",
    "Luanda",
    "Saint John's",
    "Riad",
    "Argel",
    "Buenos Aires",
    "Ereván",
    "Camberra",
    "Viena",
    "Bakú",
    "Nasáu",
    "Daca",
    "Bridgetown",
    "Manama",
    "Bruselas",
    "Belmopán",
    "Porto Novo y Cotonú",
    "Minsk",
    "Naipyidó",
    "Sucre",
    "Sarajevo",
    "Gaborone",
    "Brasilia",
    "Bandar Seri Begawan",
    "Sofía",
    "Uagadugú",
    "Gitega",
    "Timbu",
    "Praia",
    "Nom Pen",
    "Yaundé",
    "Ottawa",
    "Doha",
    "Yamena",
    "Santiago de Chile",
    "Pekín",
    "Nicosia",
    "Ciudad del Vaticano",
    "Bogotá",
    "Moroni",
    "Pionyang",
    "Seúl",
    "Yamusukro",
    "San José",
    "Zagreb",
    "La Habana",
    "Copenhague",
    "Roseau",
    "Quito",
    "El Cairo",
    "San Salvador",
    "Abu Dabi",
    "Asmara",
    "Bratislava",
    "Liubliana",
    "Madrid",
    "Washington D. C",
    "Tallin",
    "Adís Abeba",
    "Manila",
    "Helsinki",
    "Suva",
    "París",
    "Libreville",
    "Banjul",
    "Tiflis",
    "Acra",
    "Saint George",
    "Atenas",
    "Ciudad de Guatemala",
    "Georgetown",
    "Conakri",
    "Bisáu",
    "Malabo",
    "Puerto Príncipe",
    "Tegucigalpa",
    "Budapest",
    "Nueva Delhi",
    "Yakarta",
    "Bagdad",
    "Teherán",
    "Dublín",
    "Reikiavik",
    "Majuro",
    "Honiara",
    "Jerusalén",
    "Roma",
    "Kingston",
    "Tokio",
    "Amán",
    "Astaná",
    "Nairobi",
    "Biskek",
    "Tarawa",
    "Kuwait",
    "Vientián",
    "Maseru",
    "Riga",
    "Beirut",
    "Monrovia",
    "Trípoli",
    "Vaduz",
    "Vilna",
    "Luxemburgo",
    "Skopie",
    "Antananarivo",
    "Kuala Lumpur",
    "Lilongüe",
    "Malé",
    "Bamako",
    "La Valeta",
    "Rabat",
    "Port-Louis",
    "Nuakchot",
    "Ciudad de México",
    "Palikir",
    "Chisináu",
    "Mónaco",
    "Ulán Bator",
    "Podgorica",
    "Maputo",
    "Windhoek",
    "Yaren",
    "Katmandú",
    "Managua",
    "Niamey",
    "Abuya",
    "Oslo",
    "Wellington",
    "Mascate",
    "Amsterdam",
    "Islamabad",
    "Melekeok",
    "Ciudad de Panamá",
    "Port Moresby",
    "Asunción",
    "Lima",
    "Varsovia",
    "Lisboa",
    "Londres",
    "Bangui",
    "Praga",
    "Brazzaville",
    "Kinsasa",
    "Santo Domingo",
    "Bloemfontein, Ciudad Del Cabo y Pretoria",
    "Kigali",
    "Bucarest",
    "Moscú",
    "Apia",
    "Basseterre",
    "San Marino",
    "Kingstown",
    "Castries",
    "Santo Tomé",
    "Dakar",
    "Belgrado",
    "Victoria",
    "Freetown",
    "Singapur",
    "Damasco",
    "Mogadiscio",
    "Sri Jayewardenepura (capital administrativa) y Colombo (capital comercial)",
    "Babane y Lobamba",
    "Jartum",
    "Yuba",
    "Estocolmo",
    "Berna",
    "Paramaribo",
    "Bangkok",
    "Dodoma",
    "Dusambé",
    "Dili",
    "Lomé",
    "Nukualofa",
    "Puerto España",
    "Túnez",
    "Asjabad",
    "Ankara",
    "Fongafale",
    "Kiev",
    "Kampala",
    "Montevideo",
    "Taskent",
    "Port Vila",
    "Caracas",
    "Hanói",
    "Saná",
    "Yibuti",
    "Lusaka",
    "Harare"
  ];
  List flags = [
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Afghanistan.svg/600px-Flag_of_Afghanistan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/36/Flag_of_Albania.svg/600px-Flag_of_Albania.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/600px-Flag_of_Germany.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Andorra.svg/600px-Flag_of_Andorra.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9d/Flag_of_Angola.svg/600px-Flag_of_Angola.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Antigua_and_Barbuda.svg/600px-Flag_of_Antigua_and_Barbuda.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/600px-Flag_of_Saudi_Arabia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Algeria.svg/600px-Flag_of_Algeria.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/600px-Flag_of_Argentina.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2f/Flag_of_Armenia.svg/600px-Flag_of_Armenia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_Australia_%28converted%29.svg/600px-Flag_of_Australia_%28converted%29.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/600px-Flag_of_Austria.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Azerbaijan.svg/600px-Flag_of_Azerbaijan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/93/Flag_of_the_Bahamas.svg/600px-Flag_of_the_Bahamas.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f9/Flag_of_Bangladesh.svg/600px-Flag_of_Bangladesh.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Flag_of_Barbados.svg/600px-Flag_of_Barbados.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Bahrain.svg/600px-Flag_of_Bahrain.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Belgium_%28civil%29.svg/600px-Flag_of_Belgium_%28civil%29.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Flag_of_Belize.svg/600px-Flag_of_Belize.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Benin.svg/600px-Flag_of_Benin.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Flag_of_Belarus.svg/600px-Flag_of_Belarus.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Flag_of_Myanmar.svg/600px-Flag_of_Myanmar.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Bolivia.svg/600px-Flag_of_Bolivia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Flag_of_Bosnia_and_Herzegovina.svg/600px-Flag_of_Bosnia_and_Herzegovina.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_Botswana.svg/600px-Flag_of_Botswana.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/600px-Flag_of_Brazil.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Brunei.svg/600px-Flag_of_Brunei.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Bulgaria.svg/600px-Flag_of_Bulgaria.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Burkina_Faso.svg/600px-Flag_of_Burkina_Faso.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Flag_of_Burundi.svg/600px-Flag_of_Burundi.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Flag_of_Bhutan.svg/600px-Flag_of_Bhutan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Cape_Verde.svg/600px-Flag_of_Cape_Verde.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Flag_of_Cambodia.svg/600px-Flag_of_Cambodia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Cameroon.svg/600px-Flag_of_Cameroon.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Canada_%28Pantone%29.svg/600px-Flag_of_Canada_%28Pantone%29.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Qatar.svg/600px-Flag_of_Qatar.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Flag_of_Chad.svg/600px-Flag_of_Chad.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Flag_of_Chile.svg/600px-Flag_of_Chile.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Flag_of_the_People%27s_Republic_of_China.svg/600px-Flag_of_the_People%27s_Republic_of_China.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Cyprus.svg/600px-Flag_of_Cyprus.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_the_Vatican_City.svg/600px-Flag_of_the_Vatican_City.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Colombia.svg/600px-Flag_of_Colombia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/94/Flag_of_the_Comoros.svg/600px-Flag_of_the_Comoros.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Flag_of_North_Korea.svg/600px-Flag_of_North_Korea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/600px-Flag_of_South_Korea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_C%C3%B4te_d%27Ivoire.svg/600px-Flag_of_C%C3%B4te_d%27Ivoire.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Flag_of_Costa_Rica.svg/600px-Flag_of_Costa_Rica.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Croatia.svg/600px-Flag_of_Croatia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bd/Flag_of_Cuba.svg/600px-Flag_of_Cuba.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Flag_of_Denmark.svg/600px-Flag_of_Denmark.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Flag_of_Dominica.svg/600px-Flag_of_Dominica.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Flag_of_Ecuador.svg/600px-Flag_of_Ecuador.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/600px-Flag_of_Egypt.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_El_Salvador.svg/600px-Flag_of_El_Salvador.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_United_Arab_Emirates.svg/600px-Flag_of_the_United_Arab_Emirates.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_Eritrea.svg/600px-Flag_of_Eritrea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e6/Flag_of_Slovakia.svg/600px-Flag_of_Slovakia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Flag_of_Slovenia.svg/600px-Flag_of_Slovenia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Spain.svg/600px-Flag_of_Spain.svg.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/a/a4/Flag_of_the_United_States.svg/600px-Flag_of_the_United_States.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Flag_of_Estonia.svg/600px-Flag_of_Estonia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/71/Flag_of_Ethiopia.svg/600px-Flag_of_Ethiopia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_the_Philippines.svg/600px-Flag_of_the_Philippines.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Finland.svg/600px-Flag_of_Finland.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Fiji.svg/600px-Flag_of_Fiji.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/600px-Flag_of_France.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/04/Flag_of_Gabon.svg/600px-Flag_of_Gabon.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_The_Gambia.svg/600px-Flag_of_The_Gambia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Georgia.svg/600px-Flag_of_Georgia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Ghana.svg/600px-Flag_of_Ghana.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Grenada.svg/600px-Flag_of_Grenada.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Greece.svg/600px-Flag_of_Greece.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Flag_of_Guatemala.svg/600px-Flag_of_Guatemala.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Flag_of_Guyana.svg/600px-Flag_of_Guyana.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Flag_of_Guinea.svg/600px-Flag_of_Guinea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Guinea-Bissau.svg/600px-Flag_of_Guinea-Bissau.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Equatorial_Guinea.svg/600px-Flag_of_Equatorial_Guinea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Haiti.svg/600px-Flag_of_Haiti.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Flag_of_Honduras_%28Pantone%29.svg/600px-Flag_of_Honduras_%28Pantone%29.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Flag_of_Hungary.svg/600px-Flag_of_Hungary.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_India.svg/600px-Flag_of_India.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Indonesia.svg/600px-Flag_of_Indonesia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Flag_of_Iraq.svg/600px-Flag_of_Iraq.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ca/Flag_of_Iran.svg/600px-Flag_of_Iran.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/45/Flag_of_Ireland.svg/600px-Flag_of_Ireland.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Iceland.svg/600px-Flag_of_Iceland.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Flag_of_the_Marshall_Islands.svg/600px-Flag_of_the_Marshall_Islands.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/74/Flag_of_the_Solomon_Islands.svg/600px-Flag_of_the_Solomon_Islands.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Flag_of_Israel.svg/600px-Flag_of_Israel.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/600px-Flag_of_Italy.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0a/Flag_of_Jamaica.svg/600px-Flag_of_Jamaica.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Flag_of_Japan.svg/600px-Flag_of_Japan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c0/Flag_of_Jordan.svg/600px-Flag_of_Jordan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kazakhstan.svg/600px-Flag_of_Kazakhstan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Kenya.svg/600px-Flag_of_Kenya.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Flag_of_Kyrgyzstan.svg/600px-Flag_of_Kyrgyzstan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Flag_of_Kiribati.svg/600px-Flag_of_Kiribati.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Flag_of_Kuwait.svg/600px-Flag_of_Kuwait.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Flag_of_Laos.svg/600px-Flag_of_Laos.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Flag_of_Lesotho.svg/600px-Flag_of_Lesotho.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Latvia.svg/600px-Flag_of_Latvia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Flag_of_Lebanon.svg/600px-Flag_of_Lebanon.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b8/Flag_of_Liberia.svg/600px-Flag_of_Liberia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Libya.svg/600px-Flag_of_Libya.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Flag_of_Liechtenstein.svg/600px-Flag_of_Liechtenstein.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Lithuania.svg/600px-Flag_of_Lithuania.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Flag_of_Luxembourg.svg/600px-Flag_of_Luxembourg.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_North_Macedonia.svg/600px-Flag_of_North_Macedonia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Madagascar.svg/600px-Flag_of_Madagascar.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Flag_of_Malaysia.svg/600px-Flag_of_Malaysia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Flag_of_Malawi.svg/600px-Flag_of_Malawi.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Flag_of_Maldives.svg/600px-Flag_of_Maldives.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_Mali.svg/600px-Flag_of_Mali.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Malta.svg/600px-Flag_of_Malta.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2c/Flag_of_Morocco.svg/600px-Flag_of_Morocco.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Flag_of_Mauritius.svg/600px-Flag_of_Mauritius.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/600px-Flag_of_Mexico.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/43/Flag_of_Mauritania.svg/600px-Flag_of_Mauritania.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Flag_of_the_Federated_States_of_Micronesia.svg/600px-Flag_of_the_Federated_States_of_Micronesia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Moldova.svg/600px-Flag_of_Moldova.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Flag_of_Monaco.svg/600px-Flag_of_Monaco.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Mongolia.svg/600px-Flag_of_Mongolia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Montenegro.svg/600px-Flag_of_Montenegro.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Mozambique.svg/600px-Flag_of_Mozambique.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/00/Flag_of_Namibia.svg/600px-Flag_of_Namibia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Flag_of_Nauru.svg/600px-Flag_of_Nauru.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Flag_of_Nepal.svg/600px-Flag_of_Nepal.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/19/Flag_of_Nicaragua.svg/600px-Flag_of_Nicaragua.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/Flag_of_Niger.svg/600px-Flag_of_Niger.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/600px-Flag_of_Nigeria.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/600px-Flag_of_Norway.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Flag_of_New_Zealand.svg/600px-Flag_of_New_Zealand.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Flag_of_Oman.svg/600px-Flag_of_Oman.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/600px-Flag_of_the_Netherlands.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Flag_of_Pakistan.svg/600px-Flag_of_Pakistan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Palau.svg/600px-Flag_of_Palau.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Flag_of_Panama.svg/600px-Flag_of_Panama.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Flag_of_Papua_New_Guinea.svg/600px-Flag_of_Papua_New_Guinea.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Flag_of_Paraguay.svg/600px-Flag_of_Paraguay.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Peru.svg/600px-Flag_of_Peru.svg.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/1/12/Flag_of_Poland.svg/600px-Flag_of_Poland.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5c/Flag_of_Portugal.svg/600px-Flag_of_Portugal.svg.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/a/ae/Flag_of_the_United_Kingdom.svg/600px-Flag_of_the_United_Kingdom.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Central_African_Republic.svg/600px-Flag_of_the_Central_African_Republic.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/Flag_of_the_Czech_Republic.svg/600px-Flag_of_the_Czech_Republic.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Flag_of_the_Republic_of_the_Congo.svg/600px-Flag_of_the_Republic_of_the_Congo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Flag_of_the_Democratic_Republic_of_the_Congo.svg/600px-Flag_of_the_Democratic_Republic_of_the_Congo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_the_Dominican_Republic.svg/600px-Flag_of_the_Dominican_Republic.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/600px-Flag_of_South_Africa.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Rwanda.svg/600px-Flag_of_Rwanda.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Flag_of_Romania.svg/600px-Flag_of_Romania.svg.png",
    "https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/600px-Flag_of_Russia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Flag_of_Samoa.svg/600px-Flag_of_Samoa.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Saint_Kitts_and_Nevis.svg/600px-Flag_of_Saint_Kitts_and_Nevis.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b1/Flag_of_San_Marino.svg/600px-Flag_of_San_Marino.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Flag_of_Saint_Vincent_and_the_Grenadines.svg/600px-Flag_of_Saint_Vincent_and_the_Grenadines.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Flag_of_Saint_Lucia.svg/600px-Flag_of_Saint_Lucia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/Flag_of_Sao_Tome_and_Principe.svg/600px-Flag_of_Sao_Tome_and_Principe.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Flag_of_Senegal.svg/600px-Flag_of_Senegal.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/ff/Flag_of_Serbia.svg/600px-Flag_of_Serbia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Seychelles.svg/600px-Flag_of_Seychelles.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Flag_of_Sierra_Leone.svg/600px-Flag_of_Sierra_Leone.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Flag_of_Singapore.svg/600px-Flag_of_Singapore.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Flag_of_Syria.svg/600px-Flag_of_Syria.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Flag_of_Somalia.svg/600px-Flag_of_Somalia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Flag_of_Sri_Lanka.svg/600px-Flag_of_Sri_Lanka.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Flag_of_Eswatini.svg/600px-Flag_of_Eswatini.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Flag_of_Sudan.svg/600px-Flag_of_Sudan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Flag_of_South_Sudan.svg/600px-Flag_of_South_Sudan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4c/Flag_of_Sweden.svg/600px-Flag_of_Sweden.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Switzerland.svg/600px-Flag_of_Switzerland.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/60/Flag_of_Suriname.svg/600px-Flag_of_Suriname.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Flag_of_Thailand.svg/600px-Flag_of_Thailand.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tanzania.svg/600px-Flag_of_Tanzania.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/Flag_of_Tajikistan.svg/600px-Flag_of_Tajikistan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Flag_of_East_Timor.svg/600px-Flag_of_East_Timor.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Flag_of_Togo.svg/600px-Flag_of_Togo.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Tonga.svg/600px-Flag_of_Tonga.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/64/Flag_of_Trinidad_and_Tobago.svg/600px-Flag_of_Trinidad_and_Tobago.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Flag_of_Tunisia.svg/600px-Flag_of_Tunisia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Flag_of_Turkmenistan.svg/600px-Flag_of_Turkmenistan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/Flag_of_Turkey.svg/600px-Flag_of_Turkey.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Flag_of_Tuvalu.svg/600px-Flag_of_Tuvalu.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Ukraine.svg/600px-Flag_of_Ukraine.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Flag_of_Uganda.svg/600px-Flag_of_Uganda.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Uruguay.svg/600px-Flag_of_Uruguay.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Flag_of_Uzbekistan.svg/600px-Flag_of_Uzbekistan.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Flag_of_Vanuatu.svg/600px-Flag_of_Vanuatu.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Venezuela.svg/600px-Flag_of_Venezuela.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/600px-Flag_of_Vietnam.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Flag_of_Yemen.svg/600px-Flag_of_Yemen.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/3/34/Flag_of_Djibouti.svg/600px-Flag_of_Djibouti.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/0/06/Flag_of_Zambia.svg/600px-Flag_of_Zambia.svg.png",
    "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Flag_of_Zimbabwe.svg/600px-Flag_of_Zimbabwe.svg.png"
  ];

  List entries;

  var _randomObj;
  AudioCache player = null;

  void _isSelected(int index) {
    //pass the selected index to here and set to 'isSelected'
    setState(() {
      isSelected = index;
    });
  }

  // Create the random data of country and 4 options for capitals (including the correct one)
  void _makeData() {
    _randomObj = Random();

    _currentIndex =
        _randomObj.nextInt(countries.length); // position of item to show

    // add random elements into a set to avoid collisions and store them into entries
    Set candidates = Set();
    candidates.add(capitals[_currentIndex]);
    while (candidates.length < 4) {
      candidates.add(capitals[_randomObj.nextInt(countries.length)]);
    }

    entries = List.from(candidates);
    entries.shuffle();
  }

  _GameState() {
    player = AudioCache();
    _makeData();
    startWatch();
  }

  updateTime(Timer timer) {
    if (_currentItem == _numberItems) {
      _watch.stop();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Results(
            correct: _numberCorrect, total: _numberItems, time: _elapsedTime),
      ));
      _currentItem++;
    }
    if (_watch.isRunning) {
      setState(() {
        _elapsedTime = transformMilliSeconds(_watch.elapsedMilliseconds);
      });
    }
  }

  void startWatch() {
    this._watch.start();
    this._timer = Timer.periodic(new Duration(milliseconds: 100), updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Capitales de Liam")),
      body: Column(
        //shrinkWrap: true,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
              child: Text(
                _elapsedTime,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff707070),
                  fontSize: 67,
                  fontWeight: FontWeight.bold,
                ),
              )),
          Container(
            decoration: BoxDecoration(
                border: Border.all(
              color: Color(0xff505050),
              width: 2,
            )),
            child: Image.network(
              flags[_currentIndex],
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
          Stack(
            children: <Widget>[
              RoundedProgressBar(
                percent: _percentage,
                style: RoundedProgressBarStyle(
                  borderWidth: 0,
                  backgroundProgress: Color(0xffffffff),
                  colorProgress: Color(0xffFFD082),
                  colorProgressDark: Color(0xffEEB062),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        countries[_currentIndex].toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff707070),
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: entries.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTapDown: (TapDownDetails details) {
                        //whichItemSelected = 1;
                        _isSelected(index); //pass index value to '_isSelected'
                      },
                      onTap: () {
                        itemColorSelected = itemWrong;
                        if (entries[index].compareTo(capitals[_currentIndex]) ==
                            0) {
                          _numberCorrect++;
                          itemColorSelected = itemCorrect;
                          const alarmAudioPath = "sounds/correct.mp3";
                          player.play(alarmAudioPath);
                        } else {
                          const alarmAudioPath = "sounds/wrong.mp3";
                          player.play(alarmAudioPath);
                        }
                        _currentItem++;
                        _percentage =
                            (_currentItem * 100) / _numberItems.toDouble();
                        _makeData();
                        isSelected = -1;
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(35, 10, 35, 0),
                        decoration: BoxDecoration(
                            color: itemRegular,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          entries[index],
                          style:
                              TextStyle(color: Color(0xffffffff), fontSize: 21),
                        ),
                        padding: EdgeInsets.fromLTRB(20, 16, 0, 15),
                      ),
                    );
                  })),
        ],
      ),
    );
  }

  String transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String millisecStr = (hundreds % 1000).toString(); // This is wrong! sorry
    if (millisecStr.length >= 2) millisecStr = millisecStr.substring(1, 2);

    return "$minutesStr:$secondsStr:$millisecStr";
  }
}

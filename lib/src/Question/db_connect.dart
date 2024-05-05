

import 'package:projet_dev_mobile/src/Question/Question_Model.dart';

List<Question> questions = [
  Question(
    id: '10',
    title: 'Combien font 2 + 2 ?',
    options: {'5': false, '30': false, '4': true, '10': false},
  ),
  Question(
    id: '11',
    title: 'Combien font 10 + 20 ?',
    options: {'50': false, '30': true, '40': false, '10': false},
  ),
  Question(
    id: '12',
    title: 'Quelle est la capitale de la France ?',
    options: {'Paris': true, 'Berlin': false, 'Londres': false, 'Rome': false},
  ),
  // Ajout des autres questions
  Question(
    id: '13',
    title: 'Quel champignon n’existe pas ?',
    options: {'Le bolet de céléri': true, 'La trompette-de-la-mort': false, 'La barbe-de-bouc': false},
  ),
  Question(
    id: '14',
    title: 'L’art de cultiver les bonsaïs (ou arbres nains) est originaire de :',
    options: {'d’Afrique': false, 'd’Indonésie': false, 'du Japon': true},
  ),
  Question(
    id: '15',
    title: 'Comment appelle-t-on une grande pierre dressée ?',
    options: {'Un menhir': true, 'Un grohir': false, 'Un lourhir': false},
  ),
  Question(
    id: '16',
    title: 'Qu’est-ce qui doit arriver sur le stigmate pour que la fleur se reproduise ?',
    options: {'Le pollen': true, 'L’amidon': false, 'La farine': false},
  ),
  Question(
    id: '17',
    title: 'D’un iceberg flottant dans les régions polaires, on ne voit en fait :',
    options: {'qu’un cinquième': false, 'qu’un tiers': false, 'que la moitié': true},
  ),
  Question(
    id: '18',
    title: 'Combien de kilos de raisin faut-il pour faire 50 litres de vin ?',
    options: {'100 kg': false, '50 kg': true, '250 kg': false},
  ),
  Question(
    id: '19',
    title: 'Le baobab est un des plus grands arbres du monde. Cet arbre est aussi appelé :',
    options: {'arbre-mammouth': false, 'arbre à pain de singe': true, 'arbre géant': false},
  ),
  Question(
    id: '20',
    title: 'Lorsqu’un volcan se déchaine, on parle :',
    options: {'d’érosion': false, 'd’éruption': true, 'd’équation': false},
  ),
  Question(
    id: '21',
    title: 'Qu’est-ce qu’une météorite ?',
    options: {'Une pierre dans l’espace': true, 'Une boule de gaz': false, 'Une accumulation de matière': false},
  ),
  Question(
    id: '22',
    title: 'Les bananes poussent :',
    options: {'courbées vers le haut': false, 'courbées vers le bas': false, 'droites, elles se courbent après la récolte': true},
  ),
  Question(
    id: '23',
    title: 'Quels globules n’existent pas dans le corps humain ?',
    options: {'Les globules rouges': true, 'Les globules blancs': false, 'Les globules violets': false},
  ),
  Question(
    id: '24',
    title: 'Que fait le niveau de la mer lorsque la Terre se réchauffe ?',
    options: {'il monte.': true, 'Il baisse.': false, 'Il reste identique.': false},
  ),
  Question(
    id: '25',
    title: 'De nombreux produits sont en cuir, mais d’où vient ce cuir ?',
    options: {'De la peau des animaux': true, 'Du pétrole': false, 'De l’écorce de caoutchoutier': false},
  ),
  Question(
    id: '26',
    title: 'Dans quel organe du corps humain l’urine est-elle formée ?',
    options: {'Le rein': true, 'L’estomac': false, 'L’intestin': false},
  ),
  Question(
    id: '27',
    title: 'Un four à micro-ondes réchauffe la nourriture :',
    options: {'en faisant vibrer les molécules d’eau de la nourriture.': true, 'en faisant vibrer très vite la nourriture.': false, 'en produisant de la chaleur.': false},
  ),
  Question(
    id: '28',
    title: 'Le coeur humain se trouve dans la poitrine. Mais de quel côté ?',
    options: {'À gauche': true, 'Au milieu': false, 'À droite': false},
  ),
  Question(
    id: '29',
    title: 'Avec quel instrument un médecin écoute-t-il le rythme cardiaque ?',
    options: {'Un stéthoscope': true, 'Un périscope': false, 'Un cyclope': false},
  ),
  Question(
    id: '30',
    title: 'Combien de litres d’eau faut-il pour produire 1 tonne de papier ?',
    options: {'40 000 litres': false, '4 000 litres': false, '400 litres': true},
  ),
  Question(
    id: '31',
    title: 'Quel matériau ne fait pas partie de la famille des carbones ?',
    options: {'Le diamant': false, 'L’asphalte': true, 'La suie': false},
  ),
  Question(
    id: '32',
    title: 'Comment appelle-t-on la dentition des enfants ?',
    options: {'Dents de lait': true, 'Dents d’eau': false, 'Dents de beurre': false},
  ),
  Question(
    id: '33',
    title: 'De combien de musiciens se compose un quartet ?',
    options: {'4': true, '3': false, '5': false},
  ),
  Question(
    id: '34',
    title: 'Parmi ces trois langues, laquelle est la plus parlée ?',
    options: {'Le français': false, 'L’allemand': false, 'L’espagnol.': true},
  ),
  Question(
    id: '35',
    title: 'Si vous atterrissez à l’aéroport de Schiphol, c’est que vous êtes arrivés :',
    options: {'en Afrique du Sud': false, 'aux Pays-Bas': true, 'aux Antilles néerlandaises': false},
  ),
  Question(
    id: '36',
    title: 'Quelle est la capitale de l’Espagne ?',
    options: {'Madrid': true, 'Lisbonne': false, 'Rome': false},
  ),
  Question(
    id: '37',
    title: 'Dans quel pays payait-on en lires avant l’apparition de l’euro ?',
    options: {'En Italie': true, 'En Espagne': false, 'En Allemagne': false},
  ),
  Question(
    id: '38',
    title: 'De quel côté d’un bateau se trouve tribord ?',
    options: {'À droite': true, 'À gauche': false, 'En arrière': false},
  ),
  Question(
    id: '39',
    title: 'De quel pays proviennent les spaghettis à l’origine ?',
    options: {'De Chine': false, 'De Turquie': false, 'D’Italie': true},
  ),
  Question(
    id: '40',
    title: 'Le TGV (train à grande vitesse) a été conçu en France et roule à une vitesse moyenne de :',
    options: {'230 km/h': false, '350 km/h': true, '420 km/h': false},
  ),
  Question(
    id: '41',
    title: 'La plus haute montagne d’Europe de l’Ouest est haute d’environ 4 807 mètres. Il s’agit du :',
    options: {'mont Blanc': true, 'mont Ventoux': false, 'Puy-de-Dôme': false},
  ),
  Question(
    id: '42',
    title: 'Comment s’appelle l’organisation qui aide les enfants dans le monde entier ?',
    options: {'Unicef': true, 'Unesco': false, 'Uno': false},
  ),
  Question(
    id: '43',
    title: 'Les poulets fermiers sont des poulets qui :',
    options: {'vivent dans un élevage': false, 'peuvent se promener en liberté': true, 'vivent dans une ville': false},
  ),
  Question(
    id: '44',
    title: 'Quel oiseau est un symbole international de paix ?',
    options: {'La colombe': true, 'L’hirondelle': false, 'La cigogne': false},
  ),
  Question(
    id: '45',
    title: 'L’élan est le plus grand cervidé du monde. En dehors de la saison de reproduction, il vit :',
    options: {'en solitaire': true, 'en couple, avec les jeunes': false, 'en colonie': false},
  ),
  Question(
    id: '46',
    title: 'Le crocodile reste parfois près de la rivière, immobile et la gueule grande ouverte. Pourquoi ?',
    options: {'Pour être prêt à attraper un animal qui passerait par là.': false, 'Pour inspirer beaucoup d’air avant d’aller sous l’eau.': false, 'Pour perdre de la chaleur.': true},
  ),
  Question(
    id: '47',
    title: 'Le diodon est un poisson aux piquants acérés. Sous l’eau il a cette forme ronde :',
    options: {'en permanence': false, 'lorsqu’il se remplit d’eau': true, 'lorsqu’il remonte près de la surface': false},
  ),
  Question(
    id: '48',
    title: 'Quelle espèce de rhinocéros n’existe pas ?',
    options: {'Le rhinocéros blanc': false, 'Le rhinocéros noir': false, 'Le rhinocéros brun': true},
  ),
  Question(
    id: '49',
    title: 'Les poissons n’ont pas de poumons pour respirer. Avec quoi respirent-ils ?',
    options: {'Leurs branchies': true, 'Leurs écailles': false, 'Leurs nageoires': false},
  ),
  Question(
    id: '50',
    title: 'La libellule est un insecte que l’on rencontre surtout :',
    options: {'Au bord de l’eau': true, 'Dans la forêt': false, 'Dans la montagne': false},
  ),
  Question(
    id: '51',
    title: 'Où vit le renard polaire ?',
    options: {'Au pôle Nord': true, 'Au pôle Sud': false, 'Au pôle Nord et au pôle Sud': false},
  ),
  Question(
    id: '52',
    title: 'Quel oiseau peut manger en volant ?',
    options: {'Le colibri': true, 'Le merle': false, 'L’hirondelle': false},
  ),
  Question(
    id: '53',
    title: 'Quelle discipline d’athlétisme n’est jamais courue aux Jeux olympiques ?',
    options: {'Les 100 mètres haies': true, 'Les 110 mètres haies': false, 'Le sprint sur 100 mètres': false},
  ),
  Question(
    id: '54',
    title: 'Combien pèse le poids lancé par les femmes dans le lancer du poids ?',
    options: {'3 kg': false, '2 kg': false, '4 kg': true},
  ),
  Question(
    id: '55',
    title: 'D’où la marque de sport « Nike » tire-t-elle son nom ?',
    options: {'D’une déesse grecque': true, 'Du premier patron qui s’appelait Alfred Nike': false, 'De Steve Nike qui fut le premier américain à gagner le 100 mètres': false},
  ),
  Question(
    id: '56',
    title: 'Un derby c’est une course de 2 400 m destinée aux chevaux de 3 ans. C’est aussi une compétition :',
    options: {'opposant 2 équipes de la même ville ou de la même région': true, 'entre des débutants d’une même discipline sportive': false, 'opposant des équipes mixtes (hommes et femmes)': false},
  ),
  Question(
    id: '57',
    title: 'Dans les Alpes suisses, on utilise une échelle spécifique pour indiquer le niveau de difficulté du parcours pour :',
    options: {'Le ski': false, 'Les promenades en montagne': false, 'L’alpinisme': true},
  ),
  Question(
    id: '58',
    title: 'Combien de joueurs y a-t-il sur le terrain durant un match de volley ?',
    options: {'12': false, '8': false, '6': true},
  ),
  Question(
    id: '59',
    title: 'Un boxeur est déclaré K.O. après :',
    options: {'5 secondes': false, '10 secondes': true, '15 secondes': false},
  ),
  Question(
    id: '60',
    title: 'De quel sport « la course contre la montre » fait-il partie ?',
    options: {'Le cyclisme': true, 'La formule 1': false, 'L’équitation': false},
  ),
  Question(
    id: '61',
    title: 'Que lance-t-on avec une raquette de badminton ?',
    options: {'Un volant': true, 'Une balle': false, 'Une fléchette': false},
  ),
  Question(
    id: '62',
    title: 'Où les boxeurs ne peuvent-ils pas frapper ?',
    options: {'Sous la ceinture': true, 'Sur le visage': false, 'Sur le thorax': false},
  ),
];

/*class DBconnect {
  // let's first create  a function to add a question to our database.
// declare the name of the table you want to create and add .json as suffix
  final url = Uri.parse(
      'https://simplequizapp-e57fb-default-rtdb.firebaseio.com/questions.json');

  // fetch the data from database
  Future<List<Question>> fetchQuestions() async {
    // we got the data from just using this. now let's print it to see what we got.
    return http.get(url).then((response) {
      // the 'then' method returns a 'response' which is our data.
      // to whats inside we have to decode it first.
      var data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
          id: key, // the encrypted key/the title we gave to our data
          title: value['title'], // title of the question
          options: Map.castFrom(value['options']), // options of the question
        );
        // add to newQuestions
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });
  }*/
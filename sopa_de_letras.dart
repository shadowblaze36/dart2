import 'dart:io';
import 'dart:math';

//------------------------------
// Ingrese parametros aqui:
int columnas = 5;
int filas = 5;
String palabraHorizontal = 'Hola';
String palabraVertical = 'Mundo';
String palabraDiagonal = 'IBI';
//------------------------------

void main() {
  crearSopa();
}

void crearSopa() {
  //Validar que la sopa pueda crearse con los parametros ingresados
  if (!validarSopa()) return;
  //Crear la sopa aleatoria
  var sopa = crearSopaAleatoria();
  //Construir Palabras
  sopa = construirPalabras(sopa);
  //Sustituir O mayusculas por 0 y l minuscula por 1
  sopa = sustitucion(sopa);
  //Mostrar la sopa en pantalla
  imprimirSopa(sopa);
}

List<List<String>> construirPalabras(List<List<String>> sopa) {
  int espacioDiagonal = columnas > filas ? filas : columnas;
  //La variabilidad es cuanto puede moverse una palabra en su eje
  int variabilidadHorizontal = palabraHorizontal.length - columnas;
  int variabilidadVertical = palabraVertical.length - filas;
  int variabilidadDiagonal = palabraDiagonal.length - espacioDiagonal;
  List<VectorUbicacion> posiblesPosicionesHorizontal = [];
  for (var i = 0; i < sopa.length; i++) {
    for (var j = 0; j < sopa[i].length; j++) {
      if (columnas >= palabraHorizontal.length + j) {
        posiblesPosicionesHorizontal
            .add(new VectorUbicacion(x: j, y: i, alreves: false));
      }
    }
  }
  List<VectorUbicacion> posiblesPosicionesVertical = [];
  for (var element in posiblesPosicionesHorizontal) {
    stdout.write(element.x);
    stdout.write(element.y);
    stdout.write(element.alreves);
    print('');
  }
  return sopa;
}

class VectorUbicacion {
  final int x;
  final int y;
  final bool alreves;
  final List<VectorUbicacion> verticales = [];
  final List<VectorUbicacion> diagonales = [];

  VectorUbicacion({
    required this.x,
    required this.y,
    required this.alreves,
  });
}

List<List<String>> crearSopaAleatoria() {
  //Inicializar Random
  Random _rnd = Random();
  //Definir posibles letras
  const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  //Funcion que nos dara una letra aleatoria de las anteriores
  String getRandomString() => String.fromCharCodes(Iterable.generate(
      1, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  //Crear la sopa de letras como una lista de listas con caracteres aleatorios:
  var sopa = List.generate(filas,
      (i) => List.generate(columnas, (j) => getRandomString(), growable: false),
      growable: false);

  return sopa;
}

bool validarSopa() {
  //Variables de uso general en la validacion
  bool isValid = true;
  int menorDiagonal = columnas > filas ? filas : columnas;

  //Validacion BASICA:
  //Validar palabra vertical
  if (palabraHorizontal.length > columnas) {
    print(
        'Numero de columnas no es suficiente para ingresar la palabra: $palabraHorizontal');
    isValid = false;
  }
  //Validar palabra vertical
  if (palabraVertical.length > filas) {
    print(
        'Numero de filas no es suficiente para ingresar la palabra: $palabraVertical');
    isValid = false;
  }
  //Validar palabra diagonal
  if (palabraDiagonal.length > menorDiagonal) {
    print(
        'Numero de filas y columnas no es suficiente para ingresar la palabra: $palabraDiagonal');
    isValid = false;
  }
  return isValid;
}

List<List<String>> sustitucion(List<List<String>> sopa) {
  for (var i = 0; i < sopa.length; i++) {
    for (var j = 0; j < sopa[i].length; j++) {
      sopa[i][j] == 'O' ? sopa[i][j] = '0' : null;
      sopa[i][j] == 'l' ? sopa[i][j] = '1' : null;
    }
  }
  return sopa;
}

void imprimirSopa(List<List<String>> sopa) {
  print('Palabras a encontrar:');
  print('Horizontal: $palabraHorizontal');
  print('Vertical: $palabraVertical');
  print('Diagonal: $palabraDiagonal');
  print('--------Sopa de Letras--------');
  for (var i = 0; i < sopa.length; i++) {
    for (var j = 0; j < sopa[i].length; j++) {
      stdout.write(sopa[i][j]);
    }
    print('');
  }
  print('-----------------------------');
}
